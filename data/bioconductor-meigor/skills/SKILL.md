---
name: bioconductor-meigor
description: MEIGOR provides a suite of global optimization solvers designed to handle complex, non-linear, and non-convex problems in R. Use when user asks to perform global optimization, calibrate systems biology models, estimate parameters, or solve mixed-integer nonlinear programming problems.
homepage: https://bioconductor.org/packages/release/bioc/html/MEIGOR.html
---


# bioconductor-meigor

## Overview

MEIGOR (Metaheuristics for Global Optimization in R) is a suite of global optimization solvers designed to handle complex, non-linear, and non-convex problems where local solvers often fail. It is particularly suited for systems biology applications like model calibration and parameter estimation. The package provides two primary algorithms:
1. **eSSR (Enhanced Scatter Search)**: For continuous and mixed-integer nonlinear programming (MINLP).
2. **VNSR (Variable Neighbourhood Search)**: For integer programming (IP).

## Core Workflow

### 1. Problem Definition
All optimizations require a `problem` list containing:
- `f`: The name of the objective function (as a string).
- `x_L`: Vector of lower bounds for decision variables.
- `x_U`: Vector of upper bounds for decision variables.
- `x_0`: (Optional) Initial starting point.
- `neq`: (Optional) Number of equality constraints (must be defined first in the objective function).
- `c_L` / `c_U`: (Optional) Bounds for inequality constraints.

### 2. Objective Function Structure
The objective function must return a scalar `f` (the value to minimize). For constrained problems, it must return a list `list(f=f, g=g)`, where `g` is a vector of constraint values.

```r
# Example: Constrained objective function
my_obj <- function(x, extra_param) {
  f <- x[1]^2 + x[2]^2 + extra_param
  g <- rep(0, 1)
  g[1] <- x[1] + x[2] - 1 # Inequality constraint
  return(list(f=f, g=g))
}
```

### 3. Optimization Options
Define an `opts` list to control the search:
- `maxeval`: Maximum function evaluations.
- `maxtime`: Maximum CPU time in seconds.
- `local_solver`: Local search method (e.g., 'DHC', 'LBFGSB', 'SOLNP', 'NM'). Set to 0 to deactivate.
- `ndiverse`: Number of initial diverse solutions (eSSR).

### 4. Execution
Use the `MEIGO` wrapper function to run the optimization:

```r
library(MEIGOR)
Results <- MEIGO(problem, opts, algorithm="ESS", ...) # ... for extra params
```

## Algorithm Specifics

### Enhanced Scatter Search (eSSR)
Best for continuous or mixed-integer problems.
- **Mixed-Integer**: Define `int_var` (number of integer variables) and `bin_var` (number of binary variables) in the `problem` list. Variables must be ordered: [continuous, integer, binary].
- **Logarithmic Search**: Use `opts$log_var` for variables spanning multiple orders of magnitude.

### Variable Neighbourhood Search (VNSR)
Best for pure integer/binary problems (e.g., logic model optimization).
- **Triggers**: Set `algorithm="VNS"`.
- **Local Search**: Controlled by `opts$use_local` and `opts$local_search_type` (1 for first improvement, 2 for best improvement).

### Parallel Optimization (CeSSR / CeVNSR)
For computationally expensive problems, use cooperative parallel versions:
- Set `algorithm="CeSSR"` or `"CeVNSR"`.
- Define `opts$hosts` as a vector of machine addresses (e.g., `rep('localhost', 4)`).
- Set `opts$ce_niter` for the number of information exchanges between threads.

## Interpreting Results
The `Results` object contains:
- `fbest`: The best objective value found.
- `xbest`: The optimal decision variables.
- `numeval`: Total evaluations performed.
- `f`: Convergence history (best value per iteration).

## Reference documentation

- [MEIGOR: a software suite based on metaheuristics for global optimization in systems biology and bioinformatics](./references/MEIGOR-vignette.md)