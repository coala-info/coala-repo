---
name: andi
description: andi calculates evolutionary distances between closely related genomic sequences using an alignment-free approach based on long exact matches. Use when user asks to estimate genomic distances, generate a distance matrix for phylogeny reconstruction, or compare thousands of closely related genomes efficiently.
homepage: https://github.com/evolbioinf/andi/
metadata:
  docker_image: "quay.io/biocontainers/andi:0.14--hfc2f157_2"
---

# andi

## Overview

`andi` (ANchor DIstances) is an alignment-free tool optimized for calculating the evolutionary distance between closely related genomic sequences. Unlike traditional methods that require full multiple sequence alignments, `andi` identifies long exact matches (anchors) to estimate distances, making it exceptionally fast and capable of scaling to thousands of genomes. It is primarily used as a preprocessing step for phylogeny reconstruction.

## Usage and Best Practices

### Basic Command Pattern
The simplest way to use `andi` is to provide a list of FASTA files. The tool will output a distance matrix in a format compatible with most phylogeny software.

```bash
andi genome1.fasta genome2.fasta genome3.fasta > distances.dist
```

### Input Requirements
- **Format**: Input must be in FASTA format.
- **Relatedness**: `andi` is specifically designed for **closely related** sequences (e.g., different strains of the same bacterial species). It may be less accurate for highly divergent sequences where anchors are difficult to find.
- **Multiple Sequences**: You can pass many files at once or use wildcards (e.g., `andi *.fasta`).

### Common CLI Workflows
1. **Generating a Distance Matrix**:
   The default output is a symmetric distance matrix.
   ```bash
   andi *.fna > matrix.txt
   ```

2. **Phylogeny Reconstruction**:
   The output matrix is typically used as input for neighbor-joining algorithms.
   ```bash
   andi *.fasta | neighbor > tree.nwk
   ```

3. **Accessing Help**:
   For a full list of parameters including sensitivity and anchor settings:
   ```bash
   andi --help
   ```

### Expert Tips
- **Performance**: Because `andi` is alignment-free, it is significantly faster than tools like ClustalW or MAFFT for large datasets. Use it when you have hundreds or thousands of genomes.
- **Memory**: `andi` uses suffix arrays (via `libdivsufsort`). Ensure your system has enough RAM to hold the index for the combined size of your input genomes.
- **Installation**: The most reliable way to install `andi` in a bioinformatics environment is via Bioconda:
  ```bash
  conda install bioconda::andi
  ```

## Reference documentation
- [andi - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_andi_overview.md)
- [GitHub - EvolBioInf/andi: Efficient Estimation of Evolutionary Distances](./references/github_com_EvolBioInf_andi.md)