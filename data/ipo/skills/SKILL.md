---
name: ipo
description: Ipopt is a software package designed for large-scale nonlinear optimization to find local solutions for mathematical problems with nonlinear objective functions and constraints. Use when user asks to solve nonlinear optimization problems, build or install Ipopt using coinbrew or manual configuration, and link linear solvers like MUMPS or HSL for high-performance computing.
homepage: https://github.com/coin-or/Ipopt
---


# ipo

## Overview
Ipopt (Interior Point Optimizer) is a professional-grade software package designed for large-scale nonlinear optimization. It is specifically used to find local solutions for mathematical problems involving nonlinear objective functions and constraints. This skill enables the configuration and deployment of Ipopt, ensuring it is correctly linked with high-performance linear solvers like MUMPS or HSL to handle complex, twice-continuously differentiable functions.

## Installation and Build Patterns

### Using coinbrew (Recommended)
The `coinbrew` script is the most efficient way to manage the download and sequential build of Ipopt and its primary dependencies (ASL and MUMPS).

*   **Fetch and Build**:
    ```bash
    ./coinbrew fetch Ipopt --no-prompt
    ./coinbrew build Ipopt --prefix=/path/to/install --test --no-prompt --verbosity=3
    ```
*   **Install**:
    ```bash
    ./coinbrew install Ipopt --no-prompt
    ```

### Manual Build Workflow
For environments where `coinbrew` is not used, follow the standard Autotools procedure. Ensure all ThirdParty dependencies (HSL, MUMPS, ASL) are configured with the same `--prefix`.

1.  **Configure**:
    ```bash
    ./configure --prefix=/your/install/path
    ```
    *Use `./configure --help` to toggle specific linear solvers or interface options.*
2.  **Compile**:
    ```bash
    make
    ```
3.  **Verify**:
    ```bash
    make test
    ```
4.  **Install**:
    ```bash
    make install
    ```

## Tool-Specific Best Practices

### Linear Solver Selection
Ipopt's performance is heavily dependent on the underlying sparse direct linear solver.
*   **MUMPS**: Highly recommended for open-source workflows. Use the `ThirdParty-Mumps` project to build it.
*   **HSL (MA27, MA57, etc.)**: Often provides superior performance but requires separate licensing.
*   **Pardiso**: Use the version from the Pardiso Project for better performance than the standard Intel MKL version when possible.

### AMPL Interface
If the AMPL Solver Library (ASL) is detected during the build process, an `ipopt` executable is created. This allows you to solve optimization models written in the AMPL modeling language directly from the command line:
```bash
ipopt problem_name.nl
```

### Dependency Management
*   **BLAS/LAPACK**: A fast implementation (like OpenBLAS or Intel MKL) is required for efficient matrix operations.
*   **Shared Prefixes**: Always use the same `--prefix` during the `./configure` step for all COIN-OR modules to ensure headers and libraries are discovered correctly.

## Troubleshooting
*   **Factorization Errors**: If the solver returns a factorization failed status, check if the linear solver (e.g., MA57) is correctly linked or if the problem is poorly scaled.
*   **Version Checking**: Use the following to retrieve version information in C++ environments:
    ```cpp
    #include "IpoptConfig.h"
    // Use Ipopt::GetVersion() in supported interfaces
    ```

## Reference documentation
- [Ipopt Introduction](./references/github_com_coin-or_Ipopt.md)
- [Ipopt Issues and Bug Tracking](./references/github_com_coin-or_Ipopt_issues.md)