---
name: bioconductor-spktools
description: This tool analyzes and visualizes microarray spike-in data to compare expression measures across different platforms. Use when user asks to assess accuracy through signal detection slopes, evaluate precision via log-ratio distributions, calculate performance metrics like Probability of being at the Top, or generate MA plots for spike-in experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/spkTools.html
---


# bioconductor-spktools

name: bioconductor-spktools
description: Tools for analyzing and visualizing microarray spike-in data to compare expression measures across different platforms. Use this skill when you need to assess accuracy (signal detection slopes), precision (SD of log-ratios), and performance (Probability of being at the Top - POT) of microarray data using spike-in experiments.

## Overview
The `spkTools` package provides a consolidated strategy for the analysis of microarray spike-in data. It introduces the `SpikeInExpressionSet` class, which extends the standard Bioconductor `ExpressionSet` to include nominal concentrations of spiked-in transcripts. The package allows for cross-platform comparisons by mapping nominal concentrations to Average Log Expression (ALE) values, stratifying results into Low, Medium, and High expression bins.

## Core Workflow

### 1. Data Preparation
To use `spkTools`, data must be formatted as a `SpikeInExpressionSet`. This object contains the expression matrix and the metadata for spiked-in concentrations.

```R
library(spkTools)
data(affy) # Example dataset provided by the package
object <- affy
```

### 2. Accuracy Assessment
The signal detection slope measures how well observed intensities track with nominal concentrations. A slope of 1 is optimal.

```R
# Calculate slopes and identify ALE strata
# label: string for plot titles; pch: plotting character
spkSlopeOut <- spkSlope(object, label="MyExperiment", pch="+")

# Visualize ALE strata and background density
spkDensity(object, spkSlopeOut, cuts=TRUE, label="MyExperiment")
```

### 3. Precision and Specificity
Assess the variability of log-ratios where the true fold change is zero (Null set) or a known value.

```R
# Calculate log-ratio distributions for a specific fold change (e.g., fc=2)
fc <- 2
spkBoxOut <- spkBox(object, spkSlopeOut, fc)

# Plot the distributions across ALE strata
plotSpkBox(spkBoxOut, fc, ylim=c(-1.5, 2.5))

# Summary statistics for precision
sbox <- summarySpkBox(spkBoxOut)
```

### 4. Performance Metrics
Combine accuracy and precision into practical summaries like the Probability of being at the Top (POT).

```R
# Calculate Accuracy SD
AccuracySD <- spkAccSD(object, spkSlopeOut)

# Calculate POT (Probability of being in the top 100 genes for a fold change of 2)
pot <- spkPot(object, spkSlopeOut, spkSlopeOut$slopes[-1], AccuracySD, precisionQuantile=0.995)
```

### 5. Visualization (MA Plots)
Generate smooth scatter MA plots to visualize the relationship between average expression (A) and log-ratios (M).

```R
spkMA(object, spkSlopeOut, fc=2, label="MyExperiment", ylim=c(-2.5, 2.5))
```

### 6. Design Imbalance
Check if the experimental design confounds nominal concentrations with probe or array effects.

```R
# ANOVA for variance components
anv <- spkAnova(object)

# Wu's imbalance measure (0 is optimal/balanced)
bals <- spkBal(object)
```

## Key Functions
- `spkAll`: A wrapper function that runs the full suite of analyses and saves plots/tables automatically.
- `spkSlope`: Computes signal detection slopes and defines ALE strata (Low, Med, High).
- `spkPot`: Calculates the Probability of being at the Top (POT).
- `spkBox` / `plotSpkBox`: Analyzes and visualizes log-ratio distributions.
- `spkMA`: Produces stratified MA plots.

## Reference documentation
- [Tools for Spike-in Data Analysis and Visualization](./references/spkDoc.md)