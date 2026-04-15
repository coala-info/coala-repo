---
name: bioconductor-clusterexperiment
description: This tool provides robust ensemble clustering methods and the RSEC workflow for high-dimensional data like single-cell RNA-seq. Use when user asks to perform resampling-based sequential ensemble clustering, run parameter sweeps with clusterMany, create consensus clusterings, or merge clusters based on differential expression.
homepage: https://bioconductor.org/packages/release/bioc/html/clusterExperiment.html
---

# bioconductor-clusterexperiment

name: bioconductor-clusterexperiment
description: Robust clustering and ensemble methods for high-dimensional data, specifically optimized for single-cell RNA-seq. Use this skill to perform the RSEC (Resampling-based Sequential Ensemble Clustering) workflow, run parameter sweeps with clusterMany, create consensus clusterings, and merge clusters based on differential expression.

## Overview

The clusterExperiment package provides a framework for running multiple clustering algorithms and parameter sets to find a single robust clustering. Its core methodology is the RSEC (Resampling-based Sequential Ensemble Clustering) algorithm. It uses the `ClusterExperiment` class, which inherits from `SummarizedExperiment`, to store data alongside multiple clustering results.

## Core Workflow: RSEC

The RSEC algorithm is the primary workflow. It can be run as a single wrapper or as individual steps.

### 1. The RSEC Wrapper
Use the `RSEC` function to execute the entire pipeline (subsampling, sequential clustering, consensus, and merging).

```r
library(clusterExperiment)
# se is a SummarizedExperiment or ClusterExperiment object
rsecResult <- RSEC(se, 
                   isCount = TRUE, 
                   reduceMethod = "PCA", 
                   nReducedDims = 10,
                   alphas = c(0.1, 0.2), 
                   k0s = 4:10,
                   consensusMinSize = 3)
```

### 2. Manual Step-by-Step Workflow
If more control is needed, execute the steps individually:

1.  **clusterMany**: Run many clusterings across a range of parameters.
    ```r
    ce <- clusterMany(se, clusterFunction="pam", ks=5:10, 
                      reduceMethod=c("PCA", "var"), nReducedDims=c(5, 15))
    ```
2.  **makeConsensus**: Find a unified clustering across the results.
    ```r
    ce <- makeConsensus(ce, proportion = 0.7, minSize = 5)
    ```
3.  **makeDendrogram**: Create a hierarchy between the clusters.
    ```r
    ce <- makeDendrogram(ce, reduceMethod = "var", nDims = 500)
    ```
4.  **mergeClusters**: Merge clusters that show little differential expression.
    ```r
    ce <- mergeClusters(ce, mergeMethod = "adjP", DEMethod = "edgeR", cutoff = 0.05)
    ```

## Data Management

### The ClusterExperiment Object
- **Access Clusters**: Use `primaryCluster(ce)` for the default clustering or `clusterMatrix(ce)` for all clusterings.
- **Labels**: Access or set labels with `clusterLabels(ce)`.
- **Subsetting**: Standard R subsetting `ce[genes, samples]` maintains the integrity of cluster assignments and metadata.
- **Unassigned Samples**: Samples assigned `-1` were not clustered; `-2` indicates samples missing from a specific clustering run.

## Visualization

- **plotClusters**: Visualize the alignment of multiple clusterings.
    ```r
    plotClusters(ce, whichClusters = "workflow")
    ```
- **plotHeatmap**: Display gene expression with cluster annotations.
    ```r
    plotHeatmap(ce, clusterSamplesData = "dendrogramValue")
    ```
- **plotCoClustering**: Show how often samples were clustered together across the ensemble.
    ```r
    plotCoClustering(ce)
    ```
- **plotReducedDims**: Plot clusters in 2D space (PCA, t-SNE).
    ```r
    plotReducedDims(ce, whichDims = c(1, 2))
    ```

## Feature Discovery

Use `getBestFeatures` to find marker genes for the clusters. This supports pairwise comparisons or "one-vs-all" contrasts using `limma` or `edgeR`.

```r
stats <- getBestFeatures(ce, contrastType = "Pairs", DEMethod = "edgeR")
# Visualize top features
plotContrastHeatmap(ce, signif = stats)
```

## Tips for Success
- **isCount**: Always set `isCount = TRUE` if working with raw or normalized counts to ensure proper log-transformation.
- **Dimensionality Reduction**: Use `reduceMethod = "PCA"` for high-dimensional data to improve stability and speed.
- **Memory**: When rerunning steps, overwrite the existing object (e.g., `ce <- RSEC(ce, ...)`) to avoid duplicating large data matrices in memory.

## Reference documentation
- [clusterExperiment Vignette](./references/clusterExperimentTutorial.md)
- [Clustering Large Datasets](./references/largeDataSets.md)