---
name: r-polynom
description: "A collection of functions to implement a class for univariate   polynomial manipulations.</p>"
homepage: https://cloud.r-project.org/web/packages/polynom/index.html
---

# r-polynom

name: r-polynom
description: Specialized skill for univariate polynomial manipulations in R using the 'polynom' package. Use this skill when you need to create, evaluate, differentiate, integrate, or perform arithmetic operations (addition, multiplication, division with remainder) on polynomials, or when calculating interpolating and orthogonal polynomials.

# r-polynom

## Overview

The `polynom` package provides a class for univariate polynomial manipulations in R. It allows polynomials to be treated as first-class objects, enabling intuitive arithmetic operations (`+`, `-`, `*`, `/`, `%%`, `^`), calculus (differentiation and integration), and visualization.

## Installation

```R
install.packages("polynom")
library(polynom)
```

## Core Workflows

### 1. Creating Polynomials
There are three primary ways to initialize a polynomial object:

*   **From coefficients:** `polynomial(coefs)` where `coefs` are in increasing order of powers (constant, $x^1, x^2, \dots$).
    ```R
    p <- polynomial(c(1, 2, 1)) # 1 + 2x + x^2
    ```
*   **From zeros:** `poly.calc(z)` creates the monic polynomial with roots at `z`.
    ```R
    p <- poly.calc(c(1, 2, 3)) # (x-1)(x-2)(x-3)
    ```
*   **From interpolation:** `poly.calc(x, y)` creates the Lagrange interpolating polynomial passing through points $(x, y)$.
    ```R
    p <- poly.calc(x = c(0, 1, 2), y = c(1, 2, 4))
    ```

### 2. Polynomial Arithmetic
Standard R operators are overloaded for the `polynomial` class:
*   `p1 + p2`, `p1 - p2`, `p1 * p2`: Standard arithmetic.
*   `p1 / p2`: Returns the polynomial quotient (remainder discarded).
*   `p1 %% p2`: Returns the polynomial remainder.
*   `p^n`: Raises polynomial to a non-negative integer power.
*   `p1 == p2`: Checks for exact coefficient equality.

### 3. Evaluation and Calculus
*   **Evaluation:** Use `predict(p, x)` or convert to a function with `as.function(p)`.
*   **Derivatives:** `deriv(p)` returns the derivative polynomial.
*   **Integrals:** `integral(p, limits = NULL)` returns the anti-derivative.
*   **Roots:** `polyroot(p)` (standard R function) or `solve(p)` to find zeros.

### 4. Orthogonal Polynomials
Generate orthogonal polynomials over a discrete set of points:
```R
x_points <- c(0, 1, 2, 4)
op <- poly.orth(x_points) # Returns a polylist
```

### 5. Working with Lists (polylist)
A `polylist` is a list of polynomial objects, useful for handling families of polynomials (like Hermite or Legendre).
*   Convert a list: `as.polylist(list_of_polynomials)`
*   Operations applied to a `polylist` generally return a `polylist` (e.g., `deriv(He)`).

## Tips and Best Practices

*   **Numerical Stability:** Polynomials can be numerically fragile. If `poly.calc` fails or produces large errors, try shifting the origin using `change.origin(p, h)`.
*   **Variable Representation:** Calling `polynomial()` without arguments returns the identity polynomial $p(x) = x$. This is useful for building expressions: `x <- polynomial(); p <- 1 + 2*x + x^2`.
*   **Coercion:** `as.numeric(p)` extracts the coefficient vector.
*   **Printing:** The print method displays polynomials in a human-readable format (e.g., `1 + 2*x + x^2`).

## Reference documentation

- [Univariate Polynomials in R](./references/polynomials.Rmd)