---
name: bioconductor-prostar
description: This tool performs statistical analysis of quantitative proteomics data including filtering, normalization, and differential abundance testing. Use when user asks to import MSnSet data, impute missing values, aggregate peptides to proteins, or identify differentially expressed proteins in LC-MS/MS experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/Prostar.html
---

# bioconductor-prostar

name: bioconductor-prostar
description: Statistical analysis of quantitative proteomics data using the Prostar and DAPAR packages. Use this skill to perform discovery proteomics workflows including data import (MSnSet), filtering, normalization, missing value imputation, peptide-to-protein aggregation, and differential abundance testing.

# bioconductor-prostar

## Overview

The `Prostar` package (Proteomics statistical analysis with R) and its companion engine `DAPAR` provide a comprehensive pipeline for analyzing quantitative data from LC-MS/MS proteomics experiments. While Prostar is known for its Shiny GUI, this skill focuses on the underlying `DAPAR` functional workflow for programmatic analysis. The package is designed around the `MSnSet` object class and supports both peptide-level and protein-level datasets.

## Core Workflow

### 1. Data Import and Preparation
Data must be converted into an `MSnSet` object. This typically involves a quantitative matrix, metadata for analytes (peptides/proteins), and an experimental design (samples/conditions).

```r
library(Prostar)
library(DAPAR)
library(DAPARdata)

# Load example data (Exp1_R25_pept is a peptide-level MSnSet)
data(Exp1_R25_pept)
obj <- Exp1_R25_pept
```

### 2. Filtering
Remove contaminants, reverse sequences, or analytes with excessive missing values.

*   **Missing Value Filtering**: Use `filterEmptyLines()` to remove rows with no data.
*   **String-based Filtering**: Filter based on metadata columns (e.g., "Contaminant").

### 3. Normalization
Correct for systematic biases between samples.

*   **Methods**: `SumByColumns`, `QuantileCentering`, `MeanCentering`, `LOESS`, or `vsn`.
*   **Function**: `wrapper.normalizeD(obj, method = "QuantileCentering", conds = pData(obj)$Condition, type = "overall")`

### 4. Imputation
Handle missing values by distinguishing between POV (Partially Observed Values - MCAR) and MEC (Missing on the Entire Condition - MNAR).

*   **POV Imputation**: Methods like `SLSA` or `KNN`.
*   **MEC Imputation**: Methods like `FixedValue` or `QuantileCentering` (usually a small value).
*   **Function**: `wrapper.impute.slsa(obj)` for POV or `wrapper.impute.detQuant(obj)` for MNAR.

### 5. Aggregation (Peptide to Protein)
If starting with peptides, aggregate intensities to the protein level.

*   **Methods**: `sum` or `mean`.
*   **Function**: `aggregateFeatures(obj, pID = "Protein_Group_ID", method = "sum")`

### 6. Differential Analysis
Identify proteins that change significantly between conditions.

*   **Statistical Tests**: `limma` or `t-test`.
*   **Workflow**:
    1.  Compute p-values: `wrapper.diffAnaDiff(obj, condition = pData(obj)$Condition, method = "limma")`
    2.  Calibrate p-values and estimate FDR.
    3.  Apply Log Fold Change (logFC) and p-value thresholds.

### 7. Data Mining and Visualization
*   **PCA**: `wrapper.pca(obj)`
*   **Heatmaps**: `wrapper.heatmapD(obj)`
*   **Volcano Plots**: `diffAnaVolcano_Step1(list_pvals, logFC, threshold_pVal, threshold_logFC)`
*   **GO Analysis**: Perform Gene Ontology classification or enrichment using `group_GO` and `enrich_GO` wrappers.

## Key Functions Reference

| Task | Function |
| :--- | :--- |
| Normalization | `wrapper.normalizeD()` |
| Imputation (MCAR) | `wrapper.impute.slsa()`, `wrapper.impute.KNN()` |
| Imputation (MNAR) | `wrapper.impute.detQuant()`, `wrapper.impute.fixedValue()` |
| Aggregation | `aggregateFeatures()` |
| Hypothesis Testing | `wrapper.diffAnaDiff()` |
| FDR Calculation | `diffAnaComputeFDR()` |

## Reference documentation

- [Prostar user manual](./references/Prostar_UserManual.md)