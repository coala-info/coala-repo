---
name: bioconductor-erccdashboard
description: This tool evaluates the technical performance of gene expression experiments using External RNA Controls Consortium (ERCC) spike-in controls. Use when user asks to assess dynamic range, estimate the limit of detection of ratios, or analyze RNA-Seq and microarray data using ERCC spike-ins.
homepage: https://bioconductor.org/packages/release/bioc/html/erccdashboard.html
---


# bioconductor-erccdashboard

name: bioconductor-erccdashboard
description: Technical performance assessment of gene expression experiments using External RNA Controls Consortium (ERCC) spike-in controls. Use this skill to analyze RNA-Seq (count) or Microarray (array) data to evaluate dynamic range, dose-response, and Limit of Detection of Ratios (LODR).

# bioconductor-erccdashboard

## Overview

The `erccdashboard` package provides a suite of tools to assess the technical performance of differential gene expression experiments using ERCC spike-in control ratio mixtures. It evaluates the relationship between transcript abundance and signal, estimates the mRNA fraction difference between samples, and determines the sensitivity of the experiment to detect fold changes (LODR).

## Core Workflow

The most efficient way to use the package is through the `runDashboard` wrapper function, which executes the full analysis pipeline.

### 1. Prepare Input Data

The expression table (`exTable`) must follow a specific format:
- **First Column**: Named "Feature", containing unique transcript names (including ERCC IDs like "ERCC-00002").
- **Subsequent Columns**: Named using the format `Sample_Rep` (e.g., `MET_1`, `MET_2`, `CTL_1`). Only one underscore is permitted.

### 2. Execute Analysis

Run the default analysis pipeline using `runDashboard`.

```r
library(erccdashboard)

# Example for RNA-Seq count data
exDat <- runDashboard(datType="count", 
                       isNorm = FALSE,
                       exTable = myCountData,
                       filenameRoot = "MyExperiment", 
                       sample1Name = "Treatment",
                       sample2Name = "Control", 
                       erccmix = "RatioPair",
                       erccdilution = 1/100, 
                       spikeVol = 1,
                       totalRNAmass = 0.500, 
                       choseFDR = 0.05)
```

**Key Parameters:**
- `datType`: Use `"count"` for RNA-Seq or `"array"` for Microarray.
- `isNorm`: Set to `TRUE` if data is already normalized. If `TRUE` for RNA-Seq, you must provide an external P-value file (see Flexibility section).
- `erccmix`: Usually `"RatioPair"` for Ambion ExFold mixes.
- `erccdilution`, `spikeVol`, `totalRNAmass`: Specifics of the spike-in protocol used in the lab.

### 3. Interpret Results

The output `exDat` is a list containing data, results, and ggplot2 objects.

- **Dynamic Range (`exDat$Figures$dynRangePlot`)**: Shows the relationship between ERCC amount and signal.
- **ROC Curve (`exDat$Figures$rocPlot`)**: Displays diagnostic power to detect DE for different fold-change ratios.
- **LODR Plot (`exDat$Figures$lodrERCCPlot`)**: Estimates the Limit of Detection of Ratios—the abundance level required to reliably detect a specific fold change.
- **MA Plot (`exDat$Figures$maPlot`)**: Shows ratio vs. average signal, highlighting bias ($r_m$) and LODR thresholds.

## Advanced Usage

### Flexibility in Differential Expression (DE) Testing
By default, the package uses `QuasiSeq` (for counts) or `limma` (for arrays). To use results from other tools (like `DESeq2` or `edgeR` with specific parameters):
1. Save a CSV file in the working directory named `filenameRoot.All.Pvals.csv`.
2. The file must contain columns: `Feature`, `MnSignal`, `Pval`, and `Fold`.
3. `geneExprTest` will automatically detect and use this file.

### Alternative Spike-in Designs
If using custom spike-in mixtures (not the standard Ambion 4-ratio set):
- Provide a custom CSV via the `userMixFile` argument in `initDat` or `runDashboard`.
- If only a single mixture was used (no ratios), use `erccmix = "Single"` to analyze dynamic range and mRNA fraction only.

### Saving Outputs
Use `saveERCCPlots` to export the diagnostic figures to a PDF.

```r
saveERCCPlots(exDat, plotlist = "main", saveas = "pdf")
```

## Tips for Success
- **Normalization**: For RNA-Seq counts, the package defaults to 75th percentile (upper quartile) normalization. You can provide custom factors via `repNormFactor`.
- **Filtering**: The package automatically removes transcripts with very low counts (mean < 1) or too many zeros.
- **Units**: LODR estimates are returned in the units of the input data (e.g., unnormalized counts or FPKM).

## Reference documentation
- [Assessing Differential Gene Expression Experiments with the erccdashboard](./references/erccdashboard.md)