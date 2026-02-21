---
name: qsopt-ex
description: The `qsopt-ex` skill enables the use of the QSopt_ex exact linear programming solver through its Python bindings.
homepage: https://github.com/jonls/python-qsoptex
---

# qsopt-ex

## Overview

The `qsopt-ex` skill enables the use of the QSopt_ex exact linear programming solver through its Python bindings. Unlike traditional solvers that rely on floating-point arithmetic and are susceptible to rounding errors, `qsoptex` performs computations using exact rational arithmetic. This is essential for applications where numerical precision is critical, such as in mathematical proofs, theoretical research, or when dealing with ill-conditioned problems that cause standard solvers to fail or return inaccurate results.

## Core Usage Patterns

### Problem Initialization and Variable Definition
Always start by creating an `ExactProblem` instance. Variables should be defined with explicit bounds and objective coefficients.

```python
import qsoptex
from fractions import Fraction

p = qsoptex.ExactProblem()

# Define variables with names to avoid collision issues
p.add_variable(name='x1', objective=2, lower=Fraction(7, 2), upper=17)
p.add_variable(name='x2', objective=-1, lower=None, upper=2) # None implies infinity
```

### Adding Constraints
Constraints are added using a dictionary to map variable names to their coefficients.

```python
# Sense can be EQUAL, LESS, or GREATER
p.add_linear_constraint(
    qsoptex.ConstraintSense.EQUAL, 
    {'x1': 1, 'x2': 1}, 
    rhs=0, 
    name='c1'
)
```

### Solving and Retrieving Results
Set the objective sense (MAXIMIZE or MINIMIZE) before solving. Results are returned as `fractions.Fraction` or `int`.

```python
p.set_objective_sense(qsoptex.ObjectiveSense.MAXIMIZE)
status = p.solve()

if status == qsoptex.SolutionStatus.OPTIMAL:
    print(f"Objective: {p.get_objective_value()}")
    print(f"x1: {p.get_value('x1')}")
```

### Working with External Files
The library supports loading standard LP and MPS formats.

```python
p = qsoptex.ExactProblem()
p.read('model.mps', filetype='MPS') # Use 'LP' for CPLEX LP files
p.solve()
```

## Expert Tips and Best Practices

- **Explicit Naming**: Always provide explicit names for variables and constraints. QSopt_ex uses default names like `xN` or `cN`. If you add a named element that matches an existing default name, the library may silently overwrite or delete the existing element.
- **Exact Inputs**: Provide coefficients as `fractions.Fraction`, `int`, or strings that can be converted to Fractions. While `float` and `Decimal` are supported, they may introduce the very precision issues `qsopt-ex` is intended to solve if not handled carefully.
- **Logging and Debugging**: Enable simplex display to monitor the solver's progress, especially for large or difficult problems.
  ```python
  import logging
  logging.basicConfig(level=logging.DEBUG)
  p.set_param(qsoptex.Parameter.SIMPLEX_DISPLAY, 1)
  ```
- **Handling Infinity**: Use `None` in `lower` or `upper` bounds to represent negative or positive infinity, respectively.

## Reference documentation
- [Python (Cython) bindings for QSopt_ex](./references/github_com_jonls_python-qsoptex.md)