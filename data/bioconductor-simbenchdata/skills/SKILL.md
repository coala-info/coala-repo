---
name: bioconductor-simbenchdata
description: This tool provides access to 35 curated single-cell RNA-seq datasets for benchmarking simulation methods and analysis workflows. Use when user asks to retrieve benchmark scRNA-seq datasets, explore dataset metadata, or download standardized single-cell data for testing algorithms.
homepage: https://bioconductor.org/packages/release/data/experiment/html/SimBenchData.html
---

# bioconductor-simbenchdata

name: bioconductor-simbenchdata
description: Access and explore the SimBenchData collection of 35 curated single-cell RNA-seq datasets. Use this skill when you need to retrieve high-quality benchmark datasets covering various protocols (10x, inDrops, etc.), species (Human, Mouse), and tissues for evaluating single-cell simulation methods or analysis workflows.

# bioconductor-simbenchdata

## Overview

`SimBenchData` is a Bioconductor data experiment package providing 35 standardized single-cell RNA-seq datasets. These datasets were originally compiled to benchmark single-cell simulation methods but serve as a general-purpose resource for testing scRNA-seq algorithms. Data is stored as `Seurat` objects and retrieved via `ExperimentHub`.

## Data Retrieval Workflow

Datasets are hosted on `ExperimentHub`. You must first query the hub to identify the specific dataset ID (e.g., "EH5384").

```r
library(ExperimentHub)
library(SimBenchData)

# Initialize ExperimentHub and query for SimBenchData records
eh <- ExperimentHub()
alldata <- query(eh, "SimBenchData")

# View available datasets
print(alldata)

# Download a specific dataset by its ExperimentHub ID
# Example: 293T cell line
seurat_obj <- alldata[["EH5384"]]
```

## Exploring Metadata

The package provides helper functions to inspect the characteristics of the 35 available datasets without downloading the full objects first.

### Basic Metadata
Use `showMetaData()` to see provider info, source URLs, species, and genome versions.

```r
metadata <- showMetaData()
head(metadata)
```

### Technical Details
Use `showAdditionalDetail()` for experimental specifics like sequencing protocol, cell counts, and whether the data contains multiple conditions/cell types.

```r
details <- showAdditionalDetail()
# Filter for specific protocols, e.g., 10x Genomics
tenx_data <- details[details$Protocol == "10x Genomics", ]
```

## Usage Tips

- **Object Class**: Most datasets are returned as `SeuratObject` instances. Ensure the `Seurat` library is loaded to manipulate them.
- **Caching**: `ExperimentHub` caches downloads locally. Subsequent calls to the same ID will be significantly faster.
- **Selection**: Use `showAdditionalDetail()` to identify datasets that match your specific benchmarking needs (e.g., filtering for "Human" species or datasets with "Multiple_celltypes_or_conditions == Yes").

## Reference documentation

- [SimBenchData: a collection of 35 single-cell RNA-seq data](./references/SimBenchData-vignette.md)