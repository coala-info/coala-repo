---
name: deblur
description: Deblur is a high-resolution deconvolution algorithm used to recover exact biological sequence variants from amplicon sequencing data by subtracting noise. Use when user asks to denoise amplicon reads, identify sub-operational taxonomic units, or generate a BIOM table from demultiplexed sequences.
homepage: https://github.com/biocore/deblur
---


# deblur

## Overview

Deblur is a high-resolution deconvolution algorithm used to recover biological sequences from amplicon sequencing data. Unlike traditional OTU picking which clusters sequences by similarity, Deblur uses a greedy algorithm based on known error profiles to subtract noise and identify exact sequence variants (sOTUs). It is designed to work on a per-sample basis, allowing for easy parallelization and integration into larger bioinformatics pipelines.

## Installation and Environment

Deblur requires a specific environment to function correctly, particularly regarding its dependencies.

- **Python Version**: Requires Python 3.8.
- **Conda Install**: `conda install -c bioconda -c biocore deblur`
- **Critical Dependency**: SortMeRNA **must** be version 2.0. Version 2.1+ has a different output format that is currently incompatible with Deblur.
- **Other Dependencies**: VSEARCH (>=2.7.0), MAFFT (>=7.394), and biom-format.

## Core CLI Usage

The primary interface for Deblur is the `workflow` subcommand.

### Basic Workflow
To run Deblur on a demultiplexed FASTA file with a specific trim length:
```bash
deblur workflow --seqs-fp all_samples.fna --output-dir output_dir -t 150
```

### Key Parameters
- `-t <int>`: **Trim Length (Required)**. Deblur cannot compare sequences of different lengths. All reads shorter than this value are discarded; longer reads are trimmed. Use `-t -1` only if your data is already pre-trimmed to a uniform length.
- `-O <int>`: Number of threads for parallel processing.
- `--min-reads <int>`: Minimum total observations of an sOTU across all samples to be retained (default is 10). Set to `0` to disable this filtering.
- `--pos-ref-fp <path>`: Path to a positive filtering database (default is 16S).
- `--neg-ref-fp <path>`: Path to a negative filtering database (default is PhiX and adapter sequences).

## Input and Output Patterns

### Input Requirements
- Input can be a directory of FASTA/FASTQ files (one per sample) or a single demultiplexed file.
- Files can be gzipped (`.gz`).
- If starting from raw barcodes/reads, use `split_libraries_fastq.py` (QIIME 1) or equivalent to demultiplex before running Deblur.

### Understanding Outputs
The output directory contains several BIOM tables and FASTA files:
1. **`reference-hit.biom`**: Contains sOTUs that matched the positive reference (e.g., 16S) and passed negative filtering. This is typically the "clean" table used for downstream analysis.
2. **`reference-non-hit.biom`**: Contains sOTUs that did not match the positive reference but passed negative filtering.
3. **`all.biom`**: The union of hits and non-hits.
4. **`.seqs.fa`**: Corresponding FASTA files for each BIOM table where the sequence IDs match the observation IDs in the BIOM files.

## Expert Tips and Best Practices

- **Trimming Strategy**: Choose a trim length that captures the majority of your reads while maximizing sequence length. Check your quality scores; if quality drops significantly at the end of the read, trim before that point.
- **Non-16S Data**: While the default is 16S, you can use Deblur for ITS or 18S by providing custom databases via `--pos-ref-fp`.
- **Memory Management**: Deblur processes samples independently. If running on a cluster, you can distribute samples across nodes to speed up processing for very large datasets.
- **Artifact Removal**: Deblur automatically performs negative filtering against PhiX and common adapters. If you suspect specific contaminants in your lab environment, add them to a custom negative reference file.

## Reference documentation
- [Deblur GitHub Repository](./references/github_com_biocore_deblur.md)
- [Bioconda Deblur Overview](./references/anaconda_org_channels_bioconda_packages_deblur_overview.md)