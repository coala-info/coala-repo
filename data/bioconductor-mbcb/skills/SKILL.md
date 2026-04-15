---
name: bioconductor-mbcb
description: This tool performs model-based background correction for Illumina microarray data using negative control probes and various statistical methods. Use when user asks to perform background correction on Illumina expression signals, normalize microarray data, or improve signal-to-noise ratios using NP, RMA, MLE, GMLE, or MCMC approaches.
homepage: https://bioconductor.org/packages/release/bioc/html/MBCB.html
---

# bioconductor-mbcb

name: bioconductor-mbcb
description: Model-based background correction for Illumina microarray data. Use this skill when you need to perform background correction on Illumina expression signals using negative control probes via Non-Parametric, MLE, GMLE, Bayesian (MCMC), or RMA methods.

# bioconductor-mbcb

## Overview

The `MBCB` package provides model-based techniques to background-correct Illumina microarray datasets. It specifically leverages negative control probes available on modern Illumina arrays to improve signal-to-noise ratios. The package supports multiple statistical approaches for correction and includes options for subsequent normalization (Quantile or Median).

## Core Workflow

### 1. Data Preparation
The package requires two matrices: one for expression signals and one for negative control probes.

```r
library(MBCB)

# Load sample data
data(MBCBExpressionData)
# Creates: expressionSignal and negativeControl

# Parsing from files (tab-delimited)
# data <- mbcb.parseFile('signal.txt', 'negative.control.txt')
# signal <- data$sig
# negCon <- data$con
```

### 2. Background Correction
The `mbcb.correct` function is the primary tool for processing data within R.

```r
# Define methods to use
nonparametric <- TRUE
RMA <- TRUE
MLE <- TRUE
GMLE <- FALSE
MCMC <- FALSE

# Execute correction
cor <- mbcb.correct(expressionSignal, negativeControl, nonparametric, RMA, MLE, MCMC, GMLE)

# Access results (e.g., Non-Parametric results)
# corrected_data <- cor$NP
```

### 3. Integrated Analysis and Normalization
The `mbcb.main` function handles correction, optional normalization, and file output in a single step.

```r
# Normalization options: "none", "quant" (Quantile), or "median"
mbcb.main(expressionSignal, 
          negativeControl, 
          normMethod = "quant", 
          bgCorrectedFile = "output_prefix")
```

### 4. Visualization
Compare raw and corrected signals using boxplots to verify the impact of the correction.

```r
ylimits <- c(10, 60000)
par(mfrow=c(2,2))
boxplot(expressionSignal, log="y", ylim=ylimits, main="Raw")
boxplot(cor$NP, log="y", ylim=ylimits, main="NP-corrected")
boxplot(cor$RMA, log="y", ylim=ylimits, main="RMA-corrected")
boxplot(cor$MLE, log="y", ylim=ylimits, main="MLE-corrected")
```

## Key Functions and Parameters

- `mbcb.parseFile(sigFile, conFile)`: Imports signal and control data from disk.
- `mbcb.correct(sig, con, NP, RMA, MLE, MCMC, GMLE)`: Returns a list of corrected matrices.
- `mbcb.main(sig, con, ...)`: High-level wrapper.
  - `paramEstFile`: Prefix for parameter estimation output files.
  - `bgCorrectedFile`: Prefix for corrected data output files.
  - `normMethod`: "none", "quant", or "median".
- `mbcb.gui()`: Launches a Tcl/Tk graphical interface for interactive processing.

## Tips
- **RMA Method**: This is the only method that does not strictly require negative control probes; it can run on signal data alone.
- **Dependencies**: Quantile normalization (`normMethod="quant"`) requires the `preprocessCore` (or `affy`) package.
- **Output**: `mbcb.main` writes CSV files to the working directory by default.

## Reference documentation
- [MBCB](./references/MBCB.md)