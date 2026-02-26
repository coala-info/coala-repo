---
name: secedo
description: SECEDO clusters tumor cells using single nucleotide variants from single-cell sequencing data, specifically for ultra-low coverage datasets. Use when user asks to cluster tumor cells based on SNVs, generate binary pileups from aligned BAM files, or perform variant calling on identified cell clusters.
homepage: https://github.com/ratschlab/secedo
---


# secedo

## Overview
SECEDO (SinglE CEll Data tumOr clusterer) is a specialized bioinformatics tool designed to cluster tumor cells based on Single Nucleotide Variants (SNVs) from single-cell sequencing. It is particularly effective for datasets with ultra-low coverage where traditional methods might fail. The tool follows a two-step workflow: first generating a pileup from aligned BAM files, and then performing spectral clustering and expectation-maximization to group cells and call variants.

## Installation
The recommended way to install SECEDO is via Bioconda:
```bash
conda install -c conda-forge -c bioconda secedo
```

## Core Workflow

### 1. Input Pileup Generation
Before clustering, you must convert BAM files into a binary pileup format. This step is memory-efficient as it streams to disk.

```bash
./pileup -i <BAM_DIR> -o <OUT_DIR>/chromosome \
  --chromosomes 1 \
  --num_threads 20 \
  --min_base_quality 30 \
  --max_coverage 1000
```
- **BAM_DIR**: Directory containing aligned .bam files for each cell.
- **Parallelization**: To speed up processing, run separate jobs for each chromosome (1-22, X, Y). Omitting `--chromosomes` will process all 24 sequentially.
- **Quality Control**: Use `--min_base_quality` (default 30) to filter out noisy sequencing data.

### 2. Clustering and Variant Calling
Once pileups are generated, run the main `secedo` engine to group cells.

```bash
./secedo -i <PILEUP_DIR> -o <OUT_DIR> \
  --num_threads 20 \
  --homozygous_filtered_rate=0.5 \
  --seq_error_rate=0.01 \
  --min_cluster_size 500 \
  --reference_genome <REF_FASTA>
```
- **Clustering Output**: Results are written to `OUT_DIR/clustering`.
- **Variant Calling**: If `--reference_genome` is provided, SECEDO generates VCF files for each identified cluster (e.g., `cluster_1.vcf`).
- **Reference Genome Note**: Ensure the FASTA file follows standard numerical ordering (1, 2, 3... 22, X, Y). Lexicographical ordering (1, 10, 11...) will cause errors.

## Expert Tips & Parameters
- **Memory Management**: Processing ~8,000 cells at 0.5x coverage typically requires about 32GB-35GB of RAM.
- **Tumor Purity**: In version 1.0.7+, you can specify an estimated tumor purity to improve clustering accuracy in samples with high normal cell contamination.
- **Filtering**: Adjust `--homozygous_filtered_rate` to control the stringency of SNV selection for clustering.
- **Minimum Cluster Size**: Use `--min_cluster_size` to prevent the algorithm from creating tiny, statistically insignificant clusters.

## Reference documentation
- [SECEDO GitHub Repository](./references/github_com_ratschlab_secedo.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_secedo_overview.md)