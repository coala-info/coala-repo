---
name: bioconductor-rtcgatoolbox
description: RTCGAToolbox provides a unified interface to download, manage, and process pre-processed Level 3 and Level 4 TCGA Firehose data. Use when user asks to download TCGA datasets, access clinical or genomic data from Firehose, or convert Firehose data into Bioconductor-compatible objects.
homepage: https://bioconductor.org/packages/release/bioc/html/RTCGAToolbox.html
---

# bioconductor-rtcgatoolbox

name: bioconductor-rtcgatoolbox
description: Access and process TCGA Firehose data. Use when needing to download, manage, and analyze pre-processed Level 3 and Level 4 TCGA data, including clinical, mutation, RNA-seq, copy number, and methylation datasets.

# bioconductor-rtcgatoolbox

## Overview
RTCGAToolbox is an R-based data client for the TCGA Firehose project. It simplifies the process of downloading and managing large-scale genomic data by providing a unified interface to access pre-processed datasets. It returns data in structured S4 objects (`FirehoseData`) and supports conversion to standard Bioconductor classes like `SummarizedExperiment`.

## Core Workflow

1. **Identify Target Data**: Use control functions to find valid cohort aliases and run dates.
2. **Download Data**: Use `getFirehoseData` with specific logical flags for the desired data types.
3. **Access Data**: Use `getData` for raw tables or `biocExtract` for Bioconductor-compatible objects.

## Key Functions

### Discovery Functions
* `getFirehoseDatasets()`: Returns a list of available TCGA cohort abbreviations (e.g., "BRCA", "READ", "ACC").
* `getFirehoseRunningDates(last = n)`: Returns the most recent standard data run dates.
* `getFirehoseAnalyzeDates(last = n)`: Returns the most recent analysis run dates (required for GISTIC2 copy number data).

### Data Acquisition
The `getFirehoseData` function is the primary interface. By default, it only downloads clinical data.

```r
# Example: Download mutation and clinical data for Rectum Adenocarcinoma (READ)
data_obj <- getFirehoseData(
  dataset = "READ",
  runDate = "20160128",
  clinical = TRUE,
  Mutation = TRUE,
  forceDownload = TRUE
)
```

**Available Data Type Flags:**
* `RNASeqGene`, `RNASeq2Gene`, `RNASeq2GeneNorm`
* `clinical`
* `miRNASeqGene`, `miRNAArray`
* `CNASNP`, `CNVSNP`, `CNASeq`, `CNACGH`
* `Methylation`
* `Mutation`
* `mRNAArray`, `RPPAArray`

### Data Extraction
* `getData(object, type, ...)`: Extracts specific data types into tabular or list formats.
  * Example: `getData(data_obj, "clinical")`
  * Example for GISTIC: `getData(data_obj, "GISTIC", "AllByGene")`
* `biocExtract(object, type)`: Converts data into standard Bioconductor classes.
  * `RNASeq2Gene` -> `SummarizedExperiment`
  * `CNASNP` -> `RangedSummarizedExperiment`

## Usage Tips
* **File Size Limits**: Use the `fileSizeLimit` parameter (default 500MB) in `getFirehoseData` to manage memory and download time.
* **Caching**: The package checks the working directory for existing data before downloading. Use `forceDownload = TRUE` to overwrite.
* **UUIDs**: Set `getUUIDs = TRUE` if you require UUIDs instead of standard TCGA barcodes.
* **Example Data**: Use `data(accmini)` to load a small sample `FirehoseData` object for testing and pipeline development.

## Reference documentation
- [RTCGAToolbox Tutorial](./references/RTCGAToolbox-vignette.Rmd)
- [RTCGAToolbox Tutorial (Markdown)](./references/RTCGAToolbox-vignette.md)