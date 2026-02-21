---
name: tinker
description: Tinker is a comprehensive suite of programs designed for molecular design and simulation.
homepage: https://dasher.wustl.edu/tinker/
---

# tinker

## Overview
Tinker is a comprehensive suite of programs designed for molecular design and simulation. It is particularly powerful for its implementation of polarizable force fields and diverse optimization algorithms. This skill provides guidance on navigating the Tinker environment, managing the required parameter and coordinate files, and executing core simulation workflows via the command line.

## Core Workflow and File Types
Tinker operations typically require three primary file types:
- **Coordinate Files (.xyz):** Contains atom types and Cartesian coordinates. Note that Tinker XYZ files include connectivity information, unlike standard XYZ formats.
- **Parameter Files (.prm):** Defines the force field constants (e.g., `amber99.prm`, `amoeba2018.prm`).
- **Key Files (.key):** Optional but recommended. Used to specify parameters, periodic boundary conditions, and simulation constants to avoid interactive prompts.

## Common CLI Patterns
Most Tinker programs can be run non-interactively by providing arguments in order or using a `.key` file.

### Energy Minimization
To perform a local search for a minimum energy structure:
- **minimize:** Performs L-BFGS gradient minimization.
  `minimize [molecule.xyz] [gradient_threshold]`
- **newton:** Uses a truncated Newton (TNCG) method, ideal for reaching very tight convergences.
  `newton [molecule.xyz] [gradient_threshold]`

### Molecular Dynamics
- **dynamic:** Runs a MD simulation.
  `dynamic [molecule.xyz] [steps] [timestep_fs] [save_interval_ps] [ensemble_type] [temperature] [pressure]`
  *Ensemble types: 1 (NVE), 2 (NVT), 3 (NPT), 4 (GRMS).*

### Analysis and Utilities
- **analyze:** Calculates total energy and breaks it down by component (van der Waals, electrostatic, etc.).
  `analyze [molecule.xyz] [option]`
  *Options: E (Energy), P (Parameters), D (Details).*
- **xyzpdb / pdbxyz:** Converts between Tinker XYZ and standard PDB formats.
- **vibrate:** Performs normal mode vibrational analysis.

## Expert Tips
- **Force Field Selection:** Ensure the `.key` file contains the line `parameters /path/to/forcefield.prm`. Tinker 25 is not backward compatible with older parameter files; always use the parameters bundled with the current distribution.
- **Polarization Convergence:** When using AMOEBA or HIPPO, use the PCG (Preconditioned Conjugate Gradient) solver for faster convergence of induced dipoles.
- **Memory Management:** If a simulation fails with a "segmentation fault" on Linux, increase the stack size (`ulimit -s unlimited`) or ensure sufficient swap space is available, as Tinker uses dynamic memory allocation for large systems.
- **Parallel Execution:** Tinker supports OpenMP. Set the environment variable `OMP_NUM_THREADS` to the desired number of cores before running compute-intensive programs like `dynamic` or `minimize`.

## Reference documentation
- [Tinker Overview and Capabilities](./references/dasher_wustl_edu_tinker.md)
- [Installation and Versioning](./references/anaconda_org_channels_bioconda_packages_tinker_overview.md)