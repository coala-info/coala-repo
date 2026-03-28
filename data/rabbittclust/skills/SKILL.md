---
name: rabbittclust
description: RabbitTClust is a high-performance genomic clustering toolkit that utilizes dimensionality reduction and parallelization to process massive sequence datasets. Use when user asks to perform hierarchical clustering via MST, execute greedy incremental clustering, detect communities using Leiden or DBSCAN, or generate CLI commands for processing FASTA files.
homepage: https://github.com/RabbitBio/RabbitTClust
---


# rabbittclust

## Overview
RabbitTClust is a specialized toolkit designed for high-performance genomic clustering. It leverages dimensionality reduction (sketching) and parallelization to process massive datasets that would otherwise be computationally prohibitive. You should use this skill to determine the appropriate clustering algorithm (MST for hierarchical relationships, Greedy for rapid incremental updates, or Leiden/DBSCAN for community detection) and to generate the correct CLI commands for processing FASTA files or genome lists.

## Core Modules and Usage Patterns

RabbitTClust provides different binaries based on the desired clustering logic. All modules share common sketching parameters.

### 1. Minimum Spanning Tree (clust-mst)
Best for hierarchical clustering and single-linkage analysis.
- **Basic Command**: `clust-mst -i <input_fasta> -o <output_prefix> -d <distance_threshold>`
- **Input List**: Use `-l` if the input is a text file containing paths to multiple genomes.
- **Phylogeny**: Add `--newick-tree` to generate a Newick format file for downstream tree visualization.
- **Optimization**: Use `--fast` to enable the KSSD algorithm for faster sketching and distance computation.

### 2. Greedy Incremental (clust-greedy)
Best for very large datasets or when adding new genomes to an existing set.
- **Basic Command**: `clust-greedy -i <input_list> -o <output_prefix> -d <threshold>`
- **Incremental Updates**: Use `--save-rep` to store the representative inverted index, allowing for faster future additions using the `--append` flag.

### 3. Graph-Based & Density Clustering (clust-leiden / clust-dbscan)
Used for community detection within genomic networks.
- **Leiden**: Requires `igraph` dependency. Use for modularity-based community detection.
- **DBSCAN**: Use for density-based clustering to identify core genomic groups and noise.

## Expert Tips and Best Practices

### Sketching Parameters
The accuracy and speed of RabbitTClust depend heavily on sketching configuration:
- **K-mer Size (`-k`)**: Default is often sufficient, but adjust based on genome complexity (e.g., 21-31 for bacteria).
- **Sketch Size (`-s`)**: Default is 1000. Increase for higher sensitivity in distance estimation at the cost of memory and speed.
- **Containment (`-c`)**: Use when comparing genomes of significantly different sizes (e.g., a phage vs. a host) to use the Mash containment coefficient.

### Performance Tuning
- **Threads (`-t`)**: By default, the tool uses all available CPUs. Manually restrict this in shared HPC environments.
- **Filtering (`-m`)**: Use `-m <length>` to ignore small contigs or fragments (default is 10,000 bp).
- **Intermediate Files**: Use `-e` (no-save) to prevent the tool from writing large `.sketch` or `.mst` files to disk if you only need the final cluster assignments.

### Post-Processing
- **Representative Selection**: Use `--reps-per-cluster <int>` to automatically pick $k$ representative genomes from each cluster.
- **Deduplication**: Use `--dedup-dist <float>` to collapse near-identical nodes within a cluster into a single entry in a `.dedup` output file.



## Subcommands

| Command | Description |
|---------|-------------|
| clust-greedy | greedy incremental clustering module for RabbitTClust |
| clust-mst | minimum-spanning-tree-based module for RabbitTClust |

## Reference documentation
- [RabbitTClust GitHub Repository](./references/github_com_RabbitBio_RabbitTClust.md)
- [RabbitTClust README](./references/github_com_RabbitBio_RabbitTClust_blob_main_README.md)
- [Installation and Build Script](./references/github_com_RabbitBio_RabbitTClust_blob_main_install.sh.md)