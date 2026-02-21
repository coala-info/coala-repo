---
name: newmap
description: Newmap is a high-performance tool for determining the uniqueness of genomic sequences.
homepage: https://github.com/hoffmangroup/newmap
---

# newmap

## Overview
Newmap is a high-performance tool for determining the uniqueness of genomic sequences. It identifies the shortest read length required for a sequence at any given position to be unique within the genome. This is essential for downstream bioinformatics tasks like peak calling, variant calling, and normalizing sequencing depth. Use this skill to guide the process of indexing a FASTA file, performing a binary search for unique k-mer lengths, and converting those results into standard genomic formats like BED or BigWig.

## Installation and Prerequisites
Newmap requires a Linux environment and a CPU supporting the **AVX2** instruction set.
- **Conda**: `conda install bioconda::newmap`
- **PyPI**: `pip install newmap`

## Core Workflow

### 1. Indexing the Genome
Before searching, you must create an FM-index of the reference FASTA.
```bash
newmap index genome.fa
```
*   **Output**: Creates a `genome.awfmi` file.
*   **Tip**: For extremely small test genomes, use `--seed-length=1 --compression-ratio=1` to speed up the process; otherwise, stick to defaults.

### 2. Searching for Unique Lengths
This step identifies the minimum unique k-mer length for every position.
```bash
newmap search --verbose --num-threads=20 --search-range=20:200 --output-directory=unique_lengths genome.fa
```
*   **--search-range**: Defines the min:max k-mer lengths to check.
*   **--num-threads**: Highly recommended for large genomes as this process is parallelizable.
*   **Output**: Generates `.unique.uint8` files for each chromosome/sequence in the specified directory.

### 3. Generating Mappability Tracks
Convert the raw unique length data into usable tracks for a specific read length (e.g., 24bp).
```bash
newmap track --single-read=24.bed --multi-read=24.wig 24 unique_lengths/*.unique.uint8
```
*   **Single-read mappability**: A BED file where a value of 1 indicates the position is uniquely mappable at the specified length.
*   **Multi-read mappability**: A Wiggle (WIG) file representing the reciprocal of the number of matches for that read length.

## Expert Tips
- **Hardware Acceleration**: Ensure your environment supports AVX2. Without it, the underlying `AvxWindowFMIndex` library will fail.
- **Memory Management**: For large genomes (e.g., Human T2T), ensure sufficient RAM is available for the index.
- **Reverse Complement**: By default, Newmap considers both strands. If your specific application requires strand-specific uniqueness, check for the `--no-reverse-complement` option in recent versions.
- **Help Access**: Use `newmap <subcommand> --help` for detailed parameter descriptions for `index`, `search`, or `track`.

## Reference documentation
- [Newmap GitHub Repository](./references/github_com_hoffmangroup_newmap.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_newmap_overview.md)