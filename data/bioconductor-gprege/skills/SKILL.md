---
name: bioconductor-gprege
description: This tool analyzes biological time-series expression data using Gaussian process regression models. Use when user asks to rank differential expression in time-series data, identify transcription factor target genes, or filter quiet genes.
homepage: https://bioconductor.org/packages/3.8/bioc/html/gprege.html
---


# bioconductor-gprege

name: bioconductor-gprege
description: Analysis of microarray time series using Gaussian process regression models. Use this skill to filter quiet genes and rank differential expression in time-series expression data, specifically for identifying target genes of transcription factors.

# bioconductor-gprege

## Overview

The `gprege` package implements Gaussian process (GP) regression models to analyze biological time-series data. It is primarily used to quantify and rank differential expression by comparing a GP model (which captures temporal trends) against a null model (which assumes no change over time). This approach is particularly effective for identifying direct targets of transcription factors from microarray or RNA-seq time-course experiments.

## Core Workflow

### 1. Data Preparation
The package expects expression data as a matrix where rows are genes and columns are time points.

```R
library(gprege)

# Load example data (TP63 microarray fragment)
data(FragmentDellaGattaData)

# Inputs (time points) must be a column matrix
tTrue <- matrix(seq(0, 240, by = 20), ncol = 1)

# Expression matrix (rows = genes, cols = time points)
# Example: exprs_tp63_RMA
```

### 2. Configuring Options
The `gprege` function is controlled by a list of options.

```R
gpregeOptions <- list()
gpregeOptions$explore <- FALSE       # Set TRUE for interactive mode (plots each gene)
gpregeOptions$iters <- 100           # SCG optimization iterations
gpregeOptions$display <- FALSE       # Suppress optimization messages

# Define initialization hyperparameters: [inverse-lengthscale, signal-variance, noise-variance]
gpregeOptions$inithypers <- matrix(c(
  1/1000, 1e-3, 0.999,
  1/30,   0.999, 1e-3,
  1/80,   2/3,   1/3
), ncol = 3, byrow = TRUE)
```

### 3. Running the Analysis
The main function `gprege` performs the regression and calculates ranking scores based on the log-marginal likelihood (LML) ratio.

```R
# Run ranking on the dataset
gpregeOutput <- gprege(data = exprs_tp63_RMA, inputs = tTrue, gpregeOptions = gpregeOptions)

# Access ranking scores (Log-ratio of GP model vs Null model)
# Higher scores indicate stronger evidence of differential expression
scores <- gpregeOutput$rankingScores
```

### 4. Evaluation and Visualization
If ground truth labels are available (e.g., from another method like TSNI), you can evaluate performance using ROC curves.

```R
# Compare performance against ground truth or other methods
# groundTruthLabels: boolean vector where TRUE = differentially expressed
compareROC(output = gpregeOutput$rankingScores, 
           groundTruthLabels = DGatta_labels_byTSNItop100)
```

## Interactive Exploration
To visualize the GP fit for specific genes, set `explore = TRUE`. This will generate plots showing:
- The GP fit across different initializations.
- The Log-marginal likelihood (LML) contour.
- The final GP fit with optimized hyperparameters.

```R
gpregeOptions$explore <- TRUE
gpregeOptions$indexRange <- 1:5  # Explore only the first 5 genes
gprege(data = exprs_tp63_RMA, inputs = tTrue, gpregeOptions = gpregeOptions)
```

## Key Functions
- `gprege()`: Main function for GP regression and ranking.
- `compareROC()`: Generates ROC curves and calculates AUC for ranking validation.
- `exhaustivePlot()`: (Internal/Interactive) Plots the LML surface for hyperparameter optimization.

## Reference documentation
- [gprege Quick Guide](./references/gprege_quick.md)