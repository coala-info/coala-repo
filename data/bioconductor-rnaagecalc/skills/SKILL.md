---
name: bioconductor-rnaagecalc
description: This tool estimates chronological age from human RNA-Seq data using elastic net models trained on the GTEx dataset. Use when user asks to predict biological age from gene expression matrices, calculate age acceleration residuals, or visualize the relationship between RNA age and chronological age.
homepage: https://bioconductor.org/packages/release/bioc/html/RNAAgeCalc.html
---

# bioconductor-rnaagecalc

## Overview

`RNAAgeCalc` is a Bioconductor package designed to estimate chronological age from human RNA-Seq data. It utilizes elastic net models trained on the Genotype-Tissue Expression (GTEx) dataset. The package supports both tissue-specific and across-tissue age prediction, offering multiple gene signatures (e.g., DESeq2, Pearson, GenAge) and accounting for different sample types (all races vs. Caucasian).

## Core Workflow

### 1. Data Preparation
The package requires a gene expression matrix where rows are gene IDs and columns are samples.
- **Expression Types**: Supports raw "counts" or "FPKM". If counts are provided, the package converts them to FPKM using internal gene lengths.
- **ID Types**: Supports `SYMBOL` (default), `ENSEMBL`, `ENTREZID`, or `REFSEQ`.
- **Chronological Age**: Optional. If provided (at least 30 samples), the package calculates "Age Acceleration Residuals".

### 2. Predicting Age from Data Frames
Use `predict_age()` for standard matrix or data frame inputs.

```r
library(RNAAgeCalc)

# Load example data
data(fpkmExample) 

# Optional: Create chronological age data frame
my_chron_age <- data.frame(
  sampleid = colnames(fpkm), 
  age = c(30, 50)
)

# Calculate RNA Age
results <- predict_age(
  exprdata = fpkm, 
  tissue = "brain", 
  exprtype = "FPKM", 
  idtype = "SYMBOL",
  chronage = my_chron_age
)

head(results)
```

### 3. Predicting Age from SummarizedExperiment
Use `predict_age_fromse()` for Bioconductor-standard objects.

```r
library(SummarizedExperiment)

# Ensure assays(se) contains "counts" or "FPKM"
# Ensure colData(se)$age contains chronological age (optional)
res_se <- predict_age_fromse(se = my_se, exprtype = "counts", tissue = "liver")
```

## Key Parameters

- **tissue**: Choose from 26 supported tissues (e.g., `blood`, `brain`, `skin`, `lung`). If omitted or not found, an across-tissue predictor is used.
- **stype**: 
  - `"all"`: Trained on all races (default).
  - `"Caucasian"`: Trained on Caucasian samples only.
- **signature**: 
  - `"DESeq2"`: Top differentially expressed genes (default if tissue is specified).
  - `"GTExAge"`: Genes consistently differentially expressed across tissues (default if tissue is NOT specified).
  - `"GenAge"` / `"deMagalhaes"` / `"Peters"`: Specific literature-based signatures.
  - `"all"`: Uses all available genes in the calculator.

## Visualization and Interpretation

The `makeplot()` function provides a quick visualization of the relationship between predicted RNA Age and actual Chronological Age.

```r
# Requires results containing both RNAAge and ChronAge columns
makeplot(results)
```

**Interpreting Results**:
- **RNAAge**: The predicted biological age based on the transcriptome.
- **AgeAccelResid**: The residual from a linear regression of RNAAge on Chronological Age. A positive value suggests "older" biological age relative to chronological age.

## Tips
- **Imputation**: If your data is missing genes required by a signature, the package automatically performs KNN imputation using the `impute` package.
- **Gene Lengths**: When providing raw counts, you can pass a custom `genelength` vector if you do not wish to use the internal `recount2` defaults.

## Reference documentation
- [RNAAgeCalc: A multi-tissue transcriptional age calculator](./references/RNAAge-vignette.md)
- [RNAAgeCalc: A multi-tissue transcriptional age calculator (Rmd source)](./references/RNAAge-vignette.Rmd)