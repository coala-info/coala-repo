---
name: clusterone
description: ClusterONE is a graph clustering algorithm designed to identify overlapping clusters and protein complexes within weighted networks. Use when user asks to identify overlapping clusters, find protein complexes in interaction networks, or perform graph clustering on weighted edge lists.
homepage: https://paccanarolab.org/cluster-one/
metadata:
  docker_image: "quay.io/biocontainers/clusterone:1.0--hdfd78af_0"
---

# clusterone

## Overview
ClusterONE is a specialized graph clustering algorithm designed to handle weighted edges and identify overlapping clusters. Unlike many partition-based algorithms, it allows nodes to belong to multiple groups, which is essential for modeling biological systems where proteins often participate in multiple complexes. This skill assists in preparing input data, configuring expansion parameters, and interpreting the resulting cluster sets.

## Command Line Usage
The standalone version of ClusterONE is typically distributed as a Java archive (`cluster_one.jar`).

### Basic Execution
```bash
java -jar cluster_one.jar [options] input_file
```

### Input Format
- **Edge List**: A space- or tab-separated file where each line represents an edge: `node1 node2 [weight]`.
- **Weights**: If weights are provided, they should represent interaction confidence values (0 to 1).

### Key Parameters
- `-s <size>`: Minimum size of clusters to report (default is usually 3).
- `-d <density>`: Minimum density required for a cluster.
- `-o <overlap_threshold>`: Threshold for merging highly overlapping clusters (0 to 1).
- `--weighted`: Explicitly treat the input as a weighted graph.
- `--unweighted`: Treat all edges as having a weight of 1.0.

## Best Practices
- **Data Preprocessing**: Ensure your protein-protein interaction (PPI) network is formatted as a clean edge list. If using weighted data, normalize weights to a consistent scale (e.g., 0.0 to 1.0) before running the algorithm.
- **Handling Overlap**: If the output produces too many redundant clusters, increase the overlap threshold (`-o`) to merge similar neighborhoods more aggressively.
- **Significance Testing**: For biological networks, focus on clusters with a high "cohesiveness" score, which ClusterONE calculates based on the ratio of internal edge weights to the total weight of edges incident to the cluster.
- **Memory Management**: For very large networks, increase the Java heap size using the `-Xmx` flag (e.g., `java -Xmx4g -jar cluster_one.jar ...`).

## Reference documentation
- [ClusterONE Overview](./references/paccanarolab_org_cluster-one.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_clusterone_overview.md)