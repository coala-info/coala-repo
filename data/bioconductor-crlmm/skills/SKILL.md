---
name: bioconductor-crlmm
description: This tool performs genotyping and copy number estimation for Affymetrix and Illumina SNP arrays using the CRLMM algorithm. Use when user asks to preprocess CEL or IDAT files, perform genotype calling, calculate confidence scores, or estimate B-allele frequencies and Log R Ratios.
homepage: https://bioconductor.org/packages/release/bioc/html/crlmm.html
---


# bioconductor-crlmm

name: bioconductor-crlmm
description: Genotyping and copy number estimation for Affymetrix (SNP 5.0, 6.0) and Illumina Infinium arrays using the CRLMM algorithm. Use this skill to preprocess CEL or IDAT files, perform genotype calling, calculate confidence scores, and estimate raw copy number or B-allele frequencies (BAF) and Log R Ratios (LRR).

# bioconductor-crlmm

## Overview

The `crlmm` package provides a fast, memory-efficient implementation of the Corrected Robust Linear Model with Maximum likelihood (CRLMM) algorithm. It is designed to handle large-scale SNP array datasets by utilizing the `ff` package for on-disk data storage, allowing analysis of thousands of samples on standard hardware. The package supports both Affymetrix and Illumina platforms, providing genotype calls (AA, AB, BB), confidence scores, and infrastructure for downstream copy number analysis.

## Core Workflow: Affymetrix (SNP 5.0/6.0)

### 1. Setup and Data Identification
Identify CEL files and define an output directory for the `ff` files.

```r
library(crlmm)
library(ff)

# Set path for ff objects (crucial for memory management)
ldPath("path/to/output_dir")
ocProbesets(100000) # Process 100k probes at a time
ocSamples(200)      # Process 200 samples at a time

celFiles <- list.celfiles("path/to/cels", full.names=TRUE)
```

### 2. Genotyping
For simple genotyping (SnpSet output):
```r
result <- crlmm(celFiles)
# Access results
gcalls <- calls(result)
confs <- confs(result) # Confidence scores
snr <- result[["SNR"]] # Signal-to-Noise Ratio
```

### 3. Copy Number Preprocessing
For copy number workflows, use the `CNSet` container:
```r
# Define batches (e.g., by plate or scan date)
batches <- rep("batch1", length(celFiles))

cnSet <- constructAffyCNSet(celFiles, batch=batches, cdfName="genomewidesnp6", genome="hg19")
cnrmaAffy(cnSet)   # Quantile normalization for non-polymorphic markers
snprmaAffy(cnSet)  # Quantile normalization for SNPs
genotypeAffy(cnSet) # Perform genotyping
```

## Core Workflow: Illumina Infinium

### 1. Setup
Illumina requires a sample sheet and IDAT files.
```r
samplesheet <- read.csv("sample_map.csv")
arrayNames <- file.path("path/to/idats", samplesheet$SentrixPosition)

# Specify platform (e.g., "human370v1c")
cnSet <- genotype.Illumina(sampleSheet=samplesheet, 
                           arrayNames=arrayNames, 
                           cdfName="human370v1c", 
                           batch=rep("1", nrow(samplesheet)))
```

## Copy Number Estimation

Once a `CNSet` is genotyped, estimate copy number parameters:

```r
# Fit linear model for copy number
crlmmCopynumber(cnSet)

# Extract raw total copy number for specific samples/probes
# i = probe index, j = sample index
rawCN <- totalCopynumber(cnSet, i=1:1000, j=1:5)

# Extract allele-specific copy number
ca <- CA(cnSet, i=1:100, j=1:2)
cb <- CB(cnSet, i=1:100, j=1:2)
```

## Downstream Integration

### Converting to SnpMatrix (for GWAS)
Use `snpStats` for association testing:
```r
library(snpStats)
# Convert calls (1=AA, 2=AB, 3=BB) to SnpMatrix format (0, 1, 2)
theCalls <- t(calls(result)) - 1L
snpMat <- new("SnpMatrix", theCalls)
```

### BAF and LRR for HMMs
Coerce to `BafLrrSetList` for use in packages like `VanillaICE`:
```r
library(VanillaICE)
open(cnSet)
oligoSetList <- BafLrrSetList(cnSet)
lrr_values <- lrr(oligoSetList)
baf_values <- baf(oligoSetList)
close(cnSet)
```

## Tips and Quality Control

- **Memory Management**: Always use `ldPath()` to specify where `ff` files should be stored. Use `open(cnSet)` and `close(cnSet)` when accessing `ff`-backed data to manage file connections.
- **SNR**: Signal-to-Noise Ratio is a primary QC metric. For Affymetrix, SNR < 5 often indicates poor quality; for Illumina, the threshold is typically < 25.
- **Batch Effects**: Copy number estimation requires at least 10 samples per batch. Ensure the `batch` variable correctly reflects processing groups.
- **Annotation**: Ensure the correct Crlmm annotation package is installed (e.g., `genomewidesnp6Crlmm`, `human370v1cCrlmm`).

## Reference documentation
- [Preprocessing & Genotyping Affymetrix Arrays for Copy Number Analysis](./references/AffyGW.md)
- [Overview of vignettes for copy number estimation](./references/CopyNumberOverview.md)
- [Preprocessing and Genotyping Illumina Arrays for Copy Number Analysis](./references/IlluminaPreprocessCN.md)
- [Infrastructure for copy number analysis in crlmm](./references/Infrastructure.md)
- [Genotyping with the crlmm Package](./references/genotyping.md)
- [crlmm to downstream data analysis](./references/gtypeDownstream.md)