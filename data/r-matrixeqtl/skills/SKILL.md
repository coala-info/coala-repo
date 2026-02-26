---
name: r-matrixeqtl
description: Matrix eQTL is an R package that performs efficient expression quantitative trait loci (eQTL) analysis using high-performance matrix operations. Use when user asks to identify associations between genetic variants and gene expression, perform cis and trans eQTL mapping, or analyze large genomic datasets using linear regression or ANOVA models.
homepage: https://cran.r-project.org/web/packages/matrixeqtl/index.html
---


# r-matrixeqtl

## Overview
`MatrixEQTL` is an R package designed for efficient eQTL analysis of large datasets. It utilizes high-performance matrix operations to test for associations between SNPs and gene expression, supporting linear additive models, ANOVA, and genotype-covariate interactions. It can handle covariates (e.g., sex, population structure) and provides FDR control for multiple testing.

## Installation
```R
install.packages("MatrixEQTL")
library(MatrixEQTL)
```

## Core Workflow

### 1. Prepare Data Objects
Data must be loaded into `SlicedData` objects. This format allows Matrix eQTL to process data in chunks (slices) to save memory.

```R
# Initialize SlicedData objects
snps = SlicedData$new()
snps$fileDelimiter = "\t"
snps$fileOmitCharacters = "NA"
snps$fileSkipRows = 1
snps$fileSkipColumns = 1
snps$sliceSize = 2000
snps$LoadFile("snps.txt")

gene = SlicedData$new()
# ... repeat similar setup for gene expression and covariates ...
gene$LoadFile("expression.txt")
```

### 2. Define Model and Parameters
Choose the statistical model and set p-value thresholds.

- `modelLINEAR`: Standard linear regression.
- `modelANOVA`: Categorical genotype (treats genotypes as factors).
- `modelLINEAR_CROSS`: Includes genotype-covariate interaction term.

```R
useModel = modelLINEAR
pvOutputThreshold = 1e-5  # Threshold for all eQTLs (trans)
errorCovariance = numeric() # Identity covariance matrix
```

### 3. Run Analysis
Use `Matrix_eQTL_main` for the analysis.

**For All-Pairs (Trans) Analysis:**
```R
me = Matrix_eQTL_main(
    snps = snps,
    gene = gene,
    cvrt = cvrt,
    output_file_name = "results.txt",
    pvOutputThreshold = pvOutputThreshold,
    useModel = useModel,
    errorCovariance = errorCovariance,
    verbose = TRUE,
    pvalue.hist = TRUE
)
```

**For Cis/Trans Analysis:**
Requires location data for SNPs and genes.
```R
me = Matrix_eQTL_main(
    snps = snps,
    gene = gene,
    cvrt = cvrt,
    output_file_name = "trans_results.txt",
    pvOutputThreshold = 1e-8,
    useModel = useModel,
    errorCovariance = errorCovariance,
    verbose = TRUE,
    output_file_name.cis = "cis_results.txt",
    pvOutputThreshold.cis = 1e-4,
    snpspos = snpspos,
    genepos = genepos,
    cisDist = 1e6,
    pvalue.hist = "qqplot"
)
```

## Key Functions and Tips
- **`plot(me)`**: Generates a Q-Q plot of p-values to check for inflation.
- **Memory Management**: If working with very large gene sets, use `options(MatrixEQTL.dont.preserve.gene.object = TRUE)` to reduce memory footprint.
- **Cis-Distance**: `cisDist` defines the maximum distance between a SNP and a gene (in base pairs) to be considered a "local" (cis) eQTL.
- **Beta Estimates**: For linear models, the output includes the effect size (beta) and t-statistic.

## Reference documentation
- [Matrix eQTL Home Page](./references/home_page.md)