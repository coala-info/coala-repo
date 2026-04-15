---
name: bioconductor-microbiomedatasets
description: This package provides a centralized interface to download and load curated microbiome datasets as standardized Bioconductor objects. Use when user asks to retrieve microbiome study data, load TreeSummarizedExperiment or MultiAssayExperiment objects, or access datasets like Grieneisen, Lahti, or O'Keefe for analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/microbiomeDataSets.html
---

# bioconductor-microbiomedatasets

name: bioconductor-microbiomedatasets
description: Access and load curated microbiome datasets from Bioconductor. Use this skill when you need to retrieve standardized microbiome data (e.g., Grieneisen, Lahti, O'Keefe) as TreeSummarizedExperiment or MultiAssayExperiment objects for analysis.

# bioconductor-microbiomedatasets

## Overview

The `microbiomeDataSets` package provides a centralized interface for downloading and caching curated microbiome datasets from ExperimentHub. These datasets are typically formatted as `TreeSummarizedExperiment` objects (for taxonomic data) or `MultiAssayExperiment` objects (when multiple data types like metabolomics are present), making them immediately compatible with the `mia` (Microbiome Analysis) ecosystem and other Bioconductor tools.

## Core Workflow

### 1. List Available Datasets
To see which datasets are currently available in the package:

```r
library(microbiomeDataSets)
availableDataSets()
```

### 2. Loading Data
Datasets are loaded using specific functions named after the first author of the study. Data is automatically downloaded from ExperimentHub and cached locally.

```r
# Load a specific dataset (e.g., Grieneisen TS data)
tse <- GrieneisenTSData()

# Load a dataset with multiple assays (e.g., O'Keefe DS data)
mae <- OKeefeDSData()
```

### 3. Common Dataset Functions
The following functions are commonly used to retrieve specific studies:
- `GrieneisenTSData()`: Large-scale primate gut microbiome longitudinal data.
- `LahtiMLData()` / `LahtiMData()`: Human intestinal microbiota data.
- `OKeefeDSData()`: Diet swap study data (often returns a MultiAssayExperiment).
- `SilvermanAGutData()`: Human gut microbiome data.
- `SongQAData()`: Quality assessment data.
- `SprockettTHData()`: Human infant gut data.

## Data Structures

### TreeSummarizedExperiment (TSE)
Most taxonomic datasets are returned as a `TreeSummarizedExperiment`.
- **Assays**: Contain abundance tables (e.g., counts).
- **RowData**: Contains taxonomic information.
- **ColData**: Contains sample metadata (age, sex, clinical variables).
- **RowTree**: Phylogenetic tree (if available).

### MultiAssayExperiment (MAE)
If the study includes multi-omics data (e.g., 16S rRNA + Metabolomics):
- Use `experiments(mae)` to list the different data types.
- Use `mae[[1]]` or `mae[["experiment_name"]]` to extract a specific experiment as a TSE.

## Tips and Best Practices
- **Caching**: The first time you call a data function, it will download the data. Subsequent calls will load the data from your local BiocFileCache.
- **Integration**: These objects are designed to be used directly with the `mia` package for downstream analysis (e.g., `mia::estimateRichness(tse)`).
- **Help**: Use `?GrieneisenTSData` (or any other function name) to view specific metadata, including the original publication DOI and data processing details.

## Reference documentation
- [microbiomeDataSets](./references/microbiomeDataSets.md)