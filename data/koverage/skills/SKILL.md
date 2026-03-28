---
name: koverage
description: "Koverage generates coverage statistics from sequencing reads and reference assemblies using mapping or kmer-based methods. Use when user asks to calculate assembly coverage, estimate abundance in metagenomic datasets, or generate read alignment statistics."
homepage: https://github.com/beardymcjohnface/Koverage
---

# koverage

## Overview

Koverage is a high-performance tool designed to generate coverage statistics from sequencing reads and reference assemblies. It prioritizes low memory usage and efficient I/O, making it suitable for massive metagenomic datasets that traditional tools struggle to process. It offers two primary modes: a default mapping-based approach using minimap2 and a kmer-based approach that provides superior scalability for extremely large reference files.

## Installation and Setup

Install Koverage via Bioconda or PyPI. It is recommended to use a dedicated Python 3.11 environment.

```bash
# Bioconda installation
conda install -c conda-forge -c bioconda koverage

# PyPI installation
pip install koverage
```

Verify the installation using the built-in test suite:
```bash
koverage test
```

## Command Line Usage

### Basic Execution

The primary command is `koverage run`. You must provide a directory or TSV file of reads and a reference FASTA file.

```bash
# Default mapping-based coverage
koverage run --reads /path/to/reads --ref assembly.fasta
```

### Choosing a Coverage Method

- **Map (Default)**: Uses `minimap2` to align reads. Best for standard accuracy.
- **Kmer**: Uses kmer frequencies. Significantly more scalable for very large reference FASTAs (e.g., massive metagenomes).

```bash
# Explicitly call mapping method
koverage run --reads readDir --ref assembly.fasta map

# Use kmer method for large references
koverage run --reads readDir --ref assembly.fasta kmer
```

### Input Specification (`--reads`)

Koverage accepts two formats for the `--reads` argument:

1.  **Directory**: Provide a path to a folder containing FASTQ files. Koverage automatically infers sample names and pairs files based on `_R1` and `_R2` suffixes.
2.  **TSV File**: Provide a tab-separated file for precise control.
    - 2 columns: `SampleID`, `Read_Path` (Single-end)
    - 3 columns: `SampleID`, `R1_Path`, `R2_Path` (Paired-end)

### High-Performance Computing (HPC)

Koverage is built on Snakemake. Any arguments not recognized by Koverage are passed directly to the underlying Snakemake engine. Use this to run on clusters via profiles.

```bash
koverage run --reads readDir --ref assembly.fasta --profile mySlurmProfile
```

## Expert Tips and Best Practices

- **Scalability**: If the reference FASTA is exceptionally large (e.g., hundreds of thousands of contigs), prefer the `kmer` method to minimize the RAM footprint and I/O overhead associated with indexing and alignment.
- **Filename Convention**: When using directory input, ensure read files follow standard naming conventions (e.g., `Sample_R1.fastq.gz`) so the auto-detection logic correctly identifies pairs.
- **Resource Management**: Since Koverage passes arguments to Snakemake, use `--cores` or `-j` to limit local CPU usage if not running on a cluster.
- **Testing Methods**: You can test specific methods or all of them simultaneously to ensure your environment supports the required dependencies:
  ```bash
  koverage test map kmer coverm
  ```



## Subcommands

| Command | Description |
|---------|-------------|
| koverage config | Copy the system default config file |
| koverage run | Run Koverage |
| snakemake | Snakemake is a Python based language and execution environment for GNU Make-like workflows. |

## Reference documentation

- [Koverage README](./references/github_com_beardymcjohnface_Koverage_blob_main_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_koverage_overview.md)