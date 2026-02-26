---
name: skmer
description: Skmer calculates genomic distances and mutation rates from sequencing reads using alignment-free k-mer statistics. Use when user asks to build a reference library, query samples against a library, calculate pairwise genomic distances, or estimate uncertainty in distance measurements.
homepage: https://github.com/shahab-sarmashghi/Skmer
---


# skmer

## Overview
`skmer` provides a fast, alignment-free workflow for calculating genomic distances between samples using k-mer statistics. By leveraging Mash and Jellyfish, it processes raw sequencing reads to estimate the Jaccard index and subsequently the mutation rate, while applying corrections for sequencing depth and error rates. It is particularly effective for "genome skimming" projects where high-coverage data is unavailable.

## Core Workflows

### 1. Building a Reference Library
To process a collection of samples (one FASTQ/FASTA file per sample) and generate a searchable library:
`skmer reference <input_directory> -p <threads> -l <library_name>`

- **K-mer Size (`-k`)**: Default is 31. Do not go below 21 to avoid random k-mer collisions.
- **Sketch Size (`-s`)**: Default is 10^7. Larger sketches increase accuracy but require more disk space.
- **Phylogenetic Distance (`-t`)**: Use this flag to apply the Jukes-Cantor transformation, converting raw distances into mutation rates suitable for tree building.

### 2. Querying Samples
To identify an unknown sample or compare it against an existing library:
`skmer query <query_file> <library_directory> -o <output_prefix>`

- Use the `-a` flag to automatically add the processed query to the reference library for future use.

### 3. Pairwise Distance Calculation
If you have multiple processed libraries or need to re-calculate distances for an existing library:
`skmer distance <library_directory> -t -o <output_name>`

### 4. Uncertainty Estimation
To perform subsampling for quantifying uncertainty in distance estimates:
`skmer subsample <input_directory> -sub <num_subsamples>`

## Expert Tips & Best Practices
- **Input Preparation**: Ensure input files are uncompressed (.fastq, .fq, .fa, .fasta). If working with paired-end data, merge overlapping reads using tools like BBMerge before running `skmer` to improve k-mer count accuracy.
- **Assembly vs. Skims**: If the input sequence is long (e.g., a full assembly), `skmer` automatically detects this and skips the low-coverage/error correction steps.
- **Parallelization**: Always utilize the `-p` flag during the `reference` step to significantly speed up k-mer counting and sketching across multiple CPU cores.
- **Output Interpretation**: The default output `ref-dist-mat.txt` contains a square matrix of pairwise distances. If `-t` is used, these values represent estimated substitutions per site.

## Reference documentation
- [Skmer GitHub Repository](./references/github_com_shahab-sarmashghi_Skmer.md)
- [Bioconda Skmer Package](./references/anaconda_org_channels_bioconda_packages_skmer_overview.md)