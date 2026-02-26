---
name: bioconductor-depecher
description: Bioconductor-depecher performs automated clustering and group differentiation for high-dimensional single-cell data such as flow cytometry and scRNA-seq. Use when user asks to identify cell populations, visualize marker distributions on tSNE or UMAP, and statistically compare cluster abundances between experimental groups.
homepage: https://bioconductor.org/packages/release/bioc/html/DepecheR.html
---


# bioconductor-depecher

name: bioconductor-depecher
description: Perform automated clustering and group differentiation for high-dimensional cytometry data (flow, mass, scRNAseq). Use this skill when analyzing single-cell data to identify cell populations, visualize marker distributions on tSNE/UMAP, and statistically compare groups using Wilcoxon or sPLS-DA methods.

# bioconductor-depecher

## Overview
DepecheR (Deterministic Partitioning to Essential CHaracteristics) is an R package designed for the analysis of high-dimensional single-cell data, such as flow cytometry, mass cytometry (CyTOF), and scRNA-seq. It provides a streamlined workflow for automated clustering, visualization, and statistical comparison between groups. Its primary strength lies in its ability to perform penalty-based clustering that automatically selects relevant markers and determines the optimal number of clusters.

## Installation
```R
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("DepecheR")
```

## Typical Workflow

### 1. Data Preparation
DepecheR expects a `data.frame` or `matrix` where rows are cells and columns are markers. Multiple samples should be merged into a single object with an additional column for sample IDs.
*   **Note:** Data must be transformed (e.g., arcsinh) before clustering. DepecheR does not perform pre-processing/compensation.

### 2. Automated Clustering
The `depeche` function performs clustering, scaling, and parameter selection automatically.
```R
# Cluster on specific marker columns
# testData[, 2:15] contains the expression values
result <- depeche(testData[, 2:15])

# Access cluster assignments
clusters <- result$clusterVector

# Access cluster centers (essential markers for each cluster)
centers <- result$clusterCenters
```

### 3. Visualization
Use `dColorPlot` to overlay clusters or marker expression onto 2D coordinates (tSNE or UMAP).
```R
# Plot clusters on tSNE
dColorPlot(colorData = result$clusterVector, xYData = testDataSNE$Y, 
           colorScale = "dark_rainbow", plotName = "Clusters")

# Plot specific marker expression
dColorPlot(colorData = testData[, "SYK"], xYData = testDataSNE$Y, plotName = "SYK_Expression")
```

### 4. Group Comparison
To identify which clusters differ between experimental groups (e.g., Control vs. Treatment):
*   **dResidualPlot:** Visualizes non-statistical differences in cluster abundance.
*   **dWilcox:** Performs Wilcoxon rank-sum tests on cluster frequencies across groups.
*   **dSplsda:** Uses sparse Partial Least Squares Discriminant Analysis to identify clusters that robustly separate groups.

```R
# Statistical comparison using sPLS-DA
sPLSDA_res <- dSplsda(xYData = testDataSNE$Y, 
                      idsVector = testData$ids, 
                      groupVector = testData$label, 
                      clusterVector = result$clusterVector)
```

### 5. Single-Cell Group Probability
The `groupProbPlot` function identifies group-specific cell populations without requiring prior clustering. It calculates the likelihood of a cell belonging to a group based on its Euclidean neighbors.
```R
testData$groupProb <- groupProbPlot(xYData = testDataSNE$Y,
                                    groupVector = testData$label,
                                    dataTrans = testData[, marker_cols])
```

## Tips and Best Practices
*   **Output Files:** Many DepecheR functions (like `dColorPlot`, `dDensityPlot`, and `dSplsda`) save high-resolution PNG files directly to the working directory rather than printing to the R console.
*   **Marker Selection:** The `essenceElementList` in the `depeche` output shows which specific markers were "essential" for defining each cluster.
*   **Memory:** For very large datasets, ensure sufficient RAM as the k-nearest neighbor searches and sPLS-DA can be computationally intensive.
*   **CyTOF Data:** When using `dViolins`, be aware that the dominant zero-peak in CyTOF data can sometimes make interpretation difficult; the package is optimized for transformed data.

## Reference documentation
- [Example of a cytometry data analysis with DepecheR](./references/DepecheR_test.md)
- [Probability plot usage](./references/GroupProbPlot_usage.md)