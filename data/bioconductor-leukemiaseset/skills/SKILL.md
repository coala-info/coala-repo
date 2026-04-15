---
name: bioconductor-leukemiaseset
description: This package provides a curated ExpressionSet object containing preprocessed microarray gene expression data for the four main types of leukemia and healthy controls. Use when user asks to load leukemia gene expression data, access MILE study microarray samples, or perform multi-class classification analysis on bone marrow expression profiles.
homepage: https://bioconductor.org/packages/release/data/experiment/html/leukemiasEset.html
---

# bioconductor-leukemiaseset

## Overview
The `leukemiasEset` package provides a curated `ExpressionSet` object containing microarray gene expression data from 60 bone marrow samples. The data represents the four main types of leukemia (Acute Lymphoblastic, Acute Myeloid, Chronic Lymphocytic, and Chronic Myeloid) plus healthy/non-leukemia controls. The data was generated using Affymetrix Human Genome U133 Plus 2.0 chips and preprocessed using RMA with Ensembl Gene ID mapping (GeneMapper).

## Data Loading and Initial Inspection
To use the dataset, you must load the library and then use the `data()` function to bring the object into the environment.

```R
# Load the package
library(leukemiasEset)

# Load the dataset
data(leukemiasEset)

# View the ExpressionSet object summary
leukemiasEset
```

## Accessing Metadata (PhenoData)
The dataset includes phenotypic information critical for classification and group comparisons.

```R
# View the sample metadata table
pData(leukemiasEset)

# Check the distribution of leukemia types
table(leukemiasEset$LeukemiaType)

# Available columns:
# - LeukemiaType: Acronyms (ALL, AML, CLL, CML, NoL)
# - LeukemiaTypeFullName: Descriptive names
# - Subtype: Specific cytogenetic or karyotype info
```

## Accessing Expression Data
The expression matrix contains 20,172 features (Ensembl IDs).

```R
# Extract the expression matrix
exp_matrix <- exprs(leukemiasEset)

# View first few rows and columns
exp_matrix[1:5, 1:5]

# Get feature (Gene) IDs
featureNames(leukemiasEset)[1:10]
```

## Common Workflows

### Sample Renaming
A common practice with this dataset is to prefix sample names with their disease type for easier identification in plots.

```R
sampleNames(leukemiasEset) <- paste(leukemiasEset$LeukemiaType, 
                                    sampleNames(leukemiasEset), 
                                    sep="_")
```

### Subset for Specific Comparison
If you only want to compare two types (e.g., AML vs. NoL):

```R
# Subset the ExpressionSet
aml_vs_nol <- leukemiasEset[, leukemiasEset$LeukemiaType %in% c("AML", "NoL")]
```

### Integration with geNetClassifier
This dataset is frequently used as the example input for the `geNetClassifier` package to perform multi-class gene selection and classification.

## Tips
- **Feature IDs**: The features are Ensembl IDs (e.g., ENSG00000000003). If you need Gene Symbols, you will need to use `biomaRt` or `org.Hs.eg.db` for mapping.
- **Normalization**: The data is already RMA-normalized and log2-transformed. No further initial normalization is typically required for standard downstream analysis.
- **Source**: This is a subset of the MILE (Microarray Innovations in Leukemia) study (GSE13159).

## Reference documentation
- [Leukemia's microarray gene expression data (expressionSet)](./references/reference_manual.md)