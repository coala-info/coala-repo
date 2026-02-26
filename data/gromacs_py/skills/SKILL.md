---
name: gromacs_py
description: gromacs_py is a Python wrapper for the GROMACS molecular dynamics suite that automates system preparation and simulation workflows. Use when user asks to generate topologies, prepare molecular systems with solvation and neutralization, or execute MD simulations including minimization and equilibration.
homepage: https://github.com/samuelmurail/gromacs_py
---


# gromacs_py

## Overview
`gromacs_py` is a specialized Python library that acts as a high-level wrapper for the GROMACS MD simulation suite. It is designed to transform manual, error-prone command-line sequences into reproducible Python scripts. Use this skill when you need to automate routine MD operations, particularly when handling multiple systems or requiring programmatic control over topology generation and system preparation.

## Installation and Environment Setup
The library is primarily distributed via Bioconda. Ensure that GROMACS and its dependencies are correctly mapped in your environment.

- **Preferred Installation**: Use conda to handle both the library and the GROMACS engine.
  ```bash
  conda install -c bioconda gromacs_py
  ```
- **Manual Path Configuration**: If GROMACS is installed separately, the `gmx` executable must be in your system PATH.
  ```bash
  export PATH="*path_to_gromacs*/bin/":$PATH
  ```
- **Dependencies**: The tool relies on `Ambertools`, `Rdkit`, and `Acpype` for advanced topology generation (especially for small molecules).

## Core Workflow Patterns
The library follows a sequential MD preparation logic. Use the following functional areas to build your scripts:

### 1. Topology Generation
`gromacs_py` can generate topologies directly from PDB files. It integrates with `pdb2pqr` and `Ambertools`.
- Use `TopMol` imports for handling molecular topologies.
- Utilize `extract_itp_atomtypes()` to manage atom type definitions when merging different force field parameters.

### 2. System Preparation
Automate the "box-water-ions" sequence which is typically tedious in standard CLI:
- **Box Creation**: Define Periodic Boundary Conditions (PBC) and box dimensions.
- **Solvation**: Programmatically add water molecules to the defined box.
- **Neutralization**: Add counter-ions (Na+, Cl-) to neutralize the system charge based on the generated topology.

### 3. Simulation Execution
The wrapper provides methods to trigger GROMACS runs:
- **Minimization**: Run steepest descent or conjugate gradient algorithms.
- **Equilibration**: Execute NVT and NPT ensembles to stabilize temperature and pressure.
- **Production**: Launch the final MD data collection phase.

## Expert Tips and Best Practices
- **Version Compatibility**: While the library supports GROMACS 5.1 and newer, certain features like cyclic peptide handling may have specific version requirements. Always verify the GROMACS version if a simulation fails during the `grompp` phase.
- **Atom Manipulation**: Use the `add_atoms()` and `add_nb_pairs()` functions for custom topology modifications or when working with non-standard residues.
- **Error Handling**: If you encounter a mismatch between `.gro` and `.tpr` files, ensure that the topology (`.top`) used during the `grompp` step exactly matches the coordinate file from the previous equilibration step.
- **Automation**: Leverage the library's ability to loop through multiple PDB files to set up high-throughput simulation batches, which is the primary strength of this wrapper over manual GROMACS CLI usage.

## Reference documentation
- [Gromacs_py Overview](./references/anaconda_org_channels_bioconda_packages_gromacs_py_overview.md)
- [Gromacs_py GitHub Repository](./references/github_com_samuelmurail_gromacs_py.md)
- [Gromacs_py Commit History](./references/github_com_samuelmurail_gromacs_py_commits_master.md)