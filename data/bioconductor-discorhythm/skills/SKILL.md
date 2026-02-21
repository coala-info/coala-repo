---
name: bioconductor-discorhythm
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/DiscoRhythm.html
---

# bioconductor-discorhythm

name: bioconductor-discorhythm
description: Analysis of periodicity in large-scale temporal biological datasets (e.g., circadian transcriptomics). Use this skill to perform rhythmicity analysis in R, including data import, outlier detection, PCA, replicate analysis, and oscillation detection using methods like Cosinor, JTK Cycle, ARSER, and Lomb-Scargle.

## Overview

DiscoRhythm is a Bioconductor package designed to characterize rhythmicity in high-throughput temporal data. It provides a standardized workflow to estimate cyclical characteristics such as period, phase, and amplitude. The package is particularly useful for circadian studies and supports various experimental designs, including those with uneven sampling or biological replicates.

## Core Workflow

### 1. Data Import and Formatting

DiscoRhythm uses `SummarizedExperiment` objects. Data can be imported from a CSV-style data frame where metadata is encoded in column names.

**Column Naming Convention:** `PrefixTime_UniqueId_ReplicateId` (e.g., `CT24_SampleA_1`).

```R
library(DiscoRhythm)
library(SummarizedExperiment)

# Load example data or your own data frame
indata <- discoGetSimu() 

# Convert data frame to SummarizedExperiment
# Metadata is automatically parsed from column names
se <- discoDFtoSE(indata)

# Check for missing or constant values
se <- discoCheckInput(se)
```

### 2. Outlier Detection

Identify problematic samples using inter-sample correlation and Principal Component Analysis (PCA).

```R
# 1. Inter-sample correlation
cor_res <- discoInterCorOutliers(se, cor_method="pearson", threshold=3)

# 2. PCA-based outlier detection
pca_res <- discoPCAoutliers(se, threshold=3, scale=TRUE)

# Filter the dataset
se_filtered <- se[, !cor_res$outliers & !pca_res$outliers]
```

### 3. Replicate Analysis and Row Selection

Handle technical replicates by combining them (mean/median) and optionally filtering rows based on ANOVA signal-to-noise ratio.

```R
# Combine replicates and perform ANOVA
# aov_method: "Equal Variance", "Welch", or "None"
res_rep <- discoRepAnalysis(se_filtered, 
                            aov_method="Equal Variance", 
                            avg_method="Median")
se_final <- res_rep$se
```

### 4. Period Detection

Determine the dominant periodicity across the entire dataset before performing feature-wise testing.

```R
# Test a range of periods
period_res <- discoPeriodDetection(se_final, timeType="linear", main_per=24)

# Inspect median R-squared values to find the strongest period
```

### 5. Oscillation Detection (ODA)

Quantify rhythmicity for each feature using one or more algorithms.

```R
# Run rhythm detection (CS=Cosinor, JTK=JTK Cycle, LS=Lomb-Scargle, ARS=ARSER)
# discoODAs automatically selects valid methods based on data properties
oda_results <- discoODAs(se_final, 
                         period=24, 
                         method=c("CS", "JTK"), 
                         circular_t=FALSE)

# Access results for a specific method
head(oda_results$CS)
```

## Algorithm Selection Guide

| Method | Best For | Restrictions |
| :--- | :--- | :--- |
| **Cosinor (CS)** | General sinusoid fitting | None (very flexible) |
| **JTK Cycle** | Non-parametric, outlier robust | Requires even/integer intervals |
| **Lomb-Scargle (LS)** | Unevenly spaced data | No ARSER-style detrending |
| **ARSER (ARS)** | Non-stationary time-series | No missing values or replicates |

## Batch Execution

For a quick, automated run of the entire pipeline with a generated HTML report:

```R
results <- discoBatch(indata = my_df,
                      report = "my_report.html",
                      main_per = 24,
                      osc_method = "CS")
```

## Reference documentation

- [Introduction to DiscoRhythm](./references/disco_workflow_vignette.md)
- [DiscoRhythm Workflow Rmd](./references/disco_workflow_vignette.Rmd)