---
name: mcl
description: The Markov Cluster (MCL) algorithm performs unsupervised clustering of graphs and networks by simulating stochastic flow. Use when user asks to cluster protein sequences, detect communities in large networks, or configure the mcl command-line tool with specific inflation values.
homepage: https://micans.org/mcl/
---


# mcl

## Overview
The Markov Cluster (MCL) algorithm is a fast and scalable unsupervised cluster algorithm for graphs (networks) based on simulation of stochastic flow. It is widely used in bioinformatics for clustering protein sequences and in general data science for community detection in large networks. This skill assists in configuring the `mcl` command-line tool, selecting appropriate inflation values, and managing the input/output workflow.

## Core CLI Usage
The basic syntax for running MCL is:
`mcl <input_file> --abc -I <inflation_value> -o <output_file>`

### Input Formats
- **ABC Format**: A simple tab-separated text file with three columns: `node_A node_B weight`. Use the `--abc` flag to process this format.
- **Native Matrix Format**: MCL's internal format. If using raw matrices, ensure they are formatted correctly for the `mcx` suite.

### The Inflation Parameter (`-I`)
The inflation parameter is the primary handle for controlling cluster granularity.
- **Range**: Typically between 1.2 and 5.0.
- **Low Inflation (1.2 - 1.8)**: Produces fewer, larger, and coarser clusters.
- **High Inflation (2.0 - 5.0)**: Produces many small, fine-grained clusters.
- **Best Practice**: Start with `2.0` as a default. If clusters are too large, increase the value in increments of 0.5.

## Common Workflow Patterns

### Basic Clustering
To cluster a weighted network in ABC format with default inflation:
`mcl network.abc --abc -I 2.0 -o out.clusters`

### Handling Large Networks
For very large graphs, use the `-te` parameter to specify the number of threads for parallel execution:
`mcl network.abc --abc -I 2.0 -te 4 -o out.clusters`

### Pre-processing with mcxload
For complex pipelines, it is often better to convert ABC files to MCL's native binary format first using `mcxload`. This allows for better label management:
1. Create a tab and binary file: `mcxload -abc network.abc --stream-mirror -write-tab labels.tab -o network.mci`
2. Run MCL on the binary: `mcl network.mci -I 2.0`
3. Format output back to labels: `mcxdump -icl out.network.mci.I20 -tabr labels.tab -o clusters.txt`

## Expert Tips
- **Self-loops**: MCL automatically handles self-loops, but you can influence them using the `-self-loop` flag if the input graph lacks them.
- **Pruning**: If memory is an issue on massive graphs, use `-P` and `-S` to adjust pruning constants, though the defaults are usually optimal for accuracy.
- **Validation**: Use the `clm info` and `clm modularity` tools (part of the MCL suite) to evaluate the quality of the resulting clusters.

## Reference documentation
- [MCL Overview](./references/micans_org_mcl.md)
- [Bioconda MCL Package](./references/anaconda_org_channels_bioconda_packages_mcl_overview.md)