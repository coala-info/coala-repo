---
name: seidr
description: Seiðr is a toolkit for ensemble gene regulatory network inference that aggregates predictions from multiple independent algorithms to improve network robustness. Use when user asks to infer gene networks, aggregate multiple network predictions, extract top-ranked edges, or analyze scale-free topology.
homepage: https://github.com/bschiffthaler/seidr
---


# seidr

# Seiðr

## Overview
Seiðr is a specialized toolkit designed for "crowd" gene network inference. It enables the construction of ensemble networks by aggregating predictions from multiple independent algorithms—such as Random Forest (via Ranger), SVM, and Lasso (via GLMnet)—to improve the reliability and robustness of gene regulatory network (GRN) discovery.

## CLI Usage and Best Practices

### Network Ranking and Filtering
The `top` subcommand is the primary tool for extracting the most significant interactions from an inferred or aggregated network.

*   **Extracting Top Edges**: Use `seidr top` to filter for the N most significant edges.
*   **Handling Ties**: The tool is designed to handle score ties properly, ensuring that edges with identical weights are treated consistently during the ranking process.
*   **Large N Values**: When requesting a large number of top edges, `seidr top` maintains performance even when encountering high-scoring edges early in the file.

### Scale-Free Topology (SFT) Analysis
Seiðr includes functionality to evaluate and enforce scale-free topology, a common characteristic of biological networks.

*   **SFT Cutoff**: Use the `-c` flag to specify the SFT cutoff. 
    *   *Note*: In versions 0.14.2 and later, `-c` is the correct short flag (replacing the older `-S` flag to avoid conflicts).
*   **Scaling Control**: Use the `--no-scale` flag if you wish to prevent the tool from automatically scaling edge scores during processing.

### Core Algorithms
Seiðr integrates several high-performance libraries for network inference. When configuring workflows, consider the strengths of the bundled submodules:
*   **Ranger**: Fast implementation of Random Forests for feature importance.
*   **GLMnet**: Efficient Lasso and Elastic Net regression.
*   **LibSVM/LibLinear**: Support Vector Machine approaches for classification or regression-based inference.

### General Tips
*   **Version Checking**: If the tools only output version information, ensure the logger is properly initialized or check for installation conflicts.
*   **Help Pages**: Use the `--help` flag with any subcommand to view default values and parameter descriptions, which are updated to reflect current bugfixes in help display logic.



## Subcommands

| Command | Description |
|---------|-------------|
| aggregate | Aggregate multiple SeidrFiles. |
| cluster-enrichment | Test whether clusters of two networks show significant overlap or extract clusters |
| neighbours | Get the top N first-degree neighbours for each node or a list of nodes |
| resolve | Resolve node indices in text file to node names. |
| roc | Calculate ROC curves of predictions in SeidrFiles given true edges |
| seidr backbone | Determine noisy network backbone scores. Optionally filter on these scores. |
| seidr compare | Compare edges or nodes in two networks. |
| seidr graphstats | Calculate graph level network statistics |
| seidr index | Create index for SeidrFiles |
| seidr sample | Sample edges from a SeidrFile |
| seidr_adjacency | Transform a SeidrFile into an adjacency matrix |
| seidr_convert | Convert different text based formats |
| seidr_import | Convert various text based network representations to SeidrFiles |
| seidr_reheader | Modify SeidrFile headers. Currently only drops disconnected nodes and resets stats. |
| seidr_stats | Calculate network centrality statistics |
| threshold | Pick hard network threshold according to topology |
| view | View and filter contents of SeidrFiles |

## Reference documentation
- [Seidr GitHub Repository](./references/github_com_bschiffthaler_seidr.md)
- [Changelog and CLI Updates](./references/github_com_bschiffthaler_seidr_blob_master_CHANGES.md)
- [Submodule Integrations](./references/github_com_bschiffthaler_seidr_blob_master_.gitmodules.md)