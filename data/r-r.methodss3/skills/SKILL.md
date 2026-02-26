---
name: r-r.methodss3
description: This tool simplifies the creation and management of S3 generic functions and methods in R by automating registration and reducing boilerplate code. Use when user asks to define S3 methods, create generic functions, automate method dispatch, or manage R package method definitions.
homepage: https://cloud.r-project.org/web/packages/R.methodsS3/index.html
---


# r-r.methodss3

name: r-r.methodss3
description: Simplifies the creation of S3 generic functions and methods in R. Use this skill when developing R packages or scripts that require robust S3 method dispatch, automatic generation of generic functions, or a migration path toward S4-style method definitions. It is particularly useful for avoiding manual `UseMethod` calls and managing naming conflicts.

# r-r.methodss3

## Overview
`R.methodsS3` provides a high-level interface for defining S3 methods and generics in R. It automates the creation of generic functions if they do not exist and ensures that methods are correctly registered. This reduces boilerplate code and maintenance for package developers while maintaining compatibility with standard R S3 dispatch.

## Installation
To install the stable version from CRAN:
```r
install.packages("R.methodsS3")
```

## Core Functions

### setGenericS3()
Creates an S3 generic function.
- **Usage**: `setGenericS3("myMethod", export=TRUE)`
- **Behavior**: If the function already exists, it is not overwritten unless specified. It automatically adds `UseMethod("myMethod")` to the body.

### setMethodS3()
Defines an S3 method for a specific class.
- **Usage**: `setMethodS3("myMethod", "myClass", function(object, ...) { ... })`
- **Workflow**:
  1. Checks if the generic `myMethod` exists; if not, it calls `setGenericS3` automatically.
  2. Defines the function `myMethod.myClass`.
  3. Handles visibility (public/protected/private) and caching.

## Workflows

### 1. Defining a New Generic and Method
Instead of manually writing a generic and then the method, do it in one step:
```r
library(R.methodsS3)

# This automatically creates the generic 'compute' and the method 'compute.default'
setMethodS3("compute", "default", function(x, ...) {
  return(x + 1)
})

# Add a specific class method
setMethodS3("compute", "numeric", function(x, ...) {
  return(x * 2)
})
```

### 2. Handling Existing Functions
If you want to create a method for a function that exists in `base` R but isn't a generic:
```r
# R.methodsS3 will attempt to turn the existing function into a generic 
# while preserving its original functionality as the default method.
setMethodS3("print", "myCustomClass", function(x, ...) {
  cat("Custom class output\n")
})
```

## Tips for Package Development
- **Namespace**: When using `R.methodsS3` in a package, ensure `R.methodsS3` is in `Imports` and you import the necessary functions in your `NAMESPACE`.
- **Documentation**: You still need to document the methods using `roxygen2` or `.Rd` files. `R.methodsS3` handles the functional logic, not the documentation generation.
- **S4 Migration**: Using `setMethodS3` makes code more structured, making it easier to transition to S4 `setMethod` later if the project complexity grows.

## Reference documentation
- [R.methodsS3: S3 Methods Simplified](./references/README.md)