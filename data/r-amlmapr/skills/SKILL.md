---
name: r-amlmapr
description: This tool predicts transcriptional Acute Myeloid Leukemia subtypes from gene expression data using a Support Vector Machine model. Use when user asks to classify AML gene expression data into transcriptional clusters, predict AML subtypes, or map AML heterogeneity.
homepage: https://cran.r-project.org/web/packages/amlmapr/index.html
---

# r-amlmapr

name: r-amlmapr
description: Predict transcriptional AML subtypes using an SVM-based model. Use this skill when you need to classify Acute Myeloid Leukemia (AML) gene expression data into specific transcriptional clusters based on the methodology from Severens et al. (2024).

# r-amlmapr

## Overview
The `amlmapr` package provides a Support Vector Machine (SVM) based model to predict transcriptional AML subtypes. It is designed to map AML heterogeneity by identifying novel clusters from transcriptomic data.

## Installation
```R
install.packages("caret")
library(devtools)
install_github("jeppeseverens/AMLmapR")
```

## Workflow

### 1. Prepare Input Data
The model requires raw gene counts. **Do not normalize or log-transform the counts** before inputting them into the prediction function.

*   **Format**: A matrix or data frame.
*   **Rows**: Samples (set as `rownames`).
*   **Columns**: Ensembl IDs (set as `colnames`).
*   **Alignment**: Data should ideally be aligned using STAR (v2.7.5c) against GDC h38 GENCODE v36.
*   **Column Ordering**: Ensure your matrix columns match the expected Ensembl IDs. You can align your columns using the package's example matrix:
    ```R
    your_matrix <- your_matrix[, colnames(AMLmapR::example_matrix)]
    ```

### 2. Predict Subtypes
Use the `predict_AML_clusters` function to classify your samples.

```R
library(AMLmapR)

# Load your data (must be a matrix)
# counts_matrix <- as.matrix(your_data)

# Example using internal data
example_data <- AMLmapR::example_matrix

# Run prediction
predictions <- predict_AML_clusters(example_data)

# View results
print(predictions)
```

## Tips
*   **Strandness**: When merging *ReadsPerGene.out.tab* files from STAR, ensure you select the correct count column based on the library's strandness.
*   **Class Requirement**: The input must be of class `Matrix`. Use `as.matrix()` if your data is currently a data frame.
*   **Citation**: If used in publication, cite: Severens, J. et al. "Mapping AML heterogeneity - multi-cohort transcriptomic analysis identifies novel clusters and divergent ex-vivo drug responses." Nature Leukemia (2024).

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)