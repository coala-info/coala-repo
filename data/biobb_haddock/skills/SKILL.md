---
name: biobb_haddock
description: The biobb_haddock tool provides Python-based building blocks to integrate the HADDOCK software suite into automated protein-protein docking workflows. Use when user asks to perform flexible protein-protein docking, define experimental restraints for simulations, or execute HADDOCK docking steps within a bioinformatics pipeline.
homepage: https://github.com/bioexcel/biobb_haddock
---


# biobb_haddock

## Overview

The `biobb_haddock` module is a collection of Python-based building blocks that wrap the HADDOCK (High Ambiguity Driven protein-protein DOCKing) software suite. It is designed to integrate HADDOCK's powerful docking capabilities into automated bioinformatics workflows. The skill allows users to perform flexible protein-protein docking by providing a consistent interface for setting up simulations, defining restraints based on experimental data (like NMR or mutagenesis), and executing the docking steps.

## Installation and Setup

The tool can be installed via multiple package managers or used through containers:

- **Conda**: `conda install -c bioconda biobb_haddock`
- **PIP**: `pip install "biobb_haddock>=5.2.0"` (Note: Dependencies must be managed manually with PIP).
- **Docker**: `docker pull quay.io/biocontainers/biobb_haddock:5.2.0--pyhdfd78af_0`
- **Singularity**: `singularity pull --name biobb_haddock.sif https://depot.galaxyproject.org/singularity/biobb_haddock:5.2.0--pyhdfd78af_0`

## Common CLI Patterns

All `biobb_haddock` modules follow a standard BioBB command-line structure. The primary interaction method is passing a JSON configuration file along with input and output file paths.

### General Command Structure
```bash
[tool_name] --config config.json --input_file_path1 input1.pdb --input_file_path2 input2.pdb --output_file_path output.zip
```

### Configuration File (JSON)
The tool relies on a JSON file to define simulation parameters. 
```json
{
    "properties": {
        "project_name": "docking_simulation",
        "haddock_dir": "/path/to/haddock/installation",
        "binary_path": "haddock3"
    }
}
```

## Expert Tips and Best Practices

- **Path Management**: Always use absolute paths for configuration options within your JSON files to ensure the HADDOCK engine correctly locates local installations and temporary directories.
- **Container Selection**: For MacOS users, it is strongly recommended to use **Docker** instead of Singularity for better stability and performance.
- **Folder-Based I/O**: Recent versions of the tool (v5.1.0+) support using folders as inputs and outputs for certain steps. This is particularly useful for `haddock3_run` operations where multiple models are generated.
- **Dependency Check**: If installing via PIP, ensure that the underlying HADDOCK software and its specific requirements (like CNS) are correctly configured in your environment and accessible via the `binary_path` property.
- **Command Help**: You can access specific help and available file formats for any module by running the command with the `-h` flag:
  ```bash
  haddock3_run -h
  ```

## Reference documentation
- [Anaconda Biobb Haddock Overview](./references/anaconda_org_channels_bioconda_packages_biobb_haddock_overview.md)
- [GitHub Biobb Haddock README](./references/github_com_bioexcel_biobb_haddock.md)