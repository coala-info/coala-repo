---
name: bioconductor-macorrplot
description: This package provides a graphical diagnostic tool to assess the quality of microarray normalization by plotting the correlation of random gene pairs against their average standard deviation. Use when user asks to evaluate normalization quality, identify systematic bias in expression data, or compare different normalization methods like RMA and MAS5.
homepage: https://bioconductor.org/packages/release/bioc/html/maCorrPlot.html
---

# bioconductor-macorrplot

## Overview

The `maCorrPlot` package provides a graphical diagnostic tool to assess the quality of microarray normalization. It is based on the principle that random pairs of genes should, on average, have zero correlation. If a plot shows a significant non-zero average correlation (especially for low-variance genes), it indicates a failure in the normalization process (e.g., RMA or MAS5 artifacts).

## Basic Workflow

### 1. Data Preparation
The package expects a matrix of expression values (log-transformed) where rows are genes and columns are samples.

```r
library(maCorrPlot)
data(oligodata) # Loads example datasets: datA.rma, datA.mas5, etc.

# Example: Check dimensions (e.g., 5000 genes, 30 samples)
dim(datA.rma)
```

### 2. Sampling Gene Pairs
Use `CorrSample` to compute correlations and standard deviations for a random subset of gene pairs.

```r
# np: number of random pairs
# seed: for reproducibility
corrA.rma <- CorrSample(datA.rma, np=1000, seed=213)
```

### 3. Visualizing Results
The `plot` method for `CorrSample` objects displays the average correlation (y-axis) against the average standard deviation (x-axis).

```r
# Basic plot
plot(corrA.rma)

# Advanced plot with individual points and a theoretical model curve
plot(corrA.rma, scatter=TRUE, curve=TRUE)
```
*   **Interpretation**: If the confidence intervals (vertical bars) do not cross the zero-correlation line, there is evidence of systematic bias in normalization.

## Advanced Usage

### Comparing Normalization Methods
You can pass multiple `CorrSample` objects to a single plot call to compare different algorithms (e.g., MAS5 vs. RMA).

```r
corrA.mas5 <- CorrSample(datA.mas5, np=1000, seed=213)

# Compare using labels
plot(corrA.mas5, corrA.rma, cond=c("MAS5", "RMA"))

# Nested comparison (e.g., 2 datasets x 2 methods)
plot(corrA.mas5, corrA.rma, corrB.mas5, corrB.rma, 
     cond=list(c("MAS5","RMA","MAS5","RMA"), c("A","A","B","B")))
```

### Grouping by Gene Characteristics
You can investigate if specific groups of genes (e.g., those with "Absent" calls) drive the spurious correlations using the `groups` argument.

```r
# Calculate number of 'Present' calls per gene
pcntA <- rowSums(datA.amp == "P")

# Calculate average present calls for the sampled pairs
pcntA.pairs <- (pcntA[corrA.rma$ndx1] + pcntA[corrA.rma$ndx2]) / 2

# Create groups (e.g., Low, Medium, High presence)
pgrpA.pairs <- cut(pcntA.pairs, c(0, 10, 20, 30), include.lowest=TRUE)

# Plot with groups and a legend
plot(corrA.rma, groups=pgrpA.pairs, auto.key=TRUE)
```

## Tips and Caveats
*   **Large Arrays Only**: This diagnostic is designed for high-density arrays (e.g., HGU133A). It may not be valid for "boutique" or small-scale arrays where the assumption of zero average correlation might not hold.
*   **Lattice Integration**: The `plot` method is based on `lattice` (specifically `xyplot`). You can pass standard lattice arguments like `ylim`, `xlim`, or `nint` (number of intervals for averaging) to customize the output.
*   **Normalization Quality**: This tool detects normalization artifacts but does not measure the biological accuracy of fold-change estimates.

## Reference documentation
- [maCorrPlot](./references/maCorrPlot.md)