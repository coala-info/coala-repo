---
name: bioconductor-m3d
description: This tool performs statistical testing for DNA methylation differences in Reduced Representation Bisulfite Sequencing data using the Maximum Mean Discrepancy. Use when user asks to identify differentially methylated regions, test for changes in methylation profile distributions, or account for coverage variation in methylation analysis.
homepage: https://bioconductor.org/packages/3.6/bioc/html/M3D.html
---


# bioconductor-m3d

name: bioconductor-m3d
description: Statistical testing for Reduced Representation Bisulfite Sequencing (RRBS) data sets using the Maximum Mean Discrepancy (MMD). Use this skill to identify differentially methylated regions (DMRs) by testing for changes in the distribution of methylation profiles across pre-defined regions of interest, accounting for coverage variation.

## Overview

The M3D package provides a kernel-based statistical test for identifying differences in DNA methylation profiles between sample groups. Unlike site-specific tests, M3D evaluates the spatial distribution of methylation within regions (islands). It uses the Maximum Mean Discrepancy (MMD) and subtracts a coverage-only MMD to ensure that identified differences are driven by methylation levels rather than just sequencing depth fluctuations.

## Core Workflow

### 1. Data Preparation
M3D uses the `BSraw` data structure from the `BiSeq` package. You can import data from various BED file formats.

```r
library(BiSeq)
library(M3D)

# Define sample metadata
group <- factor(c('Control', 'Control', 'Treat', 'Treat'))
samples <- c('C1', 'C2', 'T1', 'T2')
colData <- DataFrame(group, row.names = samples)

# Read BED files (types: 'Encode', 'BisSNP', 'EPP', 'bismarkCov', 'bismarkCytosine')
rrbs <- readBedFiles(files, colData, bed_type = 'Encode')

# Define regions of interest (GRanges)
# Often created using BiSeq::clusterSites and BiSeq::clusterSitesToGR
data(CpGsDemo) 
```

### 2. Computing the M3D Statistic
The package offers "lite" functions which are faster and more memory-efficient. They automatically calculate the difference between the full MMD and the coverage MMD.

```r
# Find overlaps between regions and cytosine sites
overlaps <- findOverlaps(CpGsDemo, rowRanges(rrbs))

# Compute the M3D statistic (Lite version recommended)
# Returns a matrix where the first column is the mean inter-group difference
M3Dstat <- M3D_Wrapper_lite(rrbs, overlaps)
```

### 3. P-value Generation and FDR
P-values are calculated by comparing inter-group differences against the null distribution (inter-replicate differences).

```r
group1 <- 'Control'
group2 <- 'Treat'

# Generate p-values
# method='empirical' is default; use method='model' for small sample sizes
PDemo <- pvals_lite(rrbs, CpGsDemo, M3Dstat, group1, group2, method='empirical')

# Identify significant regions (FDR < 0.01)
significant_indices <- which(PDemo$FDRmean <= 0.01)
dmrs <- CpGsDemo[significant_indices]
```

### 4. Visualization
Visualize the smoothed methylation profiles for specific regions to inspect the differences between groups.

```r
# Plot profile for the first significant region
plotMethProfile(rrbs, CpGsDemo, group1, group2, significant_indices[1])
```

## Advanced Features

### Outlier Detection
To prevent highly variable regions in the null distribution from skewing results, use the `outlier_test` parameter in the p-value functions.

```r
PDemo <- pvals(rrbs, CpGsDemo, M3Dstat, group1, group2, outlier_test = TRUE)
# Highly variable regions will return NA in the FDRmean vector
```

### Parallel Processing
For large datasets, use the parallelized versions of the wrappers:
- `M3D_Para`: Standard parallel wrapper.
- `M3D_Para_lite`: Memory-efficient parallel wrapper.

## Tips for Success
- **Lite Functions**: Always prefer `M3D_Wrapper_lite` and `pvals_lite` for modern analysis to save memory.
- **Coverage Requirements**: Ensure regions have sufficient coverage (e.g., >100 total reads across samples) before testing to improve statistical power.
- **Bed Types**: Double-check your BED file format against the supported types (`BisSNP`, `EPP`, `bismarkCov`, `bismarkCytosine`, `Encode`) when using `readBedFiles`.

## Reference documentation
- [M3D: Statistical Testing for RRBS Data Sets](./references/M3D_vignette.md)