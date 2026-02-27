---
name: bioconductor-signet
description: The bioconductor-signet package uses simulated annealing to identify and test the significance of high-scoring gene subnetworks within biological pathways. Use when user asks to find active gene subnetworks, perform pathway-based subnetwork searches, or identify significant connected components in biological networks.
homepage: https://bioconductor.org/packages/3.8/bioc/html/signet.html
---


# bioconductor-signet

## Overview

The `signet` package implements a heuristic search (simulated annealing) to identify gene subnetworks within biological pathways that exhibit unusually high scores. It is designed to move beyond simple pathway enrichment by finding specific connected components (subnetworks) that drive the signal. The significance of these subnetworks is determined by comparing their scores against an empirical null distribution generated from the input data.

## Workflow

### 1. Data Preparation

The package requires two main inputs:
- **Gene Scores**: A data frame where the first column is the Gene ID (e.g., Entrez) and the second column is the numerical score.
- **Pathway Graphs**: A list of `graphNEL` objects. It is recommended to use the `graphite` package to retrieve these.

```r
library(signet)
library(graphite)

# 1. Get pathways (e.g., KEGG human)
paths <- graphite::pathways("hsapiens", "kegg")
kegg_human <- lapply(paths, graphite::pathwayGraph)

# 2. Prepare scores (example format)
# data(daub13) 
# head(scores) 
#   gene     score
# 1    1 0.9200665
```

### 2. Searching for Subnetworks

Use `searchSubnet` to find the highest-scoring subnetwork (HSS) within each provided pathway.

```r
# Run simulated annealing search
HSS <- searchSubnet(kegg_human, scores)
```

### 3. Significance Testing

To determine if the found subnetworks are statistically significant, you must generate a null distribution by randomly sampling scores across the network structures.

```r
# 1. Generate empirical null distribution (n = 1000 or more recommended)
null <- nullDist(kegg_human, scores, n = 1000)

# 2. Compute p-values and update the signet object
HSS <- testSubnet(HSS, null)
```

### 4. Results and Interpretation

Generate a summary table to view the pathway name, subnetwork size, score, p-value, and the specific genes involved.

```r
# Generate summary table
tab <- summary(HSS)

# Filter for significant results (e.g., p < 0.05)
sig_pathways <- tab[tab$p.val < 0.05, ]
```

### 5. Visualization

`signet` facilitates network visualization by exporting results to XGMML format, which can be imported into Cytoscape.

- **Single Pathway**: Highlights the HSS within the context of the full pathway.
- **Merged Subnetworks**: Merges all subnetworks meeting a specific p-value threshold.

```r
# Export a single pathway (the first one in the list)
writeXGMML(HSS[[1]], filename = "single_pathway.xgmml")

# Export all significant subnetworks (p < 0.01) merged into one graph
writeXGMML(HSS, filename = "merged_significant.xgmml", threshold = 0.01)
```

## Tips and Best Practices

- **Identifier Matching**: Ensure that the Gene IDs in your `scores` data frame match the node IDs in the `graphNEL` objects (typically Entrez IDs). Use `graphite::convertIdentifiers` if necessary.
- **Computation Time**: `searchSubnet` and `nullDist` can be computationally intensive for large pathway sets. Consider parallelizing these steps if working with hundreds of pathways.
- **Null Distribution Size**: For publication-quality p-values, increase `n` in `nullDist` (e.g., `n = 10000`). You can concatenate multiple null distribution vectors to increase precision.
- **Score Direction**: The algorithm searches for *high* scores. If your input data consists of p-values where low values are significant, transform them (e.g., `-log10(p-value)`) before running `signet`.

## Reference documentation

- [signet](./references/signet.md)