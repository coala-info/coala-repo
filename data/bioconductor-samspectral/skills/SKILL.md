---
name: bioconductor-samspectral
description: SamSPECTRAL performs modified spectral clustering on large flow cytometry datasets using a faithful sampling strategy to reduce computational complexity. Use when user asks to cluster high-dimensional flow cytometry data, build data communities for reduction, tune spectral clustering parameters, or merge clusters based on a separation factor.
homepage: https://bioconductor.org/packages/release/bioc/html/SamSPECTRAL.html
---


# bioconductor-samspectral

name: bioconductor-samspectral
description: Expert guidance for using the SamSPECTRAL R package to perform modified spectral clustering on large flow cytometry datasets. Use this skill when a user needs to cluster high-dimensional flow cytometry data (FCS files or data matrices), specifically when traditional spectral clustering is too computationally expensive. It includes workflows for data reduction (building communities), parameter tuning (sigma and separation factor), and final cluster assignment.

# bioconductor-samspectral

## Overview

SamSPECTRAL is a Bioconductor package designed to overcome the memory and time limitations of classical spectral clustering when applied to large biological datasets, such as flow cytometry. It uses a "faithful sampling" strategy to reduce data into "communities" before performing spectral clustering on those representatives. The final step involves a post-processing stage that merges clusters based on a separation factor.

## Core Workflow

The package can be used via a high-level wrapper or a step-by-step manual process for fine-tuning.

### 1. High-Level Usage
The `SamSPECTRAL()` function wraps the entire process. It is recommended to test parameters on a subset of data first.

```r
library(SamSPECTRAL)
data(small_data) # Example data: 'small' matrix

# Run SamSPECTRAL
# normal.sigma: scaling parameter (1/sigma^2)
# separation.factor: controls cluster merging (higher = more clusters)
labels <- SamSPECTRAL(small, 
                      dimension=c(1,2,3), 
                      normal.sigma=200, 
                      separation.factor=0.39)

# Plot results
plot(small, pch='.', col=labels)
```

### 2. Parameter Tuning Workflow
If the high-level function does not yield optimal results, follow this manual workflow to find the best `normal.sigma` and `separation.factor`.

#### Step A: Data Scaling and Community Building
Scale data to [0,1] and reduce the dataset size.
```r
# Scale columns
full <- small
for (i in 1:ncol(full)) {
  full[,i] <- (full[,i] - min(full[,i])) / (max(full[,i]) - min(full[,i]))
}

# Build communities (m=3000 is usually sufficient for speed)
society <- Building_Communities(full, m=3000, space.length=1, community.weakness.threshold=1)
```

#### Step B: Adjusting normal.sigma
Calculate conductance and check the eigenvalue plot for a "knee" shape.
```r
conductance <- Conductance_Calculation(full, normal.sigma=250, space.length=1, society, precision=6)

clust_result <- Civilized_Spectral_Clustering(full, maximum.number.of.clusters=30, 
                                              society, conductance, stabilizer=1)

# Look for a 'knee' in the plot
plot(clust_result@eigen.space$values[1:50])
```
*   **Too small sigma (high normal.sigma):** No knee, values drop too fast.
*   **Too large sigma (low normal.sigma):** Too many eigenvalues close to 1.

#### Step C: Adjusting separation.factor
Use the `Connecting` function to merge spectral clusters into biological populations.
```r
# Extract labels from spectral step
labels.for_num.of.clusters <- clust_result@labels.for_num.of.clusters
number.of.clusters <- clust_result@number.of.clusters

# Apply separation factor
res <- Connecting(full, society, conductance, number.of.clusters, 
                  labels.for_num.of.clusters, separation.factor=0.5)
plot(full, pch='.', col=res$label)
```
*   **Low separation.factor:** Merges distinct populations (under-clustering).
*   **High separation.factor:** Keeps populations separate (over-clustering).

## Tips for Large Datasets
*   **Memory Management:** For very large datasets, ensure `m` (number of communities) is kept around 3000 to keep execution under one minute on standard hardware.
*   **Consistency:** Once parameters are tuned on 2-3 representative samples, they can typically be applied to the rest of the dataset if experimental conditions are consistent.
*   **Outliers:** SamSPECTRAL labels isolated outliers as `NA`.

## Reference documentation
- [Clustering by SamSPECTRAL](./references/Clustering_by_SamSPECTRAL.md)