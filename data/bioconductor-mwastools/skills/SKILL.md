---
name: bioconductor-mwastools
description: This tool provides a comprehensive pipeline for performing Metabolome-Wide Association Studies on large-scale metabonomic datasets. Use when user asks to perform quality control on metabolic data, run association models adjusted for confounders, visualize results via skyline plots, identify metabolites using STOCSY, or map findings to KEGG pathways.
homepage: https://bioconductor.org/packages/release/bioc/html/MWASTools.html
---

# bioconductor-mwastools

name: bioconductor-mwastools
description: Comprehensive pipeline for Metabolome-Wide Association Studies (MWAS). Use when analyzing metabonomic data (NMR or MS) to perform quality control (PCA, CV filtering), run association models (logistic/linear regression) adjusted for epidemiological confounders, visualize results via skyline plots, identify metabolites using STOCSY, and map findings to KEGG pathways.

# bioconductor-mwastools

## Overview
MWASTools provides an integrated workflow for analyzing large-scale metabonomic datasets. It bridges the gap between raw metabolic profiles and biological interpretation by offering tools for data quality assessment, robust statistical modeling (accounting for confounders like age and BMI), and metabolite identification. It is particularly optimized for 1H NMR data but applicable to other metabolic profiling platforms.

## Core Workflow

### 1. Data Preparation
Store metabolic and clinical data in a `SummarizedExperiment` object.
```r
library(MWASTools)
# Create or load a SummarizedExperiment object
# metabolic_data: features (rows) x samples (cols)
# clinical_data: samples (rows) x variables (cols)
data("metabo_SE") 
```

### 2. Quality Control (QC)
Perform PCA to detect batch effects and calculate Coefficient of Variation (CV) to assess reproducibility.
```r
# PCA for batch effect detection
PCA_model = QC_PCA(metabo_SE, scale = FALSE, center = TRUE)
QC_PCA_scoreplot(PCA_model, metabo_SE)

# CV analysis and filtering
metabo_CV = QC_CV(metabo_SE, plot_hist = TRUE)
# Filter features with CV > 30%
metabo_SE_filtered = CV_filter(metabo_SE, metabo_CV, CV_th = 0.3)
```

### 3. Metabolome-Wide Association Analysis
Run association models adjusted for confounders. Supported methods include "logistic", "linear", "pearson", and "spearman".
```r
# Run logistic regression adjusted for Age, Gender, and BMI
MWAS_results = MWAS_stats(metabo_SE_filtered, 
                         disease_id = "T2D",
                         confounder_ids = c("Age", "Gender", "BMI"), 
                         assoc_method = "logistic",
                         mt_method = "BH") # Multiple testing correction
```

### 4. Visualization
Generate "skyline" plots to visualize the association of metabolic features across the spectrum.
```r
# Visualize p-values and estimates across the NMR spectrum
skyline = MWAS_skylineNMR(metabo_SE_filtered, MWAS_results, ref_sample = "QC1")
```

### 5. Metabolite Identification (STOCSY)
Use Statistical Total Correlation Spectroscopy (STOCSY) to identify unknown NMR signals by looking for correlations with a driver signal.
```r
# Query a specific ppm value to find correlated signals
stocsy_results = STOCSY_NMR(metabo_SE, ppm_query = 1.04)
```

### 6. Biological Interpretation
Map metabolites of interest (using KEGG IDs) to biological pathways.
```r
# Map valine (C00183) and isoleucine (C00407)
kegg_pathways = MWAS_KEGG_pathways(metabolites = c("cpd:C00183", "cpd:C00407"))
```

## Tips and Best Practices
- **Confounder Adjustment**: Always include relevant clinical variables (age, sex, BMI) in `MWAS_stats` to avoid spurious associations common in epidemiological studies.
- **CV Thresholds**: Use a CV threshold of 0.30 for biomarker discovery and 0.15 for strict quantification, following FDA guidelines.
- **SummarizedExperiment**: Ensure your input object has `sample_type` defined in `colData` (e.g., "experimental" and "QC") for the QC functions to work correctly.
- **Bootstrapping**: For model validation, consider using the bootstrapping capabilities available within the package to ensure the robustness of identified biomarkers.

## Reference documentation
- [MWASTools](./references/MWASTools.md)