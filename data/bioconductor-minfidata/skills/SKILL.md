---
name: bioconductor-minfidata
description: This package provides example datasets for the Illumina Human Methylation 450k array, including raw and preprocessed data objects. Use when user asks to load example methylation data, test minfi workflows, or demonstrate DNA methylation analysis using RGChannelSet and MethylSet objects.
homepage: https://bioconductor.org/packages/release/data/experiment/html/minfiData.html
---


# bioconductor-minfidata

name: bioconductor-minfidata
description: Provides example datasets for the Illumina Methylation 450k array. Use this skill when you need to demonstrate, test, or develop workflows for DNA methylation analysis using the minfi package, specifically requiring RGChannelSet or MethylSet objects.

## Overview
The `minfiData` package is a Bioconductor data experiment package containing Illumina Human Methylation 450k array data for 6 samples. It provides both raw intensity data and preprocessed methylation data, serving as the standard example dataset for the `minfi` ecosystem.

## Loading the Data
To use the datasets, load the package and use the `data()` function:

```r
library(minfiData)

# Load raw data (RGChannelSet)
data(RGsetEx)

# Load preprocessed data (MethylSet)
data(MsetEx)

# Load small subsets (600 CpGs) for fast testing
data(RGsetEx.sub)
data(MsetEx.sub)
```

## Key Objects
- **RGsetEx**: An `RGChannelSet` object containing the raw intensities in the red and green channels. This is the starting point for most `minfi` preprocessing pipelines.
- **MsetEx**: A `MethylSet` object representing the data after basic preprocessing (specifically `preprocessRaw`). It contains the methylated and unmethylated signals.
- **Phenotype Data**: Access sample metadata using `pData(RGsetEx)`. Note that in this example dataset, some phenotype information is masked.

## Typical Workflows
The datasets in `minfiData` are designed to be passed into `minfi` functions:

### Preprocessing and Normalization
```r
library(minfi)
# Perform functional normalization on the raw data
mSetSq <- preprocessQuantile(RGsetEx)
```

### Quality Control
```r
# Generate a QC report
qc <- getQC(MsetEx)
plotQC(qc)

# Check detection p-values
detP <- detectionP(RGsetEx)
```

### Extracting Beta and M-values
```r
# Get Beta values (0 to 1 scale)
beta <- getBeta(MsetEx)

# Get M-values (log-ratio of intensities)
mValues <- getM(MsetEx)
```

## Tips
- Use the `.sub` versions (`RGsetEx.sub`, `MsetEx.sub`) when writing unit tests or debugging code to minimize memory usage and computation time.
- The raw IDAT files used to create these objects are stored in the package's `extdata` directory, which can be accessed via `system.file("extdata", package = "minfiData")`.

## Reference documentation
- [minfiData Reference Manual](./references/reference_manual.md)