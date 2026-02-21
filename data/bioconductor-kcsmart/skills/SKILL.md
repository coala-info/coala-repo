---
name: bioconductor-kcsmart
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/KCsmart.html
---

# bioconductor-kcsmart

name: bioconductor-kcsmart
description: Statistical analysis of multi-experiment aCGH data to find recurrent genomic gains and losses. Use this skill when you need to perform kernel convolution-based smoothing (KC-SMART) on copy number data, identify significant recurrent aberrations using permutation-based thresholds, or compare copy number profiles between two groups of samples.

## Overview

KCsmart (Kernel Convolution-based Smoothing) is a package for identifying recurrent genomic aberrations from array Comparative Genome Hybridization (aCGH) data. Unlike methods that rely on discrete calling of gains and losses, KCsmart uses continuous log2 ratios. It applies Gaussian locally weighted regression to summed totals of positive and negative ratios, corrects for probe spacing, and determines significance through permutation testing.

## Core Workflow

### 1. Data Preparation
The package requires a data frame or a Bioconductor object (DNAcopy, CGHbase) containing:
- `chrom`: Chromosome names.
- `maploc`: Chromosomal locations.
- Sample columns: Numeric log2 ratios (no missing values allowed).

```r
library(KCsmart)
data(hsSampleData) # Example dataset
# Ensure no NAs; impute or discard if necessary
```

### 2. Mirror Locations
To prevent signal decay at chromosome ends and centromeres, KCsmart uses "mirroring."
- Use `data(hsMirrorLocs)` for human or `data(mmMirrorLocs)` for mouse.
- Custom genomes require a list with start, centromere (optional), and end coordinates for each chromosome.

### 3. Calculating the Sample Point Matrix (SPM)
The `calcSpm` function performs the kernel convolution. The `sigma` parameter (in bp) determines the smoothing scale (default is 1Mb).

```r
# 1Mb kernel width
spm1mb <- calcSpm(hsSampleData, hsMirrorLocs)

# 4Mb kernel width for lower resolution/larger regions
spm4mb <- calcSpm(hsSampleData, hsMirrorLocs, sigma=4000000)
```

### 4. Significance Testing
Determine thresholds for gains and losses using permutation.
- `findSigLevelTrad`: Traditional Bonferroni-corrected significance.
- `findSigLevelFdr`: False Discovery Rate (FDR) approach.

```r
# n=1000 is recommended for definitive analysis
sigLevel <- findSigLevelTrad(hsSampleData, spm4mb, n=10, p=0.05)
```

### 5. Visualization and Extraction
- **Plotting**: Use `plot(spm)` to see genomic views. Use `sigLevels` to add thresholds.
- **Extraction**: Use `getSigSegments` to retrieve genomic coordinates and probe names for significant regions.

```r
# Plot gains and losses in one frame with significance
plot(spm4mb, sigLevels=sigLevel, type=1)

# Extract segments
sigRegions <- getSigSegments(spm4mb, sigLevel)
# Access probes in the first gained region
sigRegions@gains[[1]]$probes
```

## Advanced Analysis

### Multi-scale Analysis (Scale Space)
Compare results across different kernel widths to identify both focal and broad aberrations.

```r
plotScaleSpace(list(spm1mb, spm4mb), list(sigLevel1mb, sigLevel4mb), type='g')
```

### Comparative KC-SMART
Identify significant differences between two groups (e.g., Treatment vs. Control).

1. **Create Collection**: `calcSpmCollection` requires a class vector `cl` (0s and 1s).
2. **Compare**: `compareSpmCollection` uses permutations or the `siggenes` package.
3. **Extract**: `getSigRegionsCompKC` retrieves the differing regions.

```r
# cl defines the two groups
spmc <- calcSpmCollection(hsSampleData, hsMirrorLocs, cl=c(rep(0,10), rep(1,10)))
spmc.sig <- compareSpmCollection(spmc, method="siggenes")
diffRegions <- getSigRegionsCompKC(spmc.sig)
plot(spmc.sig, sigRegions=diffRegions)
```

## Reference documentation
- [KC-SMART Vignette](./references/KCS.md)