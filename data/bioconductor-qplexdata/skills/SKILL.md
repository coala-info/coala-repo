---
name: bioconductor-qplexdata
description: This package provides datasets and example workflows for analyzing qPLEX-RIME and total proteome data. Use when user asks to access experimental proteomics data for benchmarking, reproduce qPLEX-RIME analysis workflows, or load human protein annotation objects.
homepage: https://bioconductor.org/packages/release/data/experiment/html/qPLEXdata.html
---

# bioconductor-qplexdata

name: bioconductor-qplexdata
description: Provides datasets and example workflows for the analysis of qPLEX-RIME (Quantitative Proteomics of Endogenous Complexes by Rapid Immunoprecipitation Mass spectrometry of Endogenous proteins) and total proteome data. Use this skill to access experimental data from breast cancer cell lines (MCF7) and clinical tumor material (PDX and human breast cancer) for benchmarking or reproducing proteomics analysis workflows.

## Overview

The `qPLEXdata` package is a data-only experiment package that supports the `qPLEXanalyzer` ecosystem. It contains several datasets (Experiments 1-9) representing different biological contexts, including ER (Estrogen Receptor) interactomes, crosslinking comparisons, time-course treatments (OHT), and total proteome studies. These datasets are typically used to demonstrate differential expression analysis, normalization strategies, and regression techniques for proteomics data.

## Core Workflows

### Loading Data and Annotation

The package provides a standard human annotation object and multiple experimental datasets.

```r
library(qPLEXdata)
library(qPLEXanalyzer)
library(dplyr)

# Load human annotation
data(human_anno)

# Load a specific experiment (e.g., Experiment 1)
data(exp1_specificity)
```

### Converting to MSnSet

Data in `qPLEXdata` is often stored as a list containing `intensities` and `metadata`. You must convert these to an `MSnSet` object for use with `qPLEXanalyzer`.

```r
# Example for Experiment 1
MSnset_data <- convertToMSnset(
  exp1_specificity$intensities,
  metadata = exp1_specificity$metadata,
  indExpData = c(6:15),
  Sequences = 1,
  Accessions = 5
)
```

### Common Analysis Patterns

1. **Normalization**: Use `groupScaling` for RIME data (where IgG and bait samples have different distributions) or `normalizeScaling` for total proteome data.
2. **Aggregation**: Use `summarizeIntensities` to roll up peptide-level data to protein-level data using the `human_anno` object.
3. **Differential Analysis**: Define contrasts and use `computeDiffStats` followed by `getContrastResults`.

```r
# Group-based scaling (e.g., ER vs IgG)
MSnset_norm <- groupScaling(MSnset_data, median)

# Summarize to protein level
MSnset_Pnorm <- summarizeIntensities(MSnset_norm, sum, human_anno)

# Statistical testing
contrasts <- c(ER_vs_IgG = "ER - IgG")
diffstats <- computeDiffStats(MSnSetObj = MSnset_Pnorm, contrasts = contrasts)
results <- getContrastResults(diffstats = diffstats, contrast = contrasts)
```

### Handling Multiple Runs (Batch Effects)

For experiments spanning multiple TMT 10plex runs (like Experiment 3 or 4), datasets are combined using the `combine` function after updating feature labels and sample names.

```r
# Combine multiple MSnSet objects
MSnset_P1 <- updateFvarLabels(MSnset_P1)
MSnset_P2 <- updateFvarLabels(MSnset_P2)
MSnset_comb <- combine(MSnset_P1, MSnset_P2)

# Account for batch effects in differential analysis
batchEffect <- c("Run", "BioRep")
diffstats <- computeDiffStats(MSnset_comb, contrasts = contrasts, batchEffect = batchEffect)
```

### Regression Analysis

In complex interactome studies (e.g., Experiment 3), use `regressIntensity` to correct for bait dependency (e.g., ER levels) after filtering out non-specific binders identified via IgG comparison.

```r
# Regression on a specific protein (e.g., ESR1/P03372)
MSnset_reg <- regressIntensity(MSnset_subset, controlInd = IgG_indices, ProteinId = "P03372")
```

## Available Experiments

- **exp1_specificity**: ER interactome in MCF7 (ER vs IgG).
- **exp2_Xlink**: Comparison of DSG/FA (double) vs FA (single) crosslinking.
- **exp3_OHT_ESR1**: ER complex dynamics upon OHT treatment (2h, 6h, 24h).
- **exp4_OHT_FP**: Total proteome (Full Proteome) changes upon OHT treatment.
- **exp5_PDX**: ER interactome in Patient Derived Xenograft tumors.
- **exp6_ER**: ER interactome in primary human breast cancer tumors.
- **exp7_NCOA3 / exp8_CBP / exp9_PolII**: Interactomes for NCOA3, CBP, and RNA Polymerase II.

## Reference documentation

- [qPLEXdata](./references/qPLEXdata.md)