---
name: isodyn
description: Isodyn is a specialized kinetic modeling tool designed for 13C metabolic flux analysis (MFA).
homepage: https://github.com/seliv55/isodyn
---

# isodyn

## Overview

Isodyn is a specialized kinetic modeling tool designed for 13C metabolic flux analysis (MFA). It bridges the gap between raw mass spectrometry data and biological insight by simulating how 13C labels propagate through central metabolic pathways. By fitting these simulations to experimental data, the tool estimates reaction parameters and real-world metabolic fluxes while accounting for metabolite concentrations as constraints. It is particularly useful for researchers working with mass spectrometry data that has been corrected for natural isotope abundance (e.g., via Midcor).

## Installation and Setup

Isodyn is a C++ based tool that runs in a Linux environment. It does not require a formal installation process beyond compiling the source code.

1.  **Compilation**: If you modify any `.cpp` or `.h` files, or are setting up for the first time, run:
    ```bash
    make clean && make
    ```
2.  **Execution**: The primary interface is the `iso.sh` shell script, which wraps the `isodyn.out` executable.

## Command Line Usage

The `iso.sh` script accepts several flags to control the simulation and fitting logic.

### Basic Execution Patterns

*   **Default Simulation**: Run a single simulation with default parameters.
    ```bash
    ./iso.sh
    ```
*   **Data Fitting**: Use the Simulated Annealing algorithm to fit the model to experimental data.
    ```bash
    ./iso.sh -F
    ```
*   **Statistical Analysis**: Generate mean and confidence intervals for the estimated fluxes.
    ```bash
    ./iso.sh -S
    ```

### Customizing Inputs and Outputs

You can override default file paths using the following options:

*   **-a [file]**: Specify the 13C labeling input file (typically Midcor output).
*   **-b [file]**: Specify the measured metabolite concentrations file.
*   **-i [path]**: Set the path for the initial set of parameters.
*   **-o [dir]**: Set the output directory for results.
*   **-s [path]**: Set the path for the statistical results file.

### Advanced Fitting Modes

*   **-N**: Determine the number of degrees of freedom for goodness-of-fit estimation.
*   **-C**: Attempt to increase confidence intervals for fluxes.
*   **-K**: Apply a specialized algorithm for fitting transketolase parameters.
*   **-A**: Apply a specialized algorithm for fitting transaldolase parameters.

## Expert Tips and Best Practices

*   **Data Pre-processing**: Isodyn is designed to work seamlessly with Midcor. Ensure your mass spectrometry data is corrected for natural occurring isotopes and peak overlapping before inputting it into Isodyn.
*   **Concentration Constraints**: Unlike some MFA tools that only use labeling data, Isodyn uses metabolite concentrations as a restrictive factor. Ensure your `fcon` file is accurate to improve the goodness of fit.
*   **Output Management**: Use the `-m` flag to control the number of files saved during the fitting process (default is 77). This is useful for managing disk space during long optimization runs.
*   **Verification**: Always check the `fstat` output to evaluate the confidence intervals. If intervals are too narrow or the fit is poor, consider re-running with the `-C` flag or adjusting initial parameters.

## Reference documentation

- [Isodyn README](./references/github_com_seliv55_isodyn.md)