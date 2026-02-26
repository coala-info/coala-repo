---
name: gretl
description: "gretl is a high-performance toolkit for the statistical analysis and evaluation of variation graphs in GFA format. Use when user asks to calculate graph statistics, perform core pangenome analysis, quantify path similarity, or generate node-level metrics."
homepage: https://github.com/moinsebi/gretl
---


# gretl

## Overview
gretl (Graph Evaluation Toolkit) is a high-performance tool designed for the statistical analysis of variation graphs. It operates on GFA (v1.0-1.2) files to generate metrics based on nodes, edges, and paths/walks. Use this skill to quantify graph complexity, identify core vs. accessory sequences, and perform bootstrap sampling of pangenome components. It is particularly useful for researchers working with pangenome builders like PGGB or Minigraph-Cactus who need to validate or summarize their graph structures.

## Core Workflow and Best Practices

### 1. Graph Preparation
gretl requires numerical node IDs. If your graph uses string identifiers, you must convert them first.

*   **ID Conversion**: Use `id2int` to map string IDs to integers.
    ```bash
    gretl id2int -g input.gfa -o numeric_graph.gfa -d id_dictionary.txt
    ```
*   **Sorting**: For "jump" statistics and window-based commands, the graph should be sorted in pan-genomic order. It is recommended to use `odgi sort -Y` before running gretl analysis.

### 2. Generating Statistics
The `stats` command is the primary entry point for graph evaluation.

*   **Graph-level Summary**: Provides global metrics and hybrid statistics (average/SD of paths).
    ```bash
    gretl stats -g graph.gfa -o summary_stats.txt
    ```
*   **Path-specific Metrics**: Use the `-p` flag to calculate statistics for every individual path/sample in the graph.
    ```bash
    gretl stats -g graph.gfa -o path_stats.txt -p
    ```
*   **PanSN Support**: If your GFA follows the PanSN-spec (e.g., `Sample#Haplotype#Contig`), use `--pansn` to group paths by sample.

### 3. Similarity and Core Analysis
These commands help define the "pangenome genome" components.

*   **Core Analysis**: Summarize how much sequence exists at each similarity level (e.g., sequence present in 1 sample, 2 samples, ..., all samples).
    ```bash
    gretl core -g graph.gfa -o core_stats.txt
    ```
*   **Path Similarity (PS)**: Calculate similarity levels specifically for each path to see how much of a specific sample is "core" vs. "unique."
    ```bash
    gretl ps -g graph.gfa -o path_similarity.txt
    ```

### 4. Node-Level Inspection
For granular analysis of graph topology:
*   **Node-list**: Generates a TSV containing Length, Core level, Depth, and Node Degree (ND) for every node.
    ```bash
    gretl node-list -g graph.gfa -o nodes.tsv
    ```

### 5. Performance Optimization
*   **Multithreading**: Most commands support the `-t` option. Always specify threads for large pangenomes to ensure linear scaling.
    ```bash
    gretl stats -t 8 -g large_graph.gfa -o output.txt
    ```

## Expert Tips
*   **Memory Efficiency**: gretl is designed to be memory efficient, but very large graphs with millions of paths/walks may still require significant RAM.
*   **Walks vs. Paths**: While gretl accepts GFA `W` (walk) lines, it treats them internally as paths.
*   **Integration**: The output TSV files are designed for easy downstream visualization. Use the `node-list` output to identify high-degree nodes which often represent collapsed repeats or complex structural variations.

## Reference documentation
- [GitHub - MoinSebi/gretl](./references/github_com_MoinSebi_gretl.md)