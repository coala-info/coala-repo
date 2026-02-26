---
name: bte
description: The Big Tree Explorer is a Python API designed for the efficient programmatic analysis and manipulation of massive mutation-annotated phylogenetic trees. Use when user asks to load protobuf tree files, find the last common ancestor of samples, query mutations, or modify tree structures.
homepage: https://github.com/jmcbroome/BTE
---


# bte

## Overview

The Big Tree Explorer (bte) is a Cython-based Python API that wraps the Mutation Annotated Tree (MAT) library. It is specifically designed to handle massive phylogenetic trees—such as the global SARS-CoV-2 tree containing millions of sequences—which typically overwhelm standard libraries like Biopython.Phylo or ETE3. Use this skill to perform programmatically complex queries that exceed the capabilities of command-line tools like `matUtils`, while maintaining the speed of C++ through a Pythonic interface.

## Installation and Setup

The most reliable way to install `bte` is via the Bioconda channel.

```bash
# Create a dedicated environment for bte
conda create --name bte_env -c conda-forge -c bioconda bte python=3.8
conda activate bte_env
```

## Core Usage Patterns

### Loading a Tree
The primary entry point is the `MATree` object. It can load compressed or uncompressed protobuf files.

```python
import bte
# Load the latest public SARS-CoV-2 tree
tree = bte.MATree("public-latest.all.masked.pb.gz")
```

### Finding the Last Common Ancestor (LCA)
Efficiently find the common ancestor for a list of node IDs or samples.

```python
# Find LCA for a list of samples
node_ids = ["sample_1", "sample_2", "sample_3"]
lca_node = tree.get_lca(node_ids)
print(f"LCA Node ID: {lca_node}")
```

### Querying Mutations
Retrieve mutation information for specific nodes or branches.

```python
# Get mutations associated with a specific node
mutations = tree.get_mutations("node_id")
for mut in mutations:
    print(f"Position: {mut.position}, Ref: {mut.ref}, Alt: {mut.alt}")
```

### Tree Manipulation
You can modify branch lengths or annotate nodes directly within the MAT structure.

```python
# Set the branch length of a specific node
tree.set_branch_length("node_id", 0.0001)

# Write the modified tree back to a protobuf file
tree.save_pb("modified_tree.pb")
```

## Expert Tips

- **Data Sourcing**: For SARS-CoV-2 analysis, always use the daily updated trees maintained by UCSC (available at `http://hgdownload.soe.ucsc.edu/goldenPath/wuhCor1/UShER_SARS-CoV-2/`).
- **Memory Efficiency**: `bte` is significantly more memory-efficient than Newick-based parsers because it stores mutations as annotations on the tree structure rather than recalculating them from a multiple sequence alignment.
- **Performance**: If you are performing iterative searches across the tree, use `bte`'s built-in functions (like `get_lca`) rather than writing custom traversal logic in pure Python to leverage the underlying C++ speed.
- **Version Compatibility**: `bte` is Python version-specific. If you encounter `ImportError`, ensure your Python version matches the one used during the `conda install`.

## Reference documentation
- [bte Overview](./references/anaconda_org_channels_bioconda_packages_bte_overview.md)
- [BTE GitHub Repository](./references/github_com_jmcbroome_BTE.md)