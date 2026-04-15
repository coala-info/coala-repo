---
name: bioconductor-curatedtcgadata
description: This package provides a streamlined interface for accessing and integrating highly curated The Cancer Genome Atlas (TCGA) data as MultiAssayExperiment objects. Use when user asks to download TCGA datasets, explore available cancer assays, filter samples by type, or access standardized clinical and subtype information.
homepage: https://bioconductor.org/packages/release/data/experiment/html/curatedTCGAData.html
---

# bioconductor-curatedtcgadata

## Overview

The `curatedTCGAData` package provides a streamlined interface to highly curated TCGA data. It delivers data as `MultiAssayExperiment` objects, which coordinate multiple experimental assays (e.g., gene expression, CNV, mutations) with patient clinical data. This skill covers data acquisition, versioning, and integration with `TCGAutils` for sample selection and clinical mapping.

## Core Workflow

### 1. Installation and Setup

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install(c("curatedTCGAData", "MultiAssayExperiment", "TCGAutils"))

library(curatedTCGAData)
library(MultiAssayExperiment)
library(TCGAutils)
```

### 2. Exploring Available Data

To see which cancer types (disease codes) are available:
```r
data("diseaseCodes", package = "TCGAutils")
# View available codes (e.g., ACC, BRCA, COAD)
subset(diseaseCodes, Available == "Yes")
```

To see available assays for a specific disease (e.g., Colon Adenocarcinoma):
```r
curatedTCGAData(diseaseCode = "COAD", assays = "*", dry.run = TRUE)
```

### 3. Loading Data

Load specific assays for a cancer type. It is recommended to use `version = "2.0.1"` for the latest improvements (e.g., GRCh37 coordinates, merged platforms).

```r
# Load Mutation and RNASeq data for Adrenocortical Carcinoma
mae <- curatedTCGAData(
    diseaseCode = "ACC", 
    assays = c("Mutation", "RNASeq2GeneNorm"), 
    version = "2.0.1", 
    dry.run = FALSE
)
```

### 4. Clinical and Subtype Data

Access patient metadata and standardized clinical variables:
```r
# Get common clinical names (vital_status, days_to_death, etc.)
clinical_vars <- getClinicalNames("ACC")
colData(mae)[, clinical_vars]

# Access cancer-specific subtype information
getSubtypeMap(mae)
```

### 5. Sample Selection and Filtering

TCGA datasets often contain a mix of primary tumors, metastatic sites, and normal controls. Use `TCGAutils` to filter for specific sample types.

```r
# Extract only primary tumor samples
primary_mae <- TCGAprimaryTumors(mae)

# Manually split assays by sample type (e.g., 01 = Primary Solid Tumor, 11 = Solid Tissue Normal)
split_mae <- TCGAsplitAssays(mae, sampleCodes = c("01", "11"))
```

### 6. Extracting Assays

To work with a single assay while retaining patient clinical data:
```r
# Extract mutation data and append clinical colData
mutations <- getWithColData(mae, "ACC_Mutation-20160128", mode = "append")
```

## Data Classes

- **SummarizedExperiment**: Used for rectangular data like RNA-seq or Microarray.
- **RaggedExperiment**: Used for genomic range-based data like Mutations or Copy Number (CNV). Use `sparseAssay()` or `qreduceAssay()` to convert these to matrix formats for analysis.

## Tips and Best Practices

- **Dry Run**: Always set `dry.run = TRUE` first to check assay names and file sizes before downloading.
- **Wildcards**: Use `assays = "*"` to see all available data types for a cohort.
- **Versioning**: If reproducing older research, you may need `version = "1.1.38"`.
- **Replicates**: Use `TCGAutils::mergeReplicates()` if a patient has multiple samples for the same assay.
- **Exporting**: Use `exportClass(mae, dir = "output_path", fmt = "csv")` to save the integrated data for use in other environments.

## Reference documentation

- [curatedTCGAData](./references/curatedTCGAData.md)