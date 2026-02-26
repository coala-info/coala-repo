---
name: orientagraph
description: OrientAGraph builds and refines admixture graphs by optimizing the orientation of migration edges using Maximum Likelihood Network Orientation. Use when user asks to estimate admixture graphs with migration edges, optimize the orientation of gene flow events, or score and reorient existing population models.
homepage: https://github.com/sriramlab/OrientAGraph
---


# orientagraph

## Overview
OrientAGraph is an extension of the TreeMix software suite that implements Maximum Likelihood Network Orientation (MLNO). In population genetics, admixture graphs represent the historical relationships and gene flow between populations. While standard tools like TreeMix use heuristics to place migration edges, OrientAGraph optimizes the orientation of these edges to maximize the likelihood of the model. It can be used to build new graphs from scratch with improved search heuristics or to refine and score previously generated models.

## Installation and Setup
The most efficient way to install OrientAGraph is via Bioconda:
```bash
conda install bioconda::orientagraph
```

## Common CLI Patterns

### Standard Admixture Graph Estimation
To run a standard search for an admixture graph with migration edges (e.g., 2 edges) and an outgroup:
```bash
orientagraph -i input_data.gz -m 2 -root OutgroupPop -o output_prefix
```

### Running MLNO on Every Migration Edge
By default (v1.2+), OrientAGraph runs MLNO after the first two migration edges. To run it after every migration edge added:
```bash
orientagraph -i input_data.gz -m 5 -root OutgroupPop -mlno "" -o output_prefix
```

### Scoring and Reorienting an Existing Graph
If you already have a graph (vertices and edges files) and want to find the best orientation using MLNO:
```bash
orientagraph -i input_data.gz -gf input.vertices.gz input.edges.gz -score mlno -o reoriented_output
```

### Replicating Original Paper Methodology
To perform the most exhaustive search described in the original MLNO study (note: this is computationally expensive for many populations):
```bash
orientagraph -i input_data.gz -m 3 -root OutgroupPop -allmigs -mlno -o exhaustive_output
```

## Expert Tips and Best Practices

*   **Rooting is Critical**: Always use the `-root <population>` flag. OrientAGraph performs best when the starting tree is correctly rooted at a known outgroup before the network search begins.
*   **MLNO Frequency**: The `-mlno` flag accepts a comma-separated list of integers (e.g., `-mlno 1,2,3`). This tells the tool to run the MLNO routine only after those specific migration edges are added. Using `-mlno 0` disables the routine entirely.
*   **Computational Trade-offs**: The `-allmigs` flag evaluates every legal way to add a migration edge rather than using the standard TreeMix heuristic. Combining `-allmigs` with `-mlno` provides the most thorough search but may be prohibitively slow for large datasets.
*   **Input Preparation**: OrientAGraph uses the same input format as TreeMix (gzipped allele frequency files). Ensure your input file is properly formatted with population headers and count data.
*   **Block Jackknife**: Use the `-k` flag (e.g., `-k 500`) to specify the number of SNPs per block for estimating the covariance matrix, which accounts for linkage disequilibrium.

## Reference documentation
- [OrientAGraph GitHub Repository](./references/github_com_sriramlab_OrientAGraph.md)
- [Bioconda OrientAGraph Overview](./references/anaconda_org_channels_bioconda_packages_orientagraph_overview.md)