---
name: bioconductor-gispa
description: GISPA defines and ranks gene sets that satisfy a predefined molecular profile across three sample classes by integrating up to three different genomic features. Use when user asks to identify gene sets with specific multi-omic profiles, integrate RNA-seq and DNA copy number data, or rank genes based on their support for a molecular profile using change-point analysis.
homepage: https://bioconductor.org/packages/3.8/bioc/html/GISPA.html
---

# bioconductor-gispa

## Overview

GISPA (Gene Integrated Set Profile Analysis) is a method for defining gene sets that satisfy a predefined molecular profile across three sample classes. It allows for the integration of one, two, or three different genomic features (e.g., RNA-seq expression, DNA copy number, somatic variants). The core strength of GISPA is its ability to rank genes based on how well they support a specific profile in a "Reference" sample compared to two "Comparison" samples, using change-point analysis to identify the most significant gene sets.

## Typical Workflow

### 1. Data Preparation
GISPA requires data as `ExpressionSet` objects. Rows must represent genes (or genomic features) and columns must represent samples.
- **Overlap:** For multi-feature analysis, gene names must overlap across all data types.
- **Minimums:** At least 10 genes and exactly three sample classes are required.
- **Reference Sample:** You must identify the index of the sample of interest (Reference) and the indices of the two comparison samples.

```R
library(GISPA)
# Load example data (exprset, varset, cnvset)
data(GISPAdata) 

# Check indices for your groups
# ref.samp.idx: index of the sample of interest
# comp.samp.idx: indices of the two comparison samples
```

### 2. Running the Analysis
The `GISPA` function is the primary entry point. You specify the number of features, the data sets, and the desired profile ("up" or "down") for each.

**Two-Feature Example (Up-regulated Expression and Copy Gain):**
```R
results <- GISPA(
  feature = 2, 
  f.sets = c(exprset, cnvset), 
  ref.samp.idx = 1, 
  comp.samp.idx = c(2, 3),
  f.profiles = c("up", "up"),
  cpt.method = "BinSeg", # Change-point method: AMOC, BinSeg, PELT, or SeqNeigh
  cpt.max = 5            # Max number of change points
)
```

### 3. Visualizing and Interpreting Results
GISPA provides several plotting functions to evaluate the identified gene sets.

**Slope Plot:** Shows the level of support for the profile across different change points.
```R
cptSlopeplot(gispa.output = results, feature = 2, type = c("EXP", "CNV"))
```

**Stacked Barplot (Sample Contribution):** Visualizes which samples are driving the profile for the top-ranked gene set (Change Point 1).
```R
stackedBarplot(
  gispa.output = results, 
  feature = 2, 
  cpt = 1, 
  type = c("EXP", "CNV"),
  samp.col = c("red", "green", "blue")
)
```

**Proportion Barplot (Feature Contribution):** Shows the percent contribution of each data type (e.g., is the profile driven more by Expression or CNV?).
```R
propBarplot(gispa.output = results, feature = 2, cpt = 1)
```

## Key Parameters
- `feature`: 1, 2, or 3 (number of data types to integrate).
- `f.sets`: A vector of `ExpressionSet` objects.
- `f.profiles`: A vector of "up" or "down" strings corresponding to each feature.
- `cpt.method`: The method for detecting change points in the profile scores. "BinSeg" is often a robust default.
- `cpt.data`: Usually set to "var" or "mean" to find changes in variance or mean of the profile scores.

## Reference documentation
- [GISPA Manual](./references/GISPA_manual.md)