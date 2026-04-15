---
name: bioconductor-les
description: This tool identifies differential effects in tiling microarray data by integrating probe-level p-values into spatially coherent scores. Use when user asks to identify loci of enhanced significance, analyze genomic tiling data, or detect regulated regions in ChIP-chip and DNA modification experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/les.html
---

# bioconductor-les

name: bioconductor-les
description: Identifying differential effects in tiling microarray data using the Loci of Enhanced Significance (LES) framework. Use this skill when analyzing genomic tiling data to identify regions of interest (e.g., ChIP-chip, DNA modification) by integrating probe-level p-values into spatially coherent scores (Lambda).

# bioconductor-les

## Overview

The `les` package provides a statistical framework to identify "Loci of Enhanced Significance" in tiling microarray data. It operates on the principle that in regions without differential effects, p-values are uniformly distributed, while regulated regions show a shift toward zero. By applying a sliding window and estimating the fraction of significant probes ($\Lambda$), it identifies regulated genomic regions independently of the underlying probe-level statistical test.

## Core Workflow

### 1. Data Preparation
The package requires probe positions and corresponding p-values (e.g., from `limma` or a t-test).

```r
library(les)
# pos: integer vector of genomic positions
# pval: numeric vector of p-values for each position
# res: Les object
res <- Les(pos, pval, chr = NULL)
```

### 2. Estimating Local Significance ($\Lambda$)
Calculate the local fraction of significant probes using a weighting window.

```r
# win: window size in base pairs
# weighting: triangWeight (default), rectangWeight, epWeight, or gaussWeight
res <- estimate(res, win = 200, weighting = rectangWeight)
```

### 3. Identifying Regulated Regions
Convert the continuous $\Lambda$ statistic into discrete regions by estimating a threshold ($\Theta$).

```r
# Estimate threshold based on Grenander estimator
res <- threshold(res, grenander = TRUE)

# Identify contiguous regions meeting the threshold
res <- regions(res, minLength = 0, maxGap = 0)

# Extract results as a data frame
reg_df <- res["regions"]
```

### 4. Statistical Validation
Compute confidence intervals for $\Lambda$ via bootstrapping. This is computationally intensive; use a subset of probes if possible.

```r
# subset: logical or integer vector
res <- ci(res, subset = NULL, nBoot = 50, alpha = 0.1)
```

## Visualization and Export

### Plotting Results
The `plot` method is highly customizable using specific argument lists for different plot components.

```r
# Basic plot
plot(res, region = TRUE)

# Advanced plot with confidence intervals and custom colors
plot(res, 
     error = "ci", 
     region = TRUE, 
     rug = TRUE,
     sigArgs = list(col = "red"),
     plotArgs = list(main = "LES Analysis"),
     regionArgs = list(col = "grey", density = 20))
```

### Exporting Data
Results can be exported to standard genomic formats for use in genome browsers.

```r
export(res, "results.bed", format = "bed")
export(res, "results.gff", format = "gff")
export(res, "results.wig", format = "wig")
```

## Tips and Best Practices
- **Window Selection**: The power of detection is highest when the window size matches the expected size of the biological effect.
- **Weighting Functions**: While `triangWeight` is the default, `rectangWeight` often provides sharper boundaries for spike-in style data.
- **Custom Windows**: You can define custom weighting functions: `function(distance, win) { ... }`.
- **Accessing Slots**: Use the `[` operator (e.g., `res["lambda"]`) to access internal data slots of the `Les` object.

## Reference documentation
- [Introduction to the les package](./references/les.md)