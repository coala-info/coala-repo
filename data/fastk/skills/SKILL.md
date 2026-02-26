---
name: fastk
description: FastK is a high-performance k-mer counter designed to generate frequency distributions, tables, and per-base profiles for large DNA sequencing datasets. Use when user asks to count k-mers, generate k-mer frequency histograms, create per-base k-mer profiles, or perform set operations on k-mer tables.
homepage: https://github.com/thegenemyers/FASTK
---


# fastk

## Overview

FastK is a high-performance k-mer counter specifically optimized for high-quality DNA assembly data. Unlike general-purpose counters, it is designed to handle massive datasets (such as the 32GB Axolotl genome) on machines with limited RAM by leveraging efficient disk-based sorting. It is significantly faster than tools like KMC3 for HiFi data and provides unique "profiles"—a per-base sequence of k-mer counts—which are essential for identifying repeats, heterozygosity, and assembly artifacts.

## Core Command Line Usage

### Basic K-mer Counting
The primary command is `FastK`. By default, it produces a `.hist` file containing the k-mer frequency distribution.

```bash
# Basic run with default k=40
FastK sample.fastq

# Specify k-mer size and verbose output
FastK -k31 -v sample.fasta.gz
```

### Generating Tables and Profiles
To produce more than just a histogram, use the `-t` and `-p` flags.

*   **Tables (`-t`)**: Stores k-mer/count pairs. Use a threshold to ignore low-count k-mers (often sequencing errors).
*   **Profiles (`-p`)**: Generates a count for every k-mer position in the input sequences.

```bash
# Generate a table of k-mers occurring 2+ times and a profile
FastK -k40 -t2 -p sample.bam
```

### Resource Management
FastK is designed to be memory-efficient. You can explicitly control its resource usage:

*   `-M<int>`: Set memory limit in GB (default is 12GB).
*   `-T<int>`: Set number of threads (default is 4).
*   `-P<dir>`: Set temporary directory for intermediate files (defaults to `$TMPDIR`).

```bash
# High-performance run on a large dataset
FastK -M64 -T16 -P/scratch/tmp/ genome_hifi.cram
```

## Downstream Analysis Utilities

FastK includes several "ex" (extraction) utilities to work with its specialized binary outputs:

### Histex (Histogram Extraction)
Use `Histex` to view or convert the `.hist` file.
```bash
# Display the histogram in text format
Histex sample.hist
```

### Tabex (Table Extraction)
Use `Tabex` to query the `.ktab` files.
```bash
# List all k-mers and counts in the table
Tabex sample.ktab

# Find the count of a specific k-mer
Tabex sample.ktab ACGTACGT...
```

### Profex (Profile Extraction)
Use `Profex` to view the per-base k-mer counts generated with the `-p` option.
```bash
# Display the profile for the first 10 sequences
Profex -s10 sample.prof
```

### Logex (Logical Expressions)
`Logex` allows you to perform set operations (union, intersection, difference) on k-mer tables.
```bash
# Create a table of k-mers present in 'reads' but not in 'assembly'
Logex "diff = A - B" reads.ktab assembly.ktab
```

## Expert Tips and Best Practices

*   **Canonical K-mers**: FastK automatically treats a k-mer and its Watson-Crick complement as the same entity, storing only the lexicographically smaller "canonical" version.
*   **File Extensions**: FastK determines input type by extension (`.cram`, `.bam`, `.sam`, `.fasta`, `.fastq`, `.db`, `.dam`). Ensure your files are named correctly; gzipped files must end in `.gz`.
*   **Output Naming**: By default, outputs use the prefix of the first input file. Use `-N<path_name>` to specify a custom output prefix and directory.
*   **Handling Large Genomes**: For Tbp-scale datasets, ensure the disk space in your temporary directory (`-P`) is at least 2-3 times the size of the input data, even if RAM is limited.
*   **Invalid Characters**: Any k-mer containing non-ACGT characters (like 'N') is automatically ignored and will result in a count of 0 in profiles.

## Reference documentation
- [FastK GitHub Repository](./references/github_com_thegenemyers_FASTK.md)
- [Bioconda FastK Overview](./references/anaconda_org_channels_bioconda_packages_fastk_overview.md)