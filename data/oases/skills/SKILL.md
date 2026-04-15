---
name: oases
description: The oases skill provides guidance on using the qpOASES library to solve dense quadratic programming problems through an active-set strategy. Use when user asks to solve quadratic programs, implement model predictive control, or hot-start optimization problems in C++ or Python.
homepage: https://github.com/coin-or/qpOASES
metadata:
  docker_image: "quay.io/biocontainers/oases:0.2.09--h7b50bb2_2"
---

# oases

## Overview
The oases skill provides guidance on utilizing the qpOASES library to solve dense quadratic programming problems. It is specifically designed for "online" optimization, where the solution to one problem is used to hot-start the next, making it ideal for real-time control applications. This skill covers the mathematical formulation required by the solver and the standard build procedures for integrating the library into C++ or Python environments.

## Problem Formulation
To use oases, you must express your optimization problem in the following standard form:

**Objective:**
Minimize `1/2 * x'Hx + x'g`

**Constraints:**
Subject to:
- `lb <= x <= ub` (Lower and upper bounds on variables)
- `lbA <= Ax <= ubA` (Lower and upper bounds on linear constraints)

Where:
- `H`: Symmetric Hessian matrix (typically positive semi-definite).
- `g`: Gradient vector.
- `A`: Constraint matrix.
- `x`: Vector of decision variables.

## Build and Compilation Patterns
The library is self-contained but can be optimized by linking against LAPACK and BLAS.

### Native Build System
Use the provided Makefiles for your specific platform:
- **Linux:** `make -f make_linux.mk`
- **macOS:** `make -f make_osx.mk`
- **Windows:** `make -f make_windows.mk`

### CMake Integration
For modern C++ projects, use the `find_package` command. Ensure `qpOASESConfig.cmake` is in your system path:
```cmake
find_package(qpOASES REQUIRED)
target_link_libraries(your_project_target qpOASES::qpOASES)
```

## Best Practices
- **Hot-Starting:** Always leverage the "online" nature of the solver when working with MPC. The active-set strategy is significantly faster when the optimal active set does not change much between iterations.
- **Problem Scaling:** Ensure the Hessian `H` and constraint matrix `A` are well-scaled to avoid numerical issues in ill-posed or degenerate problems.
- **Interface Selection:** 
    - Use the **C++ API** for high-performance, embedded, or real-time applications.
    - Use the **Python or Matlab interfaces** for rapid prototyping and algorithm validation.
- **Error Detection:** Monitor the solver's return status to detect infeasible or unbounded problem formulations early in the control loop.

## Reference documentation
- [qpOASES Wiki](./references/github_com_coin-or_qpOASES_wiki.md)
- [qpOASES Main Repository](./references/github_com_coin-or_qpOASES.md)