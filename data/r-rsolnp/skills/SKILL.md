---
name: r-rsolnp
description: R package rsolnp (documentation from project home).
homepage: https://cran.r-project.org/web/packages/rsolnp/index.html
---

# r-rsolnp

## Overview
The `rsolnp` package provides an R implementation of the SOLNP algorithm, a robust general non-linear solver. It utilizes the Augmented Lagrange Multiplier method to handle optimization problems that include both equality and inequality constraints. It is widely used in finance (e.g., GARCH model estimation) and econometrics due to its stability and ability to handle complex constraint surfaces.

## Installation
To install the package from CRAN:
```R
install.packages("rsolnp")
```

## Main Functions

### solnp()
The primary function for constrained optimization.
```R
solnp(pars, fun, eqfun = NULL, eqB = NULL, ineqfun = NULL, ineqLB = NULL, 
      ineqUB = NULL, LB = NULL, UB = NULL, control = list(), ...)
```
- `pars`: Initial parameter values (starting vector).
- `fun`: The objective function to minimize.
- `eqfun`: Function for equality constraints (returns a vector).
- `eqB`: The values the equality constraints must equal.
- `ineqfun`: Function for inequality constraints.
- `ineqLB` / `ineqUB`: Lower and upper bounds for the inequality constraints.
- `LB` / `UB`: Lower and upper bounds for the parameters themselves.

### gosolnp()
A multi-start version of the solver used for global optimization. It generates random starting parameters from a truncated normal distribution to avoid local minima.
```R
gosolnp(pars = NULL, fixed = NULL, fun, eqfun = NULL, eqB = NULL, 
        ineqfun = NULL, ineqLB = NULL, ineqUB = NULL, LB = NULL, UB = NULL, 
        n.restarts = 1, n.sim = 20000, cluster = NULL, ...)
```

## Workflow Example: Constrained Optimization

This example minimizes a simple function subject to an equality constraint.

```R
library(rsolnp)

# 1. Define the objective function
obj_func <- function(x) {
    return(x[1]^2 + x[2]^2)
}

# 2. Define equality constraint (e.g., x1 + x2 = 1)
equal_const <- function(x) {
    return(x[1] + x[2])
}

# 3. Set starting values
init_params <- c(0.1, 0.1)

# 4. Run solver
# eqB = 1 means equal_const(x) must equal 1
result <- solnp(pars = init_params, fun = obj_func, eqfun = equal_const, eqB = 1)

# 5. Access results
print(result$pars)
```

## Tips and Best Practices
- **Scaling**: Ensure your objective function and constraints are well-scaled. Large differences in magnitude between parameters can lead to convergence issues.
- **Control Parameters**: Use the `control` argument to adjust `tol` (tolerance), `outer.iter` (maximum major iterations), and `inner.iter` (maximum minor iterations).
- **Inequality Constraints**: If you only have lower bounds for inequalities, set `ineqUB` to a very large number.
- **Gradients**: While `solnp` can calculate numerical derivatives, providing analytical gradients (via `control = list(grad = ...)` and `control = list(jac = ...)`) significantly improves speed and accuracy for complex problems.
- **Global Search**: If the solver gets stuck in local optima, switch to `gosolnp` with a high `n.sim` value.

## Reference documentation
- [rsolnp Home Page](./references/home_page.md)