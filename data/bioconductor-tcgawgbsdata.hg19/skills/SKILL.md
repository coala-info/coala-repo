---
name: bioconductor-tcgawgbsdata.hg19
description: This package provides access to TCGA Whole Genome Bisulfite Sequencing data mapped to the hg19 reference genome for use with the bsseq package. Use when user asks to retrieve TCGA WGBS data from ExperimentHub, perform high-resolution methylation profiling, or identify differentially methylated regions between tumor and normal samples.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/tcgaWGBSData.hg19.html
---


# bioconductor-tcgawgbsdata.hg19

## Overview

The `tcgaWGBSData.hg19` package provides access to Whole Genome Bisulfite Sequencing (WGBS) data from The Cancer Genome Atlas (TCGA) mapped to the hg19 reference genome. The data is hosted on `ExperimentHub` and is primarily structured for use with the `bsseq` package. It allows for high-resolution methylation profiling and comparison between tumor and normal samples.

## Data Acquisition

Data is retrieved using `ExperimentHub`. The package typically involves two main components: the assay data (HDF5 format) and the `BSseq` object metadata.

```r
library(ExperimentHub)
library(bsseq)

eh = ExperimentHub()
# Query for the package resources
query(eh, "tcgaWGBSData.hg19")

# EH1661: Assay data (h5 file)
# EH1662: BSseq object
tcga_data <- eh[["EH1661"]]
TCGA_bs <- eh[["EH1662"]]

# Critical: The HDF5 file must be renamed/linked correctly for the BSseq object to find it
file.rename(from=tcga_data, to=paste0(dirname(tcga_data), '/assays.h5'))
```

## Workflow: Differential Methylation Analysis

### 1. Phenotype and Coverage Exploration
Extract sample metadata and calculate basic methylation statistics.

```r
library(Biobase)
phenoData <- pData(TCGA_bs)

# Get coverage matrices
cov_matrix <- getCoverage(TCGA_bs)
meth_matrix <- getCoverage(TCGA_bs, type='M')

# Calculate mean methylation (filtering for minimum coverage of 10)
meth_matrix[cov_matrix < 10] <- NA
meanMethylation <- DelayedArray::colMeans(meth_matrix / cov_matrix, na.rm=TRUE)
```

### 2. Smoothing and T-Statistics
To identify Differentially Methylated Regions (DMRs), the data should be smoothed. It is recommended to subset by chromosome for memory efficiency.

```r
# Subset to a specific chromosome and specific samples
chrIndex <- seqnames(TCGA_bs) == 'chr22'
group1 <- c(11, 6, 23) # Indices for Normal
group2 <- c(20, 26, 25) # Indices for Tumor
TCGA_bs_sub <- updateObject(TCGA_bs[chrIndex, c(group1, group2)])

# Smooth the data
TCGA_bs_sub.fit <- BSmooth(TCGA_bs_sub, mc.cores = 2, verbose = TRUE)

# Compute t-statistics
TCGA_bs_sub.tstat <- BSmooth.tstat(TCGA_bs_sub.fit, 
                                   group1 = 1:3, 
                                   group2 = 4:6, 
                                   estimate.var = "group2", 
                                   local.correct = TRUE)
```

### 3. Finding DMRs
Identify regions where methylation differs significantly between groups.

```r
# Find regions based on t-stat cutoff
dmrs0 <- dmrFinder(TCGA_bs_sub.tstat, cutoff = c(-4.6, 4.6))

# Filter for biological significance (e.g., at least 3 CpGs and 10% difference)
dmrs <- subset(dmrs0, n >= 3 & abs(meanDiff) >= 0.1)

# Visualize a specific region
plotRegion(TCGA_bs_sub.fit, dmrs[1,], extend = 5000, addRegions = dmrs)
```

## Usage Tips
- **Memory Management**: The data is stored in HDF5 format via `DelayedArray`. Avoid converting the entire matrix to a standard R matrix (`as.matrix()`) unless working with a small subset.
- **File Paths**: If you encounter errors regarding missing `.h5` files, ensure the `EH1661` resource has been renamed to `assays.h5` in the same directory as the `BSseq` object.
- **Object Updates**: Use `updateObject()` on older `BSseq` objects retrieved from ExperimentHub to ensure compatibility with current `bsseq` package versions.

## Reference documentation
- [tcgaWGBSData.hg19](./references/tcgaWGBSData.hg19.md)