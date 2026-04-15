---
name: bioconductor-agilp
description: This tool provides a low-level analysis pipeline for processing and normalizing Agilent gene expression microarray data. Use when user asks to extract raw signal data from scanner files, average replicate probes, generate normalization baselines, perform Loess normalization, or merge array data into expression matrices.
homepage: https://bioconductor.org/packages/release/bioc/html/agilp.html
---

# bioconductor-agilp

name: bioconductor-agilp
description: Low-level analysis pipeline for gene expression microarray data, specifically optimized for Agilent platforms. Use this skill to extract raw signal data from scanner files, average replicate probes, normalize data against a baseline using Loess normalization, and manage large datasets using template-based file selection and merging.

# bioconductor-agilp

## Overview

The `agilp` package provides a specialized pipeline for processing Agilent microarray data. It is designed to handle the transition from raw scanner output (.txt files) to normalized expression matrices. Key capabilities include extracting median signals (red and green channels), handling replicate probes, generating normalization baselines from multiple arrays, and performing Loess normalization.

## Core Workflow

### 1. Data Extraction (AAProcess)
Extract raw median expression data from Agilent scanner files. This function averages replicate probes and saves individual files for each array and color channel.

```r
library(agilp)
# Define directories
inputdir <- "path/to/scanner_files/"
outputdir <- "path/to/extracted_data/"

# s = number of header lines to skip (default is 9)
AAProcess(input = inputdir, output = outputdir, s = 9)
```

### 2. Template Preparation (filenamex)
To organize metadata, use `filenamex` to generate a list of extracted file names that can be pasted into an experimental template (CSV/TXT).

```r
filenamex(input = "path/to/extracted_data/", output = "path/to/metadata/")
```

### 3. Generating a Normalization Baseline (Baseline)
Create a reference baseline representing the mean value for each probe across a set of arrays. This is required for subsequent normalization.

```r
# NORM="LOG" performs base 2 log transformation before averaging
Baseline(
  NORM = "LOG", 
  allfiles = "TRUE", 
  input = "path/to/extracted_data/", 
  baseout = "path/to/baseline.txt"
)
```

### 4. Normalization (AALoess)
Normalize arrays against the generated baseline using Loess normalization.

```r
AALoess(
  input = "path/to/extracted_data/",
  output = "path/to/normalized_data/",
  baseline = "path/to/baseline.txt",
  LOG = "TRUE"
)
```

### 5. Data Loading and Merging (Loader)
Select specific files based on criteria in your template and merge them into a single expression matrix.

```r
# f="FALSE" merges files into a single data frame/file
# r=2 (column in template containing filenames)
# A=2, B=10 (rows in template to process)
data_matrix <- Loader(
  input = "path/to/normalized_data/",
  t = "path/to/template.txt",
  f = "FALSE",
  r = 2, A = 2, B = 10
)
```

## Key Parameters and Tips

- **File Paths**: `agilp` functions often require trailing slashes in directory paths. Use `file.path(..., fsep = .Platform$file.sep)` to ensure cross-platform compatibility.
- **Channel Selection**: `AAProcess` automatically handles both single and two-color arrays, treating channels independently.
- **Memory Management**: For very large datasets, use `Loader` with `f="TRUE"` to simply move/organize files before processing them in smaller batches.
- **Common Probe Filtering**: If arrays in a set have different numbers of probes, `Baseline` and `Loader` will automatically subset the data to include only the identifiers common to all files.

## Reference documentation

- [Agilp Manual Vignette](./references/agilp_manual.md)