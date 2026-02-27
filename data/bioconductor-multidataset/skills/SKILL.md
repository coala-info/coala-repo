---
name: bioconductor-multidataset
description: This tool manages and integrates multiple omic datasets sharing common samples within a unified R object. Use when user asks to create MultiDataSet objects, add diverse omic layers, synchronize samples across datasets, or subset data by sample, dataset name, or genomic range.
homepage: https://bioconductor.org/packages/release/bioc/html/MultiDataSet.html
---


# bioconductor-multidataset

name: bioconductor-multidataset
description: Management and integration of multiple omic datasets (gene expression, methylation, SNPs, etc.) with common samples. Use when Claude needs to create, manipulate, or subset MultiDataSet objects in R, especially for multi-omic data integration, sample synchronization, or genomic range-based filtering.

# bioconductor-multidataset

## Overview
The `MultiDataSet` package provides a specialized S4 class designed to store and manage multiple biological datasets (e.g., expression, methylation, SNPs) that share a common set of samples. It acts as a wrapper for Bioconductor classes like `eSet` and `SummarizedExperiment`, ensuring sample consistency across different "omics" layers while allowing independent storage of phenotypic and feature data.

## Core Workflow

### 1. Initialization
Always start by creating an empty `MultiDataSet` object.
```r
library(MultiDataSet)
multi <- createMultiDataSet()
```

### 2. Adding Datasets
Datasets are added using specific functions (preferred) or general functions.

**Specific Functions:**
Use these for standard Bioconductor objects to ensure proper slotting.
- `add_genexp(multi, expressionSet)`: Adds gene expression data.
- `add_methy(multi, methylationSet)`: Adds DNA methylation data.
- `add_snps(multi, snpSet)`: Adds SNP/Genotype data.
- `add_rnaseq(multi, summarizedExperiment)`: Adds RNA-seq data.

**General Functions:**
Use these for custom types or when specific wrappers aren't available.
- `add_eset(multi, object, dataset.type = "type")`: For `eSet` derived classes.
- `add_rse(multi, object, dataset.type = "type")`: For `SummarizedExperiment` derived classes.

**Key Arguments:**
- `dataset.name`: Use this to add multiple sets of the same type (e.g., `dataset.type="expression", dataset.name="discovery"`).
- `GRanges`: Provide genomic coordinates if they aren't in the object. Set to `NA` for non-genomic data (e.g., proteomics).
- `overwrite`: Set to `TRUE` to replace an existing dataset of the same name.

### 3. Sample Synchronization
`MultiDataSet` uses an `id` column in the phenotypic data (`pData` or `colData`) to match samples across sets. If the `id` column is missing, it defaults to `sampleNames`.

To keep only samples present in every dataset:
```r
multi_common <- commonSamples(multi)
```

### 4. Subsetting and Extraction
The `[` operator is overloaded for three-dimensional subsetting: `[samples, tables, ranges]`.

- **By Sample:** `multi[sample_ids, ]`
- **By Dataset Name:** `multi[, "expression"]`
- **By Genomic Range:** `multi[, , GRanges("chr17:1-100000")]` (Note: Datasets without `rowRanges` are dropped during range filtering).
- **Extraction:** Use `[[` or `drop = TRUE` to retrieve the original object (e.g., `ExpressionSet`).
  ```r
  eset <- multi[["expression"]]
  # OR
  eset <- multi[, "expression", drop = TRUE]
  ```

### 5. Advanced Filtering
Use `subset` to filter features or samples across all datasets simultaneously based on metadata columns.
```r
# Filter features by gene name (must exist in fData/rowData)
subset(multi, genes == "SLC35E2")

# Filter samples by phenotype (must exist in pData/colData)
subset(multi, , sex == "Female")
```

## Tips and Best Practices
- **Sample IDs:** Ensure your datasets have a consistent `id` column in their phenotypic data before adding them to avoid warnings and ensure correct matching.
- **Memory:** `MultiDataSet` stores data efficiently, but adding very large datasets (like whole-genome SNPs) may require significant RAM.
- **Custom Classes:** To add a custom class, extend `eSet` or `SummarizedExperiment` and use `add_eset` or `add_rse` within a custom wrapper function.

## Reference documentation
- [Introduction to MultiDataSet](./references/MultiDataSet.md)
- [Adding a new type of data to MultiDataSet objects](./references/MultiDataSet_Extending_Proteome.md)