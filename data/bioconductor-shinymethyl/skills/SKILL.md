---
name: bioconductor-shinymethyl
description: This tool provides interactive visualization and quality control for Illumina 450K methylation array data using a Shiny-based interface. Use when user asks to summarize methylation datasets, perform quality control assessment, predict sample sex, explore batch effects, or visualize PCA results.
homepage: https://bioconductor.org/packages/release/bioc/html/shinyMethyl.html
---

# bioconductor-shinymethyl

name: bioconductor-shinymethyl
description: Interactive visualization and quality control for Illumina 450K methylation array data. Use this skill to summarize high-dimensional methylation data into a shinyMethylSet and launch an interactive Shiny interface for QC assessment, sex prediction, PCA, and batch effect exploration.

# bioconductor-shinymethyl

## Overview
The `shinyMethyl` package provides an interactive tool for the quality control and exploration of Illumina 450K methylation array data. It works by summarizing large `RGChannelSet` or `GenomicRatioSet` objects into a compact `shinyMethylSet` object, which is then used to power a Shiny-based web interface. This allows for rapid assessment of batch effects, probe bias, and sample quality without needing to manually generate dozens of static plots.

## Installation
Install the package using BiocManager:
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("shinyMethyl")
```

## Core Workflow

### 1. Prepare the Data
`shinyMethyl` requires data to be loaded via the `minfi` package. You must start with an `RGChannelSet` created from .IDAT files.

```r
library(minfi)
library(shinyMethyl)

# Load targets and read IDAT files
targets <- read.metharray.sheet(baseDir)
RGSet <- read.metharray.exp(targets = targets)
```

### 2. Summarize the Dataset
The `shinySummarize` function extracts the necessary summaries (quantiles, control probe intensities, PCA) into a `shinyMethylSet`. This object is much smaller than the raw data.

```r
# Create the summary object
myShinyMethylSet <- shinySummarize(RGSet)
```

### 3. Launch the Interactive Interface
Pass the summary object to `runShinyMethyl` to open the dashboard in your default browser.

```r
runShinyMethyl(myShinyMethylSet)
```

## Advanced Usage

### Visualizing Normalized Data
To evaluate the effect of normalization, create summaries for both raw and normalized data and pass both to the visualization function.

```r
# 1. Raw summary
summary.raw <- shinySummarize(RGSet)

# 2. Normalize and summarize
GRSet.norm <- preprocessQuantile(RGSet)
summary.norm <- shinySummarize(GRSet.norm)

# 3. Launch comparison UI
runShinyMethyl(summary.raw, summary.norm)
```

### Accessing Summary Data
A `shinyMethylSet` stores data in slots. You can access these directly if you need to perform custom analysis on the summaries.

```r
# List available slots
slotNames(myShinyMethylSet)

# Access phenotype data
pd <- myShinyMethylSet@phenotype

# Access PCA results
pca_results <- myShinyMethylSet@pca
```

## Interactive Panels and Features
*   **Quality Control:** View median methylated vs. unmethylated intensities. Samples clustering away from the main group are potential outliers.
*   **Sex Prediction:** Uses the difference in median copy number intensity between X and Y chromosomes. You can manually adjust the cutoff in the UI.
*   **PCA:** Explore global methylation patterns and identify batch effects by coloring points by phenotype or plate.
*   **Type I/II Bias:** Visualize the distribution differences between Infinium I and II probe types for individual samples.
*   **Array Design:** Check for randomization issues by visualizing sample placement on the physical slides.

## Reference documentation
- [shinyMethyl: interactive visualization of Illumina 450K methylation arrays](./references/shinyMethyl.Rmd)
- [shinyMethyl: interactive visualization of Illumina 450K methylation arrays](./references/shinyMethyl.md)