---
name: bioconductor-abarray
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ABarray.html
---

# bioconductor-abarray

name: bioconductor-abarray
description: Analysis of Applied Biosystems AB1700 Gene Expression data. Use this skill to perform automated microarray data processing, including quality control (QC), quantile normalization, differential expression analysis (t-tests, ANOVA, LPE), and visualization (Venn diagrams, heatmaps, MA plots).

# bioconductor-abarray

## Overview
The `ABarray` package is designed for the analysis of Applied Biosystems AB1700 microarray data, though its statistical functions can be applied to any expression matrix. It provides an automated pipeline that handles data loading, control probe processing, normalization, and statistical testing for differential expression.

## Core Workflow

### 1. Data Preparation
Two files are required for the automated pipeline:
- **Data File**: Tab or comma-delimited. Must contain columns: `probeID`, `geneID`, `Signal`, `S/N`, and `Flags`.
- **Experiment Design File**: Rows are samples. Must contain `sampleName` and either `assayName` or `arrayName`. Additional columns define experimental groups (e.g., `tissue`, `treatment`).

### 2. Automated Analysis
The `ABarray()` function performs the entire pipeline: reading data, QC on control probes, quantile normalization, log2 transformation, and statistical testing.

```r
library(ABarray)
# Set working directory to where files are located
setwd("path/to/data")

# Run automated analysis
# "tissue" is the column name in the design file to use for grouping
eset <- ABarray("DataFile.txt", "DesignFile.csv", "tissue")
```

### 3. Manual Analysis Steps
If you have an existing `ExpressionSet` (eset), you can run specific components:

**Quality Control and Plotting:**
```r
# Performs QC plots (Boxplot, MA, CV, Scatter, Correlation) and t-tests
doPlotEset(eset, group = "tissue", name = "quantile_results")
```

**Statistical Testing:**
- **t-test & Fold Change**: `doPlotFCT(eset, group = "tissue")`
- **ANOVA**: `doANOVA(eset, factor1 = "treatment", factor2 = "dose")` (supports 1-way or 2-way)
- **LPE (Local Pooled Error)**: Best for low replicates (2-3).
  ```r
  lpe_results <- doLPE(eset, group = "tissue", member = c("Control", "Treatment"))
  ```

**Visualization:**
```r
# Create Venn Diagrams from gene lists
list1 <- geneNames(eset)[1:100]
list2 <- geneNames(eset)[61:160]
doVennDiagram(list1, list2, names = c("Group A", "Group B"))
```

## Key Functions and Parameters
- `ABarray(dataFile, designFile, group)`: Main entry point.
- `snThresh`: Signal-to-Noise threshold (default = 3).
- `detectSample`: Percentage of samples (0.0 to 1.0) a probe must be detected in to be included in tests (default = 0.5).
- `impute`: Handles missing values (Flags > 5000). Options: "none" or "average".

## Interpreting Results
The package creates a directory named `Result_{group}` containing:
- **DataResult/**: CSV files with normalized expression, t-test results (p-values, FDR), and ANOVA results.
- **jpgFigure/ & pdfFigure/**: Visualizations including Volcano plots, MA plots, and clustering heatmaps (generated automatically if < 800 significant probes).

## Reference documentation
- [AB1700 Microarray Data Analysis](./references/ABarray.md)
- [ABarray GUI Guide](./references/ABarrayGUI.md)