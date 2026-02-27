---
name: bioconductor-sispa
description: "SISPA defines sample groups with similar gene set enrichment profiles by applying change point models to molecular data. Use when user asks to identify active versus inactive sample groups, calculate gene set enrichment scores, or partition samples based on integrated molecular profiles."
homepage: https://bioconductor.org/packages/3.5/bioc/html/SISPA.html
---


# bioconductor-sispa

name: bioconductor-sispa
description: Sample Integrated Set Profile Analysis (SISPA) for defining sample groups with similar gene set enrichment profiles. Use when analyzing molecular data (expression, methylation, variant, or copy change) to identify "active" vs "inactive" sample groups based on gene set activity using change point models.

# bioconductor-sispa

## Overview
SISPA (Sample Integrated Set Profile Analysis) is a method designed to define sample groups with similar gene set enrichment profiles. It transforms high-dimensional molecular data (like RNA-seq or variant data) into sample-specific enrichment scores, ranks them according to a desired profile (upregulated or downregulated), and applies a change point model to objectively partition samples into "active" (profile-matching) and "inactive" groups.

## Core Workflow

The package can be used either through the high-level `SISPA` wrapper or by manually executing the step-by-step pipeline.

### 1. Data Preparation
Input data should be a matrix or data frame where rows correspond to genes/probes and columns correspond to samples.
- `expression_data`: Example RNA-seq expression dataset.
- `variant_data`: Example gene variant proportion dataset.

### 2. Estimating Enrichment Scores
Use these functions to generate a single score per sample for a gene set:
- `callGSVA(x, y)`: Use when the gene set has 3 or more genes. It uses the GSVA z-score method.
- `callZSCORE(x)`: Use when the gene set has fewer than 3 genes. It computes row z-scores per sample.

### 3. Identifying Sample Groups
The `cptSamples` function applies a change point model to the enrichment scores:
- It identifies the first change point to separate the "active" profile (Group 1) from the rest (Group 0).
- Parameters: `cpt_data` ("var", "mean", or "meanvar"), `cpt_method` (default "BinSeg"), and `cpt_max`.

### 4. Integrated Analysis (The SISPA Wrapper)
The `SISPA()` function automates the process for one or two molecular features:
```r
# Single feature analysis (e.g., Expression only)
results <- SISPA(feature=1, f1.df=expr_matrix, f1.profile="up")

# Two feature integrated analysis (e.g., Expression and Variants)
results <- SISPA(feature=2, 
                 f1.df=expr_matrix, f1.profile="up",
                 f2.df=var_matrix, f2.profile="up")
```

## Visualization
SISPA provides specific plotting functions to interpret the grouping:
- `waterfallplot(x)`: Generates a bar plot of all sample z-scores, highlighting the "active" group (Group 1) in orange.
- `freqplot(x)`: Shows the distribution/count of samples with and without profile activity.

## Data Manipulation Utilities
- `filterVars(x, y)`: Filters out rows with zero values for a specific sample.
- `sortData(x, i, b)`: Sorts a data frame by a specific column index (`i`) in ascending or descending (`b`) order.

## Implementation Tips
- **Profile Selection**: Set `f1.profile="up"` to find samples with increased enrichment or `"down"` for decreased enrichment.
- **Change Point Sensitivity**: If the default variance-based change point (`cpt_data="var"`) does not yield distinct groups, try `cpt_data="mean"` or `cpt_data="meanvar"`.
- **Sample Naming**: Ensure column names (samples) are consistent across different feature data frames when performing integrated analysis.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)