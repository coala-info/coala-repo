---
name: metatree
description: metatree maps and visualizes polyphyletic groups by comparing query phylogenetic trees against a reference tree to identify topological conflicts. Use when user asks to identify taxonomic inconsistencies across multiple trees, visualize polyphyly, or compare query tree topologies to a designated reference.
homepage: https://github.com/aaronmussig/metatree
metadata:
  docker_image: "quay.io/biocontainers/metatree:0.0.1--py_0"
---

# metatree

## Overview

metatree is a specialized bioinformatics tool designed to map and visualize polyphyletic groups by comparing a set of query phylogenetic trees against a designated reference tree. It is particularly useful for researchers looking to identify topological conflicts or taxonomic inconsistencies across large batches of trees, providing a systematic way to see how groups defined in a reference are distributed across other tree topologies.

## Installation

Install metatree via Bioconda or PyPI:

```bash
# Using Conda
conda install -c bioconda metatree

# Using pip
pip install metatree
```

## Command Line Usage

The tool follows a specific positional argument structure:

```bash
metatree [batchfile] [out_dir] [taxonomy_file] [outgroup] [cpus]
```

### Argument Definitions

- **batchfile**: A text file containing paths to the Newick-formatted trees.
- **out_dir**: The directory where visualization results and analysis files will be saved.
- **taxonomy_file**: A file mapping leaf nodes to taxonomic groups.
- **outgroup**: The name of the taxon to be used as the outgroup for rooting.
- **cpus**: The number of CPU cores to allocate for parallel processing.

## Best Practices and Requirements

### Batchfile Structure
The most critical requirement for metatree is the structure of the `batchfile`. The tool expects the reference tree to be the first entry.
- **Line 1**: Path to the reference tree file.
- **Line 2+**: Paths to the query trees (one per line).

### Data Preparation
- Ensure all tree files are in a standard format (typically Newick) that the tool can parse.
- The `taxonomy_file` must contain identifiers that match the leaf labels in your tree files exactly.
- When selecting an `outgroup`, ensure that the specified taxon is present in all trees listed in the batchfile to avoid rooting errors during the comparison phase.

### Performance
For large datasets involving hundreds of trees, utilize the `cpus` parameter to significantly reduce the time required for polyphyly calculation and visualization generation.

## Reference documentation
- [metatree GitHub Repository](./references/github_com_aaronmussig_metatree.md)
- [metatree Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_metatree_overview.md)