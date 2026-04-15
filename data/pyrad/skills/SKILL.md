---
name: pyrad
description: pyrad is a bioinformatics pipeline for the de novo or reference-based assembly of RADseq data into filtered datasets for phylogenetic and population genetic analysis. Use when user asks to assemble RADseq data, generate a template parameters file, or maintain legacy pyrad workflows.
homepage: https://github.com/dereneaton/pyrad
metadata:
  docker_image: "quay.io/biocontainers/pyrad:3.0.66--py27_0"
---

# pyrad

## Overview

pyrad is a bioinformatics pipeline designed for the de novo or reference-based assembly of RADseq data. It streamlines the transition from raw Illumina sequencing reads to filtered, aligned data sets suitable for phylogenetic and population genetic analysis. It is important to note that pyrad has been superseded by ipyrad; however, this skill provides the necessary guidance for users maintaining legacy pyrad workflows or reproducing results from older studies.

## Core CLI Usage

The pyrad workflow is centered around a parameters file (typically named `params.txt`) which defines the input data, filtering thresholds, and assembly settings.

### Initialization
To start a new project, generate a template parameters file:
```bash
pyrad -n
```
This creates a `params.txt` file in the current directory with default values and comments explaining each parameter.

### Running the Pipeline
Once the `params.txt` file is configured with your data paths and settings, execute the pipeline:
```bash
pyrad -p params.txt
```

### Help and Versioning
To check the installed version or view available command-line flags:
```bash
pyrad -h
```

## Best Practices and Expert Tips

### Workflow Management
- **Transition to ipyrad**: The developer recommends that all new projects use `ipyrad` instead of `pyrad` due to significant speed improvements and expanded feature sets.
- **Dependency Verification**: Ensure that `muscle` and `vsearch` are in your system PATH, as pyrad relies on these external tools for sequence alignment and clustering.
- **Parameter Tuning**: The `params.txt` file is sensitive to formatting. Ensure that the parameter values are placed correctly after the double-slash (`//`) or specific delimiters used in the template.
- **Memory Considerations**: For large data sets, ensure your environment has sufficient memory for `numpy` and `scipy` operations, especially during the clustering and alignment phases.

### Installation Patterns
- **Conda (Recommended)**: Use the bioconda channel for the most reliable installation of pyrad and its dependencies:
  ```bash
  conda install bioconda::pyrad
  ```
- **Manual Installation**: If installing from source, ensure you have `numpy` and `scipy` pre-installed:
  ```bash
  cd pyrad
  sudo pip install .
  ```

## Reference documentation
- [pyrad - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_pyrad_overview.md)
- [dereneaton/pyrad: Assembly and analysis of RADseq data sets](./references/github_com_dereneaton_pyrad.md)