---
name: mutmap
description: The `mutmap` skill provides a streamlined workflow for identifying agronomically important loci.
homepage: https://github.com/YuSugihara/MutMap
---

# mutmap

## Overview

The `mutmap` skill provides a streamlined workflow for identifying agronomically important loci. It automates the process of mapping reads, calling variants, and calculating SNP-indices to pinpoint genomic regions where the mutant allele is fixed. Use this skill to process raw FASTQ or BAM files, perform quality trimming, and predict functional impacts of variants using SnpEff.

## Installation and Setup

Install the pipeline via bioconda to ensure all dependencies (BWA, SAMtools, BCFtools, SnpEff, Trimmomatic) are available:

```bash
conda create -c bioconda -n mutmap mutmap
conda activate mutmap
```

## Core Command Usage

The primary command is `mutmap`. It requires a reference genome, cultivar data, mutant bulk data, and the number of individuals in the bulk.

### Basic Execution (FASTQ)
Run the pipeline using paired-end FASTQ files for both the cultivar and the mutant bulk:

```bash
mutmap -r reference.fasta \
       -c cultivar_R1.fastq.gz,cultivar_R2.fastq.gz \
       -b bulk_R1.fastq.gz,bulk_R2.fastq.gz \
       -n 20 \
       -o output_directory
```

### Execution from BAM
If reads are already aligned, provide BAM files directly to skip the mapping step:

```bash
mutmap -r reference.fasta -c cultivar.bam -b bulk.bam -n 20 -o output_directory
```

### Advanced Analysis Options
*   **Trimming**: Add `-T` and `-a adapter.fasta` to perform quality and adapter trimming via Trimmomatic.
*   **Functional Annotation**: Use `-e <database>` to predict causal variants using SnpEff (e.g., `-e rice_v7.0`).
*   **Window/Step Size**: Adjust the sliding window analysis using `-w` (window size in kb) and `-s` (step size in kb). Default is 2000kb window and 100kb step.
*   **Depth Filtering**: Control variant quality with `-d` (min depth) and `-D` (max depth). Defaults are 8 and 250 respectively.

## Expert Tips and Best Practices

*   **Contig Management**: If the reference genome contains many contigs, `mutmap` only plots the 50 longest contigs. For highly fragmented assemblies, consider filtering the reference FASTA to include only major chromosomes/scaffolds before running.
*   **Bulk Size Accuracy**: Ensure the `-n` parameter accurately reflects the number of individuals in the mutant bulk, as this value is critical for the simulation of the null distribution and p-value calculation.
*   **Memory Allocation**: When working with large datasets, use `--mem` to specify the maximum memory per thread for BAM sorting (e.g., `--mem 4G`).
*   **Multiple Inputs**: You can specify multiple `-c` or `-b` flags if you have data from multiple sequencing lanes or libraries for the same samples.
*   **VCF Input**: If you already have a VCF file and only need to generate plots, use the `mutplot` command instead of the full `mutmap` pipeline.

## Reference documentation
- [MutMap GitHub Repository](./references/github_com_YuSugihara_MutMap.md)
- [MutMap Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mutmap_overview.md)