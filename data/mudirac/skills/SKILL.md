---
name: mudirac
description: Mudirac is a specialized solver for the Dirac equation that models muonic atoms and their interactions with the nucleus. Use when user asks to run muonic atom simulations, configure input files with physical keywords, or optimize nuclear parameters such as radius and skin thickness.
homepage: https://github.com/muon-spectroscopy-computational-project/mudirac
metadata:
  docker_image: "quay.io/biocontainers/mudirac:1.0.1"
---

# mudirac

## Overview

The `mudirac` tool is a specialized solver for the Dirac equation in the context of muonic atoms. Unlike standard electronic atoms, muonic atoms require precise modeling of the finite nuclear size because the muon's large mass causes its wavefunction to overlap significantly with the nucleus. This skill provides guidance on running simulations, configuring input files with specific physical keywords, and utilizing the solver for nuclear parameter optimization.

## Command Line Usage

The primary way to interact with `mudirac` is through the command line by passing an input configuration file.

### Basic Execution
To run a simulation, use the following syntax:
```bash
mudirac input.in
```
The input file (typically `.in`) contains the keywords and parameters defining the atomic system and the calculation settings.

### Compilation and Setup
If the tool is not yet installed, it must be compiled from source:
1. Create a build directory: `mkdir build && cd build`
2. Configure with CMake: `cmake ..`
3. Compile: `make mudirac`
4. (Optional) Run tests to verify the build: `make tests && make test`

To make `mudirac` accessible globally, add the `bin` directory created during compilation to your system `PATH`.

## Input File Best Practices

While the full list of keywords is maintained in the project's internal documentation (`docs/Keywords.pdf`), the following patterns are critical for accurate simulations:

### Nuclear Charge Distribution
`mudirac` supports sophisticated nuclear models. When defining the nucleus, you will often work with the two-parameter Fermi (2pF) distribution:
- **Radius/Half-density**: Controlled via keywords related to `fermi_c`.
- **Skin Thickness**: Controlled via keywords related to `t` or `skin_thickness`.
- **Optimization**: The tool can be used to find optimal `c` and `t` values given experimental energy levels.

### Physical Corrections
- **Reduced Mass**: Use the `reduced_mass` keyword to toggle or implement control logic for mass corrections in the Dirac equation.
- **Electronic Background**: You can modify the default behavior of the electronic background charge to better simulate the environment of the muonic atom.

## Expert Tips

- **Transition Labels**: When analyzing output, ensure you have included labels for transitions to make the resulting X-ray spectra easier to interpret.
- **Optimization Algorithms**: Recent versions of the tool include integration with the Ceres solver for more robust optimization of nuclear parameters.
- **Galaxy Integration**: For users who prefer a GUI or lack a local C++ environment, `mudirac` is available as a tool within the "MaterialsGalaxy" platform under the "Other Muon Tools" section.

## Reference documentation

- [Main Repository and README](./references/github_com_muon-spectroscopy-computational-project_mudirac.md)
- [Project Issues and Feature Discussions](./references/github_com_muon-spectroscopy-computational-project_mudirac_issues.md)