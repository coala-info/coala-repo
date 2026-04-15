---
name: phylogenetics
description: This tool provides a Python API to orchestrate phylogenetic workflows by wrapping PhyML for tree building and PAML for ancestral reconstruction. Use when user asks to build phylogenetic trees, reconstruct ancestral sequences, or programmatically manage phylogenetic project data.
homepage: https://github.com/Zsailer/phylogenetics
metadata:
  docker_image: "quay.io/biocontainers/phylogenetics:0.5.0--py_0"
---

# phylogenetics

## Overview

The `phylogenetics` skill provides a high-level Python API to orchestrate phylogenetic analysis. It serves as a management layer that wraps external tools—specifically PhyML for tree building and PAML for ancestral reconstruction—integrating them into a cohesive workflow. Use this skill when you need to programmatically handle phylogenetic data, compute trees from alignments, and infer ancestral states while maintaining project organization.

## Core Workflow

To execute a standard phylogenetic analysis, follow this sequence:

1.  **Initialize the Project**: Create a `PhylogeneticsProject` object to manage the directory structure and data state.
2.  **Import Data**: Load your multiple sequence alignment (MSA). The tool typically expects FASTA format but supports various schemas via `PhyloPandas`.
3.  **Build Tree**: Generate a maximum likelihood tree using the integrated PhyML wrapper.
4.  **Reconstruct Ancestors**: Perform ancestral sequence reconstruction using the PAML wrapper.

## Implementation Patterns

### Basic Project Execution
```python
from phylogenetics import PhylogeneticsProject

# Initialize project directory
project = PhylogeneticsProject(project_dir='my_phylogeny')

# Load alignment data
project.read_data(dtype='tips', path='alignment.fasta', schema='fasta')

# Run phylogenetic pipeline
project.compute_tree()
project.compute_ancestors()
```

### Data Management Tips
- **Schema Support**: Leverage the `schema` argument in `read_data` to handle different file formats (e.g., 'fasta', 'phylip').
- **Interactive Analysis**: The API is optimized for Jupyter notebooks, allowing for step-by-step execution and inspection of the `project` object.
- **Underlying Data**: The tool uses `PhyloPandas` and `Pandas` internally. You can access the underlying DataFrames to perform custom filtering or metadata manipulation on your sequences.

## Expert Practices
- **External Dependencies**: Ensure that `PhyML` and `PAML` are installed and available in your system's PATH, as the `phylogenetics` package acts as a wrapper and does not include the binary executables.
- **Project Persistence**: The `project_dir` stores the state of your analysis. You can point to an existing directory to resume a project or inspect previous results.
- **Visualization**: Since the tool is built on `ToyTree`, use ToyTree's drawing capabilities to visualize the resulting trees directly from the project object.

## Reference documentation
- [phylogenetics - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_phylogenetics_overview.md)
- [GitHub - Zsailer/phylogenetics: A Python API for managing phylogenetics projects](./references/github_com_Zsailer_phylogenetics.md)