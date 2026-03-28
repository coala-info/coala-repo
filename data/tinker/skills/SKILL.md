---
name: tinker
description: Tinker is a modular software suite for molecular design and simulation that performs tasks ranging from coordinate transformation to complex molecular dynamics and free energy calculations. Use when user asks to convert between PDB and XYZ formats, perform energy minimization, run molecular dynamics simulations, or analyze potential energy components and dipole moments.
homepage: https://dasher.wustl.edu/tinker/
---

# tinker

## Overview
Tinker is a modular and powerful software suite designed for molecular design and simulation. Unlike monolithic simulation packages, Tinker consists of a large collection of individual executable programs that perform specific tasks—from coordinate transformation and parameterization to complex MD trajectories and free energy calculations. It is particularly renowned for its support of advanced polarizable force fields like AMOEBA and HIPPO, though it handles standard fixed-charge models with equal proficiency.

## Common CLI Workflows

### 1. System Preparation
Before running simulations, coordinates must be converted into the Tinker-specific XYZ format, which includes atom connectivity.

*   **Convert PDB to XYZ**:
    `pdbxyz [molecule.pdb] [parameter_file]`
    *Example*: `pdbxyz protein.pdb amber99.prm`
*   **Convert XYZ to PDB**:
    `xyzpdb [molecule.xyz] [parameter_file]`

### 2. Energy Minimization
Used to remove steric clashes or find local minima.

*   **Local Optimization**:
    `minimize [molecule.xyz] [RMS_gradient_threshold]`
    *Note*: A common threshold is 0.01 or 0.1 kcal/mol/A.

### 3. Molecular Dynamics (MD)
The `dynamic` executable handles various ensembles (NVE, NVT, NPT).

*   **Run MD Simulation**:
    `dynamic [molecule.xyz] [steps] [timestep_fs] [save_interval_ps] [ensemble_type] [temperature] [pressure]`
    *Ensemble Types*: 1 (NVE), 2 (NVT), 4 (NPT).
    *Example*: `dynamic water.xyz 100000 1.0 1.0 2 298.0` (100ps NVT at 298K).

### 4. Analysis and Properties
The `analyze` tool is the primary utility for extracting data from structures or trajectories.

*   **Energy Decomposition**:
    `analyze [molecule.xyz] [option]`
    *   Use option **E** to see a breakdown of potential energy by component (Bond, Angle, VDW, Electrostatics, etc.).
    *   Use option **P** to calculate total dipole moments.
    *   Use option **D** to calculate energy derivatives (gradients).

## Expert Tips and Best Practices

*   **The Key File (.key)**: Always maintain a `.key` file with the same base name as your XYZ file (e.g., `protein.key` for `protein.xyz`). Use this file to specify parameters, periodic boundary conditions (`axis` keywords), and specific force field modifications.
*   **Parameter Selection**: Ensure the parameter file (`.prm`) matches the version of Tinker being used. Tinker 25 is not backward compatible with older parameter sets.
*   **Memory Management**: If a calculation fails with a "segmentation fault" or "insufficient virtual memory," check the system swap space. Tinker uses dynamic memory allocation but can require significant RAM for systems exceeding 100,000 atoms.
*   **Trajectory Files**: MD results are stored in `.arc` files. These are essentially concatenated XYZ frames. Use `analyze` or `vmd` to process these files.
*   **Polarization Convergence**: When using AMOEBA, if polarization fails to converge, check the `polar-eps` keyword in your `.key` file to adjust the convergence criteria.



## Subcommands

| Command | Description |
|---------|-------------|
| tinker_analyze | Software Tools for Molecular Design |
| tinker_dynamic | Software Tools for Molecular Design |
| tinker_minimize | Software Tools for Molecular Design |
| tinker_newton | Software Tools for Molecular Design |
| tinker_pdbxyz | Tinker Software Tools for Molecular Design |
| tinker_vibrate | Software Tools for Molecular Design |
| tinker_xyzpdb | Software Tools for Molecular Design |

## Reference documentation
- [Tinker Software Tools for Molecular Design](./references/dasher_wustl_edu_tinker.md)
- [Tinker GitHub Repository Overview](./references/github_com_TinkerTools_tinker.md)
- [Tinker User Discussions and Troubleshooting](./references/github_com_TinkerTools_tinker_discussions.md)