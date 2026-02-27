---
name: bioconductor-spicyr
description: This package analyzes spatial relationships between cell types in multiplexed imaging data to identify changes in spatial organization across experimental conditions. Use when user asks to test for changes in cell-type localization, perform mixed-effects modeling of spatial metrics, or correlate spatial interactions with survival outcomes.
homepage: https://bioconductor.org/packages/release/bioc/html/spicyR.html
---


# bioconductor-spicyr

## Overview

The `spicyR` package provides a framework for analyzing spatial relationships between cell types in multiplexed imaging data (e.g., MIBI, IMC, CODEX). It uses the L-function (a variance-stabilized K-function) to quantify the degree of co-localization or dispersion between pairs of cell types. These spatial metrics are then used as response variables in weighted linear models or mixed-effects models to identify significant changes in spatial organization across experimental conditions or clinical outcomes.

## Installation and Setup

Install the package via BiocManager:

```r
if (!require("BiocManager")) install.packages("BiocManager")
BiocManager::install("spicyR")
```

**Important Bug Fix:** There is a known S4 method dispatch issue where `SpatialExperiment` objects may not correctly inherit from `SummarizedExperiment`. Run this fix before loading the library:

```r
library(SummarizedExperiment)
methods::setClassUnion("ExpData", c("matrix", "dgCMatrix", "ExpressionSet", "SummarizedExperiment"))
library(spicyR)
```

## Core Workflow

### 1. Basic Pairwise Testing

Use the `spicy()` function to test for changes in localization between conditions. By default, it tests all pairwise combinations.

```r
# Test all pairs across a condition column
spicyTest <- spicy(spe_object, condition = "group_column")

# View top significant results
topPairs(spicyTest)

# Test a specific pair
spicyTestPair <- spicy(spe_object, 
                       condition = "group_column", 
                       from = "CellType_A", 
                       to = "CellType_B")
```

### 2. Mixed-Effects Modelling

When multiple images are available per subject, specify the `subject` parameter to treat it as a random effect.

```r
spicyMixed <- spicy(spe_object, 
                    condition = "condition", 
                    subject = "subject_id")
```

### 3. Survival Analysis

To assess if spatial interactions correlate with survival, ensure the `colData` contains a `survival` column (a `Surv` object from the `survival` package).

```r
library(survival)
spe$survival <- Surv(spe$time, spe$event)
spicySurvival <- spicy(spe, condition = "survival")

# Access results
head(spicySurvival$survivalResults)
```

## Visualization

### Significance Bubble Plot
Visualize the coefficients and p-values for all pairwise interactions.

```r
signifPlot(spicyTest, 
           breaks = c(-3, 3, 1), 
           marksToPlot = c("TypeA", "TypeB", "TypeC"))
```

### Boxplots for Specific Pairs
Examine the distribution of the localization metric across conditions for a specific interaction.

```r
# By rank or by specific cell types
spicyBoxPlot(results = spicyTest, rank = 1)
spicyBoxPlot(results = spicyTest, from = "TypeA", to = "TypeB")
```

## Advanced Features

### Accounting for Tissue Inhomogeneity
To avoid false positives caused by dense clusters or irregular tissue architecture, use the `sigma` parameter to account for local intensity.

```r
# sigma = NULL assumes homogeneity; setting a value (e.g., 20) accounts for inhomogeneity
spicyInhomo <- spicy(spe, condition = "group", sigma = 20)
```

### Custom Metrics
You can use custom distance or abundance metrics (e.g., from `imcRtools`) by passing them to the `alternateResult` parameter.

```r
# Convert a kNN graph to an abundance matrix
pairAbundances <- convPairs(spe, colPair = "knn_interaction_graph")

# Run spicy with custom metrics
spicyCustom <- spicy(spe, 
                     condition = "group", 
                     alternateResult = pairAbundances, 
                     weights = FALSE)
```

## Tips for Success

- **Condition Levels:** `spicy()` uses the first level of the `condition` factor as the baseline. Relevel your factor if you want a specific comparison.
- **Image IDs:** Ensure your object has a column named `imageID` in `colData` to distinguish between different images.
- **Cell Type Column:** By default, `spicy` looks for a column named `cellType`. If your annotations are elsewhere, specify `cellType = "your_column_name"`.
- **Data Extraction:** Use `bind(spicyTest)` to extract the raw L-function metrics for each image into a data frame for custom downstream analysis.

## Reference documentation

- [Spatial Linear and Mixed-Effects Modelling with spicyR](./references/spicyR.md)