---
name: bioconductor-hermes
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/hermes.html
---

# bioconductor-hermes

## Overview

The `hermes` package provides a robust, object-oriented framework for processing RNA-seq count data. It extends the `SummarizedExperiment` class into `HermesData` objects, enforcing specific data standards that facilitate automated quality control, annotation, and visualization. It is particularly useful for standardized pipelines where consistency in gene and sample metadata is required.

## Core Workflow

### 1. Data Import and Conversion

`hermes` requires data to be in `HermesData` or `RangedHermesData` format.

*   **From SummarizedExperiment:**
    ```r
    # Basic conversion
    object <- HermesData(summarized_experiment)
    
    # If column names need mapping to hermes standards
    object <- summarized_experiment %>%
      rename(
        row_data = c(symbol = "HGNC", desc = "HGNCGeneName", chromosome = "Chromosome"),
        col_data = c(low_depth_flag = "LowDepthFlag")
      ) %>%
      HermesData()
    ```
*   **From Matrix:**
    ```r
    object <- HermesDataFromMatrix(counts = counts_matrix, rowData = row_df, colData = col_df)
    ```

### 2. Annotation

Automate gene metadata retrieval using BioMart. Gene IDs must have a consistent prefix (e.g., "ENSG" or "GeneID").

```r
connection <- connect_biomart(prefix(object))
annotation(object) <- query(genes(object), connection)
```

### 3. Quality Control (QC)

`hermes` uses a flagging system to identify problematic genes or samples without immediately deleting them.

*   **Automatic Flagging:**
    ```r
    # Define thresholds
    controls <- control_quality(min_cpm = 10, min_cpm_prop = 0.4, min_corr = 0.4)
    # Apply flags
    object <- add_quality_flags(object, control = controls)
    ```
*   **Manual Flagging:**
    ```r
    object <- set_tech_failure(object, sample_ids = c("Sample_1", "Sample_2"))
    ```
*   **Accessing Flags:** Use `get_low_expression(object)`, `get_low_depth(object)`, or `get_tech_failure(object)`.

### 4. Filtering and Normalization

*   **Filtering:** Remove flagged entries.
    ```r
    object_filtered <- filter(object)
    ```
*   **Normalization:** Supports `cpm`, `rpkm`, `tpm`, `vst`, and `rlog`.
    ```r
    object_norm <- normalize(object_filtered, method = "tpm")
    # Access normalized counts
    tpm_counts <- assay(object_norm, "tpm")
    ```

### 5. Visualization and Analysis

*   **Descriptive Plots:** `autoplot(object)` generates a standard suite of QC plots (library sizes, non-zero genes, etc.).
*   **Top Genes:**
    ```r
    top_expr <- top_genes(object_norm, assay_name = "tpm")
    autoplot(top_expr)
    ```
*   **PCA:**
    ```r
    pca_res <- calc_pca(object_norm, assay_name = "tpm")
    autoplot(pca_res, data = as.data.frame(colData(object_norm)), colour = "GroupVariable")
    ```
*   **Differential Expression:**
    ```r
    # Ensure grouping variable is a factor
    colData(object) <- df_cols_to_factor(colData(object))
    diff_results <- diff_expression(object, group = "SEX", method = "voom")
    autoplot(diff_results)
    ```

## Tips for Success

*   **Assay Names:** `hermes` strictly expects an assay named `counts`. Use `rename(assays = c(counts = "old_name"))` if your input uses a different name.
*   **Metadata Preservation:** Use `annotation(object)` to view the core gene information (symbol, desc, chromosome, size).
*   **Factor Conversion:** Always use `df_cols_to_factor()` on your `colData` before running differential expression to avoid errors with character vectors.

## Reference documentation

- [Introduction to hermes](./references/hermes.Rmd)
- [Introduction to hermes (Markdown)](./references/hermes.md)