---
name: r-listenv
description: List environments are environments that have list-like properties.  For instance, the elements of a list environment are ordered and can be accessed and iterated over using index subsetting, e.g. 'x &lt;- listenv(a = 1, b = 2); for (i in seq_along(x)) x[[i]] &lt;- x[[i]] ^ 2; y &lt;- as.list(x)'.</p>
homepage: https://cloud.r-project.org/web/packages/listenv/index.html
---

# r-listenv

name: r-listenv
description: Create and manage list environments in R. List environments are a hybrid data structure that behaves like a list (ordered, indexable, multi-dimensional) but has the reference semantics (mutability) of an environment. Use this skill when you need to store objects in an environment while maintaining list-like indexing, or when you need mutable data structures that can be passed by reference without copying.

## Overview

The `listenv` package provides "list environments," which are environments that behave almost exactly like lists. They support:
- **Indexing**: Access elements by index `x[[1]]` or name `x$a`.
- **Mutability**: Changes made to a list environment are reflected across all references (no copy-on-write).
- **Dimensions**: Can be treated as matrices or arrays using `dim()`.
- **Compatibility**: Works with standard environment functions like `exists()`, `get()`, and `assign()`.

## Installation

```R
install.packages("listenv")
library(listenv)
```

## Core Workflows

### Creating List Environments
You can create empty list environments or initialize them with values.

```R
# Create empty
x <- listenv()

# Initialize with values
x <- listenv(a = 1, b = 2, c = "hello")

# Pre-allocate length (elements initialized to NULL)
x <- listenv()
length(x) <- 5
```

### Access and Manipulation
List environments support both list-style and environment-style access.

```R
x <- listenv(a = 1)

# Add elements
x$b <- 2          # By name
x[[3]] <- "world" # By index (expands automatically)

# Remove elements
x$a <- NULL       # Removes element 'a'
x[1:2] <- NULL    # Removes first two elements

# Iteration
for (i in seq_along(x)) {
  print(x[[i]])
}
```

### Multi-dimensional List Environments
Unlike standard environments, list environments can have dimensions.

```R
x <- as.listenv(1:6)
dim(x) <- c(2, 3)
dimnames(x) <- list(c("r1", "r2"), c("c1", "c2", "c3"))

# Access by dimension
val <- x[[1, 2]]
x[2, -1] <- list(10, 20)
```

### Coercion
Easily move between lists and list environments.

```R
# To list
l <- as.list(x)

# From list
le <- as.listenv(l)
```

## Important Considerations

### Mutability (Reference Semantics)
Because list environments are environments, they are **mutable**. If you assign a list environment to a new variable, both variables point to the same object.

```R
x <- listenv(a = 1)
y <- x
y$a <- 100
print(x$a) # Returns 100
```

### Attribute Mutability
Attributes like `names()` and `dim()` are also mutable. Changing the dimensions of one reference changes it for all references.

### Performance
List environments are useful for `future` and parallel processing frameworks because they allow for non-blocking assignment and retrieval of results in a structured, list-like way without the overhead of copying large lists.

## Reference documentation

- [List Environments](./references/listenv.md)