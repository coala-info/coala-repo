---
name: bioconductor-stepnorm
description: This tool performs stepwise and sequential normalization for cDNA microarray data to correct for systematic biases. Use when user asks to perform location normalization on two-color microarrays, apply sequential or stepwise procedures using AIC or BIC criteria, or correct for intensity, print-tip, plate, and spatial biases.
homepage: https://bioconductor.org/packages/release/bioc/html/stepNorm.html
---


# bioconductor-stepnorm

name: bioconductor-stepnorm
description: Stepwise normalization for cDNA microarray data. Use this skill to perform location normalization on two-color microarrays, including sequential and stepwise procedures that account for intensity (A), print-tip (PT), plate (PL), and spatial (2D) biases using AIC or BIC criteria.

## Overview
The `stepNorm` package provides advanced normalization techniques for cDNA microarrays. Unlike standard global normalization, it allows for a stepwise approach where multiple sources of systematic variation (intensity-dependent, print-tip, plate-specific, and spatial) are evaluated and corrected using model selection criteria like AIC or BIC. It builds upon the `marray` package classes (`marrayRaw`, `marrayNorm`).

## Core Functions

### Single-Step Normalization
Use `withinNorm` for a wrapper around standard normalization procedures:
```R
# Apply loess normalization to the first slide
res <- withinNorm(swirl[,1], norm="loess", span=0.4)

# Options include: "median", "rlm", "loess", "medianPrintTip", 
# "rlmPrintTip", "loessPrintTip", "medianPlate", "aov2D", "rlm2D", "spatialMedian"
```

### Sequential Normalization
Use `seqWithinNorm` to apply corrections in a fixed order (A -> PT -> PL -> Spatial2D) without automatic model selection:
```R
# Default: loess(A) -> median(PT) -> median(PL) -> none(Spatial2D)
res <- seqWithinNorm(swirl[,1], A="loess", PT="median", PL="median")
norm_data <- res$normdata
```

### Stepwise Normalization
Use `stepWithinNorm` to automatically select the best model at each step based on AIC or BIC:
```R
# 1. Create a list of candidate models for each bias
wf_loc <- makeStepList(
  A = c("median", "rlm", "loess"),
  PT = c("median", "rlm"),
  PL = NULL,
  Spatial2D = c("rlm2D", "loess2D")
)

# 2. Run stepwise normalization
res <- stepWithinNorm(swirl[,1], wf.loc = wf_loc, criterion = "BIC")

# 3. Access results
norm_data <- res$normdata
selection_summary <- res$res # Dataframe of chosen models and scores
```

## Workflow for cDNA Microarrays

1.  **Data Preparation**: Ensure data is in `marrayRaw` or `marrayNorm` format (e.g., from the `marray` package).
2.  **Plate ID Generation**: If plate information is missing or has empty spots, use `maCompPlate2`:
    ```R
    # Generate plate IDs for a 384-well setup
    compPlate <- maCompPlate2(n=384)
    plateIDs <- compPlate(swirl@maLayout)
    ```
3.  **Model Selection**:
    *   Use `calcAIC(fit)` or `calcBIC(fit)` to manually evaluate the goodness of fit for `marrayFit` objects.
    *   Lower values indicate a better balance between fit and parsimony.
4.  **Spatial Normalization**: For slides with visible spatial gradients, use `fit2DWithin` with `fun="spatialMedfit"` or `"loess2Dfit"`.

## Reference documentation
- [stepNorm Reference Manual](./references/reference_manual.md)