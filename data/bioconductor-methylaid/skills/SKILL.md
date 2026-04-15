---
name: bioconductor-methylaid
description: MethylAid performs interactive quality control and outlier detection for Illumina Human DNA Methylation array data. Use when user asks to summarize IDAT files, perform interactive visual QC, identify outlying samples, or combine summarized datasets for large-scale epigenome-wide association studies.
homepage: https://bioconductor.org/packages/release/bioc/html/MethylAid.html
---

# bioconductor-methylaid

name: bioconductor-methylaid
description: Quality control for Illumina Human DNA Methylation array data (450k and EPIC). Use this skill to summarize large sets of IDAT files, perform interactive visual QC, identify outlying samples, and combine summarized datasets for large-scale epigenome-wide association studies (EWAS).

## Overview

MethylAid is a Bioconductor package designed for the interactive quality control of Illumina Human DNA Methylation arrays (450k and 850k/EPIC). It streamlines the QC process into two main steps: **summarization** (extracting intensities from IDAT files) and **visualization** (launching a Shiny-based interactive application). It is particularly efficient for large datasets, supporting batch processing and parallel computing to manage memory and runtime.

## Core Workflow

### 1. Data Preparation
MethylAid uses `minfi` infrastructure to read data. You must provide a targets data frame (usually created from a Sample Sheet) containing a `Basename` column pointing to the IDAT files.

```R
library(MethylAid)
library(minfi)

# Load targets from a sample sheet
targets <- read.metharray.sheet("path/to/idat_folder")
```

### 2. Summarization
The `summarize` function extracts control probe intensities and calculates median methylated/unmethylated values.

```R
# Basic summarization
data <- summarize(targets)

# For large datasets, use batchSize to save memory
summarize(targets, batchSize = 50, file = "my_summarized_data")
# This saves an .RData file that can be loaded later
```

### 3. Visualization
The `visualize` function launches an interactive Shiny application. Note: This must be run in an interactive R session.

```R
# Launch the app
visualize(data)

# Launch with custom thresholds
visualize(data, thresholds = list(MU = 10.5, OP = 11.75, BS = 12.75, HC = 13.25, DP = 0.95))
```

## Advanced Usage

### Parallel Processing
Use `BiocParallel` to speed up summarization on multi-core machines or clusters.

```R
library(BiocParallel)

# Multi-core (not available on Windows)
data <- summarize(targets, BPPARAM = MulticoreParam(workers = 8))
```

### Using Reference Datasets
You can compare your data against large reference sets (e.g., from the `MethylAidData` package) to better identify outliers.

```R
library(MethylAidData)
data(exampleDataLarge) # 2800 samples

# Use as background in the visualizer
visualize(data, background = exampleDataLarge)
```

### Combining Datasets
If you have summarized data in multiple objects, use `combine` to merge them.

```R
combined_data <- combine(data_part1, data_part2)
```

## Key QC Metrics
The interactive app focuses on several key plots:
- **MU plot**: Rotated M (Methylated) versus U (Unmethylated) median intensities.
- **OP**: Overall Proportion of detected probes.
- **BS**: Bisulfite conversion efficiency.
- **HC**: Hybridization Control.
- **DP**: Detection P-values.

Samples falling below the dashed threshold lines in the app are candidates for removal before downstream analysis (e.g., normalization with `minfi` or `wateRmelon`).

## Reference documentation

- [MethylAid: Visual and Interactive quality control of Illumina Human DNA Methylation array data](./references/MethylAid.md)