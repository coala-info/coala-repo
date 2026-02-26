---
name: r-ggrasp
description: This tool clusters genomes and selects representative medoids based on genomic relationships to reduce redundancy in large datasets. Use when user asks to cluster genomes, select representative genomes, reduce genomic redundancy, or prioritize specific strains in a dataset.
homepage: https://cran.r-project.org/web/packages/ggrasp/index.html
---


# r-ggrasp

name: r-ggrasp
description: Gaussian-Based Genome Representative Selector with Prioritization (ggrasp). Use this skill to cluster genomes and select representative members (medoids) based on genomic relationships (distance matrices, trees, or alignments). It is ideal for reducing redundancy in large genomic datasets using Gaussian Mixture Models (GMM) or user-defined thresholds.

## Overview
The `ggrasp` package identifies representative genomes from a larger set by modeling the distribution of genomic relationships. It transforms similarity or distance data into a phylogeny, clusters the genomes, and selects a "medoid" for each cluster. Users can prioritize specific genomes (e.g., type strains or high-quality assemblies) to be selected as representatives.

## Installation
```R
install.packages("ggrasp")
```

## Core Workflow

### 1. Loading Data
Use `ggrasp.load()` to import genomic relationship data. Supported formats include distance/similarity matrices, Newick trees, or FASTA alignments.

```R
library(ggrasp)

# Loading a similarity matrix (e.g., ANI) with an offset to convert to distance
# offset=100 is common for ANI (100 - similarity)
data_path <- system.file("extdata", "Enter.ANI.mat", package="ggrasp")
ggrasp_obj <- ggrasp.load(data_path, file.format="matrix", tree.method="complete", offset=100)
```

### 2. Clustering and Selection
Use `ggrasp.cluster()` to define clusters. By default, it uses a Gaussian Mixture Model (GMM) to find an optimal threshold *de novo*.

```R
# Default GMM clustering
clustered_obj <- ggrasp.cluster(ggrasp_obj)

# Clustering with a specific threshold (e.g., 0.05 distance)
clustered_threshold <- ggrasp.cluster(ggrasp_obj, threshold=0.05)

# Clustering into a specific number of groups
clustered_fixed <- ggrasp.cluster(ggrasp_obj, num.clusters=10)
```

### 3. Prioritization
To ensure specific genomes are preferred as representatives, provide a rank file (tab-delimited: Genome ID, Rank). Lower rank values (e.g., 1) are prioritized.

```R
# Load with prioritization ranks
ggrasp_ranked <- ggrasp.load(data_path, file.format="matrix", offset=100, rank.file="ranks.txt")
clustered_ranked <- ggrasp.cluster(ggrasp_ranked)
```

### 4. Output and Visualization
Extract the representative genomes (medoids) or visualize the clustering logic.

```R
# Get the list of representative genome IDs
representatives <- clustered_obj@medoids

# Summary of clusters
summary(clustered_obj)

# Plot the Gaussian Mixture Model distribution
plot(clustered_obj, "gmm")

# Plot the tree with clusters highlighted
plot(clustered_obj, "tree")
```

## Tips for Success
- **Similarity vs. Distance**: If using ANI or other similarity scores, always use the `offset` parameter (e.g., `offset=100`) to convert values to distances.
- **Tree Methods**: `tree.method` supports `hclust` options like "complete", "average", or "single", as well as "nj" for Neighbor-Joining.
- **GMM Tuning**: If the default GMM fails to converge or provides unexpected results, adjust `z.score` (default 1) to control cluster merging or `min.lambda` to filter out low-weight distributions.

## Reference documentation
- [GGRaSP README](./references/README.html.md)
- [ggrasp Project Home](./references/home_page.md)