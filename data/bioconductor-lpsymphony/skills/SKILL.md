---
name: bioconductor-lpsymphony
description: This tool solves Mixed-Integer Linear Programming (MILP) problems using the SYMPHONY solver. Use when user asks to solve linear optimization problems, maximize or minimize a linear objective function, or handle mixed-integer, binary, and continuous variable constraints.
homepage: https://bioconductor.org/packages/release/bioc/html/lpsymphony.html
---

# bioconductor-lpsymphony

name: bioconductor-lpsymphony
description: Solve Mixed-Integer Linear Programming (MILP) problems using the SYMPHONY solver. Use this skill when you need to maximize or minimize a linear objective function subject to linear constraints, especially when variables must be integers (pure integer), a mix of integers and continuous values (mixed-integer), or binary.

## Overview

The `lpsymphony` package is a Bioconductor adaptation of the SYMPHONY open-source solver. It is primarily used for optimization problems in bioinformatics and operations research where decision variables are constrained to specific types (Integer, Binary, or Continuous). It is highly compatible with `Rsymphony` but includes built-in support for easier installation across different operating systems.

## Core Function: lpsymphony_solve_LP()

The primary interface is `lpsymphony_solve_LP()`.

### Function Signature
```r
lpsymphony_solve_LP(obj, mat, dir, rhs, bounds = NULL, types = NULL, max = FALSE, verbosity = -2, time_limit = -1, node_limit = -1, gap_limit = -1, first_feasible = FALSE, write_lp = FALSE, write_mps = FALSE)
```

### Parameters
- `obj`: Numeric vector of objective function coefficients.
- `mat`: Constraint matrix (left-hand side). **Note:** Use column-major order when defining the matrix.
- `dir`: Character vector of constraint directions (`"<="`, `">="`, `=="`).
- `rhs`: Numeric vector of right-hand side values.
- `types`: Character vector of variable types:
    - `"I"`: Integer
    - `"B"`: Binary
    - `"C"`: Continuous
- `max`: Logical; `TRUE` for maximization, `FALSE` for minimization.
- `bounds`: (Optional) List of `lower` and `upper` bounds.

## Typical Workflow

### 1. Define the Problem
To solve: 
Max $3x_1 + x_2 + 3x_3$
Subject to:
$-x_1 + 2x_2 + x_3 \le 4$
$4x_2 - 3x_3 \le 2$
$x_1 - 3x_2 + 2x_3 \le 3$
Where $x_1, x_3$ are Integers and $x_2$ is Continuous.

```r
library(lpsymphony)

# Objective coefficients
obj <- c(3, 1, 3)

# Constraint matrix (Column-major order)
mat <- matrix(c(-1, 0, 1,  # Column 1
                 2, 4, -3, # Column 2
                 1, -3, 2), # Column 3
               nrow = 3)

# Directions and RHS
dir <- c("<=", "<=", "<=")
rhs <- c(4, 2, 3)

# Variable types
types <- c("I", "C", "I")

# Solve
res <- lpsymphony_solve_LP(obj, mat, dir, rhs, types = types, max = TRUE)
```

### 2. Interpret Results
The function returns a list:
- `res$solution`: The optimal values for the variables.
- `res$objval`: The value of the objective function at the optimum.
- `res$status`: Integer status code (0 for `TM_OPTIMAL_SOLUTION_FOUND`).

## Advanced Usage

### Setting Bounds
By default, variables are non-negative ($[0, \infty]$). To specify different ranges:
```r
bounds <- list(lower = list(ind = c(1, 2, 3), val = c(1, 1, 1)),
               upper = list(ind = c(1, 2, 3), val = c(5, 5, 5)))

res <- lpsymphony_solve_LP(obj, mat, dir, rhs, types = types, max = TRUE, bounds = bounds)
```

### Duality
To solve the dual of a maximization problem:
1. Use the primal RHS as the dual objective coefficients.
2. Transpose the primal constraint matrix (`t(mat)`).
3. Use the primal objective coefficients as the dual RHS.
4. Flip the constraint directions (e.g., `"<="` becomes `">="`).
5. Set `max = FALSE`.

## Tips and Best Practices
- **Matrix Orientation**: `matrix()` in R fills by column by default. Ensure your `mat` construction matches the variables in your objective vector.
- **Rounding**: Never assume an integer solution can be found by rounding a continuous (LP relaxation) solution. Always use the `"I"` or `"B"` types to invoke the branch-and-cut solver.
- **Performance**: For large problems, use `verbosity = -1` or lower to reduce console output. You can also set `time_limit` (in seconds) to prevent infinite loops on hard combinatorial problems.

## Reference documentation
- [lpsymphony - Integer Linear Programming in R](./references/lpsymphony.md)