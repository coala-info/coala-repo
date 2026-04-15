---
name: bioconductor-beadarraysnp
description: This package analyzes Illumina BeadArray genotyping data, specifically from GoldenGate assays. Use when user asks to import Illumina data files, perform quality control on SNP arrays, normalize data for copy number analysis, or visualize genomic alterations and loss of heterozygosity.
homepage: https://bioconductor.org/packages/3.5/bioc/html/beadarraySNP.html
---

# bioconductor-beadarraysnp

name: bioconductor-beadarraysnp
description: Analysis of Illumina genotyping BeadArray data, specifically GoldenGate assays. Use this skill to import Illumina data files, perform Quality Control (QC), normalize SNP data for copy number analysis, and visualize Loss of Heterozygosity (LOH) or genomic alterations.

# bioconductor-beadarraysnp

## Overview

The `beadarraySNP` package is designed for the analysis of Illumina BeadArray genotyping data. It provides a specialized workflow for handling data from the GoldenGate assay, typically involving 96-well plates and OPA (Oligo Pool Assay) panels. The package facilitates the transition from raw Illumina output to normalized copy number profiles and LOH analysis.

## Core Workflow

### 1. Data Import
Data is imported into a `SnpSetIllumina` object. This requires a samplesheet (CSV) and the directory containing the raw data files.

```R
library(beadarraySNP)

# Define data directory and import
datadir <- "path/to/illumina_data"
SNPdata <- read.SnpSetIllumina(paste(datadir, "samplesheet.csv", sep="/"), datadir)

# Optional: Add annotation/phenotype data (Normal vs Tumor, Gender)
pd <- read.AnnotatedDataFrame("targets.txt", sep="\t")
pData(SNPdata) <- cbind(pData(SNPdata), pData(pd))
```

### 2. Quality Control (QC)
QC functions help identify low-quality samples or wells based on intensity metrics.

```R
# Calculate QC metrics
qc <- calculateQCarray(SNPdata)

# Plot QC results (e.g., median green intensity)
plotQC(qc, "greenMed")

# Remove samples that fail thresholds (e.g., < 1500 SNPs or specific OPA criteria)
SNPdata <- removeLowQualitySamples(SNPdata, minSNPs = 1500, minIntensity = 100, "OPA_Name")
```

### 3. Normalization
The package uses a three-step normalization process to prepare data for copy number analysis:
1. **Between Alleles**: Quantile normalization between colors to remove dye bias.
2. **Within Arrays**: Scaling samples using heterozygous SNPs.
3. **Loci Normalization**: Scaling probes against known diploid (normal) samples.

```R
# Step 1: Color bias correction
SNPnrm <- normalizeBetweenAlleles.SNP(SNPdata)

# Step 2: Sample scaling
SNPnrm <- normalizeWithinArrays.SNP(SNPnrm, callscore=0.8, relative=TRUE, fixed=FALSE, quantilepersample=TRUE)

# Step 3: Loci scaling (normalize to copy number 2)
SNPnrm <- normalizeLoci.SNP(SNPnrm, normalizeTo=2)
```

### 4. Visualization and Reporting
Generate smoothed copy number plots across chromosomes.

```R
# Filter for specific chromosomes if necessary
SNPnrm <- SNPnrm[featureData(SNPnrm)$CHR %in% c("1", "2", "X"), ]

# Basic smoothed copy number report
reportSamplesSmoothCopyNumber(SNPnrm, normalizedTo=2, smooth.lambda=4)

# Detailed report with cytobands and sex chromosomes
reportSamplesSmoothCopyNumber(SNPnrm, 
                              normalizedTo=2, 
                              paintCytobands=TRUE, 
                              smooth.lambda=4, 
                              organism="hsa", 
                              sexChromosomes=TRUE)
```

## Key Functions
- `read.SnpSetIllumina()`: Primary data ingestion.
- `calculateQCarray()` / `plotQC()`: Assessment of array performance.
- `normalizeBetweenAlleles.SNP()`: Quantile normalization of red/green channels.
- `normalizeWithinArrays.SNP()`: Normalization using heterozygous SNP calls.
- `reportSamplesSmoothCopyNumber()`: Visualization of genomic profiles.

## Reference documentation
- [beadarraySNP](./references/beadarraySNP.md)