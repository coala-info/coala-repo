---
name: bioconductor-cancersubtypes
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.6/bioc/html/CancerSubtypes.html
---

# bioconductor-cancersubtypes

name: bioconductor-cancersubtypes
description: Comprehensive analysis of cancer subtypes using genomic data. Use this skill when performing cancer subtype identification, multi-omics data integration, feature selection for survival analysis, or validating clustering results with silhouette plots and survival curves in R.

# bioconductor-cancersubtypes

## Overview
The `CancerSubtypes` package provides a unified framework for identifying and validating cancer subtypes from genomic data. It streamlines the workflow from raw data preprocessing and feature selection to clustering (using methods like SNF, iCluster, and Consensus Clustering) and downstream biological validation through survival analysis and differential expression.

## Core Workflow

### 1. Data Preprocessing
Before clustering, data should be checked for distribution and missing values.

```r
library(CancerSubtypes)

# Check data distribution (Mean, Var, MAD)
data.checkDistribution(matrix_data)

# Impute missing values
imputed_data <- data.imputation(matrix_data, fun = "microarray") # or "mean", "median"

# Normalize data
norm_data <- data.normalization(imputed_data, type = "feature_zscore", log2 = FALSE)
```

### 2. Feature Selection
Reducing dimensionality is critical for effective clustering.

*   **Variance/MAD:** `FSbyVar(data, cut.type = "topk", value = 1000)` or `FSbyMAD()`.
*   **PCA:** `FSbyPCA(data, PC_percent = 0.9)`.
*   **Cox Regression:** Use when survival data is available to find clinically relevant features.
    ```r
    data1 <- FSbyCox(GeneExp, time, status, cutoff = 0.05)
    ```

### 3. Identifying Subtypes (Clustering)
The package supports several algorithms. Most accept either a single matrix or a list of matrices (for multi-omics).

*   **Consensus Clustering (CC):**
    ```r
    result <- ExecuteCC(clusterNum = 3, d = data_list, maxK = 10, clusterAlg = "hc", distance = "pearson")
    ```
*   **Similarity Network Fusion (SNF):** Best for integrating multiple data types.
    ```r
    result <- ExecuteSNF(data_list, clusterNum = 3, K = 20, alpha = 0.5, t = 20)
    ```
*   **Integrative Clustering (iCluster):**
    ```r
    result <- ExecuteiCluster(datasets = data_list, k = 3, lambda = list(0.44, 0.33))
    ```
*   **Weighted SNF (WSNF):** Incorporates regulatory network information (miRNA-TF-mRNA).

### 4. Validation and Visualization
Evaluate the biological and statistical significance of the identified groups.

*   **Silhouette Width:** Measures cluster cohesion.
    ```r
    sil <- silhouette_SimilarityMatrix(result$group, result$distanceMatrix)
    plot(sil)
    ```
*   **Survival Analysis:** Generates Kaplan-Meier curves and calculates p-values.
    ```r
    # similarity=TRUE if using a similarity matrix (like SNF)
    p_val <- survAnalysis(mainTitle = "Survival Analysis", time, status, result$group, result$distanceMatrix, similarity = TRUE)
    ```
*   **Statistical Significance:** `sigclustTest()` tests if the clusters come from different distributions.
*   **Differential Expression:** Identify marker genes for each subtype using `DiffExp.limma()`.

## Tips for Success
*   **Input Format:** Ensure samples are in columns and features (genes/miRNAs) are in rows for most functions.
*   **Multi-omics:** When using `ExecuteSNF` or `ExecuteiCluster`, provide data as a named list, e.g., `list(mRNA = df1, miRNA = df2)`.
*   **Silhouette Warning:** If using a dissimilarity matrix instead of a similarity matrix, use the standard `cluster::silhouette()` function instead of `silhouette_SimilarityMatrix()`.

## Reference documentation
- [An introduction of CancerSubtypes](./references/CancerSubtypes-vignette.Rmd)