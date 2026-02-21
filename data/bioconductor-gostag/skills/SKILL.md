---
name: bioconductor-gostag
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/goSTAG.html
---

# bioconductor-gostag

name: bioconductor-gostag
description: Functional enrichment analysis and visualization using Gene Ontology (GO) subtrees. Use when Claude needs to: (1) Perform Over-Representation Analysis (ORA) on gene lists, (2) Cluster enriched GO terms to identify biological themes, (3) Annotate GO clusters using a subtree-based tagging approach, or (4) Generate heatmaps of enrichment scores across multiple samples or conditions.

# bioconductor-gostag

## Overview

goSTAG (Gene Ontology Subtrees to Tag and Annotate Genes) is an R package designed to streamline the interpretation of functional enrichment results. When dealing with hundreds of enriched GO terms across multiple samples, manual curation is impractical. goSTAG automates this by clustering GO terms based on the similarity of their enrichment patterns and then labeling each cluster with a representative GO term. This representative term is chosen from the cluster's subtree based on having the most paths to the root, providing a biologically relevant "tag" for the cluster.

## Installation

Install the package using BiocManager:

```r
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("goSTAG")
library(goSTAG)
```

## Typical Workflow

### 1. Prepare Input Data

goSTAG requires two main inputs: gene lists and GO term associations.

**Gene Lists:**
Format as a list of character vectors.
```r
# Load from GMT file
gene_lists <- loadGeneLists("path/to/file.gmt")

# Load from a directory of text files (one file per sample)
gene_lists <- loadGeneLists("path/to/dir", type = "DIR", header = TRUE, col = 1)
```

**GO Terms:**
Load associations (default is human, Biological Process).
```r
# Use archived data for speed
go_terms <- loadGOTerms(species = "human", domain = "BP", use_archived = TRUE)

# Or fetch latest from biomaRt
go_terms_mouse <- loadGOTerms(species = "mouse", domain = "MF", use_archived = FALSE)
```

### 2. Generate Enrichment Matrix

Calculate enrichment scores (-log10 p-values) using a hypergeometric test.
```r
enrichment_matrix <- performGOEnrichment(gene_lists, go_terms, filter_method = "p.adjust", significance_threshold = 0.05)
```

### 3. Cluster and Group GO Terms

Perform hierarchical clustering on the GO terms and group them into clusters based on a distance threshold.
```r
# 1. Hierarchical clustering
hclust_results <- performHierarchicalClustering(enrichment_matrix, distance_method = "correlation", clustering_method = "average")

# 2. Group into clusters (distance_threshold 0.2 is standard)
clusters <- groupClusters(hclust_results, distance_threshold = 0.2)
```

### 4. Annotate and Visualize

Tag the clusters with representative terms and plot the results.
```r
# Annotate clusters using the subtree algorithm
cluster_labels <- annotateClusters(clusters)

# Plot heatmap
plotHeatmap(enrichment_matrix, hclust_results, clusters, cluster_labels)
```

## Key Functions and Parameters

- `loadGOTerms`: Supports `species` ("human", "mouse", "rat") and `domain` ("BP", "CC", "MF"). Use `min_num_genes` to filter small GO categories.
- `performGOEnrichment`: Use `p.adjust_method` (e.g., "BH", "bonferroni") to control false discovery rates.
- `groupClusters`: Adjust `distance_threshold`. Smaller values (e.g., 0.05) create many specific clusters; larger values (e.g., 0.5) create fewer, broader clusters.
- `plotHeatmap`: 
    - Use `sample_hclust_results` to cluster columns (samples).
    - Use `min_num_terms` to only label clusters containing a minimum number of GO terms.
    - For high-quality output, wrap in `png()` or `pdf()` and adjust `dendrogram_lwd` and `cluster_label_cex`.

## Tips for Success

- **Species Support**: If working with species other than human, mouse, or rat, you must manually format the GO term list as a list of vectors where names are GO IDs and one element is named "ALL" containing all background genes.
- **Memory/Time**: Loading GO terms with `use_archived = FALSE` queries BioMart and can be slow. Use the archived version for quick iterations.
- **Filtering**: If the heatmap is too crowded, increase the `significance_threshold` in `performGOEnrichment` or increase the `min_num_terms` in `plotHeatmap`.

## Reference documentation
- [goSTAG](./references/goSTAG.md)