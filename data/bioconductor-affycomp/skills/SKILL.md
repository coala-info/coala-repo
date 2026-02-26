---
name: bioconductor-affycomp
description: The affycomp package benchmarks Affymetrix GeneChip expression measures by calculating performance metrics for precision, accuracy, and sensitivity using spike-in and dilution datasets. Use when user asks to assess expression measure quality, compare preprocessing methods like RMA or MAS 5.0, generate ROC curves for differential expression, or create MA plots for Affymetrix benchmark data.
homepage: https://bioconductor.org/packages/release/bioc/html/affycomp.html
---


# bioconductor-affycomp

## Overview

The `affycomp` package provides a comprehensive framework for benchmarking Affymetrix GeneChip expression measures. It utilizes known "truth" from spike-in and dilution datasets to calculate performance metrics across several dimensions: precision (replicate variability), accuracy (fold change estimation), and sensitivity/specificity (detection of differential expression).

## Core Workflow

The standard workflow involves reading expression measures (usually from CSV files) and running an assessment against the benchmark standards.

### 1. Loading Data
Expression measures must be formatted as `ExpressionSet` objects or read from CSV files where the first column contains probe set IDs.

```R
library(affycomp)

# Read dilution and spike-in expression measures
# Files should contain expression values for the benchmark arrays
d <- read.dilution("dilution_measures.csv")
s <- read.spikein("spikein_measures.csv")
```

### 2. Running Assessments
The `affycomp` function is a wrapper that performs all standard assessments and generates a summary table.

```R
# Run full assessment for a specific method (e.g., RMA)
rma.assessment <- affycomp(d, s, method.name="RMA")

# For HGU133A chips, use the specific reader
s133 <- read.newspikein("sifilename.csv")
```

### 3. Generating Reports and Plots
You can generate the standard "Image Report" figures individually or by passing assessment objects to `affycompPlot`.

```R
# Basic MA plot (Figure 1)
affycompPlot(rma.assessment$MA)

# Comparative ROC curves (Figure 5)
# Compares your method against MAS 5.0 by default
data(mas5.assessment)
affycompPlot(mas5.assessment$FC, rma.assessment$FC)

# Compare multiple methods in one plot
affycomp.compfig2(list(mas5.assessment$Dilution, rma.assessment$Dilution), 
                  method.names=c("MAS 5.0", "RMA"))
```

### 4. Summary Tables
Use these functions to get numerical performance metrics.

```R
# Detailed table of all statistics
tableAll(rma.assessment, mas5.assessment)

# Concise, informative table
affycompTable(rma.assessment, mas5.assessment)
```

## Key Assessment Components

The assessment object returned by `assessAll` or `affycomp` contains:
- `MA`: Data for MA plots (log fold change vs. mean log expression).
- `Dilution`: Assessment of standard deviation across replicates and sensitivity to total RNA abundance.
- `Signal`: Observed log intensity vs. nominal log concentration.
- `FC` / `FC2`: Fold change assessments and ROC curve data (FC2 focuses on low fold changes).

## Standard Deviation Assessment
If your preprocessing method provides standard error estimates, you can assess their reliability:

```R
# Requires ExpressionSet with SE estimates
# Figure 7: Log ratio of predicted vs. observed variance
affycompPlot(rma.sd.assessment, lw.sd.assessment)
```

## Reference documentation

- [Bioconductor Expression Assessment Tool for Affymetrix Oligonucleotide Arrays (affycomp)](./references/affycomp.md)