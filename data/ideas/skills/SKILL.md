---
name: ideas
description: IDEAS (Integrative Dynamic Epigenomic Annotation System) is a specialized tool for jointly and quantitatively characterizing multivariate epigenetic landscapes across many cell types, tissues, or conditions.
homepage: https://github.com/yuzhang123/IDEAS
---

# ideas

## Overview
IDEAS (Integrative Dynamic Epigenomic Annotation System) is a specialized tool for jointly and quantitatively characterizing multivariate epigenetic landscapes across many cell types, tissues, or conditions. Unlike methods that annotate genomes independently, IDEAS models multiple datasets simultaneously to better identify functional elements and patterns of epigenomic variation or conservation. It is particularly effective for generating robust, reproducible epigenetic state annotations from high-throughput sequencing data like ChIP-seq.

## Installation and Setup
The most reliable way to install IDEAS is via Bioconda:
```bash
conda install bioconda::ideas
```
Note: The pipeline requires R to be installed in the environment to execute the primary workflows.

## Core Usage Patterns

### Running the Pipeline
The primary entry point for modern IDEAS workflows is the R script `runideaspipe.R`. This script automates the process of starting from different initial values and combining results to produce a stable consensus.

### Handling Signal Noise
The way IDEAS handles data distribution is critical for accurate state assignment.
- **Default Log Transformation**: By default, the `-log2` option adds a pseudo-count of 1 to the signal.
- **Low-Signal Data**: If your data contains meaningful values smaller than 1 (e.g., mean read counts where values < 1 are not just noise), you must adjust the pseudo-count:
  ```bash
  # Example: Adding 0.1 instead of 1
  ideas -log2 0.1 [other_options]
  ```

### Improving Annotation Continuity
To reduce "flickering" between states and produce smoother genomic tracks, use the horizontal prior option:
- **Option**: `-hp`
- **Effect**: Improves the continuity of states along the chromosome. Use this when you prioritize broad functional domains over high-precision local transitions.

### Targeted Analysis
If you only need to process a specific region of the genome rather than the entire assembly, use the interval option:
- **Option**: `-inv`
- **Usage**: `ideas -inv [coordinates] [other_options]`

## Input Data Best Practices
IDEAS is designed to be flexible with input formats:
- **Direct Formats**: Supports BAM and BigWig files directly.
- **Preprocessing**: The tool can automatically process data from public repositories if configured, though local BAM/BigWig files are preferred for controlled environments.
- **Multivariate Input**: For best results, provide multiple marks (e.g., H3K4me3, H3K27ac, H3K4me1) across multiple cell types to allow the system to learn the joint distribution of signals.

## Reference documentation
- [IDEAS Overview and Installation](./references/anaconda_org_channels_bioconda_packages_ideas_overview.md)
- [IDEAS GitHub Documentation and CLI Usage](./references/github_com_yuzhang123_IDEAS.md)