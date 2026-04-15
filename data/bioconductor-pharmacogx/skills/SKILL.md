---
name: bioconductor-pharmacogx
description: PharmacoGx provides a unified framework for integrating and analyzing large-scale pharmacogenomic datasets. Use when user asks to integrate pharmacogenomic data into PharmacoSet objects, fit dose-response curves, compute IC50 and AUC metrics, or perform drug synergy analysis using reference models like Bliss, HSA, and Loewe.
homepage: https://bioconductor.org/packages/release/bioc/html/PharmacoGx.html
---

# bioconductor-pharmacogx

## Overview

PharmacoGx provides a unified framework for integrating and analyzing large pharmacogenomic datasets. It centers around the `PharmacoSet` (PSet) class, which coordinates cell line (sample) metadata, drug (treatment) metadata, molecular profiles (RNA, mutation, etc.), and drug dose-response data. The package is essential for biomarker discovery and drug synergy modeling in cancer research.

## Core Workflows

### 1. Working with PharmacoSet (PSet) Objects

A PSet is the primary container. While many are available via the `downloadPSet` function, you can construct custom ones using `PharmacoSet2`.

**Structure Requirements:**
*   **sample**: A data.frame with `sampleid` (rownames) and `tissueid`.
*   **treatment**: A data.frame with `treatmentid` (rownames).
*   **molecularProfiles**: A list of `SummarizedExperiment` objects or a `MultiAssayExperiment`.
*   **treatmentResponse**: A `CoreGx::TreatmentResponseExperiment` containing viability data.

```r
library(PharmacoGx)

# Basic constructor for PharmacoGx 2.0+
pset <- PharmacoSet2(
  name = "MyDataset",
  treatment = treatment_df,
  sample = sample_df,
  molecularProfiles = mae_object,
  treatmentResponse = tre_object,
  datasetType = "sensitivity"
)
```

### 2. Dose-Response Modeling

PharmacoGx provides robust functions to fit monotherapy curves and compute summary statistics.

```r
# Fit a log-logistic model
fit <- logLogisticRegression(doses, viabilities, viability_as_pct = FALSE)

# Compute summary metrics
ic50 <- computeIC50(doses, Hill_fit = fit)
auc <- computeAUC(doses, Hill_fit = fit)
```

### 3. Drug Synergy Analysis

For drug combination experiments, use the `endoaggregate` workflow to calculate synergy scores relative to null models.

**Reference Models:**
*   **HSA (Highest Single Agent)**: `computeHSA(v1, v2)`
*   **Bliss Independence**: `computeBliss(v1, v2)`
*   **Loewe Additivity**: `computeLoewe(d1, HS1, EC50_1, E_inf_1, d2, HS2, EC50_2, E_inf_2)`
*   **ZIP (Zero Interaction Potency)**: `computeZIP(...)`

**Workflow for Synergy:**
1.  **Normalize**: Ensure viability is relative to untreated controls [0, 1].
2.  **Fit Monotherapy**: Use `endoaggregate` to fit curves for individual drugs in the combination.
3.  **Merge**: Join monotherapy fit parameters back to the combination data.
4.  **Compute Scores**: Calculate the difference between observed viability and the reference model.

```r
# Example: Computing Bliss Synergy
tre_synergy <- tre_combo |>
    endoaggregate(
        assay = "combo_viability",
        Bliss_ref = computeBliss(viability_1, viability_2),
        by = assayKeys(tre_combo, "combo_viability")
    ) |>
    endoaggregate(
        assay = "combo_viability",
        Bliss_score = Bliss_ref - mean_viability,
        by = assayKeys(tre_synergy, "combo_viability")
    )
```

### 4. Visualization

Visualize synergy surfaces or heatmaps to identify dose-dependent interactions.

```r
# Synergy Surface (Contour Plot)
ggplot(synergy_df, aes(x = dose1, y = dose2, z = ZIP_delta)) +
    geom_contour_filled() +
    scale_x_log10() +
    scale_y_log10()
```

## Tips for Success

*   **Identifier Matching**: Ensure `sampleid` and `treatmentid` match exactly across all slots (sample, treatment, molecularProfiles, and treatmentResponse).
*   **Data Normalization**: Always truncate viability at 0 and ideally 1 (or 100%) before fitting curves to avoid artifacts in synergy calculation.
*   **Technical Replicates**: Use `endoaggregate` to summarize technical replicates (e.g., taking the mean) before performing curve fitting.
*   **Parallelization**: Many functions like `endoaggregate` support an `nthread` argument to speed up large-scale curve fitting.

## Reference documentation

- [Creating a PharmacoSet Object](./references/CreatingPharmacoSet.md)
- [Detecting Drug Synergy and Antagonism with PharmacoGx 3.0+](./references/DetectingDrugSynergyAndAntagonism.md)
- [PharmacoGx: An R Package for Analysis of Large Pharmacogenomic Datasets](./references/PharmacoGx.md)