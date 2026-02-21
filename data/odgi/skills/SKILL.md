---
name: odgi
description: odgi (Optimized Dynamic Genome/Graph Implementation) is a high-performance toolkit for pangenomics.
homepage: https://github.com/vgteam/odgi
---

# odgi

## Overview

odgi (Optimized Dynamic Genome/Graph Implementation) is a high-performance toolkit for pangenomics. It transforms complex genomic sequences into succinct, dynamic graph structures that minimize memory overhead while maximizing computational speed. This skill enables the efficient processing of large-scale pangenomes, allowing for the conversion of GFA files into optimized binary formats, the generation of informative visualizations, and the extraction of path-based genomic data.

## Core CLI Patterns

### Graph Construction and Optimization
The native `.og` format is significantly faster for downstream operations than raw GFA. Always build the graph first.

*   **Build and Sort**: Convert GFA to `.og` while sorting and optimizing the graph for better compression and performance.
    ```bash
    odgi build -g input.gfa -o graph.og -s -O -t <threads>
    ```
*   **GFA Compatibility**: odgi supports GFA v1.0. If using GFA v1.1 (with 'W' fields), convert it to v1.0 using `vg convert -W` before building with odgi.

### Visualization and Layout
odgi provides powerful tools to represent pangenome topology visually.

*   **1D Visualization (viz)**: Create a linear representation of the graph, often used to see path coverage and variation.
    ```bash
    odgi viz -i graph.og -o visualization.png -s '#' -t <threads>
    ```
*   **2D Layout (layout)**: Compute a 2D representation of the graph.
    ```bash
    odgi layout -i graph.og -o layout.lay -t <threads>
    ```
*   **GPU Acceleration**: If a GPU is available and the tool was built with CUDA support, use the `--gpu` flag with `odgi layout` for massive speedups (up to 50x).
    ```bash
    odgi layout -i graph.og -o layout.lay --gpu -t <threads>
    ```

### Path and Data Extraction
*   **Extract Path Names**: List all paths (e.g., haplotypes or samples) within the graph.
    ```bash
    odgi paths -i graph.og -L -t <threads>
    ```
*   **Graph Statistics**: Generate metrics for the graph, which can be integrated into MultiQC reports.
    ```bash
    odgi stats -i graph.og -S -t <threads>
    ```

## Expert Tips

*   **Memory Efficiency**: odgi uses variable-length integer representation. Sorting the graph (`-s` during build) ensures that node ID deltas are small, which significantly reduces the RAM footprint.
*   **Multi-threading**: Most odgi commands support the `-t` or `--threads` flag. Always specify the number of available cores to optimize performance on large pangenomes.
*   **Pipeline Integration**: odgi is a core component of the PGGB (Pangenome Graph Builder) pipeline. When working with minigraph-CACTUS outputs, ensure you use the `--odgi` flag in CACTUS to get native compatibility.

## Reference documentation

- [GitHub - pangenome/odgi](./references/github_com_pangenome_odgi.md)
- [odgi - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_odgi_overview.md)