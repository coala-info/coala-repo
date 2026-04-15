---
name: bioconductor-readat
description: This tool imports and processes SomaLogic ADAT files into R for protein abundance analysis. Use when user asks to read SOMAscan assay data, extract sequence metadata, or convert ADAT files into Bioconductor formats like ExpressionSet and SummarizedExperiment.
homepage: https://bioconductor.org/packages/3.8/bioc/html/readat.html
---

# bioconductor-readat

name: bioconductor-readat
description: Import and process SomaLogic ADAT files into R. Use this skill when you need to read protein abundance data from SOMAscan assays, handle WideSomaLogicData objects, or convert SomaLogic data into standard Bioconductor formats like ExpressionSet, SummarizedExperiment, or MSnSet.

## Overview

The `readat` package is designed to handle data from SomaLogic's SOMAscan assay platform. It specifically imports the proprietary text-based ADAT format into R as `WideSomaLogicData` objects (based on `data.table`). This skill facilitates the transition from raw assay output to analysis-ready Bioconductor objects.

## Core Workflow

### 1. Importing ADAT Files
The primary function is `readAdat()`. By default, it removes sequences that failed SomaLogic's quality control.

```r
library(readat)

# Basic import
adat_data <- readAdat("path/to/file.adat")

# Import including QC failures
adat_all <- readAdat("path/to/file.adat", keepOnlyPasses = FALSE)
```

### 2. Accessing Metadata and Sequence Info
`WideSomaLogicData` objects store sequence information and metadata as attributes. Use helper functions to extract them:

```r
# Get sequence-specific information (Target, UniProt, EntrezGeneID, etc.)
seq_info <- getSequenceData(adat_data)

# Get assay metadata (Version, CreatedDate, MasterMixVersion, etc.)
meta_info <- attr(adat_data, "Metadata")
```

### 3. Reshaping Data
For visualization (e.g., with `ggplot2`) or manipulation (e.g., with `dplyr`), convert the wide format (one sample per row) to a long format (one intensity per row).

```r
library(reshape2)
long_data <- melt(adat_data)
```

### 4. Converting to Bioconductor Classes
To use the data with other Bioconductor packages, convert the `WideSomaLogicData` object into standard containers:

```r
# To Biobase ExpressionSet
eset <- as.ExpressionSet(adat_data)

# To SummarizedExperiment
se <- as.SummarizedExperiment(adat_data)

# To MSnbase MSnSet
if(requireNamespace("MSnbase")) {
  msnset <- as.MSnSet(adat_data)
}
```

## Tips and Best Practices
- **Data Structure**: The imported object is a `data.table`. You can use standard `data.table` syntax for fast filtering and aggregation on the sample data.
- **QC Filtering**: Always check the number of sequences removed during import. If `readAdat` reports removals, verify the `sequenceData` to understand which proteins were excluded.
- **Column Names**: In the wide format, protein intensities are typically identified by `SeqId` (e.g., "10336-3_3"). Use `getSequenceData()` to map these IDs to human-readable gene symbols or target names.

## Reference documentation
- [Introduction](./references/introduction.md)