---
name: balrog
description: Balrog is a data-driven prokaryotic gene finder that utilizes a universal model to identify genes across diverse species without requiring genome-specific training. Use when user asks to predict genes in bacterial genomes, annotate metagenomic bins, or identify protein-coding sequences in prokaryotic assemblies.
homepage: https://github.com/Markusjsommer/BalrogCPP
---


# balrog

## Overview

Balrog (Bacterial Annotation by Learned Representation Of Genes) is a data-driven prokaryotic gene finder. While traditional gene finders often require training on the specific genome being analyzed, Balrog utilizes a universal model trained on a massive, diverse collection of protein sequences. This allows it to maintain high sensitivity across different species while reducing the number of false-positive gene predictions. It is an ideal choice for high-throughput annotation pipelines where species-specific parameters are unknown or difficult to obtain.

## Installation and Setup

Balrog requires specific versions of PyTorch and is best managed via Conda to ensure all C++ dependencies and Python libraries are correctly linked.

```bash
# Create a dedicated environment
conda create -n balrog_env python=3.7 -y
conda activate balrog_env

# Install balrog and the required version of pytorch
conda install balrog -c conda-forge -c bioconda -y
conda install pytorch=1.7.1 -c conda-forge -y
```

## CLI Usage and Patterns

The primary interface is the `balrog` command. 

### Basic Gene Prediction
To run gene prediction on a genomic FASTA file:
```bash
balrog --genome input_genome.fasta --out output_prefix
```

### Common Arguments
*   `--genome`: Path to the input assembly or genome in FASTA format.
*   `--out`: Prefix for the output files (typically generates GFF3 and protein FASTA files).
*   `--threads`: Specify the number of CPU threads for parallel processing.
*   `--mmseqs`: (Available in v0.3.0+) Enable MMseqs2 support for faster protein sequence searching and validation.

### Expert Tips
*   **Universal Application**: Because Balrog is "universal," you can use the same command and model for any prokaryotic sequence without adjusting heuristic parameters like GC-content or coding statistics.
*   **Metagenomics**: Balrog is highly effective for metagenomic bins or short contigs where there isn't enough sequence data to "self-train" traditional gene finders like GeneMarkS or Prodigal.
*   **Version Consistency**: Ensure you are using PyTorch 1.7.1. Newer versions of PyTorch may introduce breaking changes in how the TCN model weights are loaded or executed.
*   **MMseqs2 Integration**: If your workflow involves functional annotation, use the MMseqs2 integration to streamline the transition from gene prediction to protein homology searching.

## Reference documentation
- [Balrog Overview](./references/anaconda_org_channels_bioconda_packages_balrog_overview.md)
- [Balrog GitHub Repository](./references/github_com_Markusjsommer_BalrogCPP.md)
- [Balrog Tags and Version History](./references/github_com_Markusjsommer_BalrogCPP_tags.md)