---
name: bioconductor-cosiadata
description: CoSIAdata provides variance stabilizing transformation stabilized RNA-Seq expression data across multiple tissues for six model organisms. Use when user asks to download species-specific expression datasets, access VST stabilized RNA-Seq data from ExperimentHub, or retrieve cross-species genomic data for the CoSIA workflow.
homepage: https://bioconductor.org/packages/release/data/experiment/html/CoSIAdata.html
---

# bioconductor-cosiadata

## Overview

CoSIAdata is an ExperimentHub package providing Variance Stabilizing Transformation (VST) stabilized RNA-Seq data. It contains expression data across more than 132 tissues for six model organisms: *Homo sapiens*, *Mus musculus*, *Rattus norvegicus*, *Danio rerio*, *Drosophila melanogaster*, and *Caenorhabditis elegans*. Each dataset includes Anatomical Entity Names/IDs, Ensembl IDs, and Experimental IDs, making it a primary data source for the CoSIA (Cross-Species Integration and Analysis) workflow.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("CoSIAdata")
library(CoSIAdata)
```

## Accessing Species Data

The package provides convenient helper functions to download and load specific species data directly into your R session as a data frame.

```r
# Load specific species data
hs_data <- CoSIAdata::Homo_sapiens()
mm_data <- CoSIAdata::Mus_musculus()
rn_data <- CoSIAdata::Rattus_norvegicus()
dr_data <- CoSIAdata::Danio_rerio()
dm_data <- CoSIAdata::Drosophila_melanogaster()
ce_data <- CoSIAdata::Caenorhabditis_elegans()
```

## Manual Retrieval via ExperimentHub

If you need to inspect metadata or access specific versions, you can query ExperimentHub directly.

```r
library(ExperimentHub)
eh <- ExperimentHub()

# Query for all CoSIAdata resources
cosia_resources <- query(eh, "CoSIAdata")

# View metadata table
print(cosia_resources)

# Retrieve a specific record by ID (e.g., EH7863 for C. elegans)
c_elegans_vst <- eh[["EH7863"]]
```

## Data Structure

The returned objects are typically data frames containing:
- **Anatomical Entity Name**: Common name of the tissue.
- **Anatomical Entity Id**: Ontology identifier for the tissue.
- **Ensembl Id**: Unique gene identifier.
- **Experimental Id**: Identifier for the specific experiment/library.
- **VST Counts**: The stabilized expression values.

## Workflow Integration

This data is designed to be used with the `CoSIA` package. A typical workflow involves:
1. Downloading data for two or more species using `CoSIAdata`.
2. Processing the data frames to match orthologous genes.
3. Using `CoSIA` functions to calculate diversity or specificity metrics across tissues.

## Reference documentation

- [CoSIAdata Introduction](./references/CoSIAdata_vignette.md)
- [CoSIAdata RMarkdown Source](./references/CoSIAdata_vignette.Rmd)