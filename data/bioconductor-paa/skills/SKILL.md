---
name: bioconductor-paa
description: The PAA package provides a comprehensive pipeline for the analysis of single-color protein microarrays, specifically focusing on preprocessing and biomarker discovery. Use when user asks to import GPR files, perform batch effect correction, normalize protein array data, or identify biomarker candidates using ensemble feature selection.
homepage: https://bioconductor.org/packages/release/bioc/html/PAA.html
---

# bioconductor-paa

## Overview

The PAA (Protein Array Analyzer) package is designed for the analysis of single-color protein microarrays, with specialized support for ProtoArray data. It provides a complete pipeline from raw data import to the identification of biomarker candidates. Key features include robust preprocessing tools to handle batch effects and spatial biases, univariate preselection using the "minimum M statistic" (mMs), and advanced multivariate feature selection algorithms like ensemble feature selection.

## Workflow and Key Functions

### 1. Data Import
Load data from GPR files using a targets file. For ProtoArrays, it can automatically aggregate duplicate spots.

```r
library(PAA)
gpr_path <- "path/to/gpr_files"
targets_path <- "path/to/targets.txt"

# Import ProtoArray data with duplicate aggregation
elist <- loadGPR(gpr.path=gpr_path, targets.path=targets_path, array.type="ProtoArray", aggregation="min")
```

### 2. Preprocessing
Preprocessing involves background correction, batch effect removal, and normalization.

*   **Visual Inspection:** Use `plotArray()` to check for spatial biases.
*   **Background Correction:** Typically uses `limma` wrappers.
*   **Batch Filtering:** Remove features that vary significantly between batches.
    ```r
    # For two batches
    elist <- batchFilter(elist=elist, lot1=lot1_names, lot2=lot2_names, log=FALSE, p.thresh=0.001, fold.thresh=3)
    # For multi-batch scenarios
    elist <- batchFilter.anova(elist=elist, log=FALSE, p.thresh=0.001, fold.thresh=3)
    ```
*   **Normalization:** Supports "cyclicloess", "quantile", "vsn", and "rlm" (Robust Linear Model for ProtoArrays).
    ```r
    elist <- normalizeArrays(elist=elist, method="cyclicloess", cyclicloess.method="fast")
    ```
*   **Batch Adjustment:** Use `batchAdjust()` (ComBat wrapper) after normalization.

### 3. Differential Analysis
Perform univariate analysis to find significant features.

*   **mMs Matrix:** Precompute the reference matrix for the minimum M statistic.
    ```r
    mMs.matrix1 <- mMsMatrix(x=n1, y=n2)
    mMs.matrix2 <- mMsMatrix(x=n2, y=n1)
    ```
*   **Visualization:** Use `volcanoPlot()`, `pvaluePlot()`, and `plotMAPlots()`.
*   **Detailed Analysis:** `diffAnalysis()` provides a comprehensive results table including p-values, adjusted p-values (FDR), and fold changes.

### 4. Feature Selection
PAA excels at identifying biomarker panels through multivariate selection.

*   **Preselection:** Use `preselect()` to discard non-informative features before expensive multivariate runs.
*   **Frequency-based Selection:** Uses cross-validation to find a stable panel.
    ```r
    selectFeatures.results <- selectFeatures(elist, n1=20, n2=20, label1="AD", label2="NDC", 
                                             selection.method="rf.rfe", method="frequency")
    ```
*   **Ensemble Selection:** Uses bootstrapping and SVM-RFE for robust identification.
    ```r
    selectFeatures.results <- selectFeatures(elist, n1=20, n2=20, label1="AD", label2="NDC", 
                                             subsamples=10, bootstraps=10, method="ensemble")
    ```

### 5. Results Inspection
*   **Heatmaps:** `plotFeaturesHeatmap()` or `plotFeaturesHeatmap.2()`.
*   **Intensity Plots:** `plotFeatures()` for individual feature sub-plots.
*   **Reporting:** `printFeatures()` creates a summary table of the selected candidates.

## Tips for Success
*   **Log Scale:** Most PAA functions require an explicit `log` argument (TRUE/FALSE). Ensure your EList matches this parameter.
*   **BRC-IDs:** PAA identifies features using a combination of Block, Row, and Column (BRC). Use `paste(elist$genes[,1], elist$genes[,3], elist$genes[,2])` to generate these IDs if needed manually.
*   **External Dependencies:** For `rj.rfe` (Random Jungle), the external "Random Jungle" C++ package must be installed on the system.

## Reference documentation
- [PAA_1.7.1](./references/PAA_1.7.1.md)
- [PAA_vignette](./references/PAA_vignette.md)