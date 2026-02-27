---
name: bioconductor-msstatsbig
description: MSstatsBig processes large-scale proteomics datasets by performing data filtering and preprocessing on disk using the arrow backend to overcome memory limitations. Use when user asks to convert large FragPipe or Spectronaut outputs, filter big DIA datasets on disk, or prepare massive proteomics files for MSstats statistical analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/MSstatsBig.html
---


# bioconductor-msstatsbig

## Overview

`MSstatsBig` is an extension of the `MSstats` ecosystem designed to handle "big data" proteomics experiments, particularly large Data-Independent Acquisition (DIA) datasets. It addresses memory limitations by performing data filtering and preprocessing on disk using the `arrow` backend. The primary goal is to reduce the raw PSM-level data into a manageable size that can then be "collected" into R's memory for standard `MSstats` statistical analysis (protein summarization and differential expression).

## Core Workflow

### 1. Data Conversion (Large Scale)
Instead of loading a massive CSV into R, use the `MSstatsBig` converters. These functions read the input file in chunks, filter features, and write the output to a new file.

**For FragPipe:**
```r
library(MSstatsBig)

# Convert large FragPipe output to MSstats format on disk
converted_arrow <- bigFragPipetoMSstatsFormat(
  input = "path/to/msstats.csv",
  output_file = "filtered_data.csv",
  backend = "arrow",
  max_feature_count = 20 # Filters to top N features per protein to save space
)
```

**For Spectronaut:**
```r
converted_arrow <- bigSpectronauttoMSstatsFormat(
  input = "path/to/spectronaut_report.csv",
  output_file = "filtered_data.csv",
  backend = "arrow"
)
```

### 2. Loading Data into Memory
Once the data is filtered and reduced by the converter, it can be loaded into a standard R data frame for downstream analysis.

```r
# Option A: Collect from the arrow object returned by the converter
msstats_df <- as.data.frame(dplyr::collect(converted_arrow))

# Option B: Read the resulting filtered CSV
msstats_df <- read.csv("filtered_data.csv")
```

### 3. Downstream MSstats Analysis
After conversion, use the standard `MSstats` package functions.

```r
library(MSstats)

# Protein Summarization
summarized <- dataProcess(msstats_df, use_log_file = FALSE)

# Statistical Inference (Differential Expression)
# Define contrast matrix based on conditions in the data
comparison <- matrix(c(-1, 1), nrow=1)
row.names(comparison) <- "Test-Control"
colnames(comparison) <- c("Control", "Test")

results <- groupComparison(contrast.matrix = comparison, data = summarized)
```

## Key Functions and Parameters

- `bigFragPipetoMSstatsFormat()` / `bigSpectronauttoMSstatsFormat()`: Main entry points for large files.
- `backend = "arrow"`: Uses the Apache Arrow framework to process data without loading the full file into RAM.
- `max_feature_count`: A critical parameter for "Big" data. It limits the number of features (peptides/charge states) per protein, significantly reducing the memory footprint of the summarized object.
- `MSstatsPreprocessBig()`: The underlying engine used for custom formats (e.g., DIA-NN) if the data is already in a long-format compatible with MSstats.

## Tips for Large Experiments
- **Temporary Directory**: Ensure the `tempdir()` or the working directory has enough disk space to hold the intermediate `.csv` or arrow files.
- **Memory Management**: Always use `dplyr::collect()` only *after* the `MSstatsBig` converter has finished its filtering, as the raw input is likely too large for `read.csv()`.
- **Feature Selection**: If the dataset is still too large after conversion, decrease `max_feature_count` (e.g., to 10 or 20) to keep only the most informative features.

## Reference documentation
- [MSstatsBig Workflow](./references/MSstatsBig_Workflow.md)