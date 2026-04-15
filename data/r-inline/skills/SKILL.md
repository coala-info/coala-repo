---
name: r-inline
description: This tool dynamically defines R functions and S4 methods by compiling and linking inlined C, C++, or Fortran code snippets. Use when user asks to optimize R performance with compiled code, interface with C/C++/Fortran libraries without creating a package, or use the inline package to compile code on the fly.
homepage: https://cloud.r-project.org/web/packages/inline/index.html
---

# r-inline

name: r-inline
description: Dynamically define R functions and S4 methods using inlined C, C++, or Fortran code. Use this skill when you need to optimize R performance by writing bottleneck logic in compiled languages without creating a full R package, or when interfacing with existing C/C++/Fortran libraries directly within an R script.

## Overview

The `inline` package allows R users to compile and link C, C++, and Fortran code snippets on the fly. It handles the "boilerplate" of creating temporary files, compiling them with `R CMD SHLIB`, and loading the resulting shared objects into R.

## Installation

```R
install.packages("inline")
```

## Core Functions

### cfunction()
The primary interface for C, Fortran, and basic C++ code.

- **sig**: A named character vector where names are argument names and values are R types (e.g., `c(n="integer", x="numeric")`).
- **body**: The code inside the function body (omit the outer curly braces for C/C++).
- **language**: "C++" (default), "C", "Fortran", "F95".
- **convention**: ".Call" (default for C/C++), ".C", or ".Fortran".

### cxxfunction()
A specialized version for C++ that supports a plugin system (e.g., for Rcpp).

- **plugin**: Use `"Rcpp"` to automatically handle headers and environment variables for Rcpp integration.

## Common Workflows

### 1. Simple C Optimization (.C convention)
Use this for simple pointer-based manipulation of numeric vectors.

```R
library(inline)

code <- "
  for (int i = 0; i < *n; i++) {
    x[i] = x[i] * x[i];
  }
"

sig <- signature(n="integer", x="numeric")
square_func <- cfunction(sig, code, language="C", convention=".C")

# Usage
result <- square_func(n=5L, x=as.numeric(1:5))
print(result$x)
```

### 2. High-Performance C++ with Rcpp
Use `cxxfunction` with the Rcpp plugin for modern C++ features and easier memory management.

```R
library(inline)

cpp_code <- "
  int n = as<int>(x);
  double s = as<double>(y);
  return wrap(n * s);
"

fx <- cxxfunction(signature(x="integer", y="numeric"), 
                  body=cpp_code, 
                  plugin="Rcpp")

fx(10L, 5.5)
```

### 3. Fortran Integration
Note that Fortran requires specific handling of dimensions.

```R
fortran_code <- "
      integer i
      do 1 i=1, n
    1 x(i) = x(i)**3
"

cubefn <- cfunction(sig=signature(n="integer", x="numeric"), 
                    body=fortran_code, 
                    convention=".Fortran")
```

## Tips and Best Practices

- **Argument Names**: Avoid dots in argument names (e.g., use `my_val` instead of `my.val`) as they may be illegal in the target language.
- **Memory Protection**: When using the `.Call` convention in C, always use `PROTECT()` and `UNPROTECT()` for SEXP objects to prevent garbage collection errors.
- **Includes**: Use the `includes` argument to add `#include` statements or preprocessor macros.
- **Persistence**: Functions created by `inline` are lost when the R session ends. To save them, use `moveDLL()` and `writeCFunc()`/`readCFunc()`.
- **Debugging**: Set `verbose=TRUE` in `cfunction` to see the full generated source code and compilation logs if a build fails.

## Reference documentation

- [Package Manual](./references/reference_manual.md)