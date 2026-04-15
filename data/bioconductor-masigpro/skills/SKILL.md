---
name: bioconductor-masigpro
description: This tool performs regression-based analysis of single and multiseries time course transcriptomics data to identify genes with significant temporal expression changes. Use when user asks to identify differentially expressed genes in time-course experiments, find significant differences between experimental groups, or analyze isoform switches and alternative splicing.
homepage: https://bioconductor.org/packages/release/bioc/html/maSigPro.html
---

# bioconductor-masigpro

name: bioconductor-masigpro
description: Analysis of single and multiseries time course transcriptomics data (Microarray and RNA-Seq). Use this skill to identify genes with significant temporal expression changes and significant differences between experimental groups using a two-step regression approach.

## Overview
maSigPro (microarray Significant Profiles) is a Bioconductor package designed for time-course transcriptomics analysis. It uses a two-step regression strategy:
1.  **Global Regression**: Identifies genes with any significant temporal or group-related changes using an F-test.
2.  **Stepwise Regression**: Refines the model for each significant gene to identify specific variables (Time, Group, or Interactions) that drive the expression profile.

It supports both normal-distributed data (Microarrays) and count data (RNA-Seq) via Generalized Linear Models (GLMs).

## Core Workflow

### 1. Experimental Design
The `edesign` matrix is critical. Rows are arrays/samples; columns must include `Time`, `Replicate`, and binary dummy variables for each experimental group.

```r
library(maSigPro)
# Example edesign structure:
#               Time Replicate Control Cold Heat
# Control_3H_1     3         1       1    0    0
# Cold_3H_1        3         4       0    1    0
```

### 2. Define Regression Model
Create the design matrix based on the polynomial degree (e.g., degree 2 for quadratic).
```r
design <- make.design.matrix(edesign, degree = 2)
```

### 3. Find Significant Genes (Step 1)
Use `p.vector` to run the initial F-test. For RNA-Seq, set `counts = TRUE`.
```r
# Microarray
fit <- p.vector(data, design, Q = 0.05, MT.adjust = "BH")

# RNA-Seq (Negative Binomial)
fit.seq <- p.vector(rnaseq_counts, design, counts = TRUE, theta = 10)
```

### 4. Variable Selection (Step 2)
Use `T.fit` to perform stepwise regression on the genes selected in Step 1.
```r
tstep <- T.fit(fit, step.method = "backward", alfa = 0.05)
```

### 5. Extract and Visualize Results
Use `get.siggenes` to filter by R-squared and group results.
```r
# Filter by R-squared > 0.6
sigs <- get.siggenes(tstep, rsq = 0.6, vars = "groups")

# Visualization
suma2Venn(sigs$summary[, c(1:3)]) # Venn diagram of group differences
see.genes(sigs$sig.genes$ColdvsControl, k = 9) # Cluster profiles
```

## Iso-maSigPro (Isoform Analysis)
For alternative splicing/isoform analysis, provide transcript-level data with Gene IDs in the first column.

```r
# Identify Differentially Spliced Genes (DSG)
MyIso <- IsoModel(data = ISOdata[,-1], gen = ISOdata[,1], design = design, counts = TRUE)
Myget <- getDS(MyIso)

# Find isoform switches (Podium Changes)
PC <- PodiumChange(Myget, comparison = "specific", group.name = "Group2", time.points = c(18, 24))

# Plot specific gene isoforms
IsoPlot(Myget, "Gene1005")
```

## Key Functions
- `make.design.matrix()`: Converts `edesign` into a regression-ready matrix.
- `p.vector()`: Performs the first regression to select genes with significant profiles.
- `T.fit()`: Performs the second regression (stepwise) to find significant variables.
- `get.siggenes()`: Generates lists of significant genes based on R-squared and experimental groups.
- `see.genes()`: Clusters and plots expression profiles.
- `PlotGroups()`: Plots the profile of a single gene across all experimental groups.

## Tips
- **Polynomial Degree**: `degree` should be at most `(number of time points - 1)`.
- **Reference Group**: The first binary column in `edesign` (after Time and Replicate) is treated as the reference group (Control).
- **RNA-Seq Normalization**: Data must be normalized (e.g., TMM, DESeq2) before running maSigPro; the package does not perform normalization.

## Reference documentation
- [maSigPro](./references/maSigPro.md)
- [maSigProUsersGuide](./references/maSigProUsersGuide.md)