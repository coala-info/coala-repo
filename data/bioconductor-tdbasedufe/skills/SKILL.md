---
name: bioconductor-tdbasedufe
description: This tool performs tensor decomposition-based unsupervised feature extraction for gene expression and multi-omics data analysis. Use when user asks to identify differentially expressed genes, extract features from multi-dimensional tensors using HOSVD, or perform unsupervised feature selection across multiple omics layers.
homepage: https://bioconductor.org/packages/release/bioc/html/TDbasedUFE.html
---

# bioconductor-tdbasedufe

name: bioconductor-tdbasedufe
description: Perform Tensor Decomposition-based Unsupervised Feature Extraction (TDbasedUFE) for gene expression and multi-omics data analysis. Use this skill to identify differentially expressed genes or features across multiple conditions, tissues, or omics layers using HOSVD (Higher Order Singular Value Decomposition) and optimized standard deviation for p-value calculation.

## Overview
TDbasedUFE is a Bioconductor package designed for unsupervised feature extraction from complex biological datasets. It utilizes Tucker decomposition (specifically HOSVD) to decompose multi-dimensional tensors into singular value vectors. By selecting vectors that represent specific biological conditions (e.g., disease vs. control), the package identifies features (genes, methylation sites, etc.) that deviate from a Gaussian null distribution. A key strength is its ability to optimize the standard deviation (SD) used in p-value calculations to improve feature selection accuracy.

## Installation
```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("TDbasedUFE")
library(TDbasedUFE)
```

## Core Workflow: Gene Expression Analysis
This workflow is used for 3D tensors (e.g., Genes x Samples x Conditions).

1. **Prepare Tensor**: Convert count or abundance data into a tensor format.
   ```R
   # Z should be a tensor (e.g., 10000 genes x 3 replicates x 2 conditions)
   Z <- PrepareSummarizedExperimentTensor(sample_matrix, feature_names, data_array)
   ```
2. **Compute HOSVD**: Decompose the tensor.
   ```R
   HOSVD <- computeHosvd(Z)
   ```
3. **Select Singular Value Vectors**: Identify which vectors correspond to the biological signal of interest.
   ```R
   # Interactive mode
   input_all <- selectSingularValueVectorSmall(HOSVD)
   # Batch mode (e.g., selecting vectors 1 and 2)
   input_all <- selectSingularValueVectorSmall(HOSVD, input_all = c(1, 2))
   ```
4. **Feature Selection**: Calculate p-values and select features based on the optimized SD.
   ```R
   index <- selectFeature(HOSVD, input_all)
   ```
5. **Results Table**: Extract the top-ranked features.
   ```R
   results <- tableFeatures(Z, index)
   head(results)
   ```

## Core Workflow: Multi-omics Analysis
This workflow uses a "bundle of linear kernels" approach for datasets with different feature counts across omics layers.

1. **Prepare Square Tensor**: Create a tensor of kernels (Samples x Samples x Omics).
   ```R
   Z <- PrepareSummarizedExperimentTensorSquare(
       sample = sample_names,
       feature = list(mRNA = genes, Methyl = sites, ...),
       value = convertSquare(data_list),
       sampleData = metadata
   )
   ```
2. **Compute HOSVD**:
   ```R
   HOSVD <- computeHosvdSqure(Z)
   ```
3. **Select Vectors**:
   ```R
   # cond defines the labeling information for selection
   cond <- list(metadata$gender, metadata$gender, seq_len(num_omics))
   input_all <- selectSingularValueVectorLarge(HOSVD, cond)
   ```
4. **Feature Selection**: Optimize SD for each omics layer.
   ```R
   # de provides initial SD guesses for each omics layer
   index <- selectFeatureSquare(HOSVD, input_all, original_data_list, de = c(0.3, 0.1, ...))
   ```
5. **Results Table**: Extract features for a specific omics layer (id).
   ```R
   tableFeaturesSquare(Z, index, id = 3) # e.g., mRNA results
   ```

## Key Functions
- `PrepareSummarizedExperimentTensor()`: Formats raw data into a tensor.
- `computeHosvd()` / `computeHosvdSqure()`: Performs the core decomposition.
- `selectSingularValueVectorSmall()` / `...Large()`: Tools to visualize and pick vectors representing experimental design.
- `selectFeature()` / `selectFeatureSquare()`: Performs the unsupervised feature extraction using Gaussian distribution as a null hypothesis.
- `tableFeatures()`: Generates a data frame of selected features with p-values and adjusted p-values (BH method).

## Tips for Success
- **Vector Selection**: In `selectSingularValueVector`, look for vectors that show a clear separation between groups or follow a known experimental trend (e.g., a constant vector for baseline or a contrast vector for treatment vs. control).
- **SD Optimization**: If `selectFeature` fails to find a minimum, try adjusting the `de` parameter (initial SD) in the square/multi-omics workflow.
- **Memory Management**: For very large datasets, consider reducing the number of features (e.g., pre-filtering by variance) before tensor construction to avoid memory issues during HOSVD.

## Reference documentation
- [QuickStart](./references/QuickStart.md)
- [TDbasedUFE](./references/TDbasedUFE.md)