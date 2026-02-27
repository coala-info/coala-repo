---
name: bioconductor-prostatecancertaylor
description: This package provides curated DNA copy number, mRNA expression, and clinical data from the Taylor et al. prostate cancer study as a Bioconductor ExpressionSet. Use when user asks to access the Taylor prostate cancer dataset, perform survival analysis on biochemical recurrence, or conduct differential expression between primary and metastatic prostate cancer samples.
homepage: https://bioconductor.org/packages/release/data/experiment/html/prostateCancerTaylor.html
---


# bioconductor-prostatecancertaylor

## Overview
The `prostateCancerTaylor` package provides a curated Bioconductor version of the landmark integrative genomic profiling study by Taylor et al. (2010). It contains concordant assessment of DNA copy number, mRNA expression, and clinical data (including Gleason scores and biochemical recurrence) for primary and metastatic prostate cancer samples. The data is primarily stored as an `ExpressionSet` object named `taylor`.

## Loading the Dataset
To use the data, load the library and the specific dataset object:

```r
library(prostateCancerTaylor)
data(taylor)
```

## Data Structure and Exploration
The `taylor` object is an `ExpressionSet`. You can interact with it using standard Biobase methods:

### Accessing Expression Data
Retrieve the processed Affymetrix expression matrix:
```r
exp_matrix <- exprs(taylor)
# View first few rows and columns
exp_matrix[1:5, 1:5]
```

### Accessing Clinical Metadata
The phenotype data contains critical clinical variables such as Gleason score, disease status, and survival/recurrence data:
```r
clinical_data <- pData(taylor)

# Key columns include:
# - Sample_Group: Disease status (Primary, Metastatic, Normal)
# - Gleason: Pathological Gleason score
# - Time: BCR (Biochemical Recurrence) Free Time
# - Event: BCR Event (TRUE/FALSE)
# - Copy.number.Cluster: Clusters defined by CNAs
```

### Accessing Feature Metadata
Retrieve gene annotations, including Entrez IDs and Gene Symbols:
```r
gene_anno <- fData(taylor)
```

## Typical Workflows

### Survival Analysis (Biochemical Recurrence)
The dataset is frequently used to validate prognostic signatures using the BCR (Biochemical Recurrence) data:
```r
library(survival)
# Create a survival object
surv_obj <- Surv(taylor$Time, taylor$Event)

# Fit a curve based on Sample Group
fit <- survfit(surv_obj ~ Sample_Group, data = pData(taylor))
plot(fit, col = 1:3, lty = 1, main = "BCR-Free Survival by Group")
```

### Differential Expression
Compare primary vs. metastatic samples:
```r
library(limma)
group <- factor(taylor$Sample_Group)
design <- model.matrix(~0 + group)
colnames(design) <- levels(group)

fit <- lmFit(taylor, design)
cont_matrix <- makeContrasts(Metastatic - Primary, levels = design)
fit2 <- contrasts.fit(fit, cont_matrix)
fit2 <- eBayes(fit2)
topTable(fit2)
```

## Tips
- **Data Source**: This data originates from GEO series GSE21034.
- **Gene Mapping**: The package uses `org.Hs.eg.db` for mapping. If you need to map specific probes to newer annotations, use the `fData(taylor)` Entrez IDs as keys.
- **CNA Clusters**: The `Copy.number.Cluster` variable in `pData` represents the clusters identified in the original paper that robustly define low- and high-risk disease.

## Reference documentation
- [Integrative genomic profiling of human prostate cancer](./references/prostateCancerTaylor.md)