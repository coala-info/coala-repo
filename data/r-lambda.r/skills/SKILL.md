---
name: r-lambda.r
description: The lambda.r package provides a functional programming framework for R that enables pattern matching, guards, and type constraints. Use when user asks to define multi-part functions, apply pattern matching to function signatures, use guards for conditional logic, or enforce type safety in R code.
homepage: https://cloud.r-project.org/web/packages/lambda.r/index.html
---

# r-lambda.r

## Overview
The `lambda.r` package provides a syntax for functional programming in R that mimics languages like Haskell or Erlang. It allows for cleaner, more declarative code by replacing nested `if-else` blocks with pattern matching and guards. Key features include:
- **Multi-part functions**: Define a single function name with multiple bodies based on input patterns.
- **Pattern matching**: Match specific values or types directly in the function signature.
- **Guards**: Use the `?` operator to apply logical constraints to function arguments.
- **Type safety**: Define custom types and ensure functions only accept or return specific classes.

## Installation
Install the package from CRAN:
```R
install.packages("lambda.r")
library(lambda.r)
```

## Core Syntax and Workflows

### Defining Functions with Pattern Matching
Functions are defined using the `%as%` operator instead of the standard `function` keyword.

```R
# Fibonacci sequence using pattern matching
fib(0) %as% 0
fib(1) %as% 1
fib(n) %as% { fib(n-1) + fib(n-2) }
```

### Using Guards
Guards allow you to add logic to the function signature. If the guard evaluates to `FALSE`, `lambda.r` tries the next function definition.

```R
# Absolute value with guards
abs_val(n) %?% { n < 0 } %as% { -n }
abs_val(n) %as% { n }
```

### Type Constraints
You can specify types in the function signature. `lambda.r` will automatically validate the class of the arguments.

```R
# Only accepts numeric input
square(n) %::% numeric : numeric
square(n) %as% { n^2 }
```

### Custom Types (Data Modeling)
Use the PascalCase convention to define "Type Constructors".

```R
# Define a Point type
Point(x, y) %as% list(x=x, y=y)

# Function that only accepts Point types
distance(p1, p2) %::% Point : Point : numeric
distance(p1, p2) %as% {
  sqrt((p1$x - p2$x)^2 + (p1$y - p2$y)^2)
}
```

## Best Practices
- **Order Matters**: Define specific patterns (like `fib(0)`) before general patterns (like `fib(n)`). `lambda.r` searches definitions top-down.
- **Ellipses**: Use `...` in signatures to pass additional arguments to underlying R functions.
- **Debugging**: Use `describe()` on a function name to see all defined parts and their signatures.
- **Attributes**: Use the `@` symbol to access or set attributes within a functional block, which is useful for metadata-heavy data frames.

## Reference documentation
- [Home Page](./references/home_page.md)