---
name: bioconductor-oligo
description: This tool provides a unified framework for the preprocessing and analysis of high-density oligonucleotide microarrays from Affymetrix and NimbleGen. Use when user asks to import CEL or XYS files, perform RMA preprocessing, visualize probe-level data, fit Probe Level Models, or perform SNP genotyping and exon array analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/oligo.html
---


# bioconductor-oligo

name: bioconductor-oligo
description: Preprocessing and analysis of oligonucleotide microarrays (Affymetrix and NimbleGen). Use this skill to import CEL/XYS files, perform RMA preprocessing, visualize probe-level data (MA plots, boxplots), fit Probe Level Models (PLM), and perform genotyping (CRLMM) or exon/tiling array analysis.

## Overview

The `oligo` package provides a unified framework for analyzing high-density oligonucleotide arrays. It supports various designs including expression, exon, SNP, and tiling arrays. It is designed to handle large datasets efficiently by using the `ff` package for disk-based storage and supporting parallel computing.

## Core Workflow: Expression Arrays

### 1. Data Import
Use `list.celfiles` (Affymetrix) or `list.xysfiles` (NimbleGen) to identify files, then read them into a `FeatureSet` object.

```r
library(oligo)
# Affymetrix
cels <- list.celfiles("path/to/cels", full.names = TRUE)
rawData <- read.celfiles(cels)

# NimbleGen
xys <- list.xysfiles("path/to/xys", full.names = TRUE)
rawData <- read.xysfiles(xys)
```

### 2. Quality Control & Visualization
Visualize raw data to identify spatial artifacts or distribution outliers.

*   **Spatial Plots:** `image(rawData[, 1])` (use `transfo=rank` for better contrast).
*   **Distribution:** `boxplot(rawData)` and `hist(rawData)`.
*   **MA Plots:** `MAplot(rawData, pairs = TRUE)` to compare samples.

### 3. Preprocessing (RMA)
The `rma()` function performs background correction, quantile normalization, and summarization (median polish) in one step.

```r
eset <- rma(rawData)
# Access expression matrix
expMatrix <- exprs(eset)
```

## Specialized Workflows

### Exon Arrays
For exon arrays, you must specify the summarization `target` (probeset, core, extended, or full).

```r
# Gene-level summaries (core)
geneEset <- rma(exonData, target = "core")
# Exon-level summaries
exonEset <- rma(exonData, target = "probeset")
```

### SNP Genotyping (CRLMM)
The `crlmm` algorithm provides genotype calls (1=AA, 2=AB, 3=BB) and confidence scores.

```r
# Results are saved to disk to manage memory
outputDir <- "crlmm_results"
crlmm(celFiles, outputDir)

# Retrieve results
res <- getCrlmmSummaries(outputDir)
calls <- calls(res)
conf <- confs(res)
```

### Probe Level Models (PLM)
Fit models to account for probe and sample effects, useful for calculating QC metrics like RLE and NUSE.

```r
fit <- fitProbeLevelModel(rawData)
# Relative Log Expression
RLE(fit, type = "stats")
# Normalized Unscaled Standard Errors
NUSE(fit, type = "stats")
```

## High Performance Computing

For large datasets that exceed RAM:
1.  Load the `ff` library before processing.
2.  Set `ldPath()` to a directory with sufficient disk space.
3.  Use `ocSamples()` and `ocProbesets()` to tune batch sizes.

```r
library(ff)
ldPath("temp_ff_dir")
# oligo functions will now automatically use ff objects
```

For parallel execution on multicore machines:
```r
# Set number of threads
Sys.setenv(R_THREADS = 4)
# Or use foreach/doMC
library(doMC)
registerDoMC(4)
```

## Reference documentation

- [oligo User's Guide](./references/oug.md)