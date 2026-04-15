---
name: bioconductor-breastcancerupp
description: This package provides access to the Miller et al. (2005) breast cancer gene expression dataset as a curated Bioconductor ExpressionSet. Use when user asks to load the UPP dataset, analyze p53 mutation status in breast cancer, or access Affymetrix microarray data for primary breast cancer samples.
homepage: https://bioconductor.org/packages/release/data/experiment/html/breastCancerUPP.html
---

# bioconductor-breastcancerupp

name: bioconductor-breastcancerupp
description: Access and utilize the Miller et al. (2005) breast cancer gene expression dataset (UPP). Use this skill when a user needs to load, analyze, or subset the 'upp' ExpressionSet, which includes p53 mutation status, clinical outcomes, and Affymetrix hgu133a/b microarray data for 251 samples.

# bioconductor-breastcancerupp

## Overview
The `breastCancerUPP` package is a Bioconductor experiment data package providing a curated `ExpressionSet` (eSet) from the study by Miller et al. (2005). This dataset is significant for its focus on the p53 transcriptional fingerprint and its ability to distinguish p53-mutant from wild-type tumors. It contains expression data for 44,928 features across 251 primary breast cancer samples, along with comprehensive clinical metadata.

## Loading and Inspecting Data
To use this dataset, you must load the `Biobase` package alongside the data package.

```r
# Load the package and dataset
library(Biobase)
library(breastCancerUPP)
data(upp)

# Basic inspection
upp                 # View summary of the ExpressionSet
dim(upp)            # Get number of features and samples
```

## Accessing Components
The data is structured as a standard Bioconductor `ExpressionSet`.

### Expression Data
Contains single-channel oligonucleotide microarray data (Affymetrix hgu133a/hgu133b).
```r
# Access expression matrix
exp_matrix <- exprs(upp)
exp_matrix[1:5, 1:5] # View first 5 rows and columns
```

### Phenotype (Clinical) Data
Contains patient information, including p53 status, survival data, and treatment response.
```r
# Access clinical metadata
clinical_data <- pData(upp)
head(clinical_data)

# Common columns of interest
# p53 status, survival time, and event indicators are typically present
colnames(clinical_data)
```

### Feature (Annotation) Data
Contains probe information for the Affymetrix platforms.
```r
# Access probe annotations
feature_info <- fData(upp)
head(feature_info)

# Check the platform used
annotation(upp)
```

## Typical Workflow: p53 Analysis
The primary utility of this dataset is analyzing the 32-gene signature related to p53 status.

```r
# Example: Compare expression between p53 mutant and wild-type
# Note: Ensure 'p53' or similar column exists in pData(upp)
p53_status <- pData(upp)$p53 

# Subset for wild-type samples
wt_samples <- upp[, pData(upp)$p53 == "0"] # Assuming 0 is WT
```

## Metadata and Documentation
To understand the experimental design and the study's findings:
```r
# View the study abstract
abstract(upp)

# View MIAME (Minimum Information About a Microarray Experiment)
experimentData(upp)
```

## Reference documentation
- [Package Reference Manual](./references/reference_manual.md)