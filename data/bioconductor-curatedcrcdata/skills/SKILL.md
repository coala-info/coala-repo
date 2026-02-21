---
name: bioconductor-curatedcrcdata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/curatedCRCData.html
---

# bioconductor-curatedcrcdata

name: bioconductor-curatedcrcdata
description: Access and analyze curated colorectal cancer (CRC) gene expression datasets from the curatedCRCData Bioconductor package. Use this skill when a user needs to load standardized ExpressionSet objects for CRC, perform meta-analysis, or retrieve clinical metadata and survival data from multiple public CRC studies.

# bioconductor-curatedcrcdata

## Overview
The `curatedCRCData` package provides a collection of colorectal cancer (CRC) gene expression datasets, curated and homogenized into `ExpressionSet` objects. It is designed for large-scale meta-analysis, allowing researchers to easily combine multiple studies while maintaining consistent clinical metadata (e.g., stage, grade, survival time, and recurrence status).

## Installation and Loading
To use the package, ensure it is installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("curatedCRCData")
library(curatedCRCData)
```

## Typical Workflow

### 1. Listing Available Datasets
The package contains many datasets named after the primary author or study (e.g., `GSE14333_eset`). You can list available data using:

```r
# List all objects available in the package
data(package = "curatedCRCData")
```

### 2. Loading a Specific Dataset
Load a dataset into the R environment using the `data()` function.

```r
# Example: Loading the GSE14333 dataset
data(GSE14333_eset)

# View the ExpressionSet object
GSE14333_eset
```

### 3. Accessing Expression and Clinical Data
Since the data are stored as `ExpressionSet` objects, use standard `Biobase` methods:

```r
# Extract expression matrix (genes x samples)
exprs_matrix <- exprs(GSE14333_eset)

# Extract clinical metadata (samples x variables)
clinical_data <- pData(GSE14333_eset)

# View available clinical variables
colnames(clinical_data)
```

### 4. Common Clinical Variables
The curation process standardizes variable names across studies. Common fields include:
- `vital_status`: "living" or "deceased"
- `days_to_death`: Number of days to death
- `recurrence_status`: "recurrence" or "norecurrence"
- `days_to_tumor_recurrence`: Time to recurrence
- `pathologic_stage`: TNM stage (e.g., I, II, III, IV)
- `age_at_initial_pathologic_diagnosis`: Patient age

### 5. Data Filtering and Preprocessing
Datasets often contain "NA" values for certain clinical parameters. It is standard practice to filter for samples with complete survival data before analysis:

```r
# Filter for samples with known survival time and status
keep <- !is.na(GSE14333_eset$vital_status) & !is.na(GSE14333_eset$days_to_death)
GSE14333_subset <- GSE14333_eset[, keep]
```

## Tips for Meta-Analysis
- **Gene Symbols**: Most datasets use Gene Symbols as feature names. Check `featureNames(eset)` to verify.
- **Merging**: Use the `merge` or `cbind` functions carefully, or better yet, use the `MultiAssayExperiment` package or simple list-based iteration to handle multiple studies.
- **Batch Effects**: When combining datasets, always perform batch effect correction (e.g., using `sva::ComBat`) as the data come from different platforms and labs.

## Reference documentation
- [curatedCRCData Bioconductor Page](https://bioconductor.org/packages/release/data/experiment/html/curatedCRCData.html)