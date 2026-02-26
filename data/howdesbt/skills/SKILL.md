---
name: howdesbt
description: HowDeSBT is a tool for large-scale sequence search that uses partitioned Bloom filters to optimize storage and query efficiency. Use when user asks to create Bloom filters from sequence data, cluster filters into a tree topology, build a searchable index, or query sequences against a Sequence Bloom Tree.
homepage: https://github.com/medvedevgroup/HowDeSBT
---


# howdesbt

## Overview
HowDeSBT (How-Determined Sequence Bloom Tree) is a specialized tool for large-scale sequence search. It optimizes the standard SBT approach by partitioning Bloom filters into "how" and "determined" components, which significantly reduces the storage footprint and improves query efficiency. Use this skill to navigate the multi-step process of constructing a searchable index from raw sequence data and executing queries against that index.

## Installation and Setup
Install howdesbt via Bioconda for the most stable environment:
```bash
conda install bioconda::howdesbt
```
To verify the installation and see available subcommands, run:
```bash
howdesbt ?
```

## Core Workflow

### 1. Create Bloom Filters (makebf)
Convert your input sequence files (FASTA/FASTQ) into Bloom filters. This step typically requires k-mer counting (often using Jellyfish).
- Use `howdesbt ?makebf` to see specific formatting requirements for input k-mer lists.
- Ensure all Bloom filters in a set use the same k-mer size and filter size (number of bits).

### 2. Determine Tree Topology (cluster)
Organize the leaf Bloom filters into a tree structure based on similarity.
- Run `howdesbt cluster` on your collection of Bloom filters.
- This command generates a topology file that defines the parent-child relationships in the tree.

### 3. Build the SBT (build)
Construct the internal nodes of the tree using the topology defined in the previous step.
- Run `howdesbt build` using the topology file and the leaf Bloom filters.
- This process calculates the "how" and "determined" filters for every internal node, creating the final searchable index.

### 4. Query the Tree (query)
Search for sequences or k-mer sets within the built SBT.
- Use `howdesbt query` to search the tree.
- You can adjust threshold parameters to define what constitutes a "match" for a sequence across the tree nodes.

## Expert Tips and Best Practices
- **Parameter Estimation**: Use `ntCard` before running `makebf` to estimate the optimal Bloom filter size and k-mer counts for your specific dataset.
- **Detailed Help**: Access detailed documentation for any subcommand by prefixing it with a question mark, such as `howdesbt ?query` or `howdesbt ?build`.
- **Similarity Analysis**: Use the `bfdistance` subcommand to calculate Jaccard similarity between Bloom filters, which is useful for troubleshooting clustering results.
- **Resource Management**: Building an SBT is memory-intensive. Ensure your system has sufficient RAM to hold the bit vectors during the `build` and `cluster` phases.
- **Version Check**: Use `howdesbt version` to ensure you are running version 2.0.0 or later to take advantage of the "how/determined" split filter optimizations.

## Reference documentation
- [HowDeSBT GitHub Repository](./references/github_com_medvedevgroup_HowDeSBT.md)
- [HowDeSBT Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_howdesbt_overview.md)