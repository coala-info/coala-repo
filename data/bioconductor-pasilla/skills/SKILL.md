---
name: bioconductor-pasilla
description: This package provides RNA-Seq data from Drosophila melanogaster for differential splicing and expression analysis. Use when user asks to access example datasets for DEXSeq or DESeq2 workflows, analyze the Brooks et al. (2010) pasilla knockdown study, or load pre-processed count data for testing.
homepage: https://bioconductor.org/packages/release/data/experiment/html/pasilla.html
---

# bioconductor-pasilla

name: bioconductor-pasilla
description: Provides access to RNA-Seq data from Drosophila melanogaster for differential splicing and expression analysis. Use when needing example datasets for DEXSeq or DESeq2 workflows, or when accessing the Brooks et al. (2010) pasilla knockdown study data.

# bioconductor-pasilla

## Overview
The `pasilla` package is a Bioconductor experiment data package containing RNA-Seq read counts and sample annotations from a study on the *pasilla* gene (a splicing regulator) in *Drosophila melanogaster*. It provides the data used in the primary vignettes for the `DEXSeq` and `DESeq2` packages. The dataset includes 3 biological replicates of knockdown and 4 biological replicates of untreated control samples, with both single-read and paired-end data.

## Loading the Data
The package provides both raw count files in its `extdata` directory and pre-constructed R objects.

```r
library(pasilla)

# Locate the external data directory
dataFilesDir <- system.file("extdata", package = "pasilla", mustWork = TRUE)

# Load the sample annotation
pasillaSampleAnno <- read.csv(file.path(dataFilesDir, "pasilla_sample_annotation.csv"))

# List available count files
list.files(dataFilesDir, pattern = "\\.txt$")
```

## Typical Workflows

### Accessing the DEXSeqDataSet
The package includes a pre-processed `DEXSeqDataSet` object (named `dxd`) which is commonly used for demonstrating differential exon usage analysis.

```r
# Load the pre-computed DEXSeqDataSet
data("pasillaDEXSeqDataSet")

# The object is named 'dxd'
dxd
```

### Constructing Objects from Scratch
If you need to demonstrate how to build a `DEXSeqDataSet` from the raw HTSeq count files provided in the package:

```r
library(DEXSeq)

# Define paths to count files and GFF annotation
countFiles <- file.path(dataFilesDir, paste0(pasillaSampleAnno$file, ".txt"))
gffFile <- file.path(dataFilesDir, "Dmel.BDGP5.25.62.DEXSeq.chr.gff")

# Create the dataset
dxd <- DEXSeqDataSetFromHTSeq(
  countfiles = countFiles,
  sampleData = pasillaSampleAnno,
  design = ~ sample + exon + condition:exon,
  flattenedfile = gffFile
)
```

## Key Data Objects
- `pasillaSampleAnno`: A data frame containing the experimental design, including condition (treated/untreated) and library type (single-read/paired-end).
- `dxd`: A `DEXSeqDataSet` object containing a subset of genes for testing differential splicing.
- `extdata/`: Contains `.txt` files with per-exon counts and a `.gff` file with the flattened gene model.

## Reference documentation
- [Data Preprocessing and Object Creation](./references/create_objects.md)