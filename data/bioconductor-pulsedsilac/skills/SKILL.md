---
name: bioconductor-pulsedsilac
description: This package analyzes protein turnover and degradation rates from pulsed SILAC mass spectrometry data using specialized S4 classes. Use when user asks to manage SilacProteinExperiment objects, calculate isotope fractions, fit kinetic models to estimate protein half-lives, or filter time-series proteomics data.
homepage: https://bioconductor.org/packages/3.10/bioc/html/pulsedSilac.html
---


# bioconductor-pulsedsilac

## Overview

The `pulsedSilac` package provides a framework for analyzing protein turnover using mass spectrometry data from pulsed SILAC experiments. In these experiments, cells are switched from light to heavy amino acid media, and samples are collected over a time series. This skill helps manage the specialized S4 classes (`SilacProteinExperiment`, `SilacPeptideExperiment`, and `SilacProteomicsExperiment`) used to store this data and the workflows for fitting kinetic models to estimate degradation rates and half-lives.

## Data Organization

The package uses three main classes derived from `SummarizedExperiment`. A key feature is the `metaoptions` slot, which stores column names for conditions, timepoints, and IDs to simplify function calls.

### Creating Objects

```r
library(pulsedSilac)

# Protein level
protExp <- SilacProteinExperiment(
  assays = list(expression = protein_matrix),
  rowData = protein_metadata,
  colData = sample_metadata,
  conditionCol = "condition",
  timeCol = "time"
)

# Peptide level
peptExp <- SilacPeptideExperiment(
  assays = list(expression = peptide_matrix),
  rowData = peptide_metadata,
  colData = sample_metadata,
  conditionCol = "condition",
  timeCol = "time",
  proteinCol = "protein_id" # Links peptides to proteins
)

# Combined Proteomics Experiment
# Use buildLinkerDf to define the many-to-many relationship
linker <- buildLinkerDf(protIDs, pepIDs, protToPepList)
multiExp <- SilacProteomicsExperiment(protExp, peptExp, linkerDf = linker)
```

### Accessors and Subsetting
*   `metaoptions(obj)`: Access or set the metadata options.
*   `assaysProt(multiExp)` / `assaysPept(multiExp)`: Access specific levels in a combined object.
*   `subsetProt()` / `subsetPep()`: Subset the combined object while maintaining links if `metaoptions(multiExp)$linkedSubset` is `TRUE`.

## Typical Workflow

### 1. Filtering
Filter features based on measurement frequency across the time series.
```r
# Keep proteins measured in at least 5 out of 7 timepoints
filteredExp <- filterByMissingTimepoints(wormsPE, assayName = "ratio", maxMissing = 2)
```

### 2. Ratio and Fraction Calculation
Convert raw intensities into the fractions used for modeling.
```r
# Calculate Heavy/(Heavy + Light)
wormsPE <- calculateIsotopeRatio(wormsPE, newIsotopeAssay = "int_heavy", oldIsotopeAssay = "int_light")
wormsPE <- calculateIsotopeFraction(wormsPE, ratioAssay = "ratio")
```

### 3. Modeling Turnover
Fit kinetic models (usually exponential decay) to the fraction data.
```r
# Fit: fraction ~ 1 - exp(-k * t)
modelList <- modelTurnover(
  x = wormsPE,
  assayName = "fraction",
  formula = "fraction ~ 1 - exp(-k * t)",
  start = list(k = 0.02),
  mode = "protein",
  robust = TRUE, # Uses nlrob for outlier resistance
  returnModel = TRUE
)

# Calculate half-life from the rate constant k
modelList$half_life <- log(0.5) / (-modelList$param_values$k)
```

### 4. Visualization
*   `plotDistributionAssay(obj, assayName = "fraction")`: Check global incorporation trends.
*   `plotIndividualModel(obj, modelList, num = 1)`: Visualize the fit for a specific protein.
*   `plotDistributionModel(modelList, value = "half_life")`: Compare half-life distributions between conditions.
*   `scatterCompareModels(modelList, conditions = c("A", "B"), value = "param_values")`: Compare rate constants per protein.

## Advanced Analysis

### Cell Growth Correction
If cells are dividing, the apparent turnover includes biomass dilution.
1.  Identify stable proteins using `mostStable()`.
2.  Estimate doubling time (`tc`) using `modelTurnover` on those stable proteins.
3.  Incorporate the growth constant into the final turnover formula: `fraction ~ 1 - exp(-( (log(2)/tc) + k) * t)`.

### Model Comparison
Compare different kinetic models (e.g., with or without an offset `b`) using AIC.
```r
modelList1 <- calculateAIC(modelList1, smallSampleSize = TRUE)
modelList2 <- calculateAIC(modelList2, smallSampleSize = TRUE)
probList <- compareAIC(modelList1, modelList2)
```

## Reference documentation
- [Pulsed-SILAC data analysis](./references/pulsedsilac.md)