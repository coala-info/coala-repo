---
name: bioconductor-cllmethylation
description: This tool provides access to and analysis of DNA methylation array data for primary Chronic Lymphocytic Leukemia samples from the PACE project. Use when user asks to retrieve CLL methylation datasets from ExperimentHub, perform exploratory data analysis like PCA on patient samples, or integrate methylation profiles with multi-omics data.
homepage: https://bioconductor.org/packages/release/data/experiment/html/CLLmethylation.html
---


# bioconductor-cllmethylation

name: bioconductor-cllmethylation
description: Access and analyze DNA methylation data for Chronic Lymphocytic Leukemia (CLL) primary samples from the PACE project. Use this skill when needing to retrieve 450k/850k DNA methylation array data, perform exploratory data analysis (such as PCA) on CLL patient samples, or integrate methylation profiles with other multi-omics datasets from the BloodCancerMultiOmics2017 project.

# bioconductor-cllmethylation

## Overview

The `CLLmethylation` package provides comprehensive DNA methylation data for primary Chronic Lymphocytic Leukemia (CLL) samples. This data was generated as part of the Primary Blood Cancer Encyclopedia (PACE) project. The data is hosted on `ExperimentHub` as a `RangedSummarizedExperiment` object, allowing for seamless integration with other Bioconductor tools for genomic analysis.

## Data Access and Loading

The data is not stored directly in the package but is retrieved via `ExperimentHub`.

```r
library(ExperimentHub)
library(SummarizedExperiment)

# Initialize ExperimentHub
eh <- ExperimentHub()

# Query for the CLLmethylation resource
cll_query <- query(eh, "CLLmethylation")

# Retrieve the specific record (EH1071)
meth <- eh[["EH1071"]]
```

## Typical Workflow

### 1. Data Exploration
The object is a `RangedSummarizedExperiment`. Use standard accessors to inspect the data:
- `assay(meth)`: Access the methylation beta values.
- `colData(meth)`: Access sample metadata.
- `rowRanges(meth)`: Access genomic coordinates of the CpG sites.

### 2. Feature Selection (High Variance)
Because methylation arrays contain hundreds of thousands of sites, it is common to filter for the most variable CpG sites before performing dimensionality reduction.

```r
# Transpose and extract assay data
methData <- t(assay(meth))

# Filter for the top 5000 most variable sites
ntop <- 5000
variable_sites <- order(apply(methData, 2, var, na.rm = TRUE), decreasing = TRUE)[1:ntop]
methData_sub <- methData[, variable_sites]
```

### 3. Principal Component Analysis (PCA)
Perform PCA to visualize sample clustering and identify major drivers of variation (e.g., IGHV status or trisomy 12).

```r
# Perform PCA
pca_results <- prcomp(methData_sub, center = TRUE, scale. = FALSE)

# View importance of components
summary(pca_results)
```

### 4. Visualization
Use `ggplot2` to visualize the PCA results.

```r
library(ggplot2)
df_pca <- data.frame(pca_results$x)
ggplot(df_pca, aes(x = PC1, y = PC2)) +
  geom_point() +
  theme_bw() +
  labs(title = "PCA of CLL Methylation Data")
```

## Integration with Other Data
This package is often used in conjunction with `BloodCancerMultiOmics2017`. While `CLLmethylation` provides the full array data, `BloodCancerMultiOmics2017` contains a subset of the most variable sites alongside other omics layers (transcriptomics, drug response, etc.) for the same patient cohort.

## Reference documentation

- [CLLmethylation](./references/CLLmethylation.md)