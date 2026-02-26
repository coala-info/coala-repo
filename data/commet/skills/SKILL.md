---
name: commet
description: COMMET compares large-scale metagenomic datasets by indexing raw reads and using bit vectors to identify shared k-mers without the need for assembly. Use when user asks to generate a similarity matrix between multiple read sets, perform set operations like intersection or difference on datasets, or visualize metagenomic clustering through heatmaps and dendrograms.
homepage: https://colibread.inria.fr/software/commet/
---


# commet

## Overview
COMMET is a specialized tool designed for large-scale metagenomic projects where assembling every dataset is impractical. It works by indexing raw reads and using bit vectors to represent the presence or absence of k-mers across different samples. This allows for rapid global similarity assessments and the ability to extract specific subsets of reads that are shared between or unique to certain datasets.

## Core Workflows and CLI Patterns

### 1. Global Comparison (All-against-All)
The primary use case is generating a similarity matrix between multiple read sets.
- **Input**: A set of FASTA/FASTQ files (usually listed in a configuration file or directory).
- **Process**: COMMET indexes the k-mers and compares the bit vectors.
- **Output**: A distance matrix, often accompanied by a Python script to generate heatmaps and dendrograms.

### 2. Logical Operations on Datasets
Because COMMET stores read information as bit vectors, you can perform set theory operations:
- **Intersection**: Find reads present in both Dataset A and Dataset B.
- **Union**: Combine reads from multiple datasets while removing redundancy.
- **Difference**: Identify reads present in Dataset A but strictly absent from Dataset B (useful for subtraction mapping).

### 3. Visualization
After the comparison phase, COMMET typically produces a `.matrix` file. Use the bundled visualization scripts (often requiring `matplotlib` or `scipy`) to create:
- **Heatmaps**: To visualize the percentage of shared k-mers.
- **Dendrograms**: To see the hierarchical clustering of metagenomes based on biological similarity.

## Best Practices
- **K-mer Selection**: Ensure the k-mer size (default is often 31) is appropriate for your data's complexity and error rate.
- **Memory Management**: COMMET is efficient, but for very large datasets, ensure your environment has sufficient RAM for the indexing phase.
- **Read Quality**: While COMMET works on non-assembled reads, performing basic adapter trimming and quality filtering beforehand improves the accuracy of the similarity metrics.
- **Conda Installation**: The most reliable way to deploy COMMET is via Bioconda: `conda install -c bioconda commet`.

## Reference documentation
- [COMMET Software Home](./references/colibread_inria_fr_software_commet.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_commet_overview.md)