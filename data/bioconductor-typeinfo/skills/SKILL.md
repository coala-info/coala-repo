---
name: bioconductor-typeinfo
description: This tool annotates R functions with argument and return type information to enable runtime type checking and function reflection. Use when user asks to implement type validation, specify function signatures, or query type requirements for R functions.
homepage: https://bioconductor.org/packages/3.8/bioc/html/TypeInfo.html
---


# bioconductor-typeinfo

name: bioconductor-typeinfo
description: Annotate R functions with argument and return type information using the TypeInfo package. Use this skill when you need to implement runtime type checking, provide function reflection for automated interface generation, or ensure that Bioconductor workflows maintain strict data type integrity.

# bioconductor-typeinfo

## Overview

The `TypeInfo` package provides a mechanism for annotating R functions with specific type requirements for arguments and return values. This "reflection" allows functions to describe themselves, enabling automatic argument validation and facilitating the creation of external interfaces (like GUI widgets or web forms). It shifts the burden of type checking from the function body to a formal specification, improving code readability and reducing subtle bugs caused by unexpected input types.

## Core Workflow

### 1. Basic Type Specification
To add type information to a function, use the `typeInfo<-` replacement function. The most common approach uses `SimultaneousTypeSpecification` with a `TypedSignature`.

```R
library(TypeInfo)

# Define a function
my_analysis <- function(data, threshold) {
  # Function logic here
  return(result)
}

# Apply type information
typeInfo(my_analysis) <- SimultaneousTypeSpecification(
  TypedSignature(
    data = "numeric",
    threshold = "numeric"
  ),
  returnType = "list"
)
```

### 2. Querying Type Information
You can inspect the type requirements of an annotated function using `typeInfo()`.

```R
typeInfo(my_analysis)
```

### 3. Handling Multiple Signatures
If a function accepts different combinations of types (e.g., an argument can be either a `factor` or `numeric`), provide multiple `TypedSignature` objects.

```R
typeInfo(my_analysis) <- SimultaneousTypeSpecification(
  TypedSignature(data = "numeric", threshold = "numeric"),
  TypedSignature(data = "matrix", threshold = "numeric"),
  returnType = "list"
)
```

## Advanced Type Tests

`TypeInfo` supports different levels of strictness for type matching:

*   **InheritsTypeTest (Default):** Uses `is(object, class)`. Matches the class or any class it extends. Specified by passing a simple character string.
*   **StrictIsTypeTest:** Requires an exact class match.
    ```R
    TypedSignature(data = StrictIsTypeTest("matrix"))
    ```
*   **DynamicTypeTest:** Allows for arbitrary R expressions to validate arguments, often used for checking lengths or complex relationships. Use `quote()` to prevent premature evaluation.
    ```R
    TypedSignature(
      data = "numeric",
      threshold = quote(length(threshold) == 1 && threshold > 0)
    )
    ```
*   **IndependentTypeSpecification:** A simpler alternative when arguments are independent. It performs a logical OR within each argument's allowed types.
    ```R
    typeInfo(my_func) <- IndependentTypeSpecification(
      data = c("numeric", "integer"),
      threshold = "numeric"
    )
    ```

## Tips and Best Practices

*   **Performance:** Type checking occurs at the start and end of function execution. For performance-critical code, consider using a type-checked "wrapper" function around a faster, untyped internal function.
*   **S4 Methods:** `TypeInfo` does not directly handle S4 method dispatch (which has its own type system), but it is highly effective for standard functions and exported package APIs.
*   **Return Types:** Always specify a `returnType` to ensure the function output meets expectations, which is critical for chaining functions in automated workflows.
*   **Error Handling:** When a type mismatch occurs, `TypeInfo` stops execution with an informative error message detailing the supplied types versus the required signatures.

## Reference documentation

- [TypeInfo News](./references/TypeInfoNews.md)