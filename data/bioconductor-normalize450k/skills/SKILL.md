---
name: bioconductor-normalize450k
description: This R package reads and normalizes Illumina Infinium HumanMethylation450 BeadChip data. Use when user asks to process .idat files, perform dye bias correction, or apply LOESS-based normalization to 450K DNA methylation data.
homepage: https://bioconductor.org/packages/release/bioc/html/normalize450K.html
---


# bioconductor-normalize450k

name: bioconductor-normalize450k
description: Specialized R package for reading and normalizing Illumina Infinium HumanMethylation450 BeadChip data. Use this skill when an AI agent needs to process .idat files, perform dye bias correction, or apply the LOESS-based normalization method described by Heiss and Brenner (2015) to 450K DNA methylation data.

# bioconductor-normalize450k

## Overview
The `normalize450K` package provides a streamlined workflow for the preprocessing and normalization of Illumina 450K methylation arrays. It is particularly noted for its LOESS-based normalization approach which uses extension control probes for dye bias correction and housekeeping CpG sites for between-array normalization. While originally tested on whole blood samples, its reliance on housekeeping sites makes it applicable to various tissue types.

## Core Workflow

### 1. Data Preparation
The package requires a character vector of file paths to the `.idat` files, excluding the `_Red.idat` and `_Grn.idat` suffixes.

```r
library(normalize450K)
library(data.table)

# Example: Loading from a sample sheet
samples <- fread('SampleSheet.csv')
# Construct paths: path/to/idat/SentrixID_SentrixPosition
samples[, file := file.path(idat_dir, Sentrix_ID, paste0(Sentrix_ID, '_', Sentrix_Position))]
```

### 2. Reading Data
Use `read450K()` to load the raw signal intensities into R.

```r
raw <- read450K(samples$file)
```

### 3. Normalization
The package offers two primary paths: the full normalization pipeline or a "no normalization" control.

```r
# Apply the Heiss & Brenner LOESS normalization
norm <- normalize450K(raw)

# Alternative: No normalization (for comparison)
none <- dont_normalize450K(raw)
```

## Normalization Details
The `normalize450K()` function performs the following steps:
1. **Dye Bias Correction**: Uses extension control probes to symmetrize signal intensities.
2. **Local Regression (LOESS)**: Adjusts Type I and II probe intensities using housekeeping CpG sites and a virtual reference array.
3. **M-value Computation**: Calculates M-values from corrected intensities.
4. **Methylation-related Bias Correction**: Corrects bias affecting Type II probes.
5. **Beta-value Transformation**: Converts final M-values back to Beta-values.

Note: This method does not perform probe-type bias adjustment (like BMIQ or SWAN) by design, to avoid trading precision for accuracy.

## Reference documentation
- [Normalization of 450K data](./references/read_and_normalize450K.md)