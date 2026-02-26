---
name: biobb_md
description: The biobb_md tool provides a standardized interface for executing molecular dynamics tasks and GROMACS simulation workflows. Use when user asks to convert PDB files to topologies, define simulation boxes, solvate structures, or execute molecular dynamics simulations.
homepage: https://github.com/bioexcel/biobb_md
---


# biobb_md

## Overview
The biobb_md skill provides a standardized interface for executing molecular dynamics tasks. It acts as a compatibility layer over GROMACS, allowing for reproducible simulation steps such as structure conversion, energy minimization, and production runs. While this package has been superseded by `biobb_gromacs`, it remains the primary tool for legacy BioBB MD workflows. It is best used for automating the transition from a PDB structure to a finished simulation trajectory through discrete, modular steps.

## Installation and Setup
To use the tools in this skill, ensure the environment is properly configured:
- **Conda**: `conda install -c bioconda biobb_md`
- **Docker**: `docker pull quay.io/biocontainers/biobb_md:3.7.2--pyhdfd78af_0`
- **Singularity**: `singularity pull --name biobb_md.sif https://depot.galaxyproject.org/singularity/biobb_md:3.7.2--pyhdfd78af_0`

## Common CLI Patterns
All modules in biobb_md follow a consistent command-line structure. Replace `[module_name]` with the specific tool (e.g., `pdb2gmx`, `solvate`, `mdrun`).

```bash
[module_name] --config config.json --input_file_path1 input.ext --output_file_path1 output.ext
```

### Core Modules
- **pdb2gmx**: Converts PDB files to GROMACS structures and topologies. Supports force fields like `amber99sb-star-ildn-mut`.
- **editconf**: Defines the simulation box dimensions and centers the molecule.
- **solvate**: Adds solvent (typically water) to the simulation box.
- **grompp**: Processes the structure, topology, and parameters into a binary run file (.tpr).
- **mdrun**: Executes the actual simulation (minimization, equilibration, or production).

## Best Practices and Expert Tips
- **Configuration Files**: Always use a JSON file for the `--config` argument to define internal parameters (e.g., temperature, pressure, step size). This ensures the command line remains clean and the simulation parameters are documented.
- **Deprecation Strategy**: If starting a new project, migrate to `biobb_gromacs`. Use `biobb_md` only for reproducing older results or maintaining existing scripts.
- **File Formats**: Note that `editconf` and `solvate` in this version support PDB format inputs and outputs, which is useful for checking intermediate steps in standard molecular viewers.
- **Container Execution**: When using Docker or Singularity, ensure you mount your local working directory to the container to allow the tool to read input files and write results.
- **Force Field Selection**: For protein mutations or specific AMBER-based workflows, verify the availability of `amber99sb-star-ildn-mut` within the `pdb2gmx` module configuration.

## Reference documentation
- [Anaconda Bioconda biobb_md Overview](./references/anaconda_org_channels_bioconda_packages_biobb_md_overview.md)
- [GitHub biobb_md Repository](./references/github_com_bioexcel_biobb_md.md)