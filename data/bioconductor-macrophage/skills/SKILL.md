---
name: bioconductor-macrophage
description: The macrophage package provides RNA-seq quantification data from a study of human macrophages under various stimulation conditions. Use when user asks to access example Salmon quantification files, load pre-computed SummarizedExperiment objects for differential expression analysis, or demonstrate tximeta and DESeq2 workflows.
homepage: https://bioconductor.org/packages/release/data/experiment/html/macrophage.html
---

# bioconductor-macrophage

## Overview
The `macrophage` package is a Bioconductor experiment data package providing RNA-seq quantification data from a study by Alasoo, et al. (2018). It contains Salmon-quantified transcript abundance for 24 samples derived from 6 female donors. The data covers four experimental conditions: naive, IFN-gamma stimulation, Salmonella (SL1344) infection, and a combination of IFN-gamma and Salmonella.

## Data Access and Usage

### Loading the SummarizedExperiment
The most direct way to use this package is by loading the pre-computed `SummarizedExperiment` object, which contains the gene-level counts and metadata.

```r
library(macrophage)
data("gse")

# Explore the object
gse
colData(gse)
assay(gse, "counts")[1:5, 1:5]
```

### Accessing Raw Quantification Files
The package includes the raw Salmon `quant.sf.gz` files, which are useful for demonstrating `tximeta` or `tximport` workflows.

```r
# Locate the external data directory
dir <- system.file("extdata", package="macrophage")

# Read the sample metadata (coldata)
coldata <- read.csv(file.path(dir, "coldata.csv"))

# Construct paths to Salmon output files
files <- file.path(dir, "quant", coldata$names, "quant.sf.gz")
names(files) <- coldata$sample_id
all(file.exists(files))
```

### Experimental Design
The `coldata` contains several key variables for differential expression modeling:
- `line_id`: The donor identifier (6 donors total).
- `condition_name`: The treatment (naive, IFNg, SL1344, IFNg_SL1344).
- `sample_id`: Unique identifier for each library.

## Typical Workflow: Integration with DESeq2
This data is frequently used to demonstrate how to import Salmon data into `DESeq2` using `tximeta`.

```r
# Example of preparing for DESeq2
library(tximeta)
# Note: tximeta requires the files and coldata to be properly formatted
# with a 'files' column and 'names' column.
coldata$files <- files
se <- tximeta(coldata)

# Convert to DESeqDataSet
library(DESeq2)
dds <- DESeqDataSet(se, design = ~line_id + condition_name)
```

## Reference documentation
- [macrophage](./references/macrophage.md)