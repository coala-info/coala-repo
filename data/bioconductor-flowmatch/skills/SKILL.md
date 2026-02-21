---
name: bioconductor-flowmatch
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/flowMatch.html
---

# bioconductor-flowmatch

name: bioconductor-flowmatch
description: Expert guidance for the flowMatch Bioconductor package. Use this skill when performing cell population matching, meta-clustering, and template construction across multiple flow cytometry (FC) samples. It is particularly useful for registering corresponding populations across samples and summarizing large cohorts into robust templates.

# bioconductor-flowmatch

## Overview

The `flowMatch` package provides a framework for matching cell populations across different flow cytometry samples and creating "templates" that represent the core patterns of a class of samples. It uses a combinatorial algorithm called Mixed Edge Cover (MEC) to handle cases where populations might split, merge, or be absent across samples.

Key concepts:
- **Cluster**: A cell population within a single sample.
- **ClusteredSample**: A collection of clusters within one sample.
- **Meta-cluster**: A set of biologically similar clusters across different samples.
- **Template**: A collection of meta-clusters representing a specific class or condition.

## Typical Workflow

### 1. Data Preparation and Clustering
`flowMatch` does not perform the initial clustering. You must first cluster your data (e.g., using `kmeans`, `flowMeans`, or `flowClust`) and then wrap it in a `ClusteredSample` object.

```r
library(flowMatch)
library(healthyFlowData)
data(hd)

# Extract expression matrix
sample_data <- exprs(hd.flowSet[[1]])

# Perform clustering (e.g., kmeans)
km <- kmeans(sample_data, centers=4, nstart=20)

# Create ClusteredSample object
# Option A: Pass the sample for automatic parameter estimation
clustSample <- ClusteredSample(labels=km$cluster, sample=sample_data)

# Option B: Provide pre-computed centers and covariances
# clustSample <- ClusteredSample(labels=km$cluster, centers=list_of_means, covs=list_of_covs)
```

### 2. Matching Clusters Between Two Samples
To find correspondences between two samples, use the `match.clusters` function.

```r
# Assuming clustSample1 and clustSample2 are ClusteredSample objects
mec <- match.clusters(clustSample1, clustSample2, 
                      dist.type="Mahalanobis", 
                      unmatch.penalty=99999)

summary(mec)
```
*Tip: A very high `unmatch.penalty` forces every cluster to be matched. Lower values allow clusters to remain unmatched if they are sufficiently different.*

### 3. Creating Templates and Meta-clusters
For a collection of samples, you can build a hierarchical template tree.

```r
# clustSamples should be a list of ClusteredSample objects
template <- create.template(clustSamples)

# View summary of meta-clusters
summary(template)

# Visualize the hierarchical relationship (dendrogram)
template.tree(template)
```

### 4. Visualization
The package provides specialized plotting functions for templates and meta-clusters.

```r
# Plot template as bivariate contour plots
plot(template)

# Plot with specific colors for meta-clusters
plot(template, color.mc=c('blue', 'black', 'green', 'red'))

# Plot a specific meta-cluster
mc <- get.metaClusters(template)[[1]]
plot(mc, plot.mc=TRUE)
```

## Distance Metrics
When matching clusters or computing distances, you can choose from:
- `Mahalanobis`: Accounts for the shape (covariance) of the clusters.
- `KL`: Kullback-Leibler divergence.
- `Euclidean`: Simple distance between cluster centers.

```r
dist.cluster(cluster1, cluster2, dist.type='Mahalanobis')
```

## Reference documentation

- [flowMatch: Cell population matching and meta-clustering in Flow Cytometry](./references/flowMatch.md)