---
name: bioconductor-beachmat
description: The beachmat package provides a C++ interface for R matrix objects to enable high-performance data access across diverse matrix types using the tatami library. Use when user asks to interface R matrices with C++ code, handle sparse or delayed arrays in Rcpp, or implement memory-efficient matrix processing in Bioconductor packages.
homepage: https://bioconductor.org/packages/release/bioc/html/beachmat.html
---


# bioconductor-beachmat

## Overview

The `beachmat` package acts as a bridge between R matrix objects and the **tatami** C++ library. It allows developers to write high-performance C++ code that can transparently handle diverse R matrix types—including standard base matrices, `Matrix` package sparse/dense formats, and `DelayedArray` objects—without copying data or manually managing R-level block processing.

## Core Workflow

### 1. Initializing C++ Representations
To work with a matrix in C++, you first create a pointer to the matrix object in R. This is a lightweight operation that does not copy the underlying data.

```r
library(beachmat)
library(Matrix)

# Create a sample sparse matrix
x <- rsparsematrix(1000, 100, 0.1)

# Initialize the C++ representation
# This returns an external pointer to a tatami-compatible object
init <- initializeCpp(x)
```

### 2. C++ Implementation (Rcpp)
In your C++ source files, include `Rtatami.h`. This header provides the `Rtatami::BoundNumericPointer` class to parse the object returned by `initializeCpp()`.

```cpp
#include "Rtatami.h"

// [[Rcpp::export]]
Rcpp::NumericVector get_row_sums(Rcpp::RObject initmat) {
    // Parse the initialized R object
    Rtatami::BoundNumericPointer parsed(initmat);
    const auto& ptr = parsed->ptr;

    int NR = ptr->nrow();
    int NC = ptr->ncol();
    
    Rcpp::NumericVector output(NR);
    std::vector<double> buffer(NC);
    auto wrk = ptr->dense_row();

    for (int i = 0; i < NR; ++i) {
        auto extracted = wrk->fetch(i, buffer.data());
        double sum = 0;
        for (int j = 0; j < NC; ++j) {
            sum += extracted[j];
        }
        output[i] = sum;
    }

    return output;
}
```

### 3. Parallelization
`beachmat` supports thread-safe parallelization even when falling back to the R interpreter for unsupported matrix types.

- **Setup**: Call `setup_parallel_executor(beachmat::getExecutor())` in your package's `.onLoad` or before parallel tasks.
- **Execution**: Use `tatami::parallelize` within your C++ code to handle multi-threading across rows or columns.

## Package Integration Requirements

To use `beachmat` in a Bioconductor package:

1.  **DESCRIPTION**:
    - `SystemRequirements: C++17`
    - `Imports: Rcpp`
    - `LinkingTo: Rcpp, assorthead, beachmat`
2.  **NAMESPACE**:
    - `importFrom(Rcpp, sourceCpp)`
3.  **Best Practice**: Always call `initializeCpp()` inside your R wrapper function and pass the resulting pointer to your C++ code. Do not expose the external pointers directly to users as they are not serializable.

## Reference documentation

- [Linking instructions (Rmd)](./references/linking.Rmd)
- [Linking instructions (Markdown)](./references/linking.md)