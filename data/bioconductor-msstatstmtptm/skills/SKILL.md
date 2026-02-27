---
name: bioconductor-msstatstmtptm
description: MSstatsTMTPTM detects differentially abundant post-translational modifications in TMT-labeled mass spectrometry experiments while adjusting for global protein abundance changes. Use when user asks to format PTM data, summarize protein and PTM abundances, perform adjusted statistical testing, or generate profile plots for quality control.
homepage: https://bioconductor.org/packages/3.12/bioc/html/MSstatsTMTPTM.html
---


# bioconductor-msstatstmtptm

## Overview

The `MSstatsTMTPTM` package is a Bioconductor tool designed for detecting differentially abundant post-translational modifications (PTMs) in shotgun mass spectrometry experiments using Tandem Mass Tag (TMT) labeling. Its primary strength lies in its ability to adjust PTM-level abundance changes for underlying global protein abundance changes, ensuring that observed PTM variations are not simply artifacts of protein expression shifts.

## Core Workflow

The standard workflow involves three main stages: data formatting, summarization, and statistical modeling.

### 1. Data Preparation
You must provide two separate datasets: one for PTM-enriched samples and one for global protein (non-enriched) samples. Both must be in the MSstatsTMT format.

*   **PTM Data:** The `ProteinName` column must include the modification site (e.g., `Protein_12_S703`).
*   **Protein Data:** The `ProteinName` column contains standard protein identifiers.

Required columns for both: `ProteinName`, `PeptideSequence`, `Charge`, `PSM`, `Mixture`, `TechRepMixture`, `Run`, `Channel`, `Condition`, `BioReplicate`, and `Intensity`.

### 2. Protein Summarization
Use the `MSstatsTMT` package to summarize both datasets to the protein/PTM level.

```r
library(MSstatsTMTPTM)
library(MSstatsTMT)

# Summarize PTM data
quant.ptm <- proteinSummarization(raw.ptm,
                                  method = "msstats",
                                  global_norm = TRUE,
                                  MBimpute = TRUE)

# Summarize Global Protein data
quant.protein <- proteinSummarization(raw.protein,
                                      method = "msstats",
                                      global_norm = TRUE,
                                      MBimpute = TRUE)
```

### 3. Statistical Testing (Adjustment)
The `groupComparisonTMTPTM` function performs the adjustment. It calculates the PTM change, the protein change, and the "Adjusted" change (PTM change minus Protein change).

```r
# Full pairwise comparison
model.results <- groupComparisonTMTPTM(data.ptm = quant.ptm,
                                       data.protein = quant.protein)

# Access results
ptm_model <- model.results$PTM.Model
protein_model <- model.results$Protein.Model
adjusted_model <- model.results$Adjusted.Model # Primary result of interest
```

## Visualization

### Profile and QC Plots
Use `dataProcessPlotsTMTPTM` to visualize the data before and after summarization.

```r
# Generate Profile Plots to identify variation sources
dataProcessPlotsTMTPTM(data.ptm = raw.ptm,
                       data.protein = raw.protein,
                       data.ptm.summarization = quant.ptm,
                       data.protein.summarization = quant.protein,
                       type = 'ProfilePlot',
                       address = FALSE) # FALSE displays in R window
```

### Volcano Plots
Use the base `MSstats` package to visualize the results from the adjusted model.

```r
library(MSstats)
groupComparisonPlots(data = model.results$Adjusted.Model,
                     type = 'VolcanoPlot',
                     address = FALSE)
```

## Key Considerations
*   **Adjustment Logic:** If a PTM increases but the parent protein also increases by the same amount, the "Adjusted" log2FC will be near zero. A significant adjusted result indicates the PTM change is independent of protein expression.
*   **Contrast Matrices:** You can define specific comparisons by passing a matrix to the `contrast.matrix` argument in `groupComparisonTMTPTM`.
*   **Moderation:** Set `moderated = TRUE` in `groupComparisonTMTPTM` to use moderated t-statistics (Empirical Bayes), which is generally recommended for better power in small sample sizes.

## Reference documentation

- [MSstatsTMTPTM Vignette](./references/MSstatsTMTPTM.Rmd)
- [MSstatsTMTPTM Workflow Guide](./references/MSstatsTMTPTM.Workflow.md)
- [MSstatsTMTPTM Package Documentation](./references/MSstatsTMTPTM.md)