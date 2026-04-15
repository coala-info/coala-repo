---
name: fastk
description: FastK is a high-performance k-mer counter that generates histograms, sorted k-mer tables, and sequence profiles for high-fidelity sequencing datasets. Use when user asks to count k-mers, generate k-mer frequency histograms, create sequence profiles, or perform set operations on k-mer tables.
homepage: https://github.com/thegenemyers/FASTK
metadata:
  docker_image: "quay.io/biocontainers/fastk:1.2--h71df26d_1"
---

# fastk

## Overview

FastK is a high-performance, disk-based k-mer counter optimized for high-fidelity sequencing datasets. Unlike general-purpose counters, it is designed to be extremely fast for low-error data (under 1% error) and can process massive genomes (like the 32GB Axolotl) on machines with modest RAM by leveraging efficient disk-sorting. It produces three primary outputs: histograms of k-mer frequencies, lexicographically sorted k-mer/count tables, and sequence profiles that map k-mer counts back to specific positions in the input reads.

## Core CLI Usage

### Basic K-mer Counting
To count k-mers and produce a histogram:
```bash
FastK -k40 -v -M16 sample.fastq
```
*   `-k`: Sets k-mer length (default is 40).
*   `-v`: Enables verbose output to track progress.
*   `-M`: Limits memory usage in GB (e.g., 16GB). FastK will use disk space if the dataset exceeds this.

### Generating Tables and Profiles
To generate a k-mer table (k-mer/count pairs) and sequence profiles:
```bash
FastK -t1 -p sample.fastq
```
*   `-t`: Includes k-mers in a `.ktab` file if they occur at least N times (e.g., `-t1` for all k-mers).
*   `-p`: Produces a `.prof` file containing the count of every k-mer at its position in each read.

### Handling Input Formats
FastK natively supports multiple formats including `.fasta`, `.fastq`, `.sam`, `.bam`, and `.cram`. It also handles gzipped files automatically.
```bash
FastK -k31 reads.bam
```

## Managing FastK Files

FastK creates hidden "part" files to manage large datasets (e.g., `.sample.ktab.1`, `.sample.ktab.2`). Standard filesystem commands like `rm` or `cp` will miss these hidden components. Always use the provided suite tools:

*   **Delete**: `Fastrm sample` (removes `.hist`, `.ktab`, `.prof` and all hidden parts).
*   **Move/Copy**: Use `Fastmv` or `Fastcp` to ensure all hidden data parts are transferred correctly.
*   **Concatenate**: `Fastcat -h -t -p target source1 source2` (merges multiple FastK outputs into a single target).

## Data Extraction and Analysis

FastK outputs are binary. Use the "ex" (extraction) tools to view or convert data:

*   **Histex**: Display histogram data.
    ```bash
    Histex sample.hist
    ```
*   **Tabex**: Query or list k-mer tables.
    ```bash
    Tabex sample.ktab          # List all entries
    Tabex sample.ktab TTT...A  # Find count for a specific k-mer
    ```
*   **Profex**: View profiles for specific reads.
    ```bash
    Profex sample.prof 1 10    # Show profiles for reads 1 through 10
    ```

## Expert Tips and Best Practices

*   **Canonical K-mers**: FastK considers a k-mer and its Watson-Crick complement as the same entity. It stores the lexicographically smaller version (the "canonical" k-mer).
*   **HPC Workflows**: For very large datasets, use `Fastmerge` to combine results from independent runs on sub-parts of the data.
*   **Logical Operations**: Use `Logex` to perform set operations on k-mer tables (e.g., finding k-mers present in Sample A but not Sample B).
    ```bash
    Logex "A-B" -otable_diff A.ktab B.ktab
    ```
*   **Homopolymer Compression**: Use the `-c` flag if working with technologies prone to homopolymer length errors; this compresses runs of the same base into a single base before counting.
*   **Memory vs. Disk**: If you have high-speed NVMe storage, you can set `-M` lower to save RAM; FastK's disk-based sorting is highly optimized for fast I/O.



## Subcommands

| Command | Description |
|---------|-------------|
| FastK | FastK is a tool for k-mer counting and analysis. |
| Logex | Logex |
| Profex | Profex |
| Tabex | Tabex is a tool for extracting k-mers from k-mer tables. |

## Reference documentation
- [FastK: A K-mer counter (for HQ assembly data sets)](./references/github_com_thegenemyers_FASTK.md)
- [FastK.c Source Implementation](./references/github_com_thegenemyers_FASTK_blob_master_FastK.c.md)
- [FastK README](./references/github_com_thegenemyers_FASTK_blob_master_README.md)