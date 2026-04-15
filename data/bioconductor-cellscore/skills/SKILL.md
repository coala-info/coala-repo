---
name: bioconductor-cellscore
description: This tool evaluates cell identity and differentiation success by comparing test samples to target and donor cell types using the CellScore method. Use when user asks to calculate CellScore values, assess the identity of engineered cells, determine Likelihood Ratios for cell transitions, or visualize differentiation success.
homepage: https://bioconductor.org/packages/release/bioc/html/CellScore.html
---

# bioconductor-cellscore

name: bioconductor-cellscore
description: Evaluation of cell identity and differentiation using the CellScore method. Use this skill when you need to calculate CellScore values to assess the identity of engineered cells (i.e., derived from iPSCs or transdifferentiation) compared to their target tissue and starting cell types. This includes calculating the Likelihood Ratio (LR) and the CellScore to quantify how much a test sample resembles a target cell type versus a donor cell type.

# bioconductor-cellscore

## Overview
The `CellScore` package provides a standardized method to evaluate the success of cell transitions (differentiation or reprogramming). It uses a reference dataset of "Target" cells (the goal) and "Donor" cells (the starting point) to calculate a score for "Test" samples. The scoring system relies on two main metrics:
1.  **Likelihood Ratio (LR)**: Measures how much more likely a sample is to be the target cell type than the donor cell type.
2.  **CellScore**: A combined metric (0 to 1) that accounts for both the transition away from the donor state and the acquisition of the target state.

## Typical Workflow

### 1. Data Preparation
The package requires a `Biobase::ExpressionSet` containing log-normalized expression data. You also need a data frame defining the phenotype (pData) with specific columns.

```r
library(CellScore)

# Required columns in pData(eset):
# - SampleName: Unique identifier
# - ExperimentID: Study ID
# - Dataset: Grouping (e.g., "Target", "Donor", "Test")
# - CellType: Specific cell identity
```

### 2. Generating the Reference Surface
Before scoring, you must define the standard for the transition using known donor and target samples.

```r
# 1. Filter for relevant genes (optional but recommended)
# 2. Calculate the reference surface
# target.cell: The string naming the desired cell type
# donor.cell: The string naming the starting cell type
cellscore.res <- CellScore(
  bin.fres = eset, 
  target.cell = "Hepatocyte", 
  donor.cell = "Fibroblast"
)
```

### 3. Calculating Scores
The `CellScore` function returns a list containing the scores for all samples in the ExpressionSet.

```r
# Extract the scores data frame
scores <- cellscore.res$test.scores

# Key columns:
# - LikelihoodRatio: Positive values favor Target, negative favor Donor.
# - CellScore: Values near 1 indicate successful transition; near 0 indicate failure.
```

### 4. Visualization
The package provides specific plotting functions to evaluate the transition.

```r
# Scatter plot of Likelihood Ratio vs CellScore
plotCellScore(cellscore.res, sub="My Experiment")

# Heatmap of the marker genes used for the score
plotViperLogLike(cellscore.res)
```

## Key Functions
- `CellScore()`: The primary function to calculate likelihood ratios and cell scores.
- `P_Value_cal()`: Calculates p-values for the CellScore to determine statistical significance of the identity match.
- `extractStandard()`: Utility to extract the internal standards used for the calculation.

## Tips for Success
- **Reference Selection**: The accuracy of the CellScore depends heavily on having high-quality, representative "Donor" and "Target" samples in your dataset.
- **Normalization**: Ensure your input `ExpressionSet` is properly normalized (e.g., RMA or VST) and log-transformed before running `CellScore`.
- **Interpretation**: A high Likelihood Ratio with a low CellScore suggests the sample has left the donor state but has not yet fully reached the target state (incomplete differentiation).

## Reference documentation
- [CellScore Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/CellScore.html)