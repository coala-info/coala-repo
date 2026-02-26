---
name: biobb_gromacs
description: "biobb_gromacs provides Python-based wrappers for GROMACS utilities to create modular and reproducible molecular dynamics pipelines. Use when user asks to perform system setup, configure simulations with grompp, run molecular dynamics with mdrun, or manage restraints and selections."
homepage: https://github.com/bioexcel/biobb_gromacs
---


# biobb_gromacs

## Overview
`biobb_gromacs` is a Python-based wrapper collection that transforms standard GROMACS utilities into modular "building blocks." This approach allows for the creation of complex, reproducible molecular dynamics pipelines that can easily transition between local workstations, HPC clusters, and containerized environments. The skill focuses on the specific execution patterns of these wrappers and provides expert guidance on handling common GROMACS-specific challenges within the BioBB framework.

## Core CLI Usage
BioBB modules are typically invoked as Python scripts. Each script wraps a specific GROMACS command and manages the underlying file requirements and environment settings.

### Common Tool Modules
- **System Setup**: `solvate`, `genion`, `insert_molecules`
- **Configuration**: `grompp`, `tpr_convert`
- **Simulation**: `mdrun`, `mdrun_plumed`
- **Restraints & Selection**: `genrestr`, `gmx_select`, `ndx2resttop`

### Standard Execution Pattern
Most BioBB-GROMACS tools use a consistent argument structure for defining inputs, outputs, and properties:
`python_script --input_file_path1 input.ext --output_file_path1 output.ext --properties '{"property_name": "value"}'`

## Expert Tips and Best Practices

### Performance and HPC Optimization
- **GPU Execution (GROMACS 2024+)**: For runs on GPU-enabled nodes using GROMACS 2024 or newer, you must often provide an explicit `-ntmpi` (number of thread-MPI ranks) setting. Failure to do so can lead to performance degradation or crashes.
- **Slurm Environment Variables**: Be cautious of `OMP_NUM_THREADS` leakage in Slurm environments. It is best practice to explicitly scope your environment variables per run or define them within the BioBB tool properties to ensure the simulation uses the intended CPU resources.

### System Preparation
- **Ion Replacement**: When using the `genion` wrapper, always ensure an index (`.ndx`) file is provided if you are targeting specific water groups for replacement. This ensures the tool correctly identifies the solvent molecules to be replaced by ions.
- **Position Restraints**: Use the `genrestr` tool to generate `.itp` files for heavy atom restraints. When integrating these into a topology, ensure you are not overwriting existing restraint definitions if multiple restraint sets are needed.

### Simulation Stability
- **Checkpoint Compatibility**: When resuming simulations, verify that your `.cpt` (checkpoint) file is compatible with the version of `grompp` and `mdrun` being used. Significant version jumps in the underlying GROMACS suite can occasionally cause conflicts in how checkpoint data is read.
- **No-Append Flag**: If you need to prevent GROMACS from appending to existing output files (which can be useful for certain automated analysis pipelines), ensure the `noappend` property is set in the `mdrun` configuration.

### Containerized Execution
For consistent results across different infrastructures, utilize the pre-built containers:
- **Docker**: `docker run quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0 <command>`
- **Singularity**: `singularity exec biobb_gromacs.sif <command>`

## Reference documentation
- [biobb_gromacs Overview](./references/anaconda_org_channels_bioconda_packages_biobb_gromacs_overview.md)
- [GitHub Repository](./references/github_com_bioexcel_biobb_gromacs.md)
- [Issues and Bug Reports](./references/github_com_bioexcel_biobb_gromacs_issues.md)
- [Wiki Documentation](./references/github_com_bioexcel_biobb_gromacs_wiki.md)