---
name: grafimo
description: GRAFIMO scans Position Weight Matrices against genome variation graphs to identify motif occurrences across multiple haplotypes simultaneously. Use when user asks to find motifs in variation graphs, scan PWMs against genomic variants, or identify individual-specific motif occurrences.
homepage: https://github.com/pinellolab/GRAFIMO
---


# grafimo

## Overview

GRAFIMO (GRAph-based Finding of Individual Motif Occurrences) is a command-line tool designed to scan Position Weight Matrices (PWMs) against genome variation graphs. Unlike traditional tools that scan a single linear reference genome, GRAFIMO leverages the `vg` framework to search across all haplotypes encoded in a variation graph simultaneously. This allows for the detection of motif occurrences that may only exist in specific individuals or populations due to genetic variation.

## Core Workflows

### Finding Motifs in Variation Graphs
The primary command is `findmotif`. It requires a variation graph (indexed with XG and GBWT), a motif file, and a BED file defining the search regions.

```bash
# Scan a directory of chromosome-specific VGs
grafimo findmotif -d /path/to/vg_indexes/ -m motif.meme -b regions.bed

# Scan a single whole-genome VG file
grafimo findmotif -g genome.xg -m motif.jaspar -b regions.bed
```

### Key Parameters and Filtering
*   **Thresholds**: By default, GRAFIMO uses a P-value threshold of `1e-4`.
    *   Change P-value threshold: `-t 1e-5`
    *   Use Q-value (FDR) instead: `--qvalueT -t 0.05`
*   **Background Distribution**: Provide a custom nucleotide background file using `-k`.
    *   Format: `A 0.25 C 0.25 G 0.25 T 0.25` (tab or space separated).
*   **Haplotype Awareness**: 
    *   By default, it reports occurrences found in at least one encoded haplotype.
    *   Use `--recomb` to include potential motif occurrences that can be formed by existing variants but are not explicitly present in the input haplotypes.

## Expert Tips and Best Practices

*   **Index Requirements**: Ensure that `.xg` and `.gbwt` indexes are stored in the same directory. GRAFIMO relies on these for efficient graph traversal and haplotype tracking.
*   **Chromosome Filtering**: If you only need to scan specific chromosomes within a multi-VG directory, use `--chroms-find` followed by the chromosome names (e.g., `--chroms-find 1 2 X`).
*   **Visualization**: To inspect the graph structure of the most significant hits, use `--top-graph <N>`. This generates PNG images of the top $N$ regions, showing how the motif aligns across different paths in the graph.
*   **Output Management**: Use `-o` to specify a custom output directory. By default, GRAFIMO creates a folder named `grafimo_out_PID_MOTIFID`.
*   **Performance**: For large-scale scans, ensure `vg`, `tabix`, and `graphviz` are in your system PATH, as GRAFIMO calls these external dependencies for graph processing and visualization.

## Reference documentation
- [GRAFIMO GitHub README](./references/github_com_pinellolab_GRAFIMO.md)
- [GRAFIMO Wiki - Running GRAFIMO](./references/github_com_pinellolab_GRAFIMO_wiki.md)