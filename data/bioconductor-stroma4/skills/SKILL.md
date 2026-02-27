---
name: bioconductor-stroma4
description: This tool assigns stromal and Lehmann properties to breast cancer gene expression datasets to characterize tumor microenvironment heterogeneity. Use when user asks to estimate property levels from ExpressionSet objects, identify sample status as low, intermediate, or high, or generate stromal subtyping schemes.
homepage: https://bioconductor.org/packages/3.8/bioc/html/STROMA4.html
---


# bioconductor-stroma4

name: bioconductor-stroma4
description: Assigns stromal (tumor microenvironment) and Lehmann properties to Triple-Negative Breast Cancer (TNBC) and other cancer datasets using gene expression data. Use this skill to estimate property levels (Stroma4 or TNBCType) from ExpressionSet objects, identify sample status (low, intermediate, high), and generate stromal subtyping schemes.

# bioconductor-stroma4

## Overview

The `STROMA4` package provides tools to characterize the heterogeneity of the tumor microenvironment. It assigns samples into categories (low, intermediate, or high) based on four stromal properties (T, B, D, and E) and Lehmann's TNBCType generative properties. While developed for TNBC, these stromal signatures are applicable to other breast cancer subtypes and potentially other cancer types.

## Core Workflow

### 1. Data Preparation
The package requires an `ExpressionSet` object. Crucially, the `featureData` must contain HGNC gene symbols (gene names), as the internal signatures are mapped to these IDs.

```r
library(STROMA4)
library(Biobase)

# Example using a dataset with HGNC symbols in 'Gene.symbol' column
# Ensure your ExpressionSet (eset) has a column with HGNC IDs
head(fData(eset)[, "Gene.symbol", drop=FALSE])
```

### 2. Assigning Properties
Use the `assign.properties` function to estimate property levels. You can assign stromal properties, Lehmann properties, or both.

```r
# Assign Stromal properties only
stroma_res <- assign.properties(
  ESet = eset, 
  geneID.column = "Gene.symbol", 
  genelists = "Stroma4", 
  n = 10, 
  mc.cores = 1
)

# Assign Lehmann (TNBCType) properties only
lehmann_res <- assign.properties(
  ESet = eset, 
  geneID.column = "Gene.symbol", 
  genelists = "TNBCType", 
  n = 10, 
  mc.cores = 1
)

# Assign both simultaneously
all_res <- assign.properties(
  ESet = eset, 
  geneID.column = "Gene.symbol", 
  genelists = c("Stroma4", "TNBCType"), 
  n = 10, 
  mc.cores = 1
)
```

### 3. Interpreting Results
The function returns the original `ExpressionSet` with new columns added to the `pData` (phenotype data).

*   **Property Columns:** Look for columns ending in `.stroma.property`.
*   **Intermediate Assignments:** If >80% of samples are assigned to the "intermediate" category, the signature may be non-informative for that specific dataset.
*   **Confidence:** Increase the `n` parameter (number of random samples) to increase the confidence of the intermediate region boundary, though this increases computation time.

### 4. Creating a Subtyping Scheme
You can concatenate the individual stromal properties (T, B, D, E) to create a composite subtype for each patient.

```r
# Extract the property columns
props <- c("T", "B", "D", "E")
prop_cols <- paste0(props, ".stroma.property")
subtypes_df <- pData(stroma_res)[, prop_cols]

# Create a combined string (e.g., "T-low/B-high/D-low/E-intermediate")
combined_subtypes <- apply(subtypes_df, 1, paste, collapse="/")
```

## Performance Tips

*   **Parallelization:** Use the `mc.cores` argument to utilize multiple CPU cores. Use `parallel::detectCores()` to check available resources.
*   **Gene Mapping:** If your data uses Entrez IDs or Ensembl IDs, use `AnnotationDbi` or `org.Hs.eg.db` to map them to HGNC symbols before running `assign.properties`.

## Reference documentation

- [Using the STROMA4 package](./references/STROMA4-vignette.md)