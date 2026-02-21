# Developing packages with *beachmat*

Aaron Lun

#### 29 October 2025

#### Package

beachmat 2.26.0

# 1 Overview

The *[beachmat](https://bioconductor.org/packages/3.22/beachmat)* package provides a C++ API to extract numeric data from matrix-like R objects,
based on the matrix representations in the [**tatami**](https://github.com/tatami-inc/tatami/) library.
This enables Bioconductor packages to use C++ for high-performance processing of data in arbitrary R matrices, including:

* ordinary dense `matrix` objects
* dense and sparse matrices from the *[Matrix](https://CRAN.R-project.org/package%3DMatrix)* package
* `DelayedMatrix` objects with delayed operations from the *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* package
* and any abstract matrix-like object with a `DelayedArray::extract_array()` method.

Where possible, *[beachmat](https://bioconductor.org/packages/3.22/beachmat)* will map the R object to its C++ representation, bypassing the R interpreter to directly extract the matrix contents.
This provides fast access by avoiding R-level evaluation, saves memory by avoiding block processing and memory allocations, and permits more fine-grained parallelization.
For objects without native support, the R interpreter is called in a thread-safe manner to ensure that any downstream C++ code still works.

# 2 Linking instructions

Packages that use *[beachmat](https://bioconductor.org/packages/3.22/beachmat)*’s API should set the following:

* The compiler should support the C++17 standard.
  Developers need to tell the build system to use C++17, by modifying the `SystemRequirements` field of the `DESCRIPTION` file:

  ```
    SystemRequirements: C++17
  ```

  … or modifying the `PKG_CPPFLAGS` in the `Makevars` with the relevant flags.
* *[Rcpp](https://CRAN.R-project.org/package%3DRcpp)* should be installed.
  Developers need to ensure that *[Rcpp](https://CRAN.R-project.org/package%3DRcpp)* is loaded when the package is loaded.
  This requires addition of `Rcpp` to the `Imports` field of the `DESCRIPTION` file:

  ```
   Imports: Rcpp
  ```

  … and a corresponding `importFrom` specification in the `NAMESPACE` file:

  ```
   importFrom(Rcpp, sourceCpp)
  ```

  (The exact function to be imported doesn’t matter, as long as the namespace is loaded.
  Check out the *[Rcpp](https://CRAN.R-project.org/package%3DRcpp)* documentation for more details.)
* Linking to *[beachmat](https://bioconductor.org/packages/3.22/beachmat)* is as simple as writing:

  ```
    LinkingTo: Rcpp, assorthead, beachmat
  ```

  … in the `DESCRIPTION` file.

# 3 Reading matrix data

Given an arbitrary matrix-like object, we create its C++ representation using the `initializeCpp()` function.
The C++ object only holds views on the memory allocated and owned by R itself.
As such, initialization is very cheap as no data is copied.

```
# Mocking up some kind of matrix-like object.
library(Matrix)
x <- round(rsparsematrix(1000, 10, 0.2))

# Initializing it in C++.
library(beachmat)
init <- initializeCpp(x)
```

`init` now refers to a `BoundNumericMatrix` object, the composition of which can be found in the `Rtatami.h` header.
Of particular relevance is the `ptr` member, which contains a pointer to a `tatami::NumericMatrix` object derived from the argument to `initializeCpp()`.
Developers can read the documentation in the header file for more details:

```
browseURL(system.file("include", "Rtatami.h", package="beachmat"))
```

Now we can write a function that uses **tatami** to operate on `init`.
All functionality described in **tatami**’s [documentation](https://tatami-inc.github.io/tatami/) can be used here;
the only *[beachmat](https://bioconductor.org/packages/3.22/beachmat)*-specific factor is that developers should include the `Rtatami.h` header first (which takes care of the **tatami** headers).
Let’s just say we want to compute column sums - a simple implementation might look like this:

```
#include "Rtatami.h"
#include <vector>
#include <algorithm>

// Not necessary in a package context, it's only used for this vignette:
// [[Rcpp::depends(beachmat, assorthead)]]

// [[Rcpp::export(rng=false)]]
Rcpp::NumericVector column_sums(Rcpp::RObject initmat) {
    Rtatami::BoundNumericPointer parsed(initmat);
    const auto& ptr = parsed->ptr;

    auto NR = ptr->nrow();
    auto NC = ptr->ncol();
    std::vector<double> buffer(NR);
    Rcpp::NumericVector output(NC);
    auto wrk = ptr->dense_column();

    for (int i = 0; i < NC; ++i) {
        auto extracted = wrk->fetch(i, buffer.data());
        output[i] = std::accumulate(extracted, extracted + NR, 0.0);
    }

    return output;
}
```

Let’s compile this function with *[Rcpp](https://CRAN.R-project.org/package%3DRcpp)* and put it to work.
We can just pass in the `init` that we created earlier:

```
column_sums(init)
```

```
##  [1] -22   0 -14 -22  23  -6 -24  20 -17  -3
```

In general, we suggest calling `initializeCpp()` within package functions rather than asking users to call it themselves.
The external pointers should never be exposed to the user as they do not behave like regular objects, e.g., they are not serializable.
Fortunately, the `initializeCpp()` calls are very cheap and can be performed at the start of any R function that needs to operate on the matrix in C++.

# 4 Enabling parallelization

**tatami** calls are normally thread-safe, but if the `tatami::NumericMatrix` is constructed from an unsupported object, it needs to call R to extract the matrix contents.
The R interpreter is strictly single-threaded, which requires some care when writing our parallel sections.
The easiest way to achieve parallelization is to use the `tatami::parallelize()` function:

```
#include "Rtatami.h"
#include <vector>
#include <algorithm>

// This attribute list is not necessary in a package context,
// it's only used to allow this vignette to compile properly:
// [[Rcpp::depends(beachmat, assorthead)]]

// [[Rcpp::export(rng=false)]]
SEXP setup_parallel_executor(SEXP executor) {
    Rtatami::set_executor(executor);
    return R_NilValue;
}

// [[Rcpp::export(rng=false)]]
Rcpp::NumericVector parallel_column_sums(Rcpp::RObject initmat, int nthreads) {
    Rtatami::BoundNumericPointer parsed(initmat);
    const auto& ptr = parsed->ptr;

    auto NR = ptr->nrow();
    auto NC = ptr->ncol();
    Rcpp::NumericVector output(NC);

    tatami::parallelize([&](int thread, int start, int length) {
        std::vector<double> buffer(NR);
        auto wrk = ptr->dense_column();
        for (int i = start, end = start + length; i < end; ++i) {
            auto extracted = wrk->fetch(i, buffer.data());
            output[i] = std::accumulate(extracted, extracted + NR, 0.0);
        }
    }, NC, nthreads);

    return output;
}
```

Before we call our parallel function, we make sure that we have enabled the thread-safe protection around the R interpreter.
In a package context, this would done in an `.onLoad()`, but we can just call the setup function right here:

```
# .onLoad <- function(libname, pkgname) {
    setup_parallel_executor(beachmat::getExecutor())
# }
```

Now we put it to work with 2 threads on our previously-initialized matrix.
Note that `tatami::parallelize()` (or specifically, the macros in `Rtatami.h`) will use the standard `<thread>` library to handle parallelization,
so it will work even on toolchains that do not have OpenMP support.

```
parallel_column_sums(init, 2)
```

```
##  [1] -22   0 -14 -22  23  -6 -24  20 -17  -3
```

More advanced users can check out the parallelization-related documentation in the [**tatami\_r**](https://github.com/tatami-inc/tatami_r) repository.

# 5 Comparison to block processing

The conventional approach to iterating over a generic matrix in Bioconductor is to use *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)*’s block processing mechanism, i.e., `DelayedArray::blockApply`.
This is implemented completely in R and is convenient for developers as it can be used directly with any R function.
However, its performance only goes so far, and several years of experience with its use has revealed a few shortcomings:

* Looping over the blocks in R incurs some overhead from the interpreter.
  In most cases, this difference is modest compared to the time spent in the user-defined function itself, but occasionally there are very noticeable performance issues.
  For example, the extraction of each block is unable to re-use information from the extraction of the previous block,
  resulting in very slow iterations for some matrix types, e.g., when processing a compressed sparse column matrix using row-wise blocks.
* When extracting rows or columns, each block processing iteration allocates a block that typically contains multiple rows or columns.
  This allows for vectorized operations across the block but increases memory usage as the block must be realized into one of the standard formats.
  Conversely, small blocks will increase the number of required iterations and the looping overhead.
  This introduces an awkward tension between speed and memory efficiency that must be managed by the end user.
* When parallelizing (e.g., with *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)*), each worker process needs to holds its own block in memory for processing.
  This exacerbates the speed/memory trade-off as the extra memory usage from block realization is effectively multiplied by the number of workers.
  We have also observed that workers are rather reckless with their memory consumption as they do not consider the existence of other workers,
  causing them to use more memory than expected and leading to OOM errors on resource-limited systems.

Shifting the iteration into C++ with *[beachmat](https://bioconductor.org/packages/3.22/beachmat)* avoids many of these issues.
The looping overhead is effectively eliminated as the R interpreter is no longer involved.
Only one row/column is extracted at a time for most `tatami::Matrix` classes, minimizing memory overhead and avoiding the need for manual block size management in most cases.
Parallelization is also much easier with the standard `<thread>` library, as we do not need to spin up or fork to create a separate process.

As an aside, if an unsupported matrix class is supplied to `initializeCpp()`, *[beachmat](https://bioconductor.org/packages/3.22/beachmat)* will fall back to block processing for data extraction.

# Session information

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] beachmat_2.26.0  Matrix_1.7-4     knitr_1.50       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5             rlang_1.1.6           xfun_0.53
##  [4] generics_0.1.4        jsonlite_2.0.0        DelayedArray_0.36.0
##  [7] S4Vectors_0.48.0      htmltools_0.5.8.1     MatrixGenerics_1.22.0
## [10] sass_0.4.10           stats4_4.5.1          rmarkdown_2.30
## [13] grid_4.5.1            abind_1.4-8           evaluate_1.0.5
## [16] jquerylib_0.1.4       fastmap_1.2.0         IRanges_2.44.0
## [19] yaml_2.3.10           lifecycle_1.0.4       bookdown_0.45
## [22] BiocManager_1.30.26   compiler_4.5.1        Rcpp_1.1.0
## [25] XVector_0.50.0        lattice_0.22-7        digest_0.6.37
## [28] R6_2.6.1              SparseArray_1.10.0    assorthead_1.4.0
## [31] bslib_0.9.0           tools_4.5.1           matrixStats_1.5.0
## [34] S4Arrays_1.10.0       BiocGenerics_0.56.0   cachem_1.1.0
```