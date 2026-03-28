---
name: gaftools
description: gaftools is a suite of utilities for processing pangenome graph alignments and managing rGFA-based graph structures. Use when user asks to convert GFA to rGFA, order graph bubbles, sort GAF files, realign sequences using WFA, index alignments, or extract specific paths and statistics from pangenome data.
homepage: https://github.com/marschall-lab/gaftools
---


# gaftools

## Overview
`gaftools` is a specialized suite of utilities designed to bridge the gap between pangenome graph structures and sequence alignments. It is particularly useful for researchers working with rGFA-based graphs (like those from minigraph-cactus) and GAF files. The toolkit provides essential operations for pangenome data management, including coordinate conversion, alignment realignment using Wavefront Alignment (WFA), and bubble-based graph ordering to facilitate better visualization and sorting.

## Core Workflows and CLI Patterns

### 1. Graph Preparation and Conversion
Before analyzing alignments, ensure your graph is in the correct format. `gaftools` relies heavily on rGFA tags (`SN`, `SO`, `SR`).

*   **Convert GFA to rGFA**: Use W-lines (walks) to generate a reference-stable rGFA.
    ```bash
    gaftools gfa2rgfa --reference-name CHM13 input.gfa --output output.rgfa.gz
    ```
*   **Order Graph Bubbles**: Establish a linear order for biconnected components (bubbles). This adds `BO` (Bubble Order) and `NO` (Node Order) tags.
    ```bash
    gaftools order_gfa --outdir ordered_graph/ input.rgfa
    ```

### 2. Alignment Processing
Once the graph is ordered, you can perform advanced alignment manipulations.

*   **Sort GAF Files**: Sorting is critical for efficient viewing and requires a graph ordered with `BO`/`NO` tags.
    ```bash
    gaftools sort --bgzip -o sorted.gaf.gz input.gaf ordered_graph.rgfa
    ```
*   **Realign with WFA**: Improve alignment quality using the Wavefront Alignment algorithm.
    ```bash
    gaftools realign --fasta reads.fa input.gaf graph.gfa > realigned.gaf
    ```

### 3. Subsetting and Statistics
*   **Index for Rapid Access**: Create a `.gvi` index to allow random access by node ID or region.
    ```bash
    gaftools index input.gaf graph.rgfa
    ```
*   **View Specific Regions**: Extract alignments covering specific nodes or genomic regions.
    ```bash
    gaftools view --region "node_100-node_200" input.gaf
    ```
*   **Generate Statistics**: Get a quick summary of alignment lengths, identities, and mapping qualities.
    ```bash
    gaftools stat input.gaf
    ```

### 4. Path Extraction
*   **Retrieve Sequences**: Extract the actual DNA sequence for a specific path through the graph.
    ```bash
    gaftools find_path -p ">s1>s2<s3" --fasta graph.gfa -o path_sequence.fa
    ```

## Expert Tips
*   **Memory Management**: When working with massive pangenomes, use the `--without-sequence` flag in `order_gfa` to strip DNA sequences from the output graph, significantly reducing memory and disk usage for visualization-only tasks.
*   **Branching Graphs**: If `order_gfa` fails due to complex graph topology, use `--ignore-branching` to enforce a linear order along the primary reference path while ignoring side-branches.
*   **BGZF Compression**: Always prefer `.gz` extensions and the `--bgzip` flag where available. `gaftools` is optimized for Blocked GNU Zip Format, which allows for indexed random access.
*   **Coordinate Stability**: Use `gfa2rgfa` to move from unstable segment-relative coordinates to stable, reference-based coordinates, which is essential for comparing pangenome alignments to standard linear reference results.



## Subcommands

| Command | Description |
|---------|-------------|
| find_path | Find the genomic sequence of a given connected GFA path. |
| gaftools_index | Index a GAF file for the view functionality. |
| gaftools_phase | Add phasing information to the GAF file from a haplotag TSV file. |
| gaftools_sort | Sort the GAF alignments using BO and NO tags of the corresponding graph. |
| gaftools_stat | Calculate statistics of the given GAF file. |
| gaftools_view | View, subset or convert a GAF file (GAF file should be indexed first, using gaftools index). |
| gfa2rgfa | Converting a GFA file to rGFA format using the W-lines and the acyclic reference path. (e.g., minigraph-based graphs) |
| order_gfa | Order bubbles in the GFA by adding BO and NO tags. |
| realign | Realign a GAF file using wavefront alignment algorithm (WFA). |

## Reference documentation
- [gaftools User Guide](./references/gaftools_readthedocs_io_en_latest_guide.html.md)
- [gaftools Overview](./references/github_com_marschall-lab_gaftools_blob_main_README.md)
- [Change Log and Version Features](./references/gaftools_readthedocs_io_en_latest_changes.html.md)