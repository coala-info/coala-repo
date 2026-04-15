---
name: bubblefinder
description: BubbleFinder identifies and decomposes structural sites like snarls, superbubbles, and ultrabubbles in pangenome graphs using linear-time SPQR-tree algorithms. Use when user asks to detect snarls, identify superbubbles or ultrabubbles in GFA files, or export SPQR-tree structures for genomic variation analysis.
homepage: https://github.com/algbio/BubbleFinder
metadata:
  docker_image: "quay.io/biocontainers/bubblefinder:1.0.3--h503566f_0"
---

# bubblefinder

## Overview
BubbleFinder is a specialized tool for pangenome graph analysis that identifies and decomposes structural sites. It is significantly faster than traditional tools like `vg` for specific tasks, such as ultrabubble enumeration on large human pangenomes. Use this skill to execute graph decompositions, handle bidirected or directed GFA files, and extract SPQR-tree structures for genomic variation analysis.

## Installation and Setup
Install BubbleFinder via Bioconda or use the prebuilt Linux binaries for the best performance.

```bash
# Conda installation
conda install -c conda-forge -c bioconda bubblefinder

# Basic help check
BubbleFinder --help
```

## Core Command Patterns
BubbleFinder uses a command-based interface. The general syntax is:
`BubbleFinder <COMMAND> -g <INPUT_GRAPH> -o <OUTPUT_FILE>`

### 1. Detecting Snarls
Use this to identify all snarls in a bidirected GFA. It aims to replicate `vg snarls -a -T` behavior but uses a linear-time SPQR-tree approach.
```bash
BubbleFinder snarls -g graph.gfa -o output.snarls
```
*   **Output**: Oriented incidences (e.g., `a+`, `d-`).
*   **Note**: It may output more snarls than `vg` because it does not apply the same pruning logic.

### 2. Detecting Superbubbles
Identify superbubbles in bidirected or directed graphs.
*   **For Bidirected GFA**:
    ```bash
    BubbleFinder superbubbles -g graph.gfa -o output.superbubbles
    ```
*   **For Directed Graphs**:
    ```bash
    BubbleFinder directed-superbubbles --gfa-directed -g graph.gfa -o output.superbubbles
    ```
*   **Output**: Segment ID pairs (e.g., `a e`).

### 3. Detecting Ultrabubbles
Ultrabubbles are identified by orienting the bidirected graph and reducing the problem to directed superbubbles.
```bash
BubbleFinder ultrabubbles -g graph.gfa -o output.ultrabubbles
```
*   **Critical Requirement**: Each connected component must have at least one "tip" (a node with degree 1) to serve as a starting point for orientation.

### 4. Exporting SPQR Trees
For advanced structural analysis, export the SPQR decomposition of the graph's biconnected components.
```bash
BubbleFinder spqr-tree -g graph.gfa -o graph.spqr
```

## Input Handling and Optimization
*   **Compression**: BubbleFinder automatically detects and handles compressed inputs (`.gz`, `.bz2`, `.xz`).
*   **Format Detection**:
    *   Use `--gfa` for standard bidirected GFA (default).
    *   Use `--gfa-directed` for GFA files where edges represent directed connections.
    *   Use `--graph` for the tool's internal directed graph format.
*   **Performance**: For large human chromosome graphs (e.g., Chromosome 1), BubbleFinder benefits significantly from multi-threading during the preprocessing and tree-building phases.

## Best Practices
*   **Memory Management**: BubbleFinder is highly memory-efficient compared to `vg`, especially on high-depth pangenomes like HPRC v2.0. Use it when `vg` runs into RAM limitations.
*   **Graph Orientation**: If `ultrabubbles` fails due to a lack of tips, consider manually adding auxiliary source/sink nodes or using the `superbubbles` command on a doubled directed graph.
*   **Compact Representations**: When running `snarls`, be aware that the tool may use "clique-lines" to represent many pairs compactly.

## Reference documentation
- [BubbleFinder GitHub Repository](./references/github_com_algbio_BubbleFinder.md)
- [Bioconda BubbleFinder Overview](./references/anaconda_org_channels_bioconda_packages_bubblefinder_overview.md)