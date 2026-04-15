---
name: gretl
description: gretl is a command-line utility for the quantitative analysis and evaluation of pangenome graphs in GFA format. Use when user asks to calculate graph statistics, analyze path similarity, determine core genome size, perform window-based analysis, or estimate pangenome saturation.
homepage: https://github.com/moinsebi/gretl
metadata:
  docker_image: "quay.io/biocontainers/gretl:0.1.1--hc1c3326_2"
---

# gretl

## Overview
`gretl` (Graph Evaluation Toolkit) is a specialized command-line utility designed for the quantitative analysis of pangenome graphs. It operates primarily on GFA (v1.0-1.2) files and provides a suite of subcommands to evaluate graph topology, path similarity, and sequence distribution. It is particularly useful for researchers working with pangenome builders like PGGB or Minigraph-Cactus who need to assess graph complexity, core genome size, or sample-specific variations.

## Core Requirements
*   **Input Format**: GFA v1.0, v1.1, or v1.2.
*   **Node IDs**: Must be numerical. If your graph uses string IDs, you must use the `id2int` subcommand first.
*   **Graph Order**: For "jump" statistics and window-based analysis, the graph should be sorted in pan-genomic order (e.g., using `odgi sort -Y`).

## Common CLI Patterns

### 1. Pre-processing Graphs
If your GFA has non-numeric node IDs, convert them to ensure compatibility:
```bash
gretl id2int -g input.gfa -o numeric_output.gfa -d id_dictionary.txt
```

### 2. Generating Statistics
Calculate comprehensive metrics for the entire graph or individual paths:
*   **Graph-wide summary**: `gretl stats -g graph.gfa -o stats.txt`
*   **Path-specific metrics**: `gretl stats -g graph.gfa -o path_stats.txt -p`
*   **PanSN grouping**: Use `--pansn` to group paths by sample name according to PanSN specifications.

### 3. Similarity and Core Analysis
Analyze how sequence is shared across different samples:
*   **Core sequence**: Calculate sequence/node counts at every similarity level:
    ```bash
    gretl core -g graph.gfa -o core_stats.txt
    ```
*   **Path Similarity (PS)**: Determine similarity levels specifically for each path:
    ```bash
    gretl ps -g graph.gfa -o path_sim.txt
    ```

### 4. Window-based Analysis
Examine local graph properties using sliding windows:
*   **Linear scale (bp)**: `gretl window -g graph.gfa -o window_stats.txt`
*   **Node-based scale**: `gretl nwindow -g graph.gfa -o node_window_stats.txt`

### 5. Pangenome Saturation (Bootstrapping)
To estimate how many samples are needed to capture the full diversity of a pangenome:
```bash
gretl bootstrap -g graph.gfa -o saturation_results.txt
```

## Expert Tips
*   **Performance**: Use the `-t` flag to specify the number of threads for multi-threaded execution on large graphs.
*   **Node Lists**: Use `gretl node-list` to generate a TSV of every node's length, degree, depth, and core status. This is excellent for identifying highly connected "hubs" or private sequence blocks.
*   **Memory Efficiency**: `gretl` is most memory-efficient when node IDs are dense (starting at 1 and ending at N+1).
*   **Visualization**: The output of most `gretl` commands is designed to be piped into the Python visualization scripts found in the `scripts/` directory of the repository (e.g., `saturation_plotter.py` or `window.py`).



## Subcommands

| Command | Description |
|---------|-------------|
| gretl find | Find features in the graph and return a BED file for further analysis |
| gretl nwindow | Extending from a single node |
| gretl window | Sliding window analysis (path-centric) |
| gretl-stats | Basic graph statistics for a single graph |
| gretl_block | Statistics on pangenome blocks |
| gretl_bootstrap | Bootstrap approach |
| gretl_core | General graph similarity statistics |
| gretl_id2int | Convert node identifier to numeric values (not sorted) |
| gretl_node-list | Statistics for each node |
| gretl_ps | How much core, soft and private genome is in each sample? |

## Reference documentation
- [Main README](./references/github_com_MoinSebi_gretl_blob_master_README.md)
- [Workflow Examples](./references/github_com_MoinSebi_gretl_blob_master_doc_gretl.examples.md)
- [Subcommand Explanations](./references/github_com_MoinSebi_gretl_blob_master_doc_gretl.explained.md)