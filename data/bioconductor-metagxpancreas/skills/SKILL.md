---
name: bioconductor-metagxpancreas
description: MetaGxPancreas provides a standardized compendium of pancreatic cancer gene expression datasets and clinical metadata for meta-analysis. Use when user asks to load pancreatic cancer datasets, perform meta-analysis across multiple studies, or access curated gene expression data in SummarizedExperiment format.
homepage: https://bioconductor.org/packages/release/data/experiment/html/MetaGxPancreas.html
---

# bioconductor-metagxpancreas

## Overview

MetaGxPancreas is a Bioconductor experiment data package that provides a standardized compendium of pancreatic cancer gene expression datasets. It currently includes 15+ datasets (such as TCGA, ICGC, and PCSI) representing over 1,700 samples. The package facilitates meta-analysis by providing data in `SummarizedExperiment` format, including clinical metadata like overall survival status and time for the majority of samples.

## Installation

To install the package, use `BiocManager`:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MetaGxPancreas")
```

## Loading Datasets

The primary entry point for the package is the `loadPancreasDatasets()` function. By default, it retrieves all available datasets from ExperimentHub.

```r
library(MetaGxPancreas)

# Load all datasets with default settings
pancreasData <- loadPancreasDatasets()

# Access the list of SummarizedExperiment objects
SEs <- pancreasData$SummarizedExperiments

# Access information about removed duplicates
duplicates <- pancreasData$duplicates
```

### Customizing Data Loading

You can filter and preprocess data during the loading phase using several parameters:

- `removeDuplicates`: (Default: `TRUE`) Removes patients with Spearman correlation ≥ 0.98.
- `quantileCutoff`: (Default: `0`) Numeric (0-1) to remove genes with low standard deviation.
- `rescale`: (Default: `FALSE`) If `TRUE`, applies centering and scaling to expression sets.
- `minSampleSize`: (Default: `0`) Minimum number of patients required to keep a dataset.
- `minNumberEvents`: (Default: `0`) Minimum number of survival events required.
- `imputeMissing`: (Default: `FALSE`) If `TRUE`, imputes missing values via k-nearest neighbors (knn).
- `keepCommonOnly`: (Default: `FALSE`) If `TRUE`, retains only probes common to all datasets.

Example of a restricted load:
```r
pancreasData <- loadPancreasDatasets(
  rescale = TRUE,
  minSampleSize = 40,
  minNumberEvents = 10
)
```

## Data Exploration

Once loaded, you can inspect the sample sizes and metadata across the different studies.

### Sample Counts
```r
numSamples <- vapply(SEs, function(SE) ncol(SE), numeric(1))
sampleTable <- data.frame(numSamples = numSamples)
print(sampleTable)
```

### Accessing Metadata and Expression
Since the data is stored as `SummarizedExperiment` objects, use standard Bioconductor methods:

```r
# Get expression matrix for the first dataset
exprs_data <- assay(SEs[[1]])

# Get clinical/phenotype data
pheno_data <- colData(SEs[[1]])

# Check survival columns (usually 'days_to_death' or 'vital_status')
head(pheno_data)
```

## Typical Workflow

1. **Load Data**: Use `loadPancreasDatasets()` with `rescale = TRUE` if performing meta-analysis across platforms.
2. **Filter**: Use `keepCommonOnly = TRUE` if you need a unified gene set for a multi-study model.
3. **Analyze**: Perform survival analysis (e.g., Cox proportional hazards) or differential expression using the `colData` and `assay` components.
4. **Validate**: Train a signature on one dataset (e.g., `TCGA_SumExp`) and test it on others (e.g., `ICGCMICRO_SumExp`).

## Reference documentation

- [MetaGxPancreas: A Package for Pancreatic Cancer Gene Expression Analysis](./references/MetaGxPancreas.md)