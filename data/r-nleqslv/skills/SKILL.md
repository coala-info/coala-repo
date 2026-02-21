---
name: r-nleqslv
description: "Solve a system of nonlinear equations using a Broyden or a Newton method              with a choice of global strategies such as line search and trust region.              There are options for using a numerical or user supplied Jacobian,              for specifying a banded numerical Jacobian and for allowing              a singular or ill-conditioned Jacobian.</p>"
homepage: https://cloud.r-project.org/web/packages/nleqslv/index.html
---

# r-nleqslv

## Overview
The `nleqslv` package provides a robust solver for systems of nonlinear equations. It implements two primary algorithms: a Newton method and Broyden's secant method. It is particularly effective because it offers multiple global strategies (line search, trust region, etc.) to handle cases where the standard Newton method might fail to converge.

## Installation
Install the package from CRAN:
```R
install.packages("nleqslv")
```

## Core Workflow
The primary function is `nleqslv(x, fn, jac = NULL, ..., method = c("Broyden", "Newton"), global = c("quad", "hypot", "double", "pwldog", "dbldog", "hook", "none"))`.

1.  **Define the Function**: Create an R function that takes a vector `x` and returns a vector of the same length representing the function values (which should be zero at the solution).
2.  **Initial Guess**: Provide a starting vector `x`.
3.  **Select Method**:
    *   `Newton`: Uses the Jacobian matrix (calculated numerically by default).
    *   `Broyden`: A quasi-Newton method that updates the Jacobian, often faster for large systems.
4.  **Select Global Strategy**:
    *   `quad`, `hypot`: Line search methods.
    *   `double`, `pwldog`, `dbldog`: Trust region methods (Powell's dogleg).
    *   `hook`: More robust trust region (Hooke-Jeeves).
    *   `none`: Standard Newton/Broyden without global search.

## Example Usage
```R
library(nleqslv)

# Define a system of equations:
# x1^2 + x2^2 - 2 = 0
# exp(x1 - 1) + x2^3 - 2 = 0
dslv <- function(x) {
    y <- numeric(2)
    y[1] <- x[1]^2 + x[2]^2 - 2
    y[2] <- exp(x[1] - 1) + x[2]^3 - 2
    y
}

xstart <- c(2, 0.5)
results <- nleqslv(xstart, dslv, method="Newton", global="dbldog")

# Access the solution
sol <- results$x
# Check convergence status (termcd = 1 is success)
status <- results$termcd
```

## Key Parameters and Tips
*   **Jacobian**: If you can calculate the analytical Jacobian, provide it via the `jac` argument to improve speed and reliability.
*   **Scaling**: Use the `control` argument (e.g., `control=list(xtol=1e-8)`) to adjust tolerances. If variables have vastly different magnitudes, use the `scalex` parameter to provide scaling factors.
*   **Diagnostics**: Check `results$termcd`. A value of `1` indicates a successful search. Values `2` to `5` indicate various levels of "near" convergence or potential issues.
*   **Search for Multiple Solutions**: Use `searchEqn` to find multiple roots by starting from different points in a grid or random distribution.

## Reference documentation
- [nleqslv: Solve Systems of Nonlinear Equations](./references/home_page.md)