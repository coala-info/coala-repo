# Using HDF5-backed matrices with beachmat

Aaron Lun

#### 29 October 2025

#### Package

beachmat.hdf5 1.8.0

# 1 Overview

*[beachmat.hdf5](https://bioconductor.org/packages/3.22/beachmat.hdf5)* provides a C++ API to extract numeric data from HDF5-backed matrices from the *[HDF5Array](https://bioconductor.org/packages/3.22/HDF5Array)* package.
This extends the *[beachmat](https://bioconductor.org/packages/3.22/beachmat)* package to the matrix representations in the [**tatami\_hdf5**](https://github.com/tatami-inc/tatami_hdf5) library.
By including this package, users and developers can enable **tatami**-compatible C++ code to operate natively on file-backed data via the HDF5 C library.

# 2 For users

Users can simply load the package in their R session:

```
library(beachmat.hdf5)
```

This will automatically extend *[beachmat](https://bioconductor.org/packages/3.22/beachmat)*’s functionality to *[HDF5Array](https://bioconductor.org/packages/3.22/HDF5Array)* matrices.
Any package code based on *[beachmat](https://bioconductor.org/packages/3.22/beachmat)* will now be able to access HDF5 data natively without any further work.

# 3 For developers

Developers should read the *[beachmat](https://bioconductor.org/packages/3.22/beachmat)* developer guide if they have not done so already.

Developers can import *[beachmat.hdf5](https://bioconductor.org/packages/3.22/beachmat.hdf5)* in their packages to guarantee native support for *[HDF5Array](https://bioconductor.org/packages/3.22/HDF5Array)* classes.
This registers more `initializeCpp()` methods that initializes the appropriate C++ representations for these classes.
Of course, this adds some more dependencies to the package, which may or may not be acceptable;
some developers may prefer to leave this choice to the user or hide it behind an optional parameter to reduce the installation burden
(e.g., if HDF5-backed matrices are not expected to be a common input in the package workflow).

It’s worth noting that *[beachmat](https://bioconductor.org/packages/3.22/beachmat)* by itself will already work with `HDF5Matrix`, `H5SparseMatrix`, etc. objects even without loading *[beachmat.hdf5](https://bioconductor.org/packages/3.22/beachmat.hdf5)*.
However, this is not as efficient as any package C++ code needs to go back into R to extract the matrix data via `DelayedArray::extract_array()` and friends.
Importing *[beachmat.hdf5](https://bioconductor.org/packages/3.22/beachmat.hdf5)* provides native support without the need for calls to R functions.

# 4 In-memory caching

The `initializeCpp()` methods for the *[HDF5Array](https://bioconductor.org/packages/3.22/HDF5Array)* classes have an optional `memorize=` parameter.
If this is `TRUE`, the entire matrix is loaded from the HDF5 file into memory and stored in a global cache on first use.
Any subsequent calls to `initializeCpp()` on the same matrix instance will re-use the cached value.

In-memory caching is intended for functions or workflows that need to iterate through the matrix multiple times.
By setting `memorize=TRUE`, developers can pay an up-front loading cost to avoid the repeated penalty of disk access on subsequent iterations.
Obviously, this assumes that the matrix is still small enough that an in-memory store is feasible.

For long-running analyses, users may call `beachmat::flushMemoryCache()` to clear the cache.

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
## [1] beachmat.hdf5_1.8.0 knitr_1.50          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4          jsonlite_2.0.0        compiler_4.5.1
##  [4] BiocManager_1.30.26   Rcpp_1.1.0            rhdf5filters_1.22.0
##  [7] jquerylib_0.1.4       IRanges_2.44.0        yaml_2.3.10
## [10] fastmap_1.2.0         lattice_0.22-7        R6_2.6.1
## [13] XVector_0.50.0        S4Arrays_1.10.0       generics_0.1.4
## [16] BiocGenerics_0.56.0   DelayedArray_0.36.0   bookdown_0.45
## [19] MatrixGenerics_1.22.0 h5mread_1.2.0         bslib_0.9.0
## [22] rlang_1.1.6           cachem_1.1.0          HDF5Array_1.38.0
## [25] xfun_0.53             sass_0.4.10           SparseArray_1.10.0
## [28] cli_3.6.5             Rhdf5lib_1.32.0       digest_0.6.37
## [31] grid_4.5.1            rhdf5_2.54.0          lifecycle_1.0.4
## [34] S4Vectors_0.48.0      evaluate_1.0.5        beachmat_2.26.0
## [37] abind_1.4-8           stats4_4.5.1          rmarkdown_2.30
## [40] matrixStats_1.5.0     tools_4.5.1           htmltools_0.5.8.1
```