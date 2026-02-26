---
name: famsa
description: FAMSA is a high-performance tool designed for large-scale multiple sequence alignment of protein datasets. Use when user asks to align protein sequences, perform profile-profile alignment, generate distance or identity matrices, or export guide trees.
homepage: https://github.com/refresh-bio/FAMSA
---


# famsa

## Overview
FAMSA (Fast Alignment of Multiple Sequences Algorithm) is a specialized tool for large-scale protein sequence alignment. It is designed for extreme performance, capable of aligning millions of sequences with minimal memory overhead. It utilizes a progressive alignment strategy and offers multiple guide tree construction methods, including a highly optimized medoid tree approach for massive datasets.

## Command Line Usage

### Basic Alignment
The simplest usage requires an input FASTA file and a target output filename.
```bash
famsa input.fasta output.aln
```

### Large-Scale Alignments (>100,000 sequences)
For massive datasets, use the medoid tree feature to significantly reduce computation time and memory usage.
```bash
famsa -medoidtree -gt upgma input.fasta output.aln
```

### Guide Tree Operations
FAMSA can export or import guide trees in Newick format.
*   **Exporting a tree:**
    ```bash
    famsa -gt nj -gt_export input.fasta tree.dnd
    ```
*   **Aligning using a specific tree:**
    ```bash
    famsa -gt import tree.dnd input.fasta output.aln
    ```

### Profile-Profile Alignment
To align two existing alignments (profiles) while preserving their internal gaps:
```bash
famsa profile1.fasta profile2.fasta output_combined.aln
```

### Matrix Generation
Generate distance or identity matrices in CSV format.
*   **Distance Matrix (Lower Triangular):**
    ```bash
    famsa -dist_export input.fasta dist.csv
    ```
*   **Percent Identity Matrix (Square):**
    ```bash
    famsa -dist_export -pid -square_matrix input.fasta pid.csv
    ```

## Expert Tips and Best Practices

*   **Thread Optimization:** Use the `-t` flag to specify threads. For maximum performance, do not exceed the number of **physical** cores. Setting `-t 0` uses half of the available logical cores.
*   **Refinement Control:** By default, FAMSA enables refinement only for sets with ≤ 1000 sequences (`-refine_mode auto`). For larger sets where accuracy is more critical than speed, manually enable it with `-refine_mode on`. Conversely, disable it for maximum speed on smaller sets with `-refine_mode off`.
*   **Memory and I/O:** Use the `-gz` flag to produce gzipped output directly, saving disk space. FAMSA can also read gzipped input files automatically.
*   **Duplicate Handling:** By default, FAMSA removes duplicate sequences before alignment and restores them afterward to save time. If you need to process every sequence individually, use `-keep_duplicates`.
*   **Guide Tree Methods:** 
    *   `sl` (Single Linkage): Default, fastest.
    *   `upgma`: Good balance for most biological sequences.
    *   `nj` (Neighbor Joining): More computationally expensive but often more accurate for divergent sequences.

## Reference documentation
- [FAMSA GitHub Repository](./references/github_com_refresh-bio_FAMSA.md)
- [Bioconda FAMSA Overview](./references/anaconda_org_channels_bioconda_packages_famsa_overview.md)