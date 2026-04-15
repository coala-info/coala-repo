---
name: bioconductor-scpdata
description: This tool provides access to curated mass spectrometry-based single-cell proteomics datasets from Bioconductor. Use when user asks to load standardized single-cell proteomics data, retrieve datasets for benchmarking, or access mass spectrometry data at PSM, peptide, and protein levels.
homepage: https://bioconductor.org/packages/release/data/experiment/html/scpdata.html
---

# bioconductor-scpdata

name: bioconductor-scpdata
description: Access and retrieve curated mass spectrometry-based single-cell proteomics (SCP) datasets from Bioconductor. Use this skill when you need to load standardized SCP data for analysis, benchmarking, or method development. The skill provides access to datasets at PSM, peptide, and protein levels across various technologies (DDA, DIA, label-free, multiplexed).

# bioconductor-scpdata

## Overview

The `scpdata` package is a Bioconductor ExperimentData package that disseminates curated single-cell proteomics (SCP) datasets. All datasets are formatted using the `QFeatures` and `scp` data structures, ensuring consistency across different studies and technologies. It acts as a bridge to `ExperimentHub`, providing easy access to high-quality data from major labs (e.g., Slavov, Kelly, Schoof) without manual data wrangling.

## Loading and Exploring Datasets

### Initializing Access
To browse available datasets, use the `scpdata()` function or query `ExperimentHub` directly.

```r
library(scpdata)
library(ExperimentHub)

# List all available datasets and their metadata
info <- scpdata()
head(info[, c("title", "description")])

# Alternative: Query via ExperimentHub
eh <- ExperimentHub()
query(eh, "scpdata")
```

### Retrieving Data
You can load a dataset using its specific named function or its `ExperimentHub` ID (e.g., "EH3901").

```r
# Method 1: Use the dataset-specific function (recommended)
scp <- dou2019_lysates()

# Method 2: Use ExperimentHub ID
scp <- eh[["EH3901"]]
```

## Data Structure

Datasets are returned as `QFeatures` objects. A typical object contains:
- **Assays**: Multiple matrices representing different processing levels (e.g., `Hela_run_1` for PSMs, `peptides`, `proteins`).
- **ColData**: Sample annotations (cell line, treatment, acquisition batch, etc.).
- **RowData**: Feature annotations (protein IDs, sequence information, etc.).

```r
# Inspect the object
scp

# Access sample metadata
colData(scp)

# Access a specific assay (e.g., proteins)
assay(scp, "proteins")
```

## Typical Workflow

1. **Identify**: Use `scpdata()` to find a dataset matching your species or technology of interest.
2. **Load**: Call the dataset function (e.g., `specht2019v2()`).
3. **Integrate**: Use the `scp` package for downstream processing (normalization, imputation, etc.).
4. **Analyze**: Since the data is in `SingleCellExperiment` format within the `QFeatures` object, it is compatible with standard Bioconductor single-cell tools.

## Tips for Usage

- **Caching**: `ExperimentHub` caches data locally. The first download may take time, but subsequent loads will be near-instant.
- **Documentation**: Every dataset has a dedicated help page. Use `?dataset_name` (e.g., `?leduc2022_pSCoPE`) to see details on acquisition protocols and data collection.
- **Minimal Processing**: Datasets are provided with minimal processing to allow users to apply their own normalization and filtering pipelines.

## Reference documentation

- [Contribution Guidelines](./references/contribution_guidelines.md)
- [Single Cell Proteomics data sets](./references/scpdata.md)