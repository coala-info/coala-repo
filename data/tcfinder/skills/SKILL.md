---
name: tcfinder
description: tcfinder (Target Cluster Finder) is a lightweight, high-performance tool written in Rust designed to find clusters of interest within a phylogenetic tree.
homepage: https://github.com/PathoGenOmics-Lab/tcfinder
---

# tcfinder

## Overview
tcfinder (Target Cluster Finder) is a lightweight, high-performance tool written in Rust designed to find clusters of interest within a phylogenetic tree. Unlike general clade extractors, tcfinder specifically searches for groups that contain a user-defined minimum number of "target" samples and maintain a minimum proportion of those targets relative to the total number of tips in the clade. This makes it highly effective for identifying transmission clusters, localized outbreaks, or specific evolutionary lineages in large datasets.

## Installation and Setup
The tool is available via Bioconda.
```bash
conda install -c bioconda tcfinder
```

## Input Requirements
tcfinder requires two specific input files:
1.  **Target List**: A plain text file (`.txt`) containing one tip label per line.
2.  **Phylo4 Tree**: A CSV file representing the tree structure. tcfinder does **not** accept Newick or Nexus files directly.

### Converting Trees to tcfinder Format
You must convert your Newick/Nexus trees to the required CSV format using R (specifically the `phylobase` and `ape` packages).

**R Conversion Script:**
```R
library(ape)
library(phylobase)

# Load your tree
tree <- read.tree("my_tree.nwk")

# Convert to phylo4 and then to a dataframe
tree.p4 <- as(tree, "phylo4")
tree.p4.df <- as(tree.p4, "data.frame")

# Rename columns to match tcfinder requirements
names(tree.p4.df) <- c("label", "node", "ancestor", "edgelength", "nodetype")

# Export to CSV
write.csv(tree.p4.df, "tree_for_tcfinder.csv", row.names = FALSE)
```

## Command Line Usage
The basic syntax requires the tree, the target list, and an output path.

```bash
tcfinder --tree tree.csv --targets targets.txt --output clusters.csv
```

### Refining Cluster Detection
Adjust the sensitivity of the search using the size and proportion flags:

*   **Minimum Size (`-s`)**: The minimum number of target samples required to form a cluster (Default: 2).
*   **Minimum Proportion (`-p`)**: The minimum "purity" of the cluster, calculated as `targets / total_tips_in_clade` (Default: 0.9).

**Example: Finding strict, large clusters**
To find clusters with at least 10 targets and 100% purity:
```bash
tcfinder -i tree.csv -t targets.txt -o results.csv -s 10 -p 1.0
```

## Expert Tips and Best Practices
*   **Label Matching**: Ensure that the identifiers in your `targets.txt` file exactly match the strings in the `label` column of your tree CSV. Whitespace or hidden characters will cause targets to be ignored.
*   **Branch Lengths**: tcfinder currently ignores branch lengths (genetic distance). If you need to consider temporal or genetic distance, you should collapse nodes with branch lengths below your desired threshold in R or another tool *before* converting the tree to the CSV format.
*   **Node Types**: The `nodetype` column in the input CSV must correctly identify "tip", "internal", or "root". The tool uses this to distinguish between sample leaves and internal branching points.
*   **Verbose Mode**: Use the `-v` or `--verbose` flag to debug why certain expected clusters might not be appearing; it provides feedback on the internal scoring of clades.

## Reference documentation
- [tcfinder GitHub Repository](./references/github_com_PathoGenOmics-Lab_tcfinder.md)
- [Bioconda tcfinder Package](./references/anaconda_org_channels_bioconda_packages_tcfinder_overview.md)