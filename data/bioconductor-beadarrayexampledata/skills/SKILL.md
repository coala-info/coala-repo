---
name: bioconductor-beadarrayexampledata
description: This package provides example bead-level and summarized Illumina BeadArray datasets for testing and demonstrating Bioconductor workflows. Use when user asks to access sample BeadArray data, perform spatial quality control analysis, or demonstrate expression summarization techniques in R.
homepage: https://bioconductor.org/packages/release/data/experiment/html/beadarrayExampleData.html
---


# bioconductor-beadarrayexampledata

name: bioconductor-beadarrayexampledata
description: Provides access to example bead-level and summarized Illumina BeadArray data for use with the beadarray package. Use this skill when you need a lightweight, reproducible dataset to demonstrate bead-level analysis, quality control (BASH), or expression summarization workflows in R.

# bioconductor-beadarrayexampledata

## Overview

The `beadarrayExampleData` package is a specialized data experiment package for Bioconductor. It provides a subset of the MAQC (MicroArray Quality Control) dataset, specifically designed for testing and demonstrating the functionality of the `beadarray` package. It contains two primary data objects:
- `exampleBLData`: A `beadLevelData` object containing raw bead-level intensities and locations for 2 array sections.
- `exampleSummaryData`: An `ExpressionSetIllumina` object containing summarized expression values for 12 array sections.

The samples consist of Universal Human Reference RNA (UHRR) and Brain Reference RNA.

## Loading the Data

To use the datasets, you must first load the library and then use the `data()` function to bring the objects into your global environment.

```r
library(beadarrayExampleData)

# Load bead-level data (2 sections)
data(exampleBLData)

# Load summarized data (12 sections)
data(exampleSummaryData)
```

## Working with Bead-Level Data (`exampleBLData`)

This object is used for low-level operations such as spatial analysis, image processing simulations, and outlier detection.

- **Inspect the object**: View experiment metadata and section information.
  ```r
  exampleBLData
  sectionNames(exampleBLData)
  ```
- **Access bead data**: Retrieve raw intensities for specific sections.
  ```r
  # Access data for the first section
  head(getBeadData(exampleBLData, array = 1))
  ```
- **Quality Control**: This dataset is often used to demonstrate the `BASH` (BeadArray Spatial Homogeneity) algorithm from the `beadarray` package to detect spatial artifacts.

## Working with Summarized Data (`exampleSummaryData`)

This object is an `ExpressionSetIllumina` object, compatible with standard Bioconductor differential expression workflows (like `limma`).

- **View Phenotype Data**: Check sample groups (UHRR vs. Brain).
  ```r
  pData(exampleSummaryData)
  ```
- **Access Expression Values**:
  ```r
  # Get log-transformed expression values
  exp_values <- exprs(exampleSummaryData)
  ```
- **Feature Metadata**: Check probe IDs and annotation information.
  ```r
  fData(exampleSummaryData)
  ```

## Typical Workflow Example

A common use case is demonstrating how bead-level data is transformed into summarized data.

```r
library(beadarray)
library(beadarrayExampleData)

data(exampleBLData)

# Example: Calculate summary statistics for the bead-level data
# Note: This requires the 'beadarray' package
# greenChannel <- new("illuminaChannel", logGreenChannelTransform, illuminaOutlierMethod, mean, sd, "G")
# summaryData <- summarize(exampleBLData, list(greenChannel))
```

## Reference documentation

- [beadarrayExampleData](./references/beadarrayExampleData.md)