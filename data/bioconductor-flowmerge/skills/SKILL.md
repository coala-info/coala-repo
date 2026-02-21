---
name: bioconductor-flowmerge
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/flowMerge.html
---

# bioconductor-flowmerge

name: bioconductor-flowmerge
description: Automated gating and cluster merging for flow cytometry data using the flowMerge package. Use this skill to refine flowClust results by merging mixture components based on entropy or Mahalanobis distance criteria to better identify distinct cell populations.

# bioconductor-flowmerge

## Overview

The `flowMerge` package addresses the tendency of mixture model-based clustering (like `flowClust`) to overestimate the number of cell populations. While the Bayesian Information Criterion (BIC) is excellent for model fitting, it often requires more components than there are biological populations. `flowMerge` takes a max BIC solution and systematically merges components using an entropy-based criterion to find a parsimonious model that accurately reflects true cell sub-populations.

## Core Workflow

The typical workflow involves fitting a range of models, selecting the best fit, and then merging clusters.

### 1. Initial Clustering with flowClust
First, perform clustering across a range of $K$ (number of clusters) values.
```r
library(flowMerge)
library(flowClust)

# Fit models for K=1 to 10
res <- flowClust(myFlowFrame, varNames=c("FSC.H", "SSC.H"), K=1:10, trans=1, nu.est=1)

# Identify the max BIC solution
best_k <- which.max(flowMerge:::BIC(res))
flowClust.maxBIC <- res[[best_k]]
```

### 2. Creating a flowObj and Merging
Convert the `flowClust` result into a `flowObj` to enable merging operations.
```r
# Create flowObj
obj <- flowObj(flowClust.maxBIC, myFlowFrame)

# Perform merging (default metric is "entropy")
# Can also use metric="mahalanobis"
merged_list <- merge(obj, metric="entropy")
```

### 3. Selecting the Optimal Merged Solution
Use piecewise linear regression on the entropy vs. cluster number to find the "elbow" or changepoint.
```r
# Find the changepoint index
i <- fitPiecewiseLinreg(merged_list)

# Extract the optimal merged model
optimal_model <- merged_list[[i]]
```

## Parallel Processing

For high-throughput analysis of `flowSets` or lists of `flowFrames`, use `pFlowMerge`.

```r
# Non-parallel call (cl=NULL)
# This wraps flowClust, BIC selection, and merging into one step
result <- pFlowMerge(cl=NULL, data=myFlowSet, varNames=c("FL1.H", "FL3.H"), K=1:10)
```

## Visualization and Population Extraction

### Plotting Results
```r
# Compare models
par(mfrow=c(1,2))
plot(flowClust.maxBIC, data=myFlowFrame, main="Before Merging")
plot(optimal_model, main="After Merging")
```

### Extracting Populations
You can split the data based on the merged populations to perform downstream analysis on specific subsets (e.g., lymphocytes).
```r
# Get estimates to identify population indices
estimates <- getEstimates(optimal_model)

# Split the model to get a specific population
# 'pop' should be the index of the cluster of interest
sub_population <- split(optimal_model, population=list("target"=pop))$target
```

### Merging Tree
Visualize the merging process and marker expression across the hierarchy.
```r
# Requires Rgraphviz
f <- ptree("merged_list_name", i)
f(1) # Plot for first marker
```

## Tips and Best Practices
- **Metric Selection**: While "entropy" is the default and generally preferred for identifying distinct populations, "mahalanobis" is available for distance-based merging.
- **Memory Management**: `pFlowMerge` does not manage memory aggressively. When processing large `flowSets`, process them in smaller batches if RAM is limited.
- **Outlier Detection**: The `plot` method for merged objects often defaults to a specific outlier quantile (e.g., 90%). Adjust the `level` parameter in `plot()` to change the confidence interval of the clusters.

## Reference documentation
- [Merging Mixture Components for Cell Population Identification in Flow Cytometry Data](./references/flowmerge.md)