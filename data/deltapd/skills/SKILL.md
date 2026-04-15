---
name: deltapd
description: DeltaPD identifies gene trees that significantly deviate from a reference tree. Use when user asks to find outlier gene trees compared to a reference tree.
homepage: https://github.com/Ecogenomics/DeltaPD
metadata:
  docker_image: "quay.io/biocontainers/deltapd:0.1.5--py39h918f1d6_7"
---

# deltapd

## Overview

DeltaPD is a command-line tool designed to pinpoint gene trees that deviate significantly from a provided reference tree. This is particularly useful in evolutionary biology and phylogenetics for identifying potential errors in tree construction, unusual evolutionary events, or genes with distinct evolutionary histories. It helps researchers ensure the accuracy and reliability of their phylogenetic analyses.

## Usage

DeltaPD is primarily used via its command-line interface. The core functionality involves providing both a gene tree and a reference tree to the tool.

### Installation

It is recommended to install DeltaPD using conda:

```bash
conda install bioconda::deltapd
```

Alternatively, it can be installed via PyPI:

```bash
python -m pip install deltapd
```

After installation, the `deltapd` command will be available in your PATH.

### Basic Command Structure

The fundamental command structure for DeltaPD is:

```bash
deltapd <gene_tree_file> <reference_tree_file> [options]
```

Where:
- `<gene_tree_file>`: Path to the file containing the gene tree(s) in a Newick or similar format.
- `<reference_tree_file>`: Path to the file containing the reference tree in a Newick or similar format.

### Key Options and Considerations

While the documentation does not extensively detail specific command-line options, common practices for such tools suggest the following:

*   **Tree Format**: Ensure your input tree files are in a compatible format (e.g., Newick).
*   **Output**: The tool will typically output information about the identified outliers, possibly including scores or metrics indicating the degree of deviation. The exact output format will depend on the tool's implementation.
*   **Environment**: It's best practice to run DeltaPD within a dedicated environment (e.g., a conda environment) to manage dependencies and avoid conflicts.

### Expert Tips

*   **Data Preparation**: Before running DeltaPD, ensure your gene trees and reference tree are correctly formatted and represent the data accurately. Errors in input trees will lead to erroneous outlier detection.
*   **Interpretation**: The output of DeltaPD should be interpreted in the context of your biological question. A detected "outlier" might represent a genuine evolutionary event or a data artifact. Further investigation is often required.
*   **Version Management**: When using bioinformatics tools, it's crucial to note the version used for reproducibility. The current version mentioned is 0.1.5.

## Reference documentation

- [DeltaPD Overview (Anaconda.org)](./references/anaconda_org_channels_bioconda_packages_deltapd_overview.md)
- [DeltaPD GitHub Repository](./references/github_com_Ecogenomics_DeltaPD.md)