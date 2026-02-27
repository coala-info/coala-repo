---
name: bioconductor-prostatecancervarambally
description: This package provides access to the Varambally et al. (2005) prostate cancer gene expression dataset as a curated ExpressionSet object. Use when user asks to load the Varambally prostate cancer dataset, analyze GSE3325 gene expression data, or compare Benign, Tumour, and Metastatic prostate samples.
homepage: https://bioconductor.org/packages/release/data/experiment/html/prostateCancerVarambally.html
---


# bioconductor-prostatecancervarambally

name: bioconductor-prostatecancervarambally
description: Access and use the Varambally et al. (2005) prostate cancer dataset from Bioconductor. Use this skill when a user needs to load, analyze, or explore the GSE3325 gene expression data (Affymetrix Human Genome U133 Plus 2.0 Array) which includes Benign, Tumour, and Metastatic prostate samples.

## Overview

The `prostateCancerVarambally` package is a data experiment package providing a curated `ExpressionSet` object from the study "Integrative genomic and proteomic analysis of prostate cancer reveals signatures of metastatic progression" (Varambally et al., 2005). The dataset is useful for studying prostate cancer progression across three distinct stages: Benign, Primary Tumour, and Metastatic.

## Loading the Dataset

To use the data, you must load the library and then call the specific data object.

```r
# Load the package
library(prostateCancerVarambally)

# Load the varambally ExpressionSet object
data(varambally)

# View a summary of the object
varambally
```

## Data Structure and Exploration

The object `varambally` is an `ExpressionSet`. You can interact with it using standard Biobase methods.

### Phenotype Data (Metadata)
The samples are categorized into three groups: Benign, Tumour, and Metastatic.

```r
# Access sample metadata
metadata <- pData(varambally)

# Check the distribution of sample groups
table(varambally$Sample_Group)

# View column names (geo_accession, title, description, Sample_Group)
colnames(metadata)
```

### Feature Data (Gene Information)
The feature data contains probe information. The "Gene Symbol" column has been renamed to "Symbol" for easier access.

```r
# Access feature/gene metadata
features <- fData(varambally)

# View the first few rows
head(features[, c("Symbol", "Gene Title")])
```

### Expression Data
The expression matrix contains normalized intensity values.

```r
# Extract the expression matrix
exp_matrix <- exprs(varambally)

# Check dimensions (Probes x Samples)
dim(exp_matrix)
```

## Typical Workflow: Differential Expression

A common use case is comparing expression levels across the progression stages using `limma`.

```r
library(limma)

# Create design matrix
design <- model.matrix(~0 + varambally$Sample_Group)
colnames(design) <- levels(varambally$Sample_Group)

# Fit the linear model
fit <- lmFit(varambally, design)

# Contrast: Metastatic vs Benign
cont_matrix <- makeContrasts(MetVsBenign = Metastatic - Benign, levels = design)
fit2 <- contrasts.fit(fit, cont_matrix)
fit2 <- eBayes(fit2)

# Get top differentially expressed genes
topTable(fit2, coef="MetVsBenign", genelist=fData(varambally)$Symbol)
```

## Tips
- The `Sample_Group` factor is pre-ordered as: `Benign`, `Tumour`, `Metastatic`.
- Use `fData(varambally)$Symbol` to map probe IDs to Gene Symbols.
- This dataset is often used in meta-analyses alongside other prostate cancer datasets (e.g., Taylor, Grasso).

## Reference documentation
- [prostateCancerVarambally](./references/prostateCancerVarambally.md)