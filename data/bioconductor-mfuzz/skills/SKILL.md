---
name: bioconductor-mfuzz
description: This tool performs soft clustering of gene expression data using fuzzy c-means to identify overlapping expression patterns. Use when user asks to perform noise-robust clustering, identify genes belonging to multiple clusters, or visualize temporal expression profiles.
homepage: https://bioconductor.org/packages/release/bioc/html/Mfuzz.html
---

# bioconductor-mfuzz

name: bioconductor-mfuzz
description: Soft clustering of gene expression data (microarray, RNA-Seq, or proteomics) using fuzzy c-means. Use this skill when you need to perform noise-robust clustering, identify overlapping gene clusters, or visualize temporal expression patterns where genes may belong to multiple clusters.

# bioconductor-mfuzz

## Overview

Mfuzz is a Bioconductor package designed for soft clustering of gene expression data. Unlike hard clustering (like k-means) where each gene belongs to exactly one cluster, Mfuzz uses fuzzy c-means (FCM) to assign membership values (0 to 1) to genes for every cluster. This approach is particularly effective for time-course data as it handles noise better and reveals genes with transitional or overlapping expression profiles.

## Workflow and Usage

### 1. Data Preparation
Mfuzz operates on `ExpressionSet` objects. Data should be normalized before being passed to Mfuzz.

```r
library(Mfuzz)
data(yeast) # Example dataset

# 1. Handle missing values (FCM does not allow NAs)
# Exclude genes with > 25% missing values
yeast.r <- filter.NA(yeast, thres=0.25)
# Fill remaining NAs using mean or knn
yeast.f <- fill.NA(yeast.r, mode="mean")

# 2. Filtering (Optional)
# Remove genes with low standard deviation
yeast.filtered <- filter.std(yeast.f, min.std=0)

# 3. Standardisation
# Crucial: Standardise so mean=0 and sd=1 to cluster based on shape/trend
yeast.s <- standardise(yeast.f)
```

### 2. Parameter Selection
Fuzzy clustering requires two main parameters: the fuzzifier `m` and the number of clusters `c`.

*   **Fuzzifier (m):** Determines how "fuzzy" the clusters are. Use `mestimate` to calculate an optimal value based on the data.
    ```r
    m1 <- mestimate(yeast.s) # e.g., returns 1.15
    ```
*   **Number of Clusters (c):** Can be estimated using `cselection` or `Dmin` (minimum distance between centroids).

### 3. Soft Clustering
Execute the clustering and visualize the results.

```r
# Run fuzzy c-means
cl <- mfuzz(yeast.s, c=16, m=1.15)

# Plot results
# Membership values are color-coded (Purple/Red = high, Green/Yellow = low)
mfuzz.plot(yeast.s, cl=cl, mfrow=c(4,4), time.labels=seq(0,160,10))
```

### 4. Cluster Analysis
*   **Cluster Cores:** Extract genes that strongly belong to a specific cluster (membership > alpha).
    ```r
    # Get genes with membership > 0.7 in their respective clusters
    cores <- acore(yeast.s, cl, min.acore=0.7)
    ```
*   **Cluster Overlap:** Analyze the global structure and similarity between clusters.
    ```r
    O <- overlap(cl)
    overlap.plot(cl, over=O, thres=0.05)
    ```

## Tips for Success
*   **Standardization:** Always use `standardise()` before clustering if you want to group genes by their expression profile shape rather than absolute magnitude.
*   **Replicates:** Mfuzz treats columns as independent. Average your replicates before creating the `ExpressionSet` or clustering.
*   **Noise:** If the data is very noisy, increasing `m` will lead to fewer genes being assigned high membership values to any cluster, effectively filtering out noise.
*   **GUI:** For interactive exploration, use `Mfuzzgui()`.

## Reference documentation
- [Mfuzz](./references/Mfuzz.md)