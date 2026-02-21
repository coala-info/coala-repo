---
name: poly-qtlseq
description: PolyploidQtlSeq is a specialized bioinformatics tool that extends the traditional QTL-seq method to accommodate polyploid species.
homepage: https://github.com/TatsumiMizubayashi/PolyploidQtlSeq
---

# poly-qtlseq

## Overview

PolyploidQtlSeq is a specialized bioinformatics tool that extends the traditional QTL-seq method to accommodate polyploid species. It utilizes a simulation-based approach to calculate appropriate thresholds for QTL detection based on the specific ploidy and variant plexity of the organism. The tool automates the process of read mapping, variant detection, SNP-index calculation, and statistical plotting, allowing researchers to identify genomic regions associated with specific traits in complex polyploid genomes.

## Installation and Environment Setup

The tool is available via Bioconda and requires a .NET 8 runtime environment.

```bash
# Recommended installation via Conda
conda create -n polyQtlseq python=3
conda activate polyQtlseq
conda install -c bioconda poly-qtlseq
```

If installing manually from GitHub releases, you must set an alias for the .NET executable:
`alias polyQtlseq='dotnet /path/to/PolyploidQtlSeq.dll'`

## Pre-processing Requirements

Before running the pipeline, the reference genome must be indexed using BWA and SAMtools:

```bash
bwa index -a bwtsw REFERENCE.fa
samtools faidx REFERENCE.fa
```

## Quality Control (QC)

Use the `qc` subcommand to trim and filter raw Fastq files. The tool expects paired-end files in a single directory.

```bash
# Basic QC command
polyQtlseq qc -i RawFastqDir -o QcFastqDir -t 10
```

**Key Parameters:**
- `-i`: Directory containing raw `.fq.gz` or `.fastq.gz` files.
- `-o`: Output directory for cleaned reads.
- `-l`: Minimum read length (default: 50).
- `-q`: Base quality threshold (default: 15).
- `-t`: Number of threads (max 16).

## Analysis Pipeline

The main pipeline performs mapping and QTL-seq analysis. It requires four distinct directories containing the QC-passed Fastq files for Parent 1, Parent 2, Bulk 1, and Bulk 2.

```bash
# Standard pipeline execution
polyQtlseq -r reference.fa \
           -p1 ./P1_reads/ \
           -p2 ./P2_reads/ \
           -b1 ./Bulk1_reads/ \
           -b2 ./Bulk2_reads/ \
           -cs 10000000
```

**Key Parameters:**
- `-r`: Path to the reference FASTA file.
- `-p1 / -p2`: Directories for the two parental varieties.
- `-b1 / -b2`: Directories for the two extreme trait bulks.
- `-cs`: Chromosome size threshold; only chromosomes longer than this value (default 10Mb) are analyzed.
- `-cn`: Specific chromosome names to analyze (comma-separated).

## Expert Tips and Best Practices

- **File Naming**: Ensure your Fastq files follow a consistent naming convention for paired-end detection (e.g., `Sample_1.fq.gz` and `Sample_2.fq.gz`). Single-end files are not supported.
- **Skipping Mapping**: If you already have BAM files for your samples, place them in the respective sample directories. The pipeline will detect existing BAM files and skip the mapping step to save time.
- **SnpEff Integration**: To include variant annotation in your results, ensure a SnpEff database is prepared for your reference genome.
- **Memory Management**: When working with large polyploid genomes, ensure the environment has sufficient RAM for BWA mapping and the subsequent simulation-based threshold calculations.

## Reference documentation
- [PolyploidQtlSeq GitHub Repository](./references/github_com_TatsumiMizubayashi_PolyploidQtlSeq.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_poly-qtlseq_overview.md)