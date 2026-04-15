---
name: r-gsubfn
description: The r-gsubfn tool provides advanced string manipulation and functional programming utilities in R by allowing functions, formulas, or lists to be used for pattern replacement and argument specification. Use when user asks to perform complex string substitutions with dynamic logic, extract string components based on content, or use formula-based anonymous functions in standard R operations.
homepage: https://cloud.r-project.org/web/packages/gsubfn/index.html
---

# r-gsubfn

name: r-gsubfn
description: Advanced string manipulation and function argument utilities in R. Use this skill when you need to perform complex string substitutions where the replacement depends on logic (using functions or formulas), extract string components based on content rather than delimiters (strapply), or use formula-based anonymous functions in standard R functions like lapply, integrate, or optimize using the fn$ prefix.

# r-gsubfn

## Overview

The `gsubfn` package extends R's string handling capabilities by allowing the replacement argument in substitution functions to be a function, formula, list, or proto object. It also provides a powerful mechanism (`fn$`) to use formula-based anonymous functions across R, significantly reducing boilerplate code for functional programming.

## Installation

```R
install.packages("gsubfn")
library(gsubfn)
```

## Core Functions

### gsubfn: Enhanced Substitution
Similar to `gsub`, but the replacement can be dynamic.
- **Function replacement**: The function is called for each match; backreferences are passed as arguments.
- **Formula replacement**: A shorthand for functions (e.g., `~ x + y`).
- **List replacement**: Acts as a lookup table.

```R
# Using a formula to sum colon-separated numbers
s <- "values: 10:20 and 30:40"
gsubfn("([0-9]+):([0-9]+)", ~ as.numeric(x) + as.numeric(y), s)
# [1] "values: 30 and 70"

# Using a list for lookup
gsubfn("[MGP]", list(M = "e6", G = "e9", P = "e12"), "3.5G, 88P")
# [1] "3.5e9, 88e12"
```

### strapply: String Apply
Extracts matches and applies a function, returning a list or simplified structure. Useful for "splitting by content."

```R
# Extract digits and text into a matrix
s <- c("123abc", "456def")
strapply(s, "^([0-9]+)(.*)", c, simplify = rbind)
```

### fn$: Formula-to-Function Translator
Prepend `fn$` to any R function call to use formulas as anonymous functions.
- **Rules**: Free variables in the formula become function arguments (except `pi`, `letters`, `LETTERS`).
- **String Interpolation**: Also performs shell-style variable substitution in strings.

```R
# Standard R functions with formulas
fn$integrate(~ sin(x), 0, pi)
fn$lapply(list(1:4, 1:5), ~ LETTERS[x])
fn$sapply(1:5, ~ x^2)

# String interpolation
val <- 10
fn$cat("The value is $val\n")
```

## Advanced Workflows

### State Preservation with Proto
Use `proto` objects when you need to maintain state (like a counter) across multiple matches within the same string.

```R
# Suffix each word with its occurrence count
p <- proto(fun = function(this, x) paste0(x, "{", count, "}"))
gsubfn("\\w+", p, "the dog and the cat")
# [1] "the{1} dog{2} and{3} the{4} cat{5}"
```

### Nested fn$ Calls
You can nest `fn$` calls for complex operations like matrix multiplication or generating subsequences.

```R
# Matrix multiplication via nested apply
a <- matrix(4:1, 2); b <- matrix(1:4, 2)
fn$apply(b, 2, x ~ fn$apply(a, 1, y ~ sum(x*y)))
```

## Tips and Best Practices
- **Backreferences**: By default, `gsubfn` passes all backreferences to the function. Use the `backref` argument (e.g., `backref = -2`) to control exactly how many are passed.
- **Performance**: For simple extractions, `strapplyc` is a faster version of `strapply` that uses C code.
- **Ambiguity**: If a function has multiple formulas and only one should be translated, use `~~` for the one to be translated.
- **Development**: Use `match.funfn` in your own functions to allow users to pass formulas as arguments natively.

## Reference documentation
- [gsubfn: Utilities for Strings and for Function Arguments](./references/gsubfn.md)