---
name: koverage
description: Koverage is a high-performance pipeline designed to calculate coverage metrics across multiple samples using mapping-based or k-mer-based methods. Use when user asks to calculate contig coverage, estimate k-mer depth, process read directories for mapping, or execute coverage workflows on HPC clusters.
homepage: https://github.com/beardymcjohnface/Koverage
---


# koverage

## Overview

Koverage is a high-performance pipeline designed to generate coverage metrics across multiple samples while maintaining a small computational footprint. It addresses the scalability limitations of traditional tools by providing optimized workflows for both standard mapping and k-mer-based estimation. This skill helps you navigate its CLI to process read directories, manage sample metadata via TSV files, and execute workflows on high-performance computing (HPC) clusters using Snakemake profiles.

## Installation and Setup

Install koverage via Bioconda (recommended) or PyPI:

```bash
# Bioconda installation
conda create -n koverage python=3.11
conda activate koverage
conda install -c conda-forge -c bioconda koverage

# PyPI installation
pip install koverage
```

Verify the installation with the internal test suite:
```bash
koverage test
```

## Core Workflows

### Mapping-based Coverage (Default)
Use this for standard applications where coordinate-level coverage is needed. It utilizes `minimap2` for alignment.

```bash
koverage run --reads path/to/reads --ref assembly.fasta
```

### K-mer-based Coverage
Use this for exceptionally large reference genomes. It uses Jellyfish to sample k-mers, which significantly reduces I/O overhead.

```bash
koverage run --reads path/to/reads --ref assembly.fasta kmer
```

### CoverM Wrapper
Use this to leverage CoverM's algorithms within the koverage framework. Note: This is not available on macOS.

```bash
koverage run --reads path/to/reads --ref assembly.fasta coverm
```

## Input Management

### Automated Directory Parsing
Point `--reads` to a directory. Koverage automatically pairs files containing `_R1` and `_R2` and infers sample names from the filenames.

### Manual Sample Specification (TSV)
For complex naming or specific sample groupings, provide a TSV file to `--reads`.
- **2 Columns**: SampleName, Read1_Path
- **3 Columns**: SampleName, Read1_Path, Read2_Path

## Advanced Execution

### HPC and Cluster Integration
Since koverage is built on Snakemake, any unrecognized arguments are passed directly to the underlying Snakemake engine. Use profiles for cluster execution (e.g., Slurm, SGE).

```bash
koverage run --reads readDir --ref assembly.fasta --profile mySlurmProfile
```

### Resource Tuning
Control the parallelization of the pipeline using standard Snakemake flags:

```bash
koverage run --reads readDir --ref assembly.fasta --cores 16
```

## Output Interpretation

### Mapping Outputs
- `sample_coverage.tsv`: Detailed per-sample and per-contig statistics including Mean, Median, Hitrate (fraction of contig covered), and Variance.
- `all_coverage.tsv`: Aggregated counts across all samples per contig.

### K-mer Outputs
- `sample_kmer_coverage.[k]mer.tsv.gz`: Compressed per-sample k-mer depth statistics.
- `all_kmer_coverage.[k]mer.tsv.gz`: Aggregated k-mer statistics for the entire project.

## Reference documentation
- [Koverage GitHub Repository](./references/github_com_beardymcjohnface_Koverage.md)
- [Koverage Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_koverage_overview.md)