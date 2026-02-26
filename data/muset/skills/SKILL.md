---
name: muset
description: Muset transforms raw sequencing reads into unitig-based abundance or presence-absence matrices for comparative genomic analysis. Use when user asks to build a unitig matrix from sequencing data, generate a presence-absence matrix, or filter and manipulate k-mer matrices.
homepage: https://github.com/CamilaDuitama/muset
---


# muset

## Overview

The `muset` suite provides a high-performance pipeline for transforming raw sequencing reads into unitig-based matrices. Unlike simple k-mer counters, `muset` aggregates k-mer information into unitigs—non-branching paths in a De Bruijn graph—to provide more biologically meaningful sequences for downstream analysis. It is particularly effective for identifying "informative" sequences that vary across a cohort, supporting both abundance-based and presence-absence workflows.

## Installation and Setup

The recommended way to install `muset` and its dependencies (like `ggcat`) is via Mamba:

```bash
mamba create -n muset_env -c conda-forge -c bioconda -c camiladuitama muset ggcat=2.0.0
mamba activate muset_env
```

## Input Preparation (File-of-Files)

`muset` requires a "fof" (file-of-files) input where each line defines a sample ID and its associated sequence files.

**Format:** `SampleID : file1.fastq.gz ; file2.fastq.gz`

**Expert Tip:** You can quickly generate a compatible `fof.txt` from a directory of files using this one-liner:
```bash
ls -1 folder/*.fastq.gz | xargs -L1 readlink -f | awk '{ print "Sample_"NR" : "$1 }' > fof.txt
```

## Core Command Usage

### Building an Abundance Matrix
Use the primary `muset` command to generate a matrix where entries represent the average abundance of unitig k-mers.

```bash
muset --file fof.txt --out-dir results --kmer-size 31 --threads 8
```

### Building a Presence-Absence Matrix
If only the existence of a unitig is required (binary matrix), use `muset_pa`. This tool considers all k-mers with a multiplicity greater than 1.

```bash
muset_pa --file fof.txt --out-dir results_pa
```

### Working with Existing Matrices
If you have already generated a k-mer matrix (e.g., via `kmtricks`), you can skip the construction phase:

```bash
muset -i /path/to/existing_matrix_dir -o results
```

## Key Parameters and Optimization

| Parameter | Description | Best Practice |
|-----------|-------------|---------------|
| `-k, --kmer-size` | Size of k-mers (8-63) | Default is 31; use higher values for complex eukaryotes to increase specificity. |
| `-a, --min-abundance` | Min k-mer count to keep | Increase to 3 or 5 for high-coverage data to filter sequencing errors. |
| `-l, --min-unitig-length` | Min length of unitigs | Default is 2k-1. Increase to filter out very short, potentially noisy unitigs. |
| `-f / -F` | Fraction absent/present | Use `-f 0.2` to ensure a k-mer is absent in at least 20% of samples (informative k-mers). |
| `--abundance-metric` | mean or median | Use `median` to be more robust against k-mer outliers within a single unitig. |
| `-s, --write-seq` | Output sequences | Use this flag if you need the actual unitig sequences in the matrix rows instead of IDs. |

## Matrix Manipulation with kmat_tools

The suite includes `kmat_tools` for post-processing the generated matrices:

- **Filtering:** Remove rows or columns based on specific criteria.
- **Conversion:** Change matrix formats (e.g., between text and compressed formats).
- **Statistics:** Calculate summary statistics across the matrix.

## Reference documentation
- [GitHub Repository - CamilaDuitama/muset](./references/github_com_CamilaDuitama_muset.md)
- [MUSET Wiki](./references/github_com_CamilaDuitama_muset_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_muset_overview.md)