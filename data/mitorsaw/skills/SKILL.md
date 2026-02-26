---
name: mitorsaw
description: "Mitorsaw analyzes mitochondrial DNA variants in PacBio HiFi sequencing data, distinguishing homoplasmic and heteroplasmic variants while removing NUMT reads. Use when user asks to call mitochondrial variants, analyze heteroplasmic variants, or filter NUMT reads."
homepage: https://github.com/PacificBiosciences/mitorsaw
---


# mitorsaw

---
## Overview
Mitorsaw is a specialized bioinformatics tool designed for the in-depth analysis of mitochondrial DNA variants within PacBio HiFi sequencing data. It excels at identifying both homoplasmic (present in all copies) and heteroplasmic (present in a subset of copies) variants across the entire mitochondrial genome. A key feature is its ability to distinguish and remove nuclear mitochondrial DNA (NUMT) reads, which can otherwise confound variant calling. Furthermore, mitorsaw can construct phylogenetic-like structures to understand heteroplasmic variant inheritance patterns and estimate haplotype abundances, ultimately generating consensus sequences for each identified haplotype.

## Usage Instructions

Mitorsaw is primarily used via its command-line interface. The core functionality revolves around processing sequencing data to identify and analyze mitochondrial variants.

### Core Functionality and Commands

The primary command for running mitorsaw is `mitorsaw`. While specific subcommands are not detailed in the provided documentation, the tool's purpose suggests a workflow that likely involves inputting sequencing reads and outputting variant calls, phylogenetic information, and consensus sequences.

### Input Data

Mitorsaw is designed to work with PacBio HiFi sequencing data. The exact format of the input reads (e.g., FASTQ, BAM) is not explicitly stated but is typical for such tools.

### Key Analysis Steps and Outputs

1.  **Variant Identification**: Detects homoplasmic and heteroplasmic variants in the mitochondrial genome.
2.  **NUMT Read Removal**: Filters out reads originating from nuclear mitochondrial DNA to improve variant calling accuracy.
3.  **Phylogenetic Analysis**: Generates a tree-like structure to visualize heteroplasmic variant inheritance and haplotype relationships.
4.  **Haplotype Consensus Sequences**: Creates consensus sequences for each identified mitochondrial haplotype.

### Expert Tips and Best Practices

*   **Data Quality**: Ensure your PacBio HiFi sequencing data is of high quality, as this will directly impact the accuracy of variant detection and downstream analyses.
*   **NUMT Filtering**: Pay close attention to the NUMT read removal step. Accurate filtering is crucial for reliable mitochondrial variant analysis.
*   **Interpreting Phylogeny**: The generated phylogenetic tree is a powerful tool for understanding evolutionary relationships and inheritance patterns of mitochondrial variants. Familiarize yourself with phylogenetic interpretation to gain the most insight.
*   **Haplotype Analysis**: The consensus sequences for each haplotype can be used for further comparative genomics or population studies.

## Reference documentation
- [Mitorsaw Overview](./references/anaconda_org_channels_bioconda_packages_mitorsaw_overview.md)
- [Mitorsaw GitHub Repository](./references/github_com_PacificBiosciences_mitorsaw.md)