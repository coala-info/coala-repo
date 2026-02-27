---
name: bioconductor-prostatecancergrasso
description: This package provides access to the Grasso et al. (2012) prostate cancer expression dataset as a Bioconductor ExpressionSet object. Use when user asks to load Agilent microarray data from prostate cancer samples, access clinical metadata for disease stages, or perform differential expression analysis on the Grasso dataset.
homepage: https://bioconductor.org/packages/release/data/experiment/html/prostateCancerGrasso.html
---


# bioconductor-prostatecancergrasso

name: bioconductor-prostatecancergrasso
description: Access and utilize the Grasso et al. (2012) prostate cancer expression dataset. Use this skill to load the 'grasso' ExpressionSet object, which contains Agilent microarray data from benign, localized, and metastatic prostate cancer samples (GSE35988).

## Overview
The `prostateCancerGrasso` package is a Bioconductor data experiment package providing the processed Agilent expression data from the study "The Mutational Landscape of Lethal Castrate Resistant Prostate Cancer" (Grasso et al., 2012). The dataset includes transcriptomic profiles of prostate tissue across different stages of disease progression: Benign, Hormone-Dependent (localized), and Castrate-Resistant (metastatic).

## Loading the Dataset
To use the data, load the library and call the `grasso` data object.

```r
# Load the package
library(prostateCancerGrasso)

# Load the ExpressionSet object
data(grasso)

# View a summary of the object
grasso
```

## Data Structure and Access
The data is stored as a standard Bioconductor `ExpressionSet` object.

### Phenotypic Data (Sample Metadata)
Access the clinical groups and sample identifiers:
```r
# View sample metadata
head(pData(grasso))

# Check sample distribution across groups
table(grasso$Group)
# Groups: "Benign", "HormomeDependant", "CastrateResistant"
```

### Expression Data
Access the normalized Agilent microarray intensity values:
```r
# Get expression matrix
exp_matrix <- exprs(grasso)

# View first few rows/columns
exp_matrix[1:5, 1:5]
```

### Feature Data (Gene Information)
Access gene symbols and Entrez IDs:
```r
# View gene annotations
head(fData(grasso))

# Columns typically include: "ID", "GENE", "GENE_SYMBOL"
```

## Typical Workflow: Differential Expression
A common use case is comparing expression between disease stages using `limma`.

```r
library(limma)

# Create design matrix based on the Group column
design <- model.matrix(~0 + grasso$Group)
colnames(design) <- c("Benign", "CastrateResistant", "HormomeDependant")

# Fit linear model
fit <- lmFit(grasso, design)

# Contrast: Metastatic vs Benign
cont.matrix <- makeContrasts(CR_vs_Benign = CastrateResistant - Benign, levels=design)
fit2 <- contrasts.fit(fit, cont.matrix)
fit2 <- eBayes(fit2)

# View top differentially expressed genes
topTable(fit2, coef="CR_vs_Benign", genelist=fData(grasso)$GENE_SYMBOL)
```

## Reference documentation
- [The Mutational Landscape of Lethal Castrate Resistant Prostate Cancer](./references/prostateCancerGrasso.md)