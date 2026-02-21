---
name: heinz
description: HEINZ (Heuristic for Enriched Interaction Network Zone) is a computational tool designed to find the most significant functional modules within a larger interaction network.
homepage: https://github.com/ls-cwi/heinz
---

# heinz

## Overview
HEINZ (Heuristic for Enriched Interaction Network Zone) is a computational tool designed to find the most significant functional modules within a larger interaction network. It treats module discovery as an optimization problem, specifically the Maximum Weight Connected Subgraph (MWCS) problem. By integrating node-specific weights (such as scores derived from gene expression p-values) with network topology, HEINZ identifies the highest-scoring connected component, which often corresponds to a biologically active pathway or complex.

## Installation
The recommended method for installation is via Bioconda:

```bash
conda install bioconda::heinz
```

Note: HEINZ requires the IBM ILOG CPLEX solver. If you are compiling from source, you must have CPLEX installed and may need to specify paths to the include and library directories during the `cmake` step.

## Command Line Usage
HEINZ operates primarily on node and edge lists or standardized Steiner Tree Problem (.stp) files.

### Standard PCST Input
To run HEINZ using separate node and edge files:

```bash
heinz -n <nodes_file> -e <edges_file>
```

*   `-n`: Path to the text file containing nodes and their scores.
*   `-e`: Path to the text file containing edges.

### DIMACS Format
For instances following the DIMACS challenge formats:

*   **MWCS instances**: `heinz -stp <input.stp>`
*   **PCST instances**: `heinz -stp-pcst <input.stp>`

## Input Specifications
*   **Nodes File**: A tab-delimited file. Each line should contain a node identifier followed by its numerical score.
*   **Edges File**: A tab-delimited file. Each line should contain two node identifiers representing an edge between them.
*   **Scoring**: HEINZ expects scores where positive values indicate nodes of interest and negative values act as penalties. In bioinformatics, p-values are typically transformed into these scores using a Beta-binomial distribution model before being passed to HEINZ.

## Expert Tips and Best Practices
*   **Solver Performance**: HEINZ relies on Integer Linear Programming (ILP). For large-scale networks, the performance is highly dependent on the version of CPLEX used. Ensure you are using a modern version (12.x or higher) for optimal speed.
*   **Memory Management**: Solving the MWCS problem is NP-hard. While HEINZ is efficient, very dense networks or those with many positive nodes may require significant memory.
*   **Suboptimal Solutions**: By default, HEINZ searches for the optimal solution. If the optimal solution is too large or biologically broad, consider adjusting the parameters used to generate the input scores (e.g., the FDR threshold in the Beta-binomial model) rather than the HEINZ execution parameters.
*   **Data Preparation**: Ensure node identifiers are consistent between your node score file and your edge list. Mismatched IDs will result in nodes being treated as isolated components.

## Reference documentation
- [heinz - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_heinz_overview.md)
- [ls-cwi/heinz: Single species module discovery](./references/github_com_ls-cwi_heinz.md)