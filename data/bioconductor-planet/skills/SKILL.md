---
name: bioconductor-planet
description: This package provides specialized tools for analyzing placental DNA methylation data, including cell type deconvolution and tissue-specific epigenetic clocks. Use when user asks to estimate placental cell type proportions, predict gestational age using placental clocks, determine ethnicity from DNAm patterns, or identify probabilities of early-onset preeclampsia.
homepage: https://bioconductor.org/packages/release/bioc/html/planet.html
---


# bioconductor-planet

## Overview
The `planet` package provides tools for the analysis of placental DNA methylation data. It implements specialized "clocks" and references specifically derived from placental tissue, which are more accurate than general-purpose blood-based methods. Key capabilities include cell type deconvolution (estimating proportions of trophoblasts, stromal cells, etc.), predicting gestational age using three distinct placental clocks, predicting ethnicity, and identifying probabilities of early-onset preeclampsia (EOPE).

## Installation
```r
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("planet")
```

## Typical Workflows

### 1. Cell Composition Deconvolution
To estimate cell types in placental villi, use placental-specific reference CpGs.
*   **References:** `plCellCpGsThird` (term) or `plCellCpGsFirst` (first trimester).
*   **Method:** Use `minfi` or `EpiDISH` with the reference matrix.

```r
library(planet)
library(minfi)
data("plBetas") # Example DNAm data
data("plCellCpGsThird") # Reference for term placenta

# Using minfi approach
estimates <- minfi:::projectCellType(
  plBetas[rownames(plCellCpGsThird), ],
  plCellCpGsThird,
  lessThanOne = FALSE
)
```

### 2. Predicting Gestational Age
`planet` implements three placental clocks from Lee et al. (2019):
1.  **RPC** (Robust Placental Clock): Best for general use.
2.  **CPC** (Control Placental Clock): Derived from healthy controls.
3.  **RRPC** (Refined Robust Placental Clock): Optimized for specific variance.

```r
# Predict age for all three types
ga_results <- data.frame(
  RPC = predictAge(plBetas, type = "RPC"),
  CPC = predictAge(plBetas, type = "CPC"),
  RRPC = predictAge(plBetas, type = "RRPC")
)
```

### 3. Ethnicity Prediction
Predicts ethnicity (African, Asian, Caucasian) based on placental DNAm patterns.

```r
# Returns probabilities and classifications
ethnicity_preds <- predictEthnicity(plBetas)

# Classification with 0.75 threshold (default)
# Samples below threshold are labeled 'Ambiguous'
table(ethnicity_preds$Predicted_ethnicity)
```

### 4. Early-Onset Preeclampsia (EOPE) Prediction
Calculates the probability that a sample exhibits DNAm signatures of EOPE.
*   **Requirement:** Input must be a matrix where samples are rows and CpGs are columns.
*   **Normalization:** BMIQ normalization is highly recommended before running this function.

```r
# Requires all 45 predictive CpGs to be present
# x_test should be a matrix (Samples x CpGs)
eope_preds <- predictPreeclampsia(x_test)
```

## Usage Tips
*   **Data Normalization:** For best results, normalize DNAm data using `minfi::preprocessNoob` followed by `BMIQ`.
*   **Missing CpGs:** Functions like `predictAge` and `predictEthnicity` will report how many required CpGs were found. If a large percentage is missing, prediction accuracy will decrease.
*   **EOPE Input Format:** Unlike many Bioconductor tools that expect CpGs in rows, `predictPreeclampsia` expects **Samples in rows and CpGs in columns**.
*   **Ambiguous Ethnicity:** If a sample is labeled "Ambiguous", consider adjusting for raw probabilities in downstream differential methylation analysis rather than using the categorical label.

## Reference documentation
- [planet Vignette (Rmd)](./references/planet.Rmd)
- [planet Vignette (Markdown)](./references/planet.md)