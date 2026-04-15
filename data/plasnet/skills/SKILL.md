---
name: plasnet
description: Plasnet is a genomic analysis toolset that transforms plasmid evolutionary distance data into graph-based representations to identify communities and subcommunities. Use when user asks to partition plasmid datasets into communities, refine communities into specific types, identify hub plasmids, or visualize plasmid networks.
homepage: https://github.com/leoisl/plasnet
metadata:
  docker_image: "quay.io/biocontainers/plasnet:0.7.0--pyhdfd78af_0"
---

# plasnet

## Overview
`plasnet` is a specialized Python toolset designed for the genomic analysis of plasmids. It transforms pairwise evolutionary distance data into a graph-based representation, allowing researchers to partition large datasets into manageable "communities" and further refine them into specific "types" or subcommunities. By identifying "hub" plasmids—highly connected nodes that can obscure network structure—and providing interactive HTML visualizations, `plasnet` facilitates the exploration of plasmid evolution and horizontal gene transfer.

## Core Workflows

### 1. Initial Graph Splitting
Use the `split` command to generate an initial plasmid graph and partition it into communities.

```bash
plasnet split [PLASMIDS_FILE] [DISTANCES_FILE] [OUTPUT_DIR] \
  --distance-threshold 0.5 \
  --bh-connectivity 10 \
  --output-plasmid-graph
```
*   **Plasmids File**: A TSV with a single column `plasmid` listing all identifiers.
*   **Distances File**: A TSV with three columns: `plasmid_1`, `plasmid_2`, and `distance` (0.0 to 1.0).
*   **Distance Threshold**: The maximum distance allowed for an edge to exist between two plasmids.

### 2. Community Typing
Refine communities into subcommunities (types) using the `type` command. This typically uses a more stringent distance function or specific parameters to identify fine-grained relationships.

```bash
plasnet type [COMMUNITIES_PICKLE] [DISTANCES_FILE] [OUTPUT_DIR]
```
*   **Pickle Input**: Uses the `.pickle` file generated during the `split` step.
*   **Hub Identification**: This step explicitly identifies "hub" plasmids (highly connected nodes) and outputs them to `hub_plasmids.csv`.

### 3. Mapping Sample Hits
Annotate existing subcommunities with specific sample data to see which plasmids from your samples match the reference network.

```bash
plasnet add-sample-hits [TYPE_PICKLE] [SAMPLE_HITS_TSV] [OUTPUT_DIR]
```
*   This is essential for determining if different samples share the same plasmid types.

## Expert Tips and Best Practices

*   **Hub (Blackhole) Management**: If your visualization is a "hairball," adjust `--bh-connectivity` (minimum connections to be a hub) and `--bh-neighbours-edge-density` (max density among neighbors). `plasnet` iteratively removes these hubs to reveal the underlying community structure.
*   **Metadata Integration**: Use the `--plasmids-metadata` flag in the `split` command to attach custom attributes to plasmids, which will be reflected in the interactive visualizations.
*   **Cytoscape Integration**: For publication-quality figures, use the flags to output Cytoscape-compatible JSON files. You can then load the `plasnet` style file (available in the repository) into Cytoscape to maintain consistent coloring and labeling.
*   **Incremental Analysis**: As of v0.7.0, you can run `split` and `type` commands using previous results on a subset of plasmids to compare new data against established clusters without re-running the entire dataset.



## Subcommands

| Command | Description |
|---------|-------------|
| plasnet add-sample-hits | Add sample hits annotations on top of previously identified subcommunities or types |
| plasnet split | Creates and split a plasmid graph into communities |
| plasnet type | Type the communities of a previously split plasmid graph into subcommunities or types |

## Reference documentation
- [GitHub Repository README](./references/github_com_leoisl_plasnet_blob_main_README.md)
- [Changelog and Version History](./references/github_com_leoisl_plasnet_blob_main_CHANGELOG.md)