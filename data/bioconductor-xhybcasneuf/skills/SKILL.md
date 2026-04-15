---
name: bioconductor-xhybcasneuf
description: This package provides data and tools to analyze cross-hybridization effects and off-target reporter sensitivity in Arabidopsis thaliana microarrays. Use when user asks to load cross-hybridization datasets, analyze the relationship between probe alignment scores and expression correlations, or visualize specific examples of off-target hybridization.
homepage: https://bioconductor.org/packages/release/data/experiment/html/XhybCasneuf.html
---

# bioconductor-xhybcasneuf

## Overview

The `XhybCasneuf` package is a data experiment package containing results from a study on cross-hybridization in microarrays (specifically the ATH1 Affymetrix GeneChip for *Arabidopsis thaliana*). It provides datasets to investigate how off-target reporters—probes that partially align to unintended transcripts—influence expression correlations. The package includes data for both standard Affymetrix CDFs and custom-made CDFs designed to alleviate cross-hybridization effects.

## Core Workflows

### Loading Data

The package provides several datasets representing different subsets of probe set pairs and their sensitivity scores.

```r
library(XhybCasneuf)

# Load all probe set pairs for Affymetrix and Custom CDFs
data(AffysTissue)
data(CustomsTissue)

# Load pairs excluding those with high sequence similarity (BLAST E-value < 10^-10)
data(AffysTissue.noBl)
data(CustomsTissue.noBl)

# Load metacorrelation data (reporter-level analysis)
data(AffysTissueMC)
data(CustomsTissueMC)
```

### Analyzing Off-Target Sensitivity

The primary metric for off-target affinity is the 75th percentile of alignment scores ($Q_{XY}^{75}$). You can analyze the relationship between this score (`alSum`) and the Pearson correlation coefficient (`peCC`).

A typical analysis involves binning the alignment scores and plotting them against expression correlation:

```r
# Define bins for alignment scores
myXs <- c(seq(55, 70, length.out = 3), seq(75, 125, length = 5))

# Example: Binning Affymetrix data
X_bins <- cut(AffysTissue$alSum, myXs, include.lowest = TRUE, right = TRUE)
# Plotting peCC (correlation) vs X_bins (alignment score)
boxplot(AffysTissue$peCC ~ X_bins, col = "skyblue2", ylim = c(-1, 1))
```

### Visualizing Specific Examples

The package includes an S4 class `XhybExamples` and a method `plotExample` to visualize specific cases of cross-hybridization.

```r
# Load and plot example 1, 2, or 3
data(ex1)
plotExample(ex1)
```

The resulting plots show:
- **Plot A**: Summarized expression values of probe set X and off-target gene Y.
- **Plot B**: Background-corrected, normalized signal profiles of X's reporters.
- **Plot C**: Pearson correlation between reporter signal profiles and Y's expression as a function of alignment score.

### Running Simulations

To demonstrate the effect of individual cross-hybridizing reporters on different summarization methods (Median Polish, dChip, Tukey's Biweight), use the simulation function:

```r
runSimulation()
```

This prints correlation coefficients to the console and generates plots showing how a few cross-hybridizing reporters can significantly skew the inferred expression of a probe set depending on the algorithm used.

## Key Data Structures

- **alSum**: The $Q_{XY}^{75}$ off-target sensitivity score.
- **peCC**: Pearson correlation coefficient between intensity values.
- **Mcor**: Metacorrelation between reporter alignment scores and their individual correlation to the off-target gene.

## Reference documentation

- [XhybCasneuf package](./references/Xhyb.md)