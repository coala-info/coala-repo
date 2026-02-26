---
name: bioconductor-emtdata
description: This tool provides access to curated, pre-processed RNA-seq datasets related to Epithelial to Mesenchymal Transition (EMT) stored as SummarizedExperiment objects. Use when user asks to load EMT-related transcriptomic data, access Cursons or Foroutan datasets, or retrieve experiment data for differential expression and co-expression analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/emtdata.html
---


# bioconductor-emtdata

name: bioconductor-emtdata
description: Access and use pre-processed RNA-seq data sets related to Epithelial to Mesenchymal Transition (EMT) from the emtdata Bioconductor package. Use this skill when a user needs to load EMT-related experiment data (Cursons 2015, Cursons 2018, or Foroutan 2017) for differential expression, co-expression, or regulatory analysis.

# bioconductor-emtdata

## Overview

The `emtdata` package provides access to three curated transcriptomic datasets where Epithelial to Mesenchymal Transition (EMT) was induced in various cell lines (HMLE, PMC42, MDA-MB-468, etc.) via TGFb or other stimulants. The data is stored as `SummarizedExperiment` objects, making it compatible with standard Bioconductor workflows like `edgeR` and `limma`.

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("emtdata")
```

## Loading Data

There are two primary ways to load the datasets: using package-specific accessor functions or the `ExperimentHub` interface.

### Method 1: Accessor Functions (Recommended)

The package provides direct functions to load specific datasets:

```r
library(emtdata)

# Load Cursons et al. (2018) - HMLE cell line
se_2018 <- cursons2018_se()

# Load Cursons et al. (2015) - PMC42 and MDA-MB-468 cell lines
se_2015 <- cursons2015_se()

# Load Foroutan et al. (2017) - Meta-analysis of multiple studies
se_2017 <- foroutan2017_se()

# View metadata without loading the full object
cursons2018_se(metadata = TRUE)
```

### Method 2: ExperimentHub

```r
library(ExperimentHub)
eh <- ExperimentHub()
query(eh, "emtdata")

# Retrieve by ID
se_2018 <- eh[["EH5440"]] # Cursons 2018
se_2015 <- eh[["EH5441"]] # Cursons 2015
se_2017 <- eh[["EH5439"]] # Foroutan 2017
```

## Working with the Data

The datasets are `SummarizedExperiment` objects. You can interact with them using standard methods:

```r
library(SummarizedExperiment)

# Access counts or log-expression
counts <- assay(se_2018, "counts")
log_rpkm <- assay(se_2018, "logRPKM")

# Access sample metadata
sample_info <- colData(se_2018)

# Access gene information
gene_info <- rowData(se_2018)
```

## Typical Workflow: Exploratory Analysis

To perform MDS plots or prepare for differential expression, convert the object to a `DGEList` (from the `edgeR` package).

```r
library(edgeR)

# 1. Convert to DGEList
dge <- asDGEList(se_2018)

# 2. Normalize
dge <- calcNormFactors(dge)

# 3. Visualize with MDS
plotMDS(dge, col = as.numeric(dge$samples$group))
```

### Dataset Specific Tips

- **foroutan2017_se**: This dataset uses `logExpr` as the primary assay name. When converting to DGEList, specify the assay: `asDGEList(foroutan2017_se, assay_name = "logExpr")`.
- **cursons2015_se**: Contains multiple cell lines (PMC42-ET, PMC42-LA, MDA-MB-468). Use `colData(se)$CellLine` to subset or color plots.
- **cursons2018_se**: Focuses on HMLE cell lines and includes miR200c treatment to reinduce the epithelial phenotype.

## Reference documentation

- [emtdata Vignette (Rmd)](./references/emtdataR.Rmd)
- [emtdata Vignette (Markdown)](./references/emtdataR.md)