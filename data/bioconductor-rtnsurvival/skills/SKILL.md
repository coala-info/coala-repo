---
name: bioconductor-rtnsurvival
description: This package integrates transcriptional regulatory networks with survival data to estimate regulon activity using 2-tailed Gene Set Enrichment Analysis. Use when user asks to calculate regulon activity scores, perform Cox proportional hazards regression, or generate Kaplan-Meier survival curves based on transcriptional regulators.
homepage: https://bioconductor.org/packages/release/bioc/html/RTNsurvival.html
---

# bioconductor-rtnsurvival

## Overview

The `RTNsurvival` package integrates transcriptional regulatory networks (inferred via the `RTN` package) with survival data. It uses a 2-tailed Gene Set Enrichment Analysis (GSEA) to estimate "regulon activity" (differential Enrichment Score - dES) for individual samples. These activity scores are then used as predictors in Cox multivariate regression or as stratification factors for Kaplan-Meier analysis.

## Core Workflow

### 1. Data Preparation
The package requires a `TNI` object (from the `RTN` package) and a survival data frame. The survival data must contain columns for time and event status.

```r
library(RTN)
library(RTNsurvival)

# Load or create a TNI object (e.g., 'stni')
# Load survival data (e.g., 'survival.data')
# time: column index or name for survival time
# event: column index or name for event status (0/1)
rtns <- tni2tnsPreprocess(stni, 
                          survivalData = survival.data, 
                          time = "OS_days", 
                          event = "Vital_status", 
                          endpoint = 120, 
                          keycovar = c("Age", "Grade"))
```

### 2. Compute Regulon Activity
Regulon activity is calculated using a 2-tailed GSEA approach. This step is mandatory before running survival models.

```r
rtns <- tnsGSEA2(rtns)
```

### 3. Cox Proportional Hazards Analysis
Use `tnsCox` to identify regulons significantly associated with hazard ratios, accounting for provided covariates.

```r
rtns <- tnsCox(rtns)
# View results
results <- tnsGet(rtns, "results")
# Plot Hazard Ratios
tnsPlotCox(rtns)
```

### 4. Kaplan-Meier Analysis
Stratify the cohort based on regulon activity. The `sections` parameter determines how many groups to split the cohort into (e.g., 2 for high/low activity).

```r
# Run KM analysis
rtns <- tnsKM(rtns, sections = 2)

# Plot for a specific regulator (e.g., "FOXM1")
tnsPlotKM(rtns, regs = "FOXM1")
```

## Advanced Visualization and Data Extraction

### Individual Sample GSEA
To visualize why a specific sample has a high or low activity score for a regulator:
```r
# Plot 2-tailed GSEA for sample "Sample_ID" and regulator "FOXM1"
tnsPlotGSEA2(rtns, samid = "Sample_ID", regs = "FOXM1")
```

### Extracting Activity Scores
To perform custom downstream analysis (e.g., heatmaps with `pheatmap`):
```r
# Get the dES matrix
enrichmentScores <- tnsGet(rtns, "regulonActivity")
# 'enrichmentScores$dif' contains the activity scores
```

## Tips for Success
- **Input Consistency**: Ensure the sample IDs in the `TNI` object match the row names or ID column in the `survivalData`.
- **Endpoint**: Use the `endpoint` parameter in `tni2tnsPreprocess` to right-censor data at a specific time point (e.g., 5-year or 10-year survival).
- **Regulon Selection**: If the network is large, you can subset the analysis to specific regulators of interest using the `regs` argument in plotting functions.

## Reference documentation
- [RTNsurvival](./references/RTNsurvival.md)