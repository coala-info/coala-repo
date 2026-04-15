---
name: xclone
description: XClone infers allele- and haplotype-specific copy numbers and identifies subclonal CNAs in single cells. Use when user asks to infer allele- and haplotype-specific copy numbers, identify subclonal CNAs, process raw sequencing files, infer CNAs using read depth ratio or B-allele frequency, or combine RDR and BAF signals for clonal architecture inference.
homepage: https://github.com/single-cell-genetics/XClone
metadata:
  docker_image: "quay.io/biocontainers/xclone:0.4.0--pyhdfd78af_0"
---

# xclone

## Overview
XClone is a specialized algorithm designed to infer allele- and haplotype-specific copy numbers in individual cells. It is optimized for the sparse, low-coverage data typical of 10x Genomics and Smart-seq platforms. By integrating Read Depth Ratio (RDR) and B-Allele Frequency (BAF) information, it enables the identification of subclonal CNAs that are often missed by traditional methods.

## Installation and Environment
For optimal stability and performance, follow these environment specifications:

- **Python Version**: Python 3.9 is strongly recommended. While 3.7 is supported, 3.9 provides the most stable performance for the latest releases.
- **Environment Management**: Use Anaconda to prevent dependency conflicts.
  ```bash
  conda create -n xclone python=3.9
  conda activate xclone
  ```
- **Core Package**: Install via PyPI or GitHub for the development version.
  ```bash
  pip install xclone
  # Or for development version:
  pip install git+https://github.com/single-cell-genetics/XClone
  ```
- **Preprocessing Toolkit**: `xcltk` is required for data preparation.
  ```bash
  pip install -U xcltk
  ```

## Core Workflow Patterns
The XClone analysis pipeline typically follows a three-module sequence:

1.  **Preprocessing (`xcltk`)**: Use this toolkit to process raw sequencing files into the count matrices required for XClone.
2.  **RDR Module**: Infers CNAs based on total read depth.
3.  **BAF Module**: Infers CNAs based on allelic imbalance.
4.  **Combine Module**: Integrates RDR and BAF signals for final clonal architecture inference.

## Expert Tips and Best Practices
Based on recent updates and performance optimizations:

- **RDR Configuration**: In the RDR module, it is currently recommended to set `low_rank=False` as the default for better results in standard workflows.
- **Clustering Optimization**: When running the combine module, you can customize the number of clones to better fit the biological complexity of your sample.
- **Data Handling**:
    - If encountering memory issues with large datasets, ensure you are using the `toarray()` method instead of `.A` when handling `csc_matrix` objects in Python scripts.
    - XClone includes specific fixes for handling "0 library size" errors in the Gaussian base module; ensure you are using version 0.4.0 or later.
- **BAF Phasing**: For improved convergence in BAF signals, utilize the "reverse global phasing" step.
- **Reference Cells**: The BAF module supports multiple reference cell types. Ensure your reference cells are correctly labeled in the input AnnData object to improve phasing accuracy.
- **Spatial Data**: XClone is compatible with 10x Visium spatial transcriptomics data, following the same RDR/BAF integration logic used for single-cell data.

## Reference documentation
- [XClone GitHub Repository](./references/github_com_single-cell-genetics_XClone.md)
- [Bioconda XClone Overview](./references/anaconda_org_channels_bioconda_packages_xclone_overview.md)