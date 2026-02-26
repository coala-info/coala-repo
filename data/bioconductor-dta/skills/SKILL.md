---
name: bioconductor-dta
description: This tool performs kinetic modeling to estimate RNA synthesis and decay rates from Dynamic Transcriptome Analysis experiments. Use when user asks to estimate mRNA half-lives, calculate synthesis rates from labeled RNA fractions, or model transcriptomic kinetics in steady-state and dynamic conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/DTA.html
---


# bioconductor-dta

name: bioconductor-dta
description: Kinetic modeling for the determination of RNA synthesis and decay rates from microarray or RNAseq measurements. Use this skill when analyzing Dynamic Transcriptome Analysis (DTA) experiments involving total (T), labeled (L), and unlabeled (U) RNA fractions to estimate mRNA half-lives and synthesis rates in steady-state or dynamic conditions.

## Overview

The `DTA` package provides tools for estimating RNA kinetic parameters. It uses a first-order exponential decay model to derive synthesis and decay rates from experiments where cells are cultured with a labeling substrate (e.g., 4sU). It handles labeling bias correction (based on uridine content), quality control plotting, and multi-replicate error assessment.

## Core Workflow: Steady-State Estimation

To estimate rates in steady-state conditions (constant mRNA levels), use the `DTA.estimate` function.

### 1. Data Preparation
You need three primary inputs:
- **datamat**: A matrix of RNA intensity values (rows = genes, columns = experiments).
- **phenomat**: A data frame describing the experimental design (columns: `name`, `fraction` [T, L, or U], `time`, and `nr` [replicate number]).
- **tnumber**: A vector containing the number of uridines (or thymines in cDNA) for each transcript to correct for labeling bias.

### 2. Running the Estimation
```R
library(DTA)
# Example using provided yeast data
data(Miller2011)

res <- DTA.estimate(
  phenomat = Sc.phenomat,
  datamat = Sc.datamat,
  tnumber = Sc.tnumber,
  ccl = 150,              # Cell cycle length in minutes
  mRNAs = 60000,          # Optional: total mRNAs per cell for scaling
  reliable = Sc.reliable, # Vector of high-quality gene IDs
  save.plots = TRUE,
  condition = "experiment_name"
)
```

### 3. Accessing Results
The output is a list indexed by labeling duration.
```R
# Access decay rates (dr), synthesis rates (sr), and half-lives (hl)
decay_rates <- res[["6"]]$dr
half_lives <- res[["6"]]$hl
synthesis_rates <- res[["6"]]$Rsr # Scaled synthesis rates
```

## Dynamic Conditions (Timecourse)

When mRNA levels are not constant (e.g., stress response), use `DTA.dynamic.estimate`.

```R
# phenomat requires an additional column for the timecourse sequence
res_dyn <- DTA.dynamic.estimate(
  Sc.phenomat.dynamic, 
  Sc.datamat.dynamic,
  Sc.tnumber,
  ccl = 150,
  LtoTratio = rep(0.1, 7) # Initial guess for L/T ratios across timepoints
)
```

## Key Functions and Parameters

- `DTA.estimate`: Main function for steady-state kinetics.
- `DTA.dynamic.estimate`: Main function for non-steady-state (time-resolved) kinetics.
- `DTA.generate` / `DTA.dynamic.generate`: Simulate DTA data to test experimental designs or method limits.
- `DTA.map.it`: Helper to map uridine counts (tnumber) between different ID types (e.g., Ensembl Transcript to Gene IDs).
- `bicor`: Logical. Set to `TRUE` (default) to correct for labeling bias based on uridine content. Omission can lead to skewed estimates where half-lives correlate with transcript length.
- `ratiomethod`: Method to estimate the L/T ratio. Options include `"tls"` (total least squares, recommended), `"lm"` (linear model), or `"bias"`.

## Quality Control Plots

The package automatically generates several diagnostic plots if `save.plots = TRUE`:
- **T ~ U + L Plane**: Visualizes the total least squares regression.
- **Labeling Bias**: Shows the log-ratio of L/T vs. Uridine count. A slope indicates labeling efficiency < 100%.
- **Correlation Plots**: Pairwise comparisons of replicates and correlations between SR, DR, and HL.

## Reference documentation

- [A guide to Dynamic Transcriptome Analysis (DTA)](./references/DTA.md)