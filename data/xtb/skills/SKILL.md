---
name: xtb
description: The `xtb` program is a specialized tool for semiempirical electronic structure theory, specifically implementing the Geometry, Frequency, Noncovalent, eXtended Tight-Binding (GFN-xTB) family of methods.
homepage: https://github.com/grimme-lab/xtb
---

# xtb

## Overview

The `xtb` program is a specialized tool for semiempirical electronic structure theory, specifically implementing the Geometry, Frequency, Noncovalent, eXtended Tight-Binding (GFN-xTB) family of methods. It bridges the gap between force fields and high-level quantum mechanics, providing a robust balance of speed and accuracy. Use this skill to guide the execution of various chemical tasks, including structural refinement, thermochemical analysis, and implicit solvation modeling.

## Core CLI Usage

The primary interface for `xtb` is the command line, typically taking a molecular structure file (usually in `.xyz` or `.coord` format) as the main argument.

### Common Task Flags
- **Geometry Optimization**: `xtb <input.xyz> --opt`
  - Refines the structure to a local minimum. The optimized structure is saved to `xtbopt.xyz`.
- **Frequency Calculation**: `xtb <input.xyz> --hess`
  - Calculates the Hessian matrix, vibrational frequencies, and thermochemical data.
- **Molecular Dynamics**: `xtb <input.xyz> --md`
  - Performs MD simulations. Configuration is often handled via an additional input file (e.g., `md.inp`).
- **Single Point Energy**: `xtb <input.xyz>`
  - Calculates the energy and gradients for the provided geometry without moving atoms.

### Method Selection
- **GFN2-xTB (Default)**: `xtb <input.xyz> --gfn 2`
  - The most common choice for general-purpose calculations involving geometry and electronic properties.
- **GFN1-xTB**: `xtb <input.xyz> --gfn 1`
  - Older version, sometimes preferred for specific parameterization needs.
- **GFN-FF**: `xtb <input.xyz> --gfnff`
  - A very fast, completely automated force field for extremely large systems or rapid screening.
- **GFN0-xTB**: `xtb <input.xyz> --gfn 0`
  - A simplified version for even faster performance.

### Solvation Models
`xtb` supports several implicit solvation models to simulate the effect of a solvent environment:
- **ALPB**: `xtb <input.xyz> --alpb <solvent>` (e.g., `water`, `methanol`, `ch2cl2`).
- **GBSA**: `xtb <input.xyz> --gbsa <solvent>`.
- **CPCM-X**: Used for specific dielectric environments.

## Expert Tips and Best Practices

- **Parallelization**: Control the number of threads using the environment variable `OMP_NUM_THREADS` or the flag `--parallel <n>`.
- **Charge and Multiplicity**: Always specify the total charge and number of unpaired electrons if the system is not a neutral singlet:
  - `xtb <input.xyz> --chrg <n> --uhf <n>` (where `uhf` is the number of unpaired electrons).
- **Constraints**: For constrained optimizations, use an input file (usually named `.xtbrc` or specified via `--input`) to define fixed atoms or bond constraints.
- **Large Systems**: For systems exceeding 1,000 atoms, prefer `--gfnff` for initial structural relaxation before attempting GFN2-xTB.
- **Output Files**:
  - `xtbopt.xyz`: The final optimized geometry.
  - `xtbopt.log`: Detailed optimization steps.
  - `xtbrestart`: Binary file used to restart interrupted calculations.
  - `wbo`: Contains Wiberg bond orders.

## Reference documentation
- [xtb Repository Overview](./references/github_com_grimme-lab_xtb.md)
- [xtb User Discussions](./references/github_com_grimme-lab_xtb_discussions.md)
- [xtb Known Issues and CLI feedback](./references/github_com_grimme-lab_xtb_issues.md)