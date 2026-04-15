---
name: bioconductor-metagxovarian
description: This package provides curated and standardized ovarian cancer transcriptomic datasets for meta-analysis and cross-study validation. Use when user asks to load ovarian cancer gene expression data, perform meta-analysis across multiple cohorts, or conduct large-scale survival analyses.
homepage: https://bioconductor.org/packages/release/data/experiment/html/MetaGxOvarian.html
---

# bioconductor-metagxovarian

name: bioconductor-metagxovarian
description: Access and analyze curated ovarian cancer transcriptomic datasets. Use this skill when performing meta-analysis, validating gene signatures, or conducting large-scale survival analyses across multiple ovarian cancer cohorts.

## Overview
MetaGxOvarian is a Bioconductor experiment data package that provides a collection of curated ovarian cancer gene expression datasets. These datasets are standardized into `ExpressionSet` objects with harmonized metadata, making them suitable for meta-analysis and cross-study validation.

## Installation and Loading
To use the package, ensure it is installed via BiocManager and load it into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MetaGxOvarian")
library(MetaGxOvarian)
```

## Loading Datasets
The primary function for retrieving data is `loadOvarianDatasets()`. This function downloads and loads the curated datasets into a list.

### Basic Usage
```r
# Load all available datasets (this may take time and memory)
all_datasets <- loadOvarianDatasets()

# Load a specific subset or bundle
# Options for bundle include "all", "short", or specific study names
datasets <- loadOvarianDatasets(bundle = "all", remove.duplicates = TRUE)
```

### Parameters
- `bundle`: Character string specifying which datasets to load. Default is "all".
- `remove.duplicates`: Logical. If TRUE, removes duplicate samples across different studies based on patient IDs.

## Working with the Data
The returned object is a `list` where each element is an `ExpressionSet`.

### Inspecting the Collection
```r
# List the names of the loaded studies
names(datasets)

# Check the number of samples in each study
sapply(datasets, function(x) ncol(exprs(x)))
```

### Accessing Metadata and Expression
Standard `Biobase` methods are used to interact with the individual datasets:

```r
# Select a specific study (e.g., TCGA)
eset <- datasets[["TCGA"]]

# Extract expression matrix
expression_matrix <- exprs(eset)

# Extract clinical/phenotype data
clinical_data <- pData(eset)

# Extract feature/gene information
gene_info <- fData(eset)
```

## Common Workflows

### Filtering by Clinical Variable
To perform analysis on a specific subtype (e.g., High-Grade Serous Ovarian Cancer):

```r
# Example: Filter for samples with specific histology in the metadata
hgsoc_list <- lapply(datasets, function(eset) {
  # Note: Metadata column names are harmonized but check availability
  if("histological_type" %in% colnames(pData(eset))) {
    return(eset[, eset$histological_type == "serous"])
  }
  return(NULL)
})
```

### Preparing for Meta-Analysis
When combining studies, ensure you match features (usually by Entrez ID or Gene Symbol) provided in the `fData` slot.

```r
# Identify common genes across all loaded datasets
common_genes <- Reduce(intersect, lapply(datasets, function(x) rownames(fData(x))))

# Subset all datasets to common genes
datasets_common <- lapply(datasets, function(x) x[common_genes, ])
```

## Tips for Usage
- **Memory Management**: Loading all datasets simultaneously requires significant RAM. If memory is limited, load specific studies sequentially or use the `bundle` parameter to load smaller subsets.
- **Metadata Consistency**: While MetaGxOvarian harmonizes many clinical variables (like `days_to_death`, `vital_status`, `debulking`), always verify the presence of a column in `pData()` before attempting to access it across the entire list.
- **Duplicate Removal**: Use `remove.duplicates = TRUE` to ensure that patients participating in multiple studies (e.g., a pilot study and a larger consortium study) are not double-counted in meta-analyses.

## Reference documentation
- [MetaGxOvarian Bioconductor Page](https://bioconductor.org/packages/release/data/experiment/html/MetaGxOvarian.html)