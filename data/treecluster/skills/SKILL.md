---
name: treecluster
description: TreeCluster partitions phylogenetic tree leaves into clusters based on distance and support constraints. Use when user asks to partition phylogenetic tree leaves, identify transmission clusters, group sequences by genetic similarity, or cluster a phylogenetic tree.
homepage: https://github.com/niemasd/TreeCluster
metadata:
  docker_image: "quay.io/biocontainers/treecluster:1.0.5--pyh7e72e81_0"
---

# treecluster

## Overview
TreeCluster partitions the leaves of a phylogenetic tree (in Newick format) into the minimum number of clusters that satisfy specific distance and support constraints. It is highly efficient, often running in O(n) time, making it suitable for ultra-large trees. Use this tool to automate the identification of transmission clusters or to group sequences by genetic similarity while respecting tree topology.

## Basic Usage
Run the tool using the `TreeCluster.py` command. By default, it outputs a headerless tab-separated format: `SequenceName\tClusterID`.

```bash
# Basic clustering with the default 'max_clade' method and a 0.045 threshold
TreeCluster.py -i input_tree.nwk -t 0.045 -o clusters.txt

# Cluster using a specific branch support threshold (e.g., 95)
# Pairs connected by branches with support <= 95 will not be clustered together
TreeCluster.py -i input_tree.nwk -t 0.02 -s 95 -m max_clade
```

## Clustering Methods
Select a method using the `-m` flag based on your specific requirements:

- **max_clade (Default)**: Maximum pairwise distance in the cluster is $\le t$, and the cluster must be a monophyletic clade.
- **avg_clade**: Average pairwise distance in the cluster is $\le t$, and the cluster must be a monophyletic clade.
- **single_linkage**: Standard single-linkage clustering where any pair in a cluster is connected by a path of edges each $\le t$.
- **length**: No single edge within the cluster exceeds length $t$.
- **root_dist**: Cuts the tree at distance $t$ from the root.
- **leaf_dist_max**: Cuts the tree at distance $t$ from the "bottom" (furthest leaf from root).

## Expert Tips and Best Practices
- **Identify Singletons**: Leaves that do not meet the criteria to cluster with any other leaf are assigned a cluster ID of `-1`.
- **Threshold Selection**: If no specific threshold is known, `0.045` is the recommended starting point for viral sequences, as it aligns with Cluster Picker defaults.
- **Optimize Performance**: Most methods are O(n). However, `med_clade` is significantly slower (O(n² log n)) and should be avoided for very large trees unless median distance is strictly required.
- **Verify Clades**: Use the `-v` flag with clade-based methods (`max_clade`, `avg_clade`, `med_clade`, `length_clade`) to print the specific clades found to standard error for verification.
- **Check Support Values**: Ensure your Newick tree has support values if using the `-s` flag. If support is missing or formatted incorrectly, the tool may treat all branches as having low support.
- **Compare Clusterings**: Use the provided helper script `score_clusters.py` to calculate comparison metrics between two different clustering results.

## Reference documentation
- [TreeCluster Overview](./references/anaconda_org_channels_bioconda_packages_treecluster_overview.md)
- [TreeCluster GitHub Documentation](./references/github_com_niemasd_TreeCluster.md)