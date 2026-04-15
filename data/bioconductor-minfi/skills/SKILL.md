---
name: bioconductor-minfi
description: The minfi package provides a comprehensive pipeline for analyzing Illumina Infinium DNA methylation microarrays, from raw data ingestion to the identification of differentially methylated regions. Use when user asks to read IDAT files, perform quality control on methylation data, normalize probe intensities, or identify differentially methylated positions and regions.
homepage: https://bioconductor.org/packages/release/bioc/html/minfi.html
---

# bioconductor-minfi

## Overview
The `minfi` package is a comprehensive toolset for analyzing Illumina Infinium DNA methylation microarrays. It handles the full pipeline from raw IDAT file ingestion to the identification of differentially methylated regions (DMRs). It is particularly noted for its flexible class system that tracks data from raw probe intensities (`RGChannelSet`) to genomic-mapped methylation ratios (`GenomicRatioSet`).

## Core Workflow

### 1. Data Ingestion
The standard entry point is a Sample Sheet (CSV) and a directory of IDAT files.

```r
library(minfi)
library(minfiData) # For example data

# Read sample sheet
baseDir <- "/path/to/idat_folder"
targets <- read.metharray.sheet(baseDir)

# Load raw IDAT data into an RGChannelSet
rgSet <- read.metharray.exp(targets = targets)
```

### 2. Quality Control
Assess sample quality before normalization.

```r
# Get QC metrics
qc <- getQC(preprocessRaw(rgSet))
plotQC(qc)

# Estimate sex to check for sample swaps
predictedSex <- getSex(preprocessRaw(rgSet), cutoff = -2)
plotSex(predictedSex)

# MDS plot to visualize sample clustering
mdsPlot(rgSet, numPositions = 1000, sampGroups = targets$Sample_Group)
```

### 3. Preprocessing and Normalization
`minfi` offers several normalization methods depending on the study design:

*   `preprocessRaw(rgSet)`: No normalization.
*   `preprocessIllumina(rgSet)`: Mimics Genome Studio.
*   `preprocessSWAN(rgSet)`: Recommended for within-array normalization (Type I vs Type II probes).
*   `preprocessNoob(rgSet)`: Background correction using out-of-band probes.
*   `preprocessQuantile(rgSet)`: Best for samples with similar global methylation profiles.
*   `preprocessFunnorm(rgSet)`: Functional normalization; best for large studies with technical variation.

```r
# Example: Functional Normalization
mSetSq <- preprocessFunnorm(rgSet)

# Convert to RatioSet (Beta or M-values)
ratioSet <- ratioConvert(mSetSq, what = "both", keepCN = TRUE)

# Map to genome (creates GenomicRatioSet)
gRatioSet <- mapToGenome(ratioSet)
```

### 4. Data Extraction
Extract Beta values (0 to 1) or M-values (log-ratios) for downstream statistical analysis.

```r
beta <- getBeta(gRatioSet)
mValues <- getM(gRatioSet)
```

### 5. Differential Methylation Analysis
Identify single sites (DMP) or regions (DMR).

```r
# DMP Finding
group <- pData(gRatioSet)$Sample_Group
dmp <- dmpFinder(mValues, pheno = group, type = "categorical")

# DMR Finding (Bump Hunting)
# Requires a design matrix
design <- model.matrix(~group)
bumps <- bumphunter(gRatioSet, design = design, cutoff = 0.1, B = 100, type = "Beta")
```

## Data Classes Summary
*   `RGChannelSet`: Raw Red/Green intensities. Contains control probes.
*   `MethylSet`: Methylated/Unmethylated intensities at CpG loci.
*   `RatioSet`: Beta and/or M-values.
*   `GenomicMethylSet/GenomicRatioSet`: Data mapped to genomic coordinates (hg19, hg38, etc.).

## Tips and Best Practices
*   **Array Conversion**: Use `convertArray()` when combining data from different platforms (e.g., 450k and EPIC).
*   **Cell Type Deconvolution**: Use `estimateCellCounts()` to account for cellular heterogeneity in blood samples.
*   **SNP Filtering**: Use `dropLociWithSnps()` to remove probes where SNPs may interfere with binding and measurement.
*   **Memory Management**: For very large datasets, consider using the `DelayedArray` backend or processing in batches.

## Reference documentation
- [The minfi User’s Guide](./references/minfi.md)