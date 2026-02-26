---
name: bioconductor-bhc
description: This tool performs bottom-up Bayesian Hierarchical Clustering to determine the optimal number of clusters and generate dendrograms for multinomial or time-course data. Use when user asks to perform model-based hierarchical clustering, cluster gene expression profiles, discretize continuous data for clustering, or analyze time-course datasets without pre-defining the number of clusters.
homepage: https://bioconductor.org/packages/3.5/bioc/html/BHC.html
---


# bioconductor-bhc

name: bioconductor-bhc
description: Bayesian Hierarchical Clustering (BHC) for R. Use this skill to perform bottom-up hierarchical clustering using a Bayesian approach to determine the optimal number of clusters and provide a dendrogram. It supports multinomial data (discrete) and time-course data (continuous).

## Overview

The `BHC` package implements a Bayesian Hierarchical Clustering algorithm that avoids the need for a pre-defined number of clusters. It uses a model-based approach to calculate the probability that two nodes should be merged. It is particularly useful for biological data like gene expression profiles.

## Typical Workflow

1.  **Data Preparation**: Format data as a matrix where rows are items (e.g., genes) and columns are features (e.g., experiments).
2.  **Clustering**: Use the `bhc()` function.
3.  **Analysis**: Extract cluster labels or plot the resulting dendrogram.
4.  **Discretization (Optional)**: For continuous data, use `FindOptimalBinning` and `DiscretiseData` to convert data for multinomial clustering.

## Core Functions

### bhc()
The primary function for performing clustering.
```R
# Multinomial (Discrete) Clustering
hc <- bhc(data, itemLabels, verbose=TRUE)

# Time-Course Clustering
# timePoints: vector of time values
# noiseMode: 0 (global noise), 1 (feature-specific), 2 (item-specific)
hc_time <- bhc(data, itemLabels, 0, timePoints, "time-course", numReps=1, noiseMode=0)
```

### Data Discretization
If you have continuous data but want to use the multinomial model:
```R
# 1. Find optimal binning percentiles
percentiles <- FindOptimalBinning(data, itemLabels, transposeData=TRUE)

# 2. Discretize the data
discreteData <- DiscretiseData(t(data), percentiles=percentiles)
discreteData <- t(discreteData)

# 3. Run BHC
hc_discrete <- bhc(discreteData, itemLabels)
```

### Output and Visualization
```R
# Plot the dendrogram
plot(hc)

# Write labels to a file
WriteOutClusterLabels(hc, "cluster_assignments.txt")
```

## Tips and Best Practices

*   **Item Labels**: The `itemLabels` argument is used for tracking and plotting; it does not influence the Bayesian merging logic itself.
*   **Data Orientation**: Ensure your matrix rows represent the items you wish to cluster. Many BHC functions are sensitive to whether data is transposed.
*   **Hyperparameters**: The algorithm optimizes a global hyperparameter by default. If the log-evidence values look unusual, check if your data requires discretization.
*   **Time-Course Data**: When using "time-course" mode, ensure `timePoints` matches the number of columns in your data matrix.

## Reference documentation

- [Bayesian Hierarchical Clustering](./references/bhc.md)