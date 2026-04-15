---
name: bioconductor-restfulsedata
description: This package provides metadata-only SummarizedExperiment shells for accessing large remote genomic datasets. Use when user asks to retrieve lightweight data shells from ExperimentHub, discover available remote data resources, or prepare metadata for real-time remote assay access.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/restfulSEData.html
---

# bioconductor-restfulsedata

name: bioconductor-restfulsedata
description: Access and manage SummarizedExperiment shells for remote assay data. Use this skill to retrieve metadata-only R objects from ExperimentHub that are designed to work with the restfulSE package for real-time remote data access.

# bioconductor-restfulsedata

## Overview

The `restfulSEData` package provides "shells" (metadata-only instances) of `SummarizedExperiment` or `RangedSummarizedExperiment` objects. These objects have had their heavy assay data removed to allow for lightweight distribution. They are specifically designed to be used in conjunction with the `restfulSE` package, which restores the assay data in real-time from remote data stores (like HDF5 server or Google BigQuery).

## Core Workflow

### 1. Discovering Available Datasets
Use the `dataResource()` function to see a list of available remote data shells provided by this package.

```r
library(restfulSEData)
dataResource()
```

Commonly available resources include:
- `banoSEMeta`: Metadata for Banovich SE (methylation).
- `st100k` / `st400k` / `full_1Mneurons`: Subsets and full versions of the 10x Genomics 1.3 million neuron dataset.
- `gtexRecount`: Metadata for RECOUNT GTEx gene expression.
- `tasicST6`: Supplemental data from Tasic et al. (2016).

### 2. Retrieving Shells via ExperimentHub
The primary way to load these objects is through `ExperimentHub`.

```r
library(ExperimentHub)
ehub <- ExperimentHub()

# Query for restfulSEData records
myfiles <- query(ehub, "restfulSEData")

# Load a specific record by index or EH ID
# Example: EH551 is banoSEMeta
banoSEMeta <- myfiles[["EH551"]]
```

### 3. Inspecting the Shell
Once loaded, the object behaves like a standard `SummarizedExperiment`, but the `assays()` slot will typically be empty or set up for remote access.

```r
# Check dimensions and metadata
dim(banoSEMeta)
rowData(banoSEMeta)
colData(banoSEMeta)
```

## Usage Tips
- **Integration with restfulSE**: These shells are intended to be passed to functions in the `restfulSE` package to establish a live connection to the underlying data.
- **Memory Efficiency**: Because these objects contain only metadata (genomic coordinates, sample information, and feature annotations), they are extremely small and can be loaded without high memory overhead, even for massive datasets like the 1.3 million neuron collection.
- **Caching**: `ExperimentHub` will cache the metadata shells locally after the first download.

## Reference documentation
- [restfulSEData – SummarizedExperiment shells for remote assay data](./references/restfulSEData.md)