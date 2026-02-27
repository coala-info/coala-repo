---
name: bioconductor-prodata
description: This tool provides access to SELDI-TOF protein mass spectrometry data from breast cancer patients and healthy controls for proteomic analysis. Use when user asks to load the f45cbmk ExpressionSet, access raw SELDI-TOF spectra, or analyze protein biomarkers for breast cancer classification.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ProData.html
---


# bioconductor-prodata

name: bioconductor-prodata
description: A specialized skill for working with the Bioconductor package ProData. Use this skill to access and analyze SELDI-TOF protein mass spectrometry data from breast cancer and normal samples. This is particularly useful for researchers needing pre-processed proteomic datasets (ExpressionSet objects) or raw spectra for biomarker discovery and classification tasks in breast cancer research.

# bioconductor-prodata

## Overview

The `ProData` package provides a specific experimental dataset consisting of 167 SELDI-TOF protein mass spectrometry spectra. These samples are derived from 155 subjects, categorized into HER2 positive patients, ER/PR positive patients, normal healthy controls, and a control group from a single healthy woman. The package includes both a pre-processed `ExpressionSet` object (proto-biomarkers) and access to raw spectra files.

## Loading the Dataset

The primary dataset is stored in an object named `f45cbmk`.

```r
# Load the library
library(ProData)
library(Biobase)

# Load the pre-processed ExpressionSet
data(f45cbmk)

# View the object summary
f45cbmk
```

## Data Structure and Metadata

The `f45cbmk` object is an `ExpressionSet`. You can interact with it using standard `Biobase` methods.

### Accessing Phenotype Data
The samples are categorized into four groups:
- **A**: HER2 positive patients (n=55)
- **B**: Normal healthy patients (n=64)
- **C**: ER/PR positive patients (n=35)
- **D**: Samples from a single healthy woman (n=13)

```r
# Extract phenotype data
pheno <- pData(f45cbmk)

# Check group distributions
table(pheno$GROUP)

# View spectrum IDs
head(pheno$SPECTRUM)
```

### Accessing Expression (Peak) Data
The expression matrix contains proto-biomarkers (peaks) detected with a signal-to-noise ratio (S/N) above 10, jointly normalized.

```r
# Extract the peak intensity matrix
peak_data <- exprs(f45cbmk)

# View dimensions (Features x Samples)
dim(peak_data)
```

## Working with Raw Spectra

The package also bundles raw spectra data which can be accessed for custom pre-processing (e.g., using the `PROcess` package).

```r
# Locate the raw spectra directory
raw_dir <- system.file("f45c", package="ProData")

# List available raw files (gzipped CSVs)
raw_files <- dir(raw_dir, full.names = TRUE)

# Read and plot the first raw spectrum
# Raw files contain M/Z and Intensity columns
spectrum_1 <- read.csv(gzfile(raw_files[1]))
plot(spectrum_1, type = "l", main = "Raw SELDI-TOF Spectrum", xlab = "M/Z", ylab = "Intensity")
```

## Typical Workflow: Differential Expression

A common use case is identifying peaks that differ between cancer groups (A or C) and normal controls (B).

```r
# Example: Compare HER2+ (A) vs Normal (B)
group_mask <- pData(f45cbmk)$GROUP %in% c("A", "B")
sub_set <- f45cbmk[, group_mask]

# Proceed with standard Bioconductor differential analysis (e.g., limma or t-tests)
```

## Reference documentation

- [ProData Reference Manual](./references/reference_manual.md)