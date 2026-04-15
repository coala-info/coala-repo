---
name: bioconductor-clustall
description: ClustAll performs robust patient stratification and multi-method clustering analysis on clinical or biomedical datasets. Use when user asks to identify stable patient subgroups, execute multiple clustering pipelines, validate results against ground truth, or visualize stratification similarities.
homepage: https://bioconductor.org/packages/release/bioc/html/ClustAll.html
---

# bioconductor-clustall

name: bioconductor-clustall
description: Comprehensive patient stratification and clustering analysis using the ClustAll R package. Use when performing multi-method clustering (K-means, K-medoids, H-Clust) on clinical or biomedical datasets to identify robust patient subgroups, handle missing data, and validate results against ground truth.

# bioconductor-clustall

## Overview
ClustAll is an R package designed for robust patient stratification in complex diseases. Its core philosophy is that a truly stable stratification should be reproducible across different clustering methods and distance metrics. It automates the process of running multiple clustering pipelines, filtering for stability (bootstrapping), and identifying representative solutions.

## Core Workflow

### 1. Data Preparation and Object Creation
Load your data and initialize the ClustAll object. The package handles mixed data types and can manage missing values via imputation.

```r
library(ClustAll)
data("BreastCancerWisconsin", package = "ClustAll")

# Prepare data (exclude ID or non-feature columns)
data_use <- subset(wdbc, select = -ID)

# Create object; colValidation specifies ground truth (e.g., "Diagnosis") 
# which is excluded from clustering but used for later validation.
obj <- createClustAll(data = data_use, 
                      nImputation = NULL, 
                      colValidation = "Diagnosis")
```

### 2. Executing the Algorithm
The `runClustAll` function executes multiple clustering combinations. It uses a nomenclature system to identify the method:
- **a**: Correlation distance + K-means
- **b**: Correlation distance + Hierarchical Clustering
- **c**: Gower distance + K-medoids
- **d**: Gower distance + Hierarchical Clustering

```r
# Run the pipeline (supports multi-threading)
obj_results <- runClustAll(Object = obj, threads = 2, simplify = FALSE)
```

### 3. Identifying Robust Stratifications
Use Jaccard similarity to find groups of similar stratification solutions. Robust stratifications are those with >85% bootstrapping stability.

```r
# Visualize similarity between robust stratifications
plotJACCARD(Object = obj_results, stratification_similarity = 0.9, paint = TRUE)

# Retrieve representative centroids for each group of similar solutions
representatives <- resStratification(Object = obj_results, 
                                     population = 0.05, 
                                     stratification_similarity = 0.9, 
                                     all = FALSE)
```

### 4. Comparison and Validation
Compare different solutions or compare a solution against the ground truth using Sankey diagrams and performance metrics.

```r
# Compare two specific stratifications (e.g., "cuts_c_9" and "cuts_a_28")
plotSankey(Object = obj_results, clusters = c("cuts_c_9", "cuts_a_28"))

# Validate against ground truth (Sensitivity and Specificity)
validateStratification(obj_results, "cuts_a_28")
```

### 5. Exporting Results
Append the cluster assignments back to the original dataset for downstream analysis.

```r
df_final <- cluster2data(Object = obj_results, 
                         stratificationName = c("cuts_c_9", "cuts_a_28"))
```

## Key Tips
- **Nomenclature:** Stratification names like `cuts_a_28` indicate the method (a = Correlation/K-means) and the embedding depth (28).
- **Missing Data:** If your dataset has NAs, specify `nImputation` in `createClustAll` to trigger the internal imputation workflow.
- **Stability:** Focus on solutions highlighted in the Jaccard plot red rectangles; these represent clusters of methods that converged on similar patient groupings.

## Reference documentation
- [ClustAll User's Guide](./references/Vignette_Clustall.md)