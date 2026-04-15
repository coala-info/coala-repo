---
name: bioconductor-rankprod
description: This tool performs non-parametric statistical analysis of omics data using Rank Product and Rank Sum methods to identify differentially expressed features. Use when user asks to identify differentially expressed genes or metabolites, perform meta-analysis across multiple data origins, or analyze small and heterogeneous datasets using robust rank-based statistics.
homepage: https://bioconductor.org/packages/release/bioc/html/RankProd.html
---

# bioconductor-rankprod

name: bioconductor-rankprod
description: Statistical analysis of omics data (transcriptomics, metabolomics) using Rank Product (RP) and Rank Sum (RS) methods. Use this skill to identify differentially expressed genes or metabolites in replicated experiments, especially when dealing with small sample sizes, heterogeneous data sources (multiple origins), or non-parametric requirements.

# bioconductor-rankprod

## Overview
The `RankProd` package implements the Rank Product (RP) and Rank Sum (RS) statistics. These are non-parametric methods used to identify features (genes, metabolites, etc.) that are consistently up- or down-regulated across replicates. The methods are robust to outliers and make fewer assumptions about data distribution than t-tests, making them ideal for meta-analysis across different laboratories or platforms.

## Core Functions
- `RankProducts()`: The primary function for single-origin data or simple two-class comparisons.
- `RP.advance()`: Advanced version for data with multiple origins (e.g., combining datasets from different labs) and complex experimental designs.
- `topGene()`: Extracts and summarizes significant features based on PFP (percentage of false prediction) or p-values.
- `plotRP()`: Visualizes the relationship between the number of identified features and the estimated PFP.

## Typical Workflows

### 1. Single Origin Two-Class Analysis
Used for standard treatment vs. control experiments from a single source.
```R
library(RankProd)
# data: matrix with genes in rows, samples in columns
# cl: vector of 0s (control) and 1s (treatment)
# logged: TRUE if data is already log-transformed

RP.out <- RankProducts(data, cl, logged = TRUE, gene.names = rownames(data))

# View top 10 up-regulated and down-regulated genes
topGene(RP.out, num.gene = 10)
```

### 2. Multiple Origin Analysis (Meta-Analysis)
Used to combine datasets from different laboratories or batches where direct intensity comparison is not valid.
```R
# origin: vector indicating the source of each sample (e.g., c(1,1,1,2,2,2))
RP.adv.out <- RP.advance(data, cl, origin, logged = TRUE)

# Identify genes with PFP < 0.05
topGene(RP.adv.out, cutoff = 0.05, method = "pfp")
```

### 3. One-Class Analysis (e.g., cDNA Microarrays)
Used for pre-calculated ratios or fold-change data.
```R
# cl should be a vector of 1s
cl_one <- rep(1, ncol(data))
RP.one <- RankProducts(data, cl_one, logged = TRUE)
```

### 4. Rank Sum (RS) for Metabolomics
The Rank Sum method is often preferred for metabolomics to put a higher premium on consistency across replicates.
```R
# Set calculateProduct = FALSE to use Rank Sum instead of Rank Product
RS.out <- RankProducts(data, cl, calculateProduct = FALSE, logged = TRUE)
```

## Key Parameters and Interpretation
- **logged**: Crucial parameter. If `TRUE`, the package calculates log-ratios by subtraction. If `FALSE`, it calculates ratios by division.
- **PFP (Percentage of False Prediction)**: The non-parametric equivalent of FDR. A `pfp` of 0.05 suggests that 5% of the genes identified up to that point are likely false positives.
- **Table1 vs Table2**: In `topGene()` output, `Table1` typically contains features where Class 1 < Class 2 (up-regulated in treatment), and `Table2` contains features where Class 1 > Class 2 (down-regulated in treatment).

## Advanced Usage: Cross-Condition Identification
To find genes up-regulated in one condition but down-regulated in another, you can manually flip the class labels for one set of samples and run `RP.advance()` with multiple origins. This forces the algorithm to look for features that rank high in one set and low in the other.

## Reference documentation
- [RankProd Package Vignette](./references/RankProd.md)