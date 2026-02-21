---
name: bioconductor-diffutr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/diffUTR.html
---

# bioconductor-diffutr

## Overview

The `diffUTR` package provides a unified framework for analyzing differential exon and 3' UTR usage. It acts as a wrapper for established methods like `DEXSeq` and `edgeR`, while introducing `diffSplice2`—an improved version of `limma`'s splicing analysis that accounts for bin-specific variances. A key feature is its ability to integrate alternative poly-adenylation (APA) site databases to define and analyze UTR-specific bins that are often missing from standard annotations.

## Typical Workflow

### 1. Prepare Annotation Bins
Convert gene annotations (GTF or `EnsDb`) into non-overlapping genomic bins.

```r
library(diffUTR)
library(SummarizedExperiment)

# Standard DEU bins
bins <- prepareBins(gene_annotation)

# Differential 3' UTR bins (requires APA sites)
# APA sites can be a GRanges object or a path to a BED file
bins_utr <- prepareBins(gene_annotation, apa_sites = "path/to/apa.bed.gz")
```

### 2. Feature Counting
Count reads overlapping the defined bins. This wraps `Rsubread::featureCounts`.

```r
# bamfiles is a vector of paths
rse <- countFeatures(bamfiles, bins, strandSpecific = 2, isPairedEnd = TRUE)
```

### 3. Differential Analysis
Run the differential usage test. `diffSpliceWrapper` is recommended for speed and accuracy (using the `diffSplice2` method).

```r
# Using the formula interface
rse <- diffSpliceWrapper(rse, design = ~condition)

# For complex models, specify the coefficient
# rse <- diffSpliceWrapper(rse, design = model.matrix(~batch + condition), coef = "conditionLTP")
```

### 4. Gene-Level Statistics
Aggregate bin-level p-values and coefficients to the gene level. You can filter by bin type (e.g., only UTRs).

```r
# Extract UTR-specific results
utr_stats <- geneLevelStats(rse, includeTypes = "UTR", returnSE = FALSE)

# Extract CDS-specific results
cds_stats <- geneLevelStats(rse, includeTypes = "CDS", returnSE = FALSE)
```

## Visualization

### Volcano-style Plots
Visualize top genes based on effect size and significance.

```r
# Standard plot
plotTopGenes(rse)

# UTR-specific plot with signed/width-weighted aggregation
plotTopGenes(utr_stats, diffUTR = TRUE)
```

### Gene Profiles
Examine bin-level expression across conditions or samples.

```r
# Add normalized assays first
rse <- addNormalizedAssays(rse)

# Plot bin statistics for a specific gene
deuBinPlot(rse, "GeneName", type = "condition", colour = "condition")

# Heatmap of bins per sample
geneBinHeatmap(rse, "GeneName")
```

## Key Functions and Tips

- **Method Selection**: `DEXSeq` (via `DEXSeqWrapper`) is generally the most accurate but slow. `diffSpliceWrapper` (diffSplice2) is the recommended alternative for large datasets.
- **Density Ratio**: Use the `density.ratio` column in results to identify changes in bins that are actually expressed relative to the rest of the gene.
- **APA Databases**: For human, mouse, or C. elegans, use the PolyASite atlas. For rat, the package provides `rn6_PAS`.
- **Strandedness**: Ensure `strandSpecific` in `countFeatures` matches your library preparation (0=unstranded, 1=stranded, 2=reversely stranded).

## Reference documentation

- [diffSplice2 - Improvements to limma's diffSplice](./references/diffSplice2.md)
- [diffUTR - Analysis of differential exon and 3' UTR usage](./references/diffUTR.md)