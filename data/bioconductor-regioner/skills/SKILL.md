---
name: bioconductor-regioner
description: This tool performs statistical association analysis between sets of genomic regions using permutation tests. Use when user asks to test the significance of overlaps between genomic regions, evaluate spatial associations, or perform local Z-score analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/regioneR.html
---

# bioconductor-regioner

name: bioconductor-regioner
description: Statistical analysis of genomic region associations using permutation tests. Use when you need to evaluate if two sets of genomic regions (e.g., ChIP-seq peaks, CpG islands, promoters) overlap or are closer than expected by chance, or to perform local Z-score analysis to determine the spatial specificity of an association.

# bioconductor-regioner

## Overview

The `regioneR` package provides a framework for association analysis of genomic regions based on permutation tests. It allows users to statistically test whether the spatial relationship between two sets of regions (RS) is significant compared to a random distribution. It is "genome-aware," meaning it respects chromosome boundaries and can account for "masks" (unmappable or forbidden regions like centromeres).

## Core Workflow

### 1. Data Preparation
Convert various input formats (BED files, data frames, character strings) into `GRanges` objects using `toGRanges`.

```r
library(regioneR)

# From data frame
df <- data.frame(chr="chr1", start=c(100, 500), end=c(200, 600))
gr <- toGRanges(df)

# From file or URL
peaks <- toGRanges("path/to/peaks.bed")
```

### 2. Basic Association Testing
Use `overlapPermTest` for the most common task: checking if Set A overlaps Set B more than expected.

```r
# ntimes: number of permutations (start with 50-100 for testing, 1000+ for publication)
pt <- overlapPermTest(A=my_peaks, B=promoters, ntimes=100, genome="hg19")
summary(pt)
plot(pt)
```

### 3. Advanced Permutation Testing
Use the general `permTest` function to customize the randomization strategy and evaluation metric.

```r
pt <- permTest(A=my_regions, 
               ntimes=500, 
               randomize.function=randomizeRegions, 
               evaluate.function=numOverlaps, 
               B=other_regions, 
               genome="hg19", 
               mask=my_mask)
```

**Common Randomization Functions:**
- `randomizeRegions`: Completely randomizes positions (slowest, most flexible).
- `circularRandomizeRegions`: Maintains internal distances between regions (faster).
- `resampleRegions`: Draws from a specific "universe" (e.g., a subset of all known genes).

**Common Evaluation Functions:**
- `numOverlaps`: Counts overlaps.
- `meanDistance`: Calculates average distance to the nearest region in B.
- `meanInRegion`: Calculates the mean of a numeric value (e.g., methylation) across regions.

### 4. Local Z-Score Analysis
To determine if an association is dependent on the exact position or is a broad regional effect, use `localZScore`. A sharp peak at the center indicates high spatial specificity.

```r
lz <- localZScore(pt=pt, A=my_peaks, B=promoters, window=1000, step=50)
plot(lz)
```

## Helper Functions

`regioneR` includes utilities for manipulating region sets that are often simpler than standard `GenomicRanges` calls:

- `filterChromosomes(gr, organism="hg19")`: Keep only canonical/autosomal chromosomes.
- `extendRegions(gr, extend.start=100, extend.end=100)`: Expand regions.
- `joinRegions(gr, min.dist=10)`: Merge regions closer than a threshold.
- `overlapRegions(A, B)`: Returns a detailed data frame of overlaps between two sets.

## Tips for Success

- **Reproducibility**: When using parallel processing, set `mc.set.seed=FALSE` and use `set.seed()` to ensure results are reproducible.
- **Subset Testing**: For very large datasets, test your workflow on a subset (e.g., `sample(my_gr, 1000)`) to estimate timing before running thousands of permutations.
- **Masking**: Always use a mask (e.g., `getGenomeAndMask("hg19")$mask`) to prevent randomizing regions into unmappable areas like centromeres, which can inflate significance.
- **Named Arguments**: Always use named arguments in `permTest` (e.g., `A=peaks`) because it uses the ellipsis (`...`) to pass parameters to internal functions.

## Reference documentation

- [regioneR: Association analysis of genomic regions based on permutation tests](./references/regioneR.md)