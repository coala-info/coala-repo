---
name: r-pracma
description: The r-pracma package provides advanced numerical analysis functions in R with MATLAB-like syntax for optimization, integration, and differential equations. Use when user asks to find roots, solve systems of nonlinear equations, perform numerical integration, solve ordinary differential equations, or identify peaks in signal data.
homepage: https://cloud.r-project.org/web/packages/pracma/index.html
---


# r-pracma

name: r-pracma
description: Use this skill when performing advanced numerical analysis in R, including root finding, optimization, numerical integration, differential equations, and signal processing. It is particularly useful for users porting code from MATLAB/Octave to R, as it provides emulated MATLAB function names and signatures for linear algebra and mathematical modeling.

# r-pracma

## Overview
The `pracma` package provides R implementations of advanced functions in numerical analysis, linear algebra, optimization, and time series. It is designed to provide an environment where R can be used as a full-blown numerical computing system, often using MATLAB/Octave function names to simplify the transition for users coming from those environments.

## Installation
To install the package from CRAN:
```R
install.packages("pracma")
```

## Core Functions and Workflows

### Root Finding and Optimization
- **Univariate Roots**: Use `fzero(f, x0)` for finding roots of a function near a point or within an interval.
- **Systems of Equations**: Use `fsolve(f, x0)` for solving systems of nonlinear equations.
- **Minimization**: 
  - `fminbnd(f, a, b)` for finding the minimum of a univariate function on a bounded interval.
  - `fminsearch(f, x0)` for unconstrained multivariable optimization using the Nelder-Mead algorithm.

### Numerical Integration (Quadrature)
- **1D Integration**: `integral(f, a, b)` is the general-purpose adaptive integrator. For high precision or specific methods, use `quadgk` (Gauss-Kronrod) or `quadl` (Lobatto).
- **Multi-dimensional**: Use `integral2` for double integrals and `integral3` for triple integrals.

### Differential Equations
- **Solvers**: `pracma` provides several ODE solvers with MATLAB-like signatures:
  - `ode23(f, tspan, y0)`: Second/third-order Runge-Kutta method.
  - `ode45(f, tspan, y0)`: Fourth/fifth-order Runge-Kutta-Fehlberg method.
  - `rk4(f, tspan, y0)`: Classical fourth-order Runge-Kutta.

### Polynomials and Interpolation
- **Fitting**: `polyfit(x, y, n)` finds the coefficients of a polynomial of degree n.
- **Evaluation**: `polyval(p, x)` evaluates the polynomial at specific points.
- **Interpolation**: `interp1(x, y, xi, method = "linear")` supports linear, nearest, and cubic spline interpolation. Use `pchip` for piecewise cubic hermite interpolating polynomials.

### Linear Algebra and Special Matrices
- **Matrix Operations**: Use `eye(n)`, `ones(n, m)`, and `zeros(n, m)` for matrix creation.
- **Decompositions**: `lu`, `rref` (reduced row echelon form), and `pinv` (pseudoinverse).
- **Special Matrices**: `hankel`, `hilb`, `pascal`, `rosser`, and `wilkinson`.

### Signal and Time Series Processing
- **Peak Finding**: `findpeaks(x)` identifies local maxima in a vector.
- **Detrending**: `detrend(x)` removes linear or constant trends.
- **FFT Utilities**: `fftshift` and `ifftshift` for rearranging zero-frequency components.

## MATLAB Compatibility Tips
To avoid shadowing R base functions, some MATLAB-equivalent functions in `pracma` are capitalized. Use these instead of the lowercase versions when you need `pracma` specific behavior:
- `Diag()` instead of `diag()`
- `Norm()` instead of `norm()`
- `Trace()` instead of `sum(diag())`
- `Rank()` instead of `qr()$rank`
- `factors()` for prime factorization
- `nullspace()` for the null space of a matrix

## Reference documentation
- [Package README](./references/README.html.md)
- [Pracma Home Page](./references/home_page.md)