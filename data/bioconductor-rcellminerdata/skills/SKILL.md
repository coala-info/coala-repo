---
name: bioconductor-rcellminerdata
description: This package provides molecular profiling and drug response data for the NCI-60 cancer cell line panel. Use when user asks to load NCI-60 molecular datasets, access drug activity profiles, or integrate genomic and proteomic data for anti-cancer screening analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/rcellminerData.html
---


# bioconductor-rcellminerdata

name: bioconductor-rcellminerdata
description: Access and utilize the NCI-60 cancer cell line panel data, including molecular profiles (genomics, proteomics) and drug response assays. Use this skill when you need to load, explore, or integrate CellMiner data for anti-cancer drug screening analysis or molecular characterization of the NCI-60 cell lines.

# bioconductor-rcellminerdata

## Overview

The `rcellminerData` package provides the data infrastructure for the CellMiner project, specifically focusing on the NCI-60 cancer cell line panel. It contains two primary S4 objects: `molData` (molecular assays like gene expression, copy number, and mutation data) and `drugData` (drug activity and response data). This package is designed to be used in conjunction with the `rcellminer` package for data exploration and integration.

## Data Loading and Exploration

To begin, load both the data package and the companion analysis package:

```r
library(rcellminer)
library(rcellminerData)

# Explore available data types
names(getAllFeatureData(molData))
```

## Working with Molecular Data (molData)

The `molData` object stores various molecular profiling datasets in an `eSetList`.

- **Accessing specific datasets**: Use double brackets to extract an ExpressionSet (e.g., "exp" for expression, "cop" for copy number, "mut" for mutation, "pro" for proteomics).
  ```r
  # Get gene expression matrix
  geneExpMat <- exprs(molData[["exp"]])
  ```
- **Accessing Sample Metadata**: Retrieve cell line information, such as tissue of origin.
  ```r
  sampleInfo <- getSampleData(molData)
  # View tissue types for the first 10 cell lines
  sampleInfo[1:10, "TissueType"]
  ```
- **Adding Custom Data**: You can extend the `molData` object by adding your own eSet-derived objects to the list.
  ```r
  molData[["myCustomData"]] <- customESet
  ```

## Working with Drug Data (drugData)

The `drugData` object contains response data for thousands of compounds tested on the NCI-60 panel.

- **Accessing Activity Data**:
  - `getAct(drugData)`: Returns summarized activity data across repeats.
  - `getRepeatAct(drugData)`: Returns raw repeat data.
  ```r
  drugActMat <- exprs(getAct(drugData))
  ```
- **Drug Annotations**: Extract detailed information about the drugs, including NSC numbers, chemical structures, and clinical status.
  ```r
  drugAnnot <- as(featureData(getAct(drugData)), "data.frame")
  colnames(drugAnnot)
  ```

## Integration and Quality Control

- **Sample Consistency**: The sample data (cell line info) is typically identical between `molData` and `drugData`.
  ```r
  identical(getSampleData(molData), getSampleData(drugData))
  ```
- **Quality Control**: Note that `rcellminerData` only includes drug activity data that passed quality control (sufficient range across cell lines and reproducibility). Raw data failing these checks must be retrieved manually from the CellMiner website.

## Reference documentation

- [Accessing CellMiner Data](./references/rcellminerDataUsage.md)