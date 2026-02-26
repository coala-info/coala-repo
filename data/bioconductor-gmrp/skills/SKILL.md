---
name: bioconductor-gmrp
description: This tool performs GWAS-based Mendelian Randomization and path analysis to identify and visualize causal risk factors for diseases. Use when user asks to merge GWAS summary statistics, select independent SNPs as instrumental variables, estimate causal effects through MR regression, or generate path diagrams to disentangle direct and indirect effects.
homepage: https://bioconductor.org/packages/release/bioc/html/GMRP.html
---


# bioconductor-gmrp

name: bioconductor-gmrp
description: Perform GWAS-based Mendelian Randomization (MR) and Path Analysis to identify causal risk factors for diseases. Use this skill when you need to: (1) Merge multiple GWAS summary statistic datasets, (2) Select independent SNPs as instrumental variables based on p-value and distance criteria, (3) Perform MR regression to estimate causal effects of multiple risk factors on a disease, (4) Execute path analysis to disentangle direct and indirect effects, and (5) Generate path diagrams or SNP annotation visualizations.

## Overview

The `GMRP` package provides a framework for causal inference using GWAS summary data. It addresses the challenge of pleiotropy and correlation between risk factors by combining Mendelian Randomization with Path Analysis. This allows researchers to determine if a variable (e.g., LDL cholesterol) is a true causal factor for a disease (e.g., CAD) or if its effect is mediated through other variables.

## Core Workflow

### 1. Data Preparation and Merging
GWAS data for different traits must be merged into a unified format. Use `fmerge` to join datasets by SNP ID.

```R
library(GMRP)
# Merge two GWAS datasets (e.g., LDL and HDL)
merged_data <- fmerge(fl1 = ldl_data, fl2 = hdl_data, ID1 = "SNP", ID2 = "SNP", A = ".LDL", B = ".HDL", method = "No")
```

### 2. Creating the Standard Beta Table
The `mktable` function is the primary tool for SNP selection and formatting. It filters SNPs based on:
- `Pv`: P-value threshold (e.g., 5e-8).
- `LG`: Minimum distance between SNPs to reduce LD (e.g., 1 for 1Mb).
- `Pc`/`Pd`: Sample size proportion thresholds.

```R
# Create a beta table for MR/Path analysis
# newdata: causal variables; newcad: disease data
mybeta <- mktable(cdata = newdata, ddata = newcad, rt = "beta", 
                  varname = c("CAD", "LDL", "HDL", "TG", "TC"), 
                  LG = 1, Pv = 5e-08, Pc = 0.979, Pd = 0.979)
```

### 3. Mendelian Randomization and Path Analysis
Use the `path` function to perform the regression of SNP-disease betas on SNP-risk factor betas.

```R
# Define the model: Disease ~ RiskFactor1 + RiskFactor2 + ...
mod <- cad ~ ldl + hdl + tg + tc
path_results <- path(betav = mybeta, model = mod, outcome = "cad")
```

### 4. Visualization
`GMRP` provides functions to visualize the causal structure.

- **One-level Path Diagram**: Shows direct effects on the disease.
- **Two-level Nested Path Diagram**: Shows effects on an intermediate outcome and the final disease.

```R
# One-level diagram
pathdiagram(pathdata = mypath_df, disease = "CAD", R2 = 0.98, range = c(1:3))

# Two-level nested diagram
pathdiagram2(pathD = disease_path, pathO = outcome_path, 
             rangeD = c(1:4), rangeO = c(1:3), 
             disease = "CAD", R2D = 0.53, R2O = 0.98)
```

### 5. SNP Annotation
Analyze the genomic distribution of the instrumental variables.

```R
# Position annotation (histogram of SNP distribution/intervals)
snpPositAnnot(SNPdata = snp_df, SNP_hg19 = "chr", main = "SNP Distribution")

# Functional annotation (3D Pie chart of gene elements)
ucscannot(UCSCannot = annot_data, SNPn = 368, method = 1)
```

## Key Functions Reference

- `chrp()`: Splits hg19/hg18 strings (e.g., "chr1:12345") into numeric chromosome and position columns.
- `fmerge()`: Merges GWAS result sheets with flexible handling of unmatched SNPs.
- `mktable()`: Filters SNPs and prepares the standard input matrix for analysis.
- `path()`: Performs the core MR and path coefficient calculations.
- `pathdiagram()` / `pathdiagram2()`: Generates acyclic graphs of causal effects.
- `snpPositAnnot()`: Visualizes SNP density and physical spacing.
- `ucscannot()`: Summarizes SNP locations (intron, exon, UTR, etc.) using UCSC-based functional data.

## Reference documentation
- [GMRP-manual](./references/GMRP-manual.md)
- [GMRP](./references/GMRP.md)