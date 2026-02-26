---
name: nonpareil
description: "Nonpareil estimates the coverage and redundancy of metagenomic datasets to determine sequencing completeness. Use when user asks to assess metagenomic library saturation, estimate required sequencing depth, or calculate sequence redundancy without a reference."
homepage: http://nonpareil.readthedocs.io/
---


# nonpareil

## Overview
Nonpareil is a bioinformatics tool used to assess the "completeness" of metagenomic datasets without the need for a reference genome. It calculates the redundancy of DNA sequences within a sample to estimate the average coverage and project how much additional sequencing is required to capture the remaining diversity. This is essential for determining if a library is saturated or if further sequencing will yield significant new information.

## Common CLI Patterns

### Basic Redundancy Calculation
To estimate redundancy for a set of preprocessed reads (FASTA or FASTQ):
```bash
nonpareil -s reads.fastq -T kmer -f fastq -b output_prefix
```
*   `-s`: Input sequence file.
*   `-T`: Algorithm (usually `kmer` for speed or `alignment` for sensitivity).
*   `-f`: Format of the input file.
*   `-b`: Prefix for output files (generates `.npo` and `.npa`).

### Multi-threaded Execution
Nonpareil is computationally intensive; always use multiple threads when available:
```bash
nonpareil -s reads.fasta -T kmer -t 16 -b output_prefix
```
*   `-t`: Number of threads.

### Sampling for Large Datasets
For very large datasets, you can limit the number of reads sampled to speed up the process:
```bash
nonpareil -s reads.fasta -b output_prefix -X 10000
```
*   `-X`: Maximum number of reads to use for the estimation.

## Expert Tips
- **Preprocessing is Mandatory**: Always remove adapters and perform quality trimming before running Nonpareil. Low-quality tails or adapter contamination will artificially inflate redundancy or create false diversity.
- **Algorithm Selection**: Use `-T kmer` for most modern datasets. The `alignment` mode is more sensitive but significantly slower and generally unnecessary for high-coverage Illumina data.
- **Output Interpretation**: The primary output is the `.npo` file. This file is used by the Nonpareil R package to generate "Nonpareil Curves," which visualize the estimated coverage vs. sequencing effort.
- **Memory Management**: If running out of RAM on large files, use the `-X` flag to subsample the reads. Nonpareil's estimates remain robust even with a representative subset of the data.

## Reference documentation
- [Nonpareil ReadTheDocs](./references/nonpareil_readthedocs_io_en_latest.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_nonpareil_overview.md)