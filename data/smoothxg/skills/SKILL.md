---
name: smoothxg
description: `smoothxg` is a specialized tool for pangenomics that resolves local complexities in variation graphs.
homepage: https://github.com/pangenome/smoothxg
---

# smoothxg

## Overview
`smoothxg` is a specialized tool for pangenomics that resolves local complexities in variation graphs. Raw graphs built from genome alignments often contain dense, nonlinear structures that hinder interpretation. `smoothxg` identifies collinear blocks of paths and applies Partial Order Alignment (POA) to simplify them into acyclic subgraphs. It then "laces" these subgraphs back together based on the original paths. This process produces a "smoothed" graph that is manifold linear, preserving large structural variations while cleaning up small-scale alignment noise.

## Core Workflow and Best Practices

### 1. Prepare the Input Graph
*   **Format Requirement**: Input must be in GFA format.
*   **Path Records**: The graph must contain sequences represented as `P` (Path) records. The topology must be defined by `S` (Segment) and `L` (Link) records.
*   **Unique Naming**: Ensure all path names in the GFA are unique.
*   **Standard Pipeline**: Use `seqwish` to generate the initial variation graph from alignments before passing it to `smoothxg`.

### 2. Mandatory Pre-Sorting
`smoothxg` uses a greedy algorithm that assumes graph nodes are ordered according to their occurrence in embedded paths.
*   **Required Step**: Always sort the graph using a path-guided stochastic gradient descent (SGD) algorithm before smoothing.
*   **Recommended Tool**: Use `odgi sort -Y` to provide the necessary 1D graph layout/sort.

### 3. Execution Patterns
*   **Basic Smoothing**: Run `smoothxg` on a sorted GFA to produce a simplified version.
*   **Consensus Extraction**: Use the tool to extract a consensus pangenome graph by applying the heaviest bundle algorithm to each chain.
*   **Block Size Selection**: The resulting graph will only contain cyclic or inverting structures larger than the chosen block size. Adjust the block size based on the scale of variation you wish to preserve versus smooth.

### 4. Debugging and Optimization
*   **POA Statistics**: If the binary is built with `POA_DEBUG=ON`, use `-S` (`--write-split-block-fastas`) and `-B` (`--write-poa-block-fastas`) to inspect the intermediate sequences being aligned.
*   **Performance**: For large-scale pangenomes, ensure the system has sufficient memory, as the POA process can be resource-intensive depending on block size and path depth.

## Installation
*   **Conda**: `conda install -c bioconda smoothxg`
*   **Build from Source**: Requires GCC >= 9.3.0 and `cmake`. Ensure submodules are initialized: `git submodule update --init --recursive`.

## Reference documentation
- [smoothxg GitHub Repository](./references/github_com_pangenome_smoothxg.md)
- [smoothxg Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_smoothxg_overview.md)