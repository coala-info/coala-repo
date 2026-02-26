---
name: bioconductor-affy
description: This tool analyzes and explores Affymetrix oligonucleotide array probe-level data. Use when user asks to load CEL files, perform preprocessing using RMA or MAS 5.0, conduct quality control on microarray data, or access specific PM/MM probe intensities.
homepage: https://bioconductor.org/packages/release/bioc/html/affy.html
---


# bioconductor-affy

name: bioconductor-affy
description: Analysis and exploration of Affymetrix oligonucleotide array probe-level data. Use this skill when an AI agent needs to: (1) Load Affymetrix CEL files into R, (2) Perform preprocessing including background correction, normalization, and summarization (RMA, MAS 5.0, Li-Wong), (3) Conduct quality control using RNA degradation plots, histograms, and boxplots, or (4) Access specific PM/MM probe intensities and map them to AffyIDs.

# bioconductor-affy

## Overview

The `affy` package is the core Bioconductor tool for handling Affymetrix GeneChip data at the probe level. It provides the `AffyBatch` class to store raw intensity data and metadata, and the `expresso` framework for flexible preprocessing. It is most commonly used to convert raw `.CEL` files into an `ExpressionSet` of summarized gene expression values.

## Core Workflows

### 1. Loading Data
The primary way to load data is from a directory containing `.CEL` files.

```r
library(affy)

# Read all CEL files in the current working directory
data <- ReadAffy()

# Read specific files
data <- ReadAffy(filenames = c("sample1.CEL", "sample2.CEL"))

# View summary of the AffyBatch object
print(data)
sampleNames(data)
featureNames(data) # Returns AffyIDs
```

### 2. Preprocessing (Raw to Expression)
There are three main ways to generate expression measures:

**A. RMA (Robust Multi-array Average) - Recommended**
Fastest and most common. Performs background correction, quantile normalization, and median polish summarization.
```r
# Standard RMA
eset <- rma(data)

# Memory efficient version (skips creating AffyBatch)
eset <- justRMA() 
```

**B. MAS 5.0**
Reproduces the Affymetrix Microarray Suite 5.0 algorithm.
```r
# Get expression values
eset_mas5 <- mas5(data)

# Get Presence/Absence calls (P/M/A)
calls <- mas5calls(data)
```

**C. Expresso (Custom Pipeline)**
Allows mixing and matching of different methods.
```r
eset <- expresso(data, 
                 bgcorrect.method = "rma",
                 normalize.method = "quantiles",
                 pmcorrect.method = "pmonly",
                 summary.method = "medianpolish")
```

### 3. Quality Control and Exploration
Use these functions to diagnose array quality issues.

```r
# Visualizing intensity distributions
boxplot(data, col = "red")
hist(data)

# Spatial artifacts
image(data[, 1]) # View the first array

# Pairwise comparison (MA plots)
MAplot(data, pairs = TRUE)

# RNA Degradation Analysis
deg <- AffyRNAdeg(data)
plotAffyRNAdeg(deg)
summaryAffyRNAdeg(deg)
```

### 4. Accessing Probe Data
If you need to work with individual Perfect Match (PM) or Mismatch (MM) intensities.

```r
# Get all PM intensities as a matrix
pm_mat <- pm(data)

# Get PM intensities for a specific gene/AffyID
gene_probes <- pm(data, "1000_at")

# Check percentage of MM > PM (indicator of non-specific binding)
mean(mm(data) > pm(data))
```

## Key Classes
- **AffyBatch**: Stores raw probe-level data (PM/MM), physical array coordinates, and phenotypic data.
- **ExpressionSet**: The output of preprocessing; contains summarized expression values (access with `exprs(eset)`).
- **ProbeSet**: Contains PM and MM matrices for a specific set of probes.

## Tips
- **Memory**: For very large datasets, use `justRMA()` to avoid memory exhaustion, as it processes data at the C level without storing the full `AffyBatch`.
- **CDF Environments**: `affy` automatically tries to download the required CDF environment. If it fails, ensure the annotation package (e.g., `hgu95av2cdf`) is installed via `BiocManager`.
- **Exporting**: Use `write.exprs(eset, file="output.txt")` to save results for use in other software.

## Reference documentation
- [affy](./references/affy.md)
- [Built-in Processing Methods](./references/builtinMethods.md)
- [Custom Processing Methods](./references/customMethods.md)
- [Import Methods](./references/vim.md)