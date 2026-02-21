---
name: bioconductor-ffpeexampledata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ffpeExampleData.html
---

# bioconductor-ffpeexampledata

name: bioconductor-ffpeexampledata
description: Access and use the Illumina DASL example microarray data from the ffpeExampleData package. Use this skill when a user needs to load, explore, or analyze the GSE17565 subset containing FFPE samples of Burkitt's Lymphoma and Breast Adenocarcinoma for benchmarking or methodology development.

# bioconductor-ffpeexampledata

## Overview
The `ffpeExampleData` package provides a specialized dataset for researchers working with Formalin-Fixed Paraffin-Embedded (FFPE) tissue samples. It contains a subset of the GSE17565 study, featuring 32 samples of Burkitt's Lymphoma and Breast Adenocarcinoma. The data is provided as a `LumiBatch` object, which includes raw expression values, a dilution series, and technical duplicates, making it ideal for testing normalization and quality control algorithms specifically designed for FFPE data (such as those found in the `ffpe` package).

## Installation
To use this data, ensure the package and its primary dependency `lumi` are installed:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ffpeExampleData")
BiocManager::install("lumi")
```

## Loading and Exploring Data
The primary dataset is `lumibatch.GSE17565`.

### Loading the Dataset
```r
library(ffpeExampleData)
library(lumi)

# Load the LumiBatch object
data(lumibatch.GSE17565)
```

### Accessing Metadata and Expression Values
The object follows standard `Biobase`/`lumi` structures:

```r
# View sample metadata (RNA concentration, cell type, replicate number)
meta.data <- pData(lumibatch.GSE17565)
head(meta.data)

# Access raw expression intensities
expression.data <- exprs(lumibatch.GSE17565)

# Basic visualization of raw data
boxplot(log2(expression.data), main="Log2 Raw Intensities - GSE17565", las=2)
```

## Typical Workflow
1. **Data Inspection**: Check the `pData` to understand the dilution series (input RNA amounts) and sample types.
2. **Quality Control**: Use `lumi` functions or the `ffpe` package to assess the quality of the FFPE samples.
3. **Normalization**: Apply normalization techniques suitable for DASL arrays.
4. **Comparison**: Compare technical duplicates or analyze the effect of RNA concentration on signal intensity.

## Tips
- **Object Class**: The data is stored as a `LumiBatch` object. You must load the `lumi` library to interact with it effectively.
- **FFPE Analysis**: This package is frequently used in conjunction with the `ffpe` Bioconductor package, which contains specific tools for quality assessment of FFPE microarrays.
- **Data Source**: The data originates from the supplemental file `GSE17565_nonorm_nobkgd.txt.gz` on GEO, processed via `lumiR`.

## Reference documentation
- [ffpeExampleData Reference Manual](./references/reference_manual.md)