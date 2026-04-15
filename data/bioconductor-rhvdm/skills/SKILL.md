---
name: bioconductor-rhvdm
description: This tool implements Hidden Variable Dynamic Modelling to predict transcription factor activity and identify target genes from time-course microarray data. Use when user asks to derive kinetic parameters, uncover hidden transcription factor activity profiles, or screen and rank potential target genes from biological time-series experiments.
homepage: https://bioconductor.org/packages/3.8/bioc/html/rHVDM.html
---

# bioconductor-rhvdm

name: bioconductor-rhvdm
description: Hidden Variable Dynamic Modelling (HVDM) for predicting transcription factor activity and identifying target genes from time-course microarray data. Use this skill when analyzing biological time-series data to derive kinetic parameters (basal rate, sensitivity, degradation) and rank potential targets of a specific transcription factor.

# bioconductor-rhvdm

## Overview

The `rHVDM` package implements Hidden Variable Dynamic Modelling to transform static gene expression measurements into dynamic insights. It uses a small set of known "training" genes to uncover the hidden activity profile of a transcription factor (TF) and then uses that profile to screen other genes for potential regulation. The model accounts for basal transcription, TF-induced sensitivity, and mRNA degradation.

## Core Workflow

### 1. Data Preparation
Data must be in an `ExpressionSet` object. Expression values should be raw (not log-transformed).

```R
library(rHVDM)
data(HVDMexample) # Loads fiveGyMAS5, p53traingenes, genestoscreen

# Ensure phenoData contains: 'replicate', 'time', and 'experiment'
# Check data compatibility
HVDMcheck(fiveGyMAS5)

# Estimate measurement errors if not already in se.exprs slot
# plattid can be "affy_HGU133A", "affy_HGU133Plus2", etc.
eset <- estimerrors(eset = fiveGyMAS5, plattid = "affy_HGU133A")
```

### 2. Training Step
Derive the hidden TF activity profile using a small set (3-5) of known targets.

```R
# degrate must be the independently measured degradation rate of the FIRST gene in the vector
tHVDM_results <- training(eset = fiveGyMAS5, 
                          genes = p53traingenes, 
                          degrate = 0.8, 
                          actname = "p53")

# Generate diagnostic HTML report
HVDMreport(tHVDM_results, name = "training_report")
```

### 3. Screening and Fitting
Apply the derived activity profile to individual genes or batches.

**Individual Gene Fit:**
```R
# Fit a single gene to see if it follows the TF profile
gene_fit <- fitgene(eset = fiveGyMAS5, 
                    gene = "205692_s_at", 
                    tHVDM = tHVDM_results)
HVDMreport(gene_fit)
```

**Batch Screening:**
```R
# Screen a list of candidate genes
screen_results <- screening(eset = fiveGyMAS5, 
                            genes = genestoscreen[1:50], 
                            HVDM = tHVDM_results)

# Extract putative targets based on thresholds
# Default: Z-score > 2.5, Model Score < 100
targets <- screen_results$results[screen_results$results$class1, ]
```

## Key Parameters and Interpretation

*   **Model Score:** Measures the "closeness" of the fit. High scores indicate the gene is likely not a target or is co-regulated by other factors.
*   **Sensitivity Z-score:** The primary predictor of TF dependency. Higher Z-scores indicate more reliable targets.
*   **Degradation Rate (Dj):** The rate at which the transcript is cleared.
*   **Basal Rate (Bj):** The TF-independent production rate.
*   **Sensitivity (Sj):** The strength of the gene's response to the TF activity.

## Tips for Success

*   **Anchoring:** Always provide an independently measured degradation rate (`degrate`) for the first training gene to prevent the model from becoming singular/unstable.
*   **Zero Time Point:** The experiment must include a zero time point for every replicate/experiment combination.
*   **Technical Error:** The model relies heavily on the `se.exprs` slot. If technical errors are unknown, use `estimerrors()` rather than arbitrary values.
*   **Hessian Matrix:** If the report shows a singular Hessian, the confidence intervals and Z-scores cannot be trusted. This often happens with "rogue" genes in the training set that do not actually follow the TF's activity.

## Reference documentation

- [rHVDM](./references/rHVDM.md)