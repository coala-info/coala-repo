---
name: bioconductor-clusterfoldsimilarity
description: ClusterFoldSimilarity compares cell clusters across independent single-cell experiments by calculating similarity scores based on fold-change patterns of shared features. Use when user asks to compare cell clusters across datasets, perform cross-species or cross-technology matching, or visualize cluster similarity relationships.
homepage: https://bioconductor.org/packages/release/bioc/html/ClusterFoldSimilarity.html
---


# bioconductor-clusterfoldsimilarity

## Overview

`ClusterFoldSimilarity` is an R package designed to compare cell clusters across independent single-cell experiments. Unlike traditional integration methods that perform batch correction, this tool calculates similarity scores based on analogous fold-change patterns of shared features (e.g., genes). It is highly versatile, supporting cross-species comparisons and cross-technology matching (e.g., RNA-seq vs. ATAC-seq).

## Core Workflow

### 1. Data Preparation
The package accepts a list of `Seurat` or `SingleCellExperiment` objects. Each object should be independently normalized and processed (PCA, Clustering) before comparison.

```r
library(ClusterFoldSimilarity)
library(Seurat)

# Example: List of processed Seurat objects
sc_list <- list(dataset1, dataset2)

# Ensure clusters or labels are set
# For Seurat: Idents(obj)
# For SingleCellExperiment: colLabels(obj)
```

### 2. Computing Similarity
The primary function is `clusterFoldSimilarity()`. It computes a similarity table and, by default, generates a network graph.

```r
similarity_table <- clusterFoldSimilarity(
  scList = sc_list,
  sampleNames = c("Control", "Treatment"), # Optional names
  topN = 1,              # Number of top similar clusters to report per cluster
  topNFeatures = 1,      # Number of top contributing features to report
  nSubsampling = 15,     # Subsamplings for fold-change calculation
  parallel = TRUE        # Enable parallel computing via BiocParallel
)
```

### 3. Interpreting the Output
The resulting data frame contains:
- `similarityValue`: The score between `clusterL` and `clusterR`.
- `w`: Weight associated with the score.
- `topFeatureConserved`: The feature (gene) contributing most to the similarity.
- `featureScore`: The specific contribution of that feature.

### 4. Advanced Analysis & Visualization

**Finding Communities:**
Group clusters into "super-groups" or communities across datasets using the InfoMap algorithm.
```r
communities <- findCommunitiesSimmilarity(similarityTable = similarity_table)
```

**Similarity Heatmaps:**
Visualize all-to-all cluster similarities. Use `topN = Inf` in the main function to get all values first.
```r
# Plot heatmap for a specific dataset perspective
similarityHeatmap(similarityTable = similarity_table, mainDataset = "Control")
```

**Graph Visualization:**
Re-plot the cluster relationship graph.
```r
plotClustersGraph(similarityTable = similarity_table)
```

## Key Parameters and Tips

- **Cross-Species:** When comparing different species (e.g., Human vs. Mouse), ensure feature names (gene symbols) are mapped to a common nomenclature (e.g., converting mouse genes to uppercase to match human).
- **Subsampling:** The tool uses a Bayesian approach with subsampling. If the dataset is large, increase `nSubsampling` (the tool will suggest a value in the console).
- **Parallelization:** For large comparisons, register a parallel backend:
  ```r
  BiocParallel::register(BiocParallel::MulticoreParam(workers = 4))
  # Then call clusterFoldSimilarity(..., parallel = TRUE)
  ```
- **Feature Selection:** Use `topNFeatures` with a negative value to identify the most *dissimilar* features between clusters.

## Reference documentation

- [ClusterFoldSimilarity](./references/ClusterFoldSimilarity.md)