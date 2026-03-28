---
name: newmap
description: Newmap determines genome mappability by identifying the shortest unique k-mer at every genomic position to generate single-read and multi-read tracks. Use when user asks to index a genome, search for unique k-mer lengths, or generate mappability tracks in BED and WIG formats.
homepage: https://github.com/hoffmangroup/newmap
---

# newmap

## Overview
Newmap is a high-performance software package designed to determine genome mappability by identifying the shortest unique k-mer at every genomic position. It utilizes the AVX2 instruction set and the AvxWindowFMIndex library to efficiently output unique read lengths. These lengths are then used to generate single-read and multi-read mappability tracks (BED and WIG formats) for specific read lengths.

## Core Workflow

### 1. Genome Indexing
Generate a specialized index from a FASTA file. This is a prerequisite for all search operations.

```bash
newmap index genome.fa
```
*   **Output**: Creates a `.awfmi` index file (default: `genome.awfmi`).
*   **Optimization**: For very small test genomes, use `--seed-length=1` and `--compression-ratio=1` to accelerate index creation. For standard genomes, use default values.

### 2. Unique Length Search
Identify the minimum unique k-mer lengths across the genome using a binary search method.

```bash
newmap search --verbose --num-threads=20 --search-range=20:200 --output-directory=unique_lengths genome.fa
```
*   **Parameters**:
    *   `--num-threads`: Set based on available CPU cores for parallel processing.
    *   `--search-range`: Define the continuous range (e.g., `min:max`) for the binary search.
    *   `--output-directory`: Destination for the resulting `*.unique.uint8` files (one per sequence ID).

### 3. Mappability Track Generation
Convert the intermediate unique length files into standard genomic formats for a specific read length.

```bash
newmap track --single-read=output.bed --multi-read=output.wig <read_length> unique_lengths/*.unique.uint8
```
*   **Arguments**:
    *   `<read_length>`: The specific integer read length (e.g., `24`) to calculate mappability for.
    *   `--single-read`: Generates a BED file representing single-read mappability.
    *   `--multi-read`: Generates a WIG file representing multi-read mappability.

## Expert Tips and Best Practices
*   **Hardware Requirements**: Newmap requires a CPU with **AVX2** support. It is currently optimized for Linux environments.
*   **Parallelization**: Always specify `--num-threads` during the `search` phase to significantly reduce computation time, as this step is the most resource-intensive.
*   **Memory Management**: The tool produces `uint8` files during the search phase to keep the intermediate storage footprint small while maintaining precision for read lengths up to 255 bp.
*   **Help Command**: Use `newmap <command> --help` to view advanced parameters for specific sub-commands.



## Subcommands

| Command | Description |
|---------|-------------|
| newmap search | Search for unique k-mers in a FASTA file. |
| newmap_index | Create an index for a FASTA file. |
| newmap_track | Calculate mappability values based on read length and unique count files. |

## Reference documentation
- [Newmap README](./references/github_com_hoffmangroup_newmap_blob_master_README.md)
- [Bioconda Newmap Overview](./references/anaconda_org_channels_bioconda_packages_newmap_overview.md)