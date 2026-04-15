---
name: bioconductor-adductdata
description: This package provides mass spectrometry data and pre-computed models for adductomics analysis. Use when user asks to retrieve raw mzXML files, access retention time deviation models, or obtain quantification results for testing adductomics workflows.
homepage: https://bioconductor.org/packages/release/data/experiment/html/adductData.html
---

# bioconductor-adductdata

name: bioconductor-adductdata
description: Access and utilize the adductData Bioconductor experiment data package. Use this skill when you need to retrieve raw mzXML mass spectrometry data, retention time deviation models (rtDevModels.RData), or quantification results (adductQuantResults.RData) for adductomics analysis.

# bioconductor-adductdata

## Overview
The `adductData` package is a Bioconductor ExperimentData package providing data for adductomics analysis. It contains raw mzXML files produced on an LTQ Orbitrap XL HRMS, along with pre-computed models and quantification results generated via the `adductomicsR` workflow. This data is primarily used for testing and demonstrating adductomics pipelines.

## Loading the Package
To use the data within an R session, first load the library:

```r
library(adductData)
```

## Accessing Data via ExperimentHub
The primary way to access the datasets is through `ExperimentHub`.

```r
library(ExperimentHub)
eh <- ExperimentHub()
# Query for adductData resources
temp <- query(eh, 'adductData')
temp
```

## Workflows and Data Generation
While the package provides pre-computed data, the following workflows describe how these objects are generated using `adductomicsR`.

### Retention Time Deviation Modeling
The `rtDevModels.RData` object is created by modeling retention time drift across MS2 scans.

```r
# Example of generating RT deviation models
# Requires adductomicsR and a runOrder.csv file
rtDevModelling(
  MS2Dir = system.file("extdata", package = "adductData"),
  nCores = 4, 
  runOrder = system.file("extdata/runOrder.csv", package = "adductomicsR")
)
```

### Adduct Quantification
The `adductQuantResults.RData` object is produced by quantifying adducts against a target table.

```r
# Example quantification workflow
adductQuant(
  nCores = 4,
  targTable = system.file("extdata/exampletargTable2.csv", package = "adductomicsR"),
  intStdRtDrift = 30,
  rtDevModels = system.file("extdata/rtDevModels.RData", package = "adductData"),
  filePaths = list.files(system.file("extdata", package = "adductData"), 
                         pattern = ".mzXML", full.names = TRUE),
  maxPpm = 5,
  minSimScore = 0.8,
  minPeakHeight = 100,
  hkPeptide = 'LVNEVTEFAK'
)
```

## Locating Raw Files
To find the path to the raw mzXML files included in the package for local testing:

```r
mzxml_files <- list.files(system.file("extdata", package = "adductData"), 
                          pattern = ".mzXML", 
                          full.names = TRUE)
print(mzxml_files)
```

## Reference documentation
- [adductData](./references/adductData.md)