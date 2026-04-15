---
name: bioconductor-anota
description: This tool identifies differential translational activity from genomic data by applying Analysis of Partial Variance to correct for changes in cytosolic mRNA levels. Use when user asks to identify genes with changing translational efficiency, perform quality control on polysome profiling data, or analyze ribosome sequencing experiments using a regression-based approach.
homepage: https://bioconductor.org/packages/release/bioc/html/anota.html
---

# bioconductor-anota

name: bioconductor-anota
description: Analysis of differential translational activity using genomic data (polysome profiling or ribosome sequencing). Use this skill to identify genes where translational efficiency changes between conditions, correcting for changes in cytosolic mRNA levels using Analysis of Partial Variance (APV).

# bioconductor-anota

## Overview

The `anota` package (ANalysis Of Translational Activity) provides a robust statistical framework for identifying differential translation. Unlike simple log-ratio methods (polysome-associated mRNA / total cytosolic mRNA), `anota` uses Analysis of Partial Variance (APV) with a regression-based approach. This corrects for the spurious correlations and false positives often associated with ratio-based methods. It includes comprehensive quality control to validate model assumptions (normality of residuals, identical slopes, and influential data points) and supports the Random Variance Model (RVM) to increase statistical power in small-sample experiments.

## Typical Workflow

### 1. Data Preparation
`anota` requires two matched data matrices: one for translationally active mRNA (e.g., polysome-associated or ribosome-protected fragments) and one for total cytosolic mRNA.
- Data should be log-transformed (e.g., log2).
- A minimum of 3 replicates per group is required.
- `phenoVec` is a character vector defining the sample classes.

```R
library(anota)
# dataT: matrix of translationally active mRNA
# dataP: matrix of cytosolic mRNA
# phenoVec: e.g., c("ctrl", "ctrl", "ctrl", "treat", "treat", "treat")
```

### 2. Quality Control
Before identifying significant genes, you must validate the APV assumptions.

```R
anotaQcOut <- anotaPerformQc(
  dataT = dataT, 
  dataP = dataP, 
  phenoVec = phenoVec, 
  nDfbSimData = 500 # Number of simulations for dfbeta
)
```
**Key QC Checks:**
- **Influential data points:** Uses dfbetas to ensure specific samples aren't disproportionately driving the regression.
- **Interaction test:** Checks if the slopes of the regressions are similar across sample classes (a core APV assumption).
- **Residual distribution:** Use `anotaResidOutlierTest(anotaQcOut)` to check for normality via Q-Q plots.

### 3. Identifying Differential Translation
Once validated, use `anotaGetSigGenes` to perform the APV.

```R
anotaSigOut <- anotaGetSigGenes(
  dataT = dataT, 
  dataP = dataP, 
  phenoVec = phenoVec, 
  anotaQcObj = anotaQcOut,
  useRVM = TRUE # Recommended for small N
)
```

### 4. Filtering and Visualization
Filter results based on p-values, slopes, and fold-change (deltaPT).

```R
anotaSelected <- anotaPlotSigGenes(
  anotaSigObj = anotaSigOut, 
  selContr = 1,        # Which contrast to plot
  maxP = 0.05,         # Adjusted p-value threshold
  minSlope = -0.5,     # Filter out unrealistic slopes
  maxSlope = 1.5,
  selDeltaPT = 0.5     # Minimum change in translation
)
```

## Key Functions

- `anotaPerformQc`: Performs omnibus group effect tests and checks for influential data points and interactions.
- `anotaResidOutlierTest`: Generates Q-Q plots to assess if residuals follow a normal distribution.
- `anotaGetSigGenes`: The main analysis function. It calculates APV statistics and can apply the Random Variance Model (RVM).
- `anotaPlotSigGenes`: Generates per-gene regression plots and summary tables of significant findings.

## Tips for Success

- **Unrealistic Slopes:** Slopes < 0 or > 1 are biologically unlikely. Use the p-values for slopes provided in the output to flag or filter these genes.
- **RVM Fit:** If using `useRVM = TRUE`, check the F-distribution fit plot. If the empirical distribution deviates strongly from the theoretical one, RVM may not be appropriate for that specific normalization.
- **Normalization:** If QC fails (e.g., non-normal residuals), try different normalization or transformation methods. `anota` is sensitive to the data scale.
- **Sequencing Data:** While originally designed for microarrays, `anota` works with Ribosome Profiling (Ribo-seq) data provided it is properly normalized and log-transformed.

## Reference documentation
- [ANalysis Of Translational Activity (anota)](./references/anota.md)