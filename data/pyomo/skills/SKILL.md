---
name: pyomo
description: Pyomo is a Python-based ecosystem for modeling and solving mathematical optimization problems by interfacing with various solvers. Use when user asks to define algebraic models, set up variables and constraints, solve linear or nonlinear programs, or perform mathematical optimization.
homepage: https://github.com/Pyomo/pyomo
metadata:
  docker_image: "quay.io/biocontainers/pyomo:4.1.10527--py34_0"
---

# pyomo

## Overview
Pyomo is a powerful Python-based ecosystem for mathematical optimization that allows you to define models algebraically. It serves as a bridge between high-level mathematical formulations and low-level optimization solvers (like Gurobi, CPLEX, Ipopt, or GLPK). Use this skill to structure optimization problems by defining variables, constraints, and objectives, and to manage the workflow of instantiating and solving these models.

## Core Modeling Workflow
Pyomo supports two primary modeling approaches: **ConcreteModels** (where data is defined at the time the model is created) and **AbstractModels** (where the model structure is defined separately from the data).

### 1. Basic Model Structure
A standard Pyomo script follows this sequence:
1.  **Import**: `from pyomo.environ import *`
2.  **Model Initialization**: `model = ConcreteModel()`
3.  **Components**:
    *   **Variables**: `model.x = Var(within=NonNegativeReals)`
    *   **Objective**: `model.obj = Objective(expr=model.x**2, sense=minimize)`
    *   **Constraints**: `model.con = Constraint(expr=model.x >= 10)`
4.  **Solver Interface**: Use `SolverFactory` to select and run a solver.

### 2. Common Component Definitions
*   **Sets**: `model.I = Set(initialize=['A', 'B', 'C'])`
*   **Parameters**: `model.p = Param(model.I, initialize={'A':1, 'B':2, 'C':3})`
*   **Indexed Variables**: `model.y = Var(model.I, domain=Binary)`
*   **Indexed Constraints**: 
    ```python
    def rule_name(model, i):
        return model.y[i] <= model.p[i]
    model.con = Constraint(model.I, rule=rule_name)
    ```

## Solver Integration and Execution
Pyomo does not include solvers; it interfaces with them. Ensure the solver executable (e.g., `glpk`, `ipopt`) is in your system PATH.

### Python Script Execution
```python
solver = SolverFactory('glpk')
results = solver.solve(model, tee=True) # tee=True prints solver output
model.display() # View results
```

### Command Line Interface (CLI)
For models defined in a file (e.g., `model.py`), you can solve directly from the terminal:
*   **Basic Solve**: `pyomo solve model.py --solver=glpk`
*   **With Data File**: `pyomo solve model.py data.dat --solver=glpk`
*   **Save Results**: `pyomo solve model.py --solver=glpk --save-results results.json`

## Expert Tips and Best Practices
*   **Domain Selection**: Use specific domains like `NonNegativeReals`, `Binary`, or `Integers` to help solvers optimize more efficiently.
*   **Expression Management**: For complex constraints, use `sum()` or `quicksum` (from `pyomo.environ`) to build linear expressions efficiently.
*   **Transformation**: Use `TransformationFactory` for advanced tasks like Linearization or Disjunctive Programming (GDP).
    *   Example: `TransformationFactory('gdp.bigm').apply_to(model)`
*   **Duals**: To access dual variables (shadow prices), you must explicitly add a Suffix to the model before solving:
    `model.dual = Suffix(direction=Suffix.IMPORT)`
*   **Troubleshooting**: If a solve fails, check `results.solver.termination_condition`. Common issues include `infeasible` or `unbounded` models.

## Reference documentation
- [Pyomo Overview](./references/github_com_Pyomo_pyomo.md)