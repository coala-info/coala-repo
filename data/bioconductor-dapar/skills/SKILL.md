---
name: bioconductor-dapar
description: This tool provides functions for the processing and statistical analysis of quantitative label-free proteomics data. Use when user asks to convert proteomics data to MSnSet, filter contaminants, normalize abundance values, impute missing values, aggregate peptides to proteins, or perform differential abundance testing.
homepage: https://bioconductor.org/packages/release/bioc/html/DAPAR.html
---

# bioconductor-dapar

name: bioconductor-dapar
description: Analysis of quantitative proteomics data using the DAPAR package. Use this skill for processing label-free proteomics datasets, including data conversion to MSnSet, filtering, normalization, missing value imputation (POV/MEC), peptide-to-protein aggregation, and differential abundance testing.

# bioconductor-dapar

## Overview

DAPAR (Differential Analysis of Protein Abundance with R) is a Bioconductor package designed for the processing and statistical analysis of quantitative data from label-free proteomics experiments (LC-MS/MS). It provides the computational engine for the Prostar GUI but can be used directly in R for programmatic workflows. It handles both peptide-level and protein-level data, utilizing the `MSnSet` class from the `MSnbase` package.

## Core Workflow

### 1. Data Import and MSnSet Creation
DAPAR uses `MSnSet` objects. You can convert a standard data frame (from MaxQuant, Proline, etc.) into an `MSnSet`.

```r
library(DAPAR)
library(MSnbase)

# Example: Creating an MSnSet from a data frame
# quantCols: indices of columns containing abundance values
# pData: data frame describing the experimental design (Condition, Replicate)
# obj <- createMSnset(data, pData, quantCols, indexForID, logData = FALSE)
```

### 2. Filtering
Remove analytes based on missing values or metadata tags (e.g., contaminants, reverse sequences).

*   **Missing Values:** Use `filterEmptyLines()` or `getIndicesOfLinesToRemoveByMissingValues()`.
*   **String-based:** Use `StringBasedFiltering()` to remove rows based on metadata prefixes.

### 3. Normalization
Correct for batch effects and sample biases. Supported methods include:
*   `wrapper.normalizeD(obj, method = "GlobalQuantileAlignment")`
*   `wrapper.normalizeD(obj, method = "QuantileCentering", quantile = 0.5, type = "overall")`
*   `wrapper.normalizeD(obj, method = "MeanCentering", scaling = TRUE)`
*   `wrapper.normalizeD(obj, method = "vsn")`
*   `wrapper.normalizeD(obj, method = "LOESS")`

### 4. Imputation
DAPAR distinguishes between **POV** (Partially Observed Values) and **MEC** (Missing in the Entire Condition).

*   **Peptide-level:** Recommended to use `imp4p` methods which diagnose the missingness mechanism (MCAR vs MNAR).
*   **Protein-level:** Typically assumes POVs are MCAR and MECs are MNAR.
*   **Functions:**
    *   `wrapper.impute.slsa(obj)` (Structured Least Square Adaptive)
    *   `wrapper.impute.detQuant(obj, q = 0.01, factor = 1)` (Deterministic quantile for MNAR/MEC)
    *   `wrapper.impute.knn(obj, K = 3)`

### 5. Aggregation (Peptide to Protein)
If starting with peptides, aggregate to proteins after normalization and imputation.
*   **Function:** `aggregateFeatures(obj, pID, method = "sum", conds)`
*   Options include summing/averaging specific peptides or using proportional redistribution for shared peptides.

### 6. Hypothesis Testing
Perform differential analysis using `limma` or t-tests.
*   **Function:** `limmaCompleteTest(obj, contrast = "OnevsOne")`
*   This generates p-values and log-fold changes (logFC).
*   **FDR Calibration:** Use `diffAnaComputeFDR()` to calculate False Discovery Rates.

## Data Mining and Visualization
DAPAR provides functions to generate standard proteomics plots:
*   `corrMatrixD(obj)`: Correlation matrix between replicates.
*   `heatmapD(obj)`: Intensity heatmap with dendrograms.
*   `wrapper.pca(obj)`: Principal Component Analysis.
*   `densityPlotD(obj)`: Intensity distributions.
*   `boxPlotD(obj)`: Intensity boxplots.

## Key Tips
*   **Log Transformation:** DAPAR requires data to be on a log2 scale. If importing raw intensities, ensure `logData = TRUE` in the conversion step.
*   **Experimental Design:** Ensure your `pData` has a "Condition" column. Statistical tests rely on this grouping.
*   **MEC Handling:** Be cautious with MEC imputation; it is often safer to use a low deterministic value (e.g., 1% quantile) to represent the limit of detection.

## Reference documentation
- [Prostar User Manual](./references/Prostar_UserManual.Rmd)