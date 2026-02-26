---
name: trand
description: TranD quantifies structural variations and alternative splicing events in genomic annotations at the nucleotide level. Use when user asks to generate a transcriptome complexity profile, compare transcript models, identify internal transcriptome diversity, benchmark annotations, or quantify alternative splicing events like intron retention and alternative exon usage.
homepage: https://github.com/McIntyre-Lab/TranD
---


# trand

## Overview
TranD (Transcript Distances) is a specialized toolkit designed to pinpoint structural variations in genomic annotations at the nucleotide level. While many tools provide broad overlaps, TranD calculates specific metrics for alternative splicing events, including intron retention, alternative exon usage, and donor/acceptor site variation. It is particularly useful for researchers needing to quantify the complexity of a single transcriptome or identify precise differences between two competing annotation sets.

## Installation and Setup
The most reliable way to prepare the environment is via Conda or Mamba:
```bash
conda install -c bioconda trand
```
Alternatively, for environments where `bedtools` is already present:
```bash
pip install trand
```

## Core Workflows

### 1. Single GTF Analysis (Gene Mode)
Use this mode to generate a baseline complexity profile for an organism.
- **Purpose**: Calculate transcripts per gene, exons per transcript, and unique exons per gene.
- **Output**: Summary statistics (mean, median, variance) and distributions across the genome.
- **Visualization**: Generates plots showing the frequency of structural features.

### 2. Pairwise Comparison (1 GTF or 2 GTF)
Use this mode to find specific differences between transcript models.
- **1 GTF Pairwise**: Compares all possible transcript pairs within each gene in a single file. Useful for identifying the internal diversity of a transcriptome.
- **2 GTF Pairwise**: Compares transcripts between two different files. Essential for cross-species comparisons or benchmarking new annotations against a gold standard.
- **Metrics**: Reports nucleotide-level distances for intron retention, alternative exon usage, and 5'/3' UTR variation.

## Expert Tips and Best Practices

### Pre-processing with Utilities
Before running the main TranD analysis, check the `utilities/` directory for scripts that can clean or subset your data:
- **Filter Single-Transcript Genes**: Use `find_genes_with_one_transcript.py` if you want to focus specifically on alternative splicing, as genes with only one transcript do not contribute to pairwise distance metrics.
- **GFFCompare Integration**: Use the provided utilities to handle outputs from `gffcompare` if you are merging multiple transcript assemblies.

### Handling Long-Read Data
When working with Long-Read sequencing (PacBio/Oxford Nanopore):
- Ensure your GTF is properly formatted with consistent `gene_id` and `transcript_id` tags.
- Use the "Transcript Model Map" (TMM) workflow to align experimental transcripts to reference annotations before calculating distances.

### Interpreting Outputs
- **ir_transcripts.csv**: If this file is empty, it indicates no intron retention events were detected given the current transcript models.
- **Nucleotide Precision**: Remember that TranD distances are calculated to the exact nucleotide; small shifts in splice sites (donor/acceptor variation) will be explicitly quantified rather than grouped as "similar."

## Reference documentation
- [TranD GitHub Repository](./references/github_com_McIntyre-Lab_TranD.md)
- [TranD Wiki and User Guide](./references/github_com_McIntyre-Lab_TranD_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_trand_overview.md)