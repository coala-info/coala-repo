---
name: bioconductor-tidybulk
description: bioconductor-tidybulk performs modular transcriptomic data analysis using tidyverse principles. Use when user asks to preprocess RNA-seq data, perform dimensionality reduction, test for differential expression, or conduct cellularity deconvolution.
homepage: https://bioconductor.org/packages/release/bioc/html/tidybulk.html
---


# bioconductor-tidybulk

name: bioconductor-tidybulk
description: Modular transcriptomic data analysis using tidyverse principles. Use this skill to perform RNA-seq workflows including data preprocessing (aggregation, filtering, scaling), exploratory data analysis (dimensionality reduction, clustering), differential expression testing (edgeR, DESeq2, limma), cellularity deconvolution, and gene enrichment analysis.

# bioconductor-tidybulk

## Overview
The `tidybulk` package brings transcriptomic data analysis into the tidyverse ecosystem. It provides a unified, pipe-friendly interface for analyzing RNA-seq data, primarily working with `SummarizedExperiment` objects. It allows users to chain complex bioinformatics tasks—such as normalization, batch correction, and differential expression—using a consistent syntax that maintains data integrity while offering the flexibility of `dplyr` and `ggplot2`.

## Core Workflow

### 1. Data Initialization
Load your data and ensure it is compatible with tidyverse tools using `tidySummarizedExperiment`.

```r
library(airway)
library(tidybulk)
library(tidySummarizedExperiment)

data(airway)
# Ensure factors are correctly set for modeling
airway <- airway %>% mutate(dex = as.factor(dex))
```

### 2. Preprocessing
Clean and normalize your data before downstream analysis.

*   **Aggregate Duplicates:** Combine isoforms or redundant Ensembl IDs.
    ```r
    airway_aggr <- airway %>% aggregate_duplicates(.transcript = gene_name)
    ```
*   **Abundance Filtering:** Remove lowly expressed genes.
    ```r
    airway_filtered <- airway %>% keep_abundant(formula_design = ~ dex)
    ```
*   **Scaling/Normalization:** Account for library size (TMM, RLE, or Upper Quartile).
    ```r
    airway_norm <- airway_filtered %>% scale_abundance(method = "TMM")
    ```

### 3. Exploratory Data Analysis (EDA)
Visualize sample relationships and identify clusters.

*   **Dimensionality Reduction:** PCA or MDS.
    ```r
    airway_eda <- airway_norm %>%
      reduce_dimensions(method = "PCA", .dims = 2) %>%
      reduce_dimensions(method = "MDS", .dims = 2)
    ```
*   **Clustering:** Group samples based on expression profiles.
    ```r
    airway_clusters <- airway_eda %>% cluster_elements(method = "kmeans", centers = 2)
    ```

### 4. Differential Expression Analysis
Test for differences between conditions using multiple underlying engines (edgeR, DESeq2, limma).

```r
# Basic testing
airway_de <- airway %>%
  test_differential_expression(~ dex, method = "edgeR_quasi_likelihood")

# Using contrasts for specific comparisons
airway_contrasts <- airway %>%
  test_differential_expression(
    ~ 0 + dex,
    .contrasts = c("dextrt - dexuntrt"),
    method = "DESeq2"
  )
```

### 5. Advanced Analysis
*   **Batch Correction:** Adjust for unwanted variation (e.g., ComBat-seq).
    ```r
    airway_adj <- airway %>%
      adjust_abundance(.factor_unwanted = cell, .factor_of_interest = dex, method = "combat_seq")
    ```
*   **Cellularity Deconvolution:** Estimate cell type proportions (e.g., CIBERSORT).
    ```r
    airway_cell <- airway %>%
      deconvolve_cellularity(method = "cibersort", feature_column = "symbol")
    ```
*   **Gene Enrichment:** Test for overrepresentation or GSEA-style ranking.
    ```r
    airway_enrich <- airway %>%
      test_gene_rank(.entrez = entrezid, .arrange_desc = logFC, species = "Homo sapiens")
    ```

## Tips for Success
*   **Pivoting:** Use `pivot_sample()` to view sample-level metadata and `pivot_transcript()` to view gene-level results (like p-values and fold changes) in a tidy format.
*   **Prefixing:** When running multiple DE methods, use the `prefix` argument in `test_differential_expression()` to keep results organized in the same object.
*   **Metadata Access:** Raw fit objects from underlying packages (like the edgeR DGEList) are often stored in the object metadata: `metadata(airway)$tidybulk`.

## Reference documentation
- [Side-by-side comparison with standard interfaces](./references/comparison_coding.md)
- [Overview of the tidybulk package](./references/introduction.md)