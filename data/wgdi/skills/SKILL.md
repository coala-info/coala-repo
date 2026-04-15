---
name: wgdi
description: wgdi is a command-line tool for analyzing whole-genome duplications and reconstructing ancestral karyotypes. Use when user asks to identify syntenic blocks, calculate synonymous substitution rates (Ks), visualize Ks distribution, reconstruct ancestral karyotypes, construct phylogenetic trees, or detect chromosomal fusion events.
homepage: https://github.com/SunPengChuan/wgdi
metadata:
  docker_image: "quay.io/biocontainers/wgdi:0.75--pyhdfd78af_0"
---

# wgdi

## Overview
`wgdi` (Whole-Genome Duplication Integrated analysis) is a Python-based command-line utility designed for evolutionary genomics. It is primarily used to detect WGD events, distinguish subgenomes in polyploids, and reconstruct ancestral karyotypes. This skill helps you navigate its specific subprograms for collinearity detection, synonymous substitution rate (Ks) estimation, and chromosomal rearrangement analysis.

## Installation and Setup
Install `wgdi` via bioconda or pip:
```bash
conda install -c bioconda wgdi
# OR
pip install wgdi
```

## Core Subprograms and CLI Patterns
`wgdi` operates through specific flags that trigger different analysis modules. Most modules require a parameter file which can be generated using the `-conf` flag.

### 1. Collinearity and Homology Inference
*   **Improved Collinearity (`-icl`)**: Used to identify syntenic blocks.
    *   *Expert Tip*: In recent versions, the p-value parameter is more sensitive. It is recommended to set this to **0.2** rather than the traditional 0.05 to capture more relevant blocks.
*   **Block Information (`-bi`)**: Extracts details from collinear blocks. Use the `tandem_ratio` parameter to filter or identify tandem duplications.
*   **Shared Fusions (`-sf`)**: Identifies chromosomal fusion events shared between different species.

### 2. Ks (Synonymous Substitution) Analysis
*   **Calculate Ks (`-ks`)**: Computes the synonymous substitution rates for gene pairs in collinear blocks.
*   **Ks Visualization (`-kf`)**: Generates Ks distribution figures (ksfigure). This is essential for identifying WGD peaks and dating evolutionary events.

### 3. Ancestral Karyotyping
*   **Ancestral Karyotype (`-ak`)**: Reconstructs the ancestral state of chromosomes.
*   **Karyotype Mapping (`-km`)**: Maps modern genomes back to ancestral karyotypes to visualize rearrangements.
*   **Ancestral Karyotype Repertoire (`-akr`)**: Analyzes the full repertoire of ancestral chromosomal segments.

### 4. Phylogenetic and Fusion Analysis
*   **Alignment Trees (`-at`)**: Constructs phylogenetic trees from collinear genes.
    *   Supports low-copy datasets (e.g., output from `sonicparanoid2`).
    *   Use the `threads` parameter to speed up `iqtree` execution within this module.
*   **Fusion Positions (`-fpd`)**: Extracts a dataset of fusion positions for further evolutionary study.
*   **Fusion Detection (`-fd`)**: Determines if specific fusion events identified in one genome occur in others.

## Best Practices
*   **Parameter Files**: Always start by generating a template configuration file using `wgdi -conf ? > total.conf` (where `?` is the subprogram flag) to ensure all required parameters are defined.
*   **Data Preparation**: Ensure GFF and protein-coding sequence files are cleaned and gene names match across your input files to avoid `KeyError` or `IndexError` during Ks calculation.
*   **Thread Management**: When running `-at`, always specify the number of threads to optimize performance for large-scale alignments.

## Reference documentation
- [WGDI GitHub Repository](./references/github_com_SunPengChuan_wgdi.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_wgdi_overview.md)