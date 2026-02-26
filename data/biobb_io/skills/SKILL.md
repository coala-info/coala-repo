---
name: biobb_io
description: biobb_io retrieves molecular data and structural files from various bioinformatics repositories. Use when user asks to fetch PDB structures, download AlphaFold predictions, or retrieve molecular dynamics trajectories and chemical components.
homepage: https://github.com/bioexcel/biobb_io
---


# biobb_io

## Overview
`biobb_io` serves as the data acquisition layer for the BioExcel Building Blocks suite. It provides a collection of Python-based wrappers that standardize the retrieval of molecular data from various bioinformatics repositories. By using this skill, you can automate the initial "fetch" step of a computational workflow, ensuring that structural files and metadata are downloaded in a format compatible with downstream simulation and analysis tools.

## Installation and Setup
The recommended way to use `biobb_io` is through a Conda environment to ensure all bioinformatics dependencies are correctly managed.

```bash
# Install via Bioconda
conda install -c bioconda biobb_io
```

## Command Line Usage Patterns
All modules in `biobb_io` follow a consistent Command Line Interface (CLI) structure. The general syntax requires input parameters (like database IDs), output file paths, and an optional configuration file.

### General Syntax
`tool_name --input_argument value --output_argument value --config config.json`

### Common Modules and Tasks
- **PDB Fetching**: Retrieve 3D structures from the Protein Data Bank.
  - Tool: `pdb`
  - Typical inputs: PDB ID codes.
- **AlphaFold Predictions**: Fetch predicted structures from the AlphaFold Protein Structure Database.
  - Tool: `alphafold`
- **MDDB Data**: Retrieve molecular dynamics trajectories and metadata from the Molecular Dynamics Data Bank.
  - Tool: `mddb`
- **Chemical Components**: Fetch small molecule data or idealized coordinates.
  - Tool: `ideal_sdf` (used for fetching idealized SDF files for ligands).

## Best Practices
- **Configuration Files**: While many parameters can be passed via CLI, using a JSON configuration file is the standard BioBB practice for reproducibility.
- **MMB Mirror**: When the primary RCSB PDB servers are slow or unavailable, `biobb_io` tools often support fetching from the MMB (Molecular Modeling and Bioinformatics) mirror. Ensure your API URLs are updated to the latest versions (e.g., moving away from old MMB API endpoints as noted in recent updates).
- **Output Validation**: Always verify the integrity of the fetched file (e.g., checking if a PDB file contains the expected chains) before passing it to processing blocks like `biobb_structure_checking`.
- **Containerization**: For high-performance computing (HPC) environments, use the Docker or Singularity images provided by BioExcel to avoid local dependency conflicts.

## Reference documentation
- [github_com_bioexcel_biobb_io.md](./references/github_com_bioexcel_biobb_io.md)
- [anaconda_org_channels_bioconda_packages_biobb_io_overview.md](./references/anaconda_org_channels_bioconda_packages_biobb_io_overview.md)
- [github_com_bioexcel_biobb_io_commits_master.md](./references/github_com_bioexcel_biobb_io_commits_master.md)