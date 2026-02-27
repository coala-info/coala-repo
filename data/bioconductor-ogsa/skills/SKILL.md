---
name: bioconductor-ogsa
description: This tool performs Outlier Gene Set Analysis (OGSA) to identify pathway deregulation by integrating multi-omics data such as gene expression, methylation, and copy number variations. Use when user asks to identify significant gene sets across molecular domains, perform Tibshirani-Hastie or Rank Sum outlier analysis, or generate outlier maps for cancer subtype pathways.
homepage: https://bioconductor.org/packages/3.5/bioc/html/OGSA.html
---


# bioconductor-ogsa

name: bioconductor-ogsa
description: Outlier Gene Set Analysis (OGSA) for integrating multi-omics data (expression, methylation, copy number) to identify pathway deregulation in cancer subtypes. Use this skill when performing outlier analysis across different molecular domains, specifically for identifying significant gene sets using Tibshirani-Hastie or Rank Sum outlier approaches.

# bioconductor-ogsa

## Overview

The `OGSA` package provides a framework for global estimates of pathway deregulation by integrating significance estimates from individual pathway members. It is designed to handle multiple data types simultaneously (e.g., mRNA expression, CNV, and DNA methylation) to capture biological relationships, such as how copy number gains or promoter hypomethylation lead to increased gene expression.

## Core Workflow

### 1. Data Preparation
Data should be organized as matrices with genes in rows and samples in columns. A phenotype vector (1 for cases, 0 for controls) is required.

```r
library(OGSA)
data(ExampleData)
data(KEGG_BC_GS)

# Define phenotype and match names
phenotype <- pheno
names(phenotype) <- colnames(cnv)

# Organize multi-omics data into a list
# Order: Expression, Methylation, CNV
dataSet <- list(expr, meth, cnv)
```

### 2. Defining Biological Relationships (Tails)
Specify the direction of outliers for each data type.
*   **tailRLR**: Right-tail (Expr), Left-tail (Meth), Right-tail (CNV) — represents activation.
*   **tailLRL**: Left-tail (Expr), Right-tail (Meth), Left-tail (CNV) — represents suppression.

```r
tailRLR <- c('right', 'left', 'right')
tailLRL <- c('left', 'right', 'left')
```

### 3. Running Outlier Analysis
Use `copaInt` to calculate outlier scores and `testGScogps` to test for gene set enrichment.

**Method 1: Tibshirani-Hastie (Default)**
```r
# Standard analysis
tibRLR <- copaInt(dataSet, phenotype, tails=tailRLR)
gsTibRLR <- testGScogps(tibRLR, pathGS)

# Corrected for normal outliers
tibRLRcorr <- copaInt(dataSet, phenotype, tails=tailRLR, corr=TRUE)
gsTibRLRcorr <- testGScogps(tibRLRcorr, pathGS)
```

**Method 2: Rank Sum Approach**
Requires `offsets` to define the minimum biologically meaningful change (e.g., log fold change for expression, beta value for methylation).
```r
offsets <- c(1.0, 0.1, 0.5) # Expr, Meth, CNV thresholds

rankRLRcorr <- copaInt(dataSet, phenotype, tails=tailRLR, 
                       method='Rank', corr=TRUE, offsets=offsets)
gsRankRLRcorr <- testGScogps(rankRLRcorr, pathGS)
```

### 4. Visualization and Outlier Maps
Generate heatmaps to visualize which samples and genes contribute to a pathway's significance.

```r
# Calculate specific outlier calls
outRankRLRcorr <- outCallRank(dataSet, phenotype, 
                              names=c('Expr', 'Meth', 'CNV'),
                              tail=tailRLR, corr=TRUE, offsets=offsets)

# Generate Outlier Map (Heatmap)
# pathGS$PATHWAY_NAME selects the gene set
map <- outMap(outRankRLRcorr, pathGS$KEGG_ECM_RECEPTOR_INTERACTION, 
              hmName='ECM Outlier Map', 
              plotName='ECM_Outliers.pdf')
```

## Key Functions
*   `copaInt()`: Main wrapper for outlier analysis. Supports `method='Tibshirani'` (default) and `method='Rank'`.
*   `testGScogps()`: Performs statistical testing on gene sets based on outlier counts.
*   `outCallTib()` / `outCallRank()`: Identifies specific outlier events for visualization.
*   `outMap()`: Creates PDF heatmaps showing outlier distribution across samples and genes within a pathway.

## Tips
*   **Correction**: Always consider setting `corr=TRUE`. In the Tibshirani method, it corrects for outliers found in normal samples; in the Rank method, it applies the `offsets` thresholds.
*   **Data Alignment**: Ensure the gene names (rows) and sample names (columns) are consistent across all matrices in the `dataSet` list.
*   **Gene Sets**: The `pathGS` object should be a list where each element is a character vector of gene symbols.

## Reference documentation
- [OGSA Users Manual](./references/OGSAUsersManual.md)