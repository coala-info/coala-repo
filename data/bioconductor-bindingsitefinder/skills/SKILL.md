---
name: bioconductor-bindingsitefinder
description: The package provides functions for binding site definition and result visualization. For details please see the vignette.
homepage: https://bioconductor.org/packages/release/bioc/html/BindingSiteFinder.html
---

# bioconductor-bindingsitefinder

name: bioconductor-bindingsitefinder
description: Expert guidance for the BindingSiteFinder R package to define, analyze, and visualize RBP binding sites from iCLIP data. Use this skill when you need to process iCLIP crosslink sites (e.g., from PureCLIP), define equally sized binding sites, perform replicate reproducibility filtering, assign sites to genomic features (genes/transcript regions), or conduct differential binding analysis between conditions.

# bioconductor-bindingsitefinder

## Overview
The `BindingSiteFinder` package is designed for the precise definition of RNA-binding protein (RBP) binding sites from iCLIP (individual-nucleotide resolution UV crosslinking and immunoprecipitation) data. It transforms single-nucleotide crosslink sites into robust, equally sized binding sites while providing extensive diagnostic visualizations and integration with genomic annotations.

## Core Workflow

### 1. Data Initialization
The central data structure is the `BSFDataSet`. It requires crosslink sites (GRanges) and iCLIP coverage (BigWig files).

```r
library(BindingSiteFinder)

# Define meta table (requires condition, clPlus, clMinus columns)
meta <- data.frame(
  id = 1:4,
  condition = factor(rep("WT", 4)),
  clPlus = c("rep1_plus.bw", "rep2_plus.bw", ...),
  clMinus = c("rep1_minus.bw", "rep2_minus.bw", ...)
)

# Create BSFDataSet
bds <- BSFDataSetFromBigWig(ranges = crosslink_sites_gr, meta = meta)
```

### 2. Automated Binding Site Definition
The `BSFind()` function is a high-level wrapper that executes the standard pipeline:
1. **Global Filtering**: Removes low-score crosslink sites.
2. **Width Estimation**: Direct data-driven estimation of optimal binding site width.
3. **Gene-wise Filtering**: Retains top-performing sites per gene.
4. **Merging**: Concatenates sites into fixed-width binding regions.
5. **Reproducibility**: Filters for sites supported by $N-1$ replicates.
6. **Annotation**: Assigns sites to genes and transcript regions (CDS, UTR, Intron).

```r
# Standard run
bdsOut <- BSFind(
  object = bds, 
  anno.genes = gns_gr, 
  anno.transcriptRegionList = regions_grl,
  est.subsetChromosome = "chr22" # Optional: speed up estimation
)

# Quick visualization of the whole process
processingStepsFlowChart(bdsOut)
```

### 3. Manual Refinement
If `BSFind()` is too automated, call utility functions individually:
- `pureClipGlobalFilter()`: Filter by input score.
- `estimateBsWidth()`: Find optimal width (use `estimateBsWidthPlot()` to visualize).
- `makeBindingSites()`: Create the actual ranges.
- `reproducibilityFilter()`: Ensure consistency across replicates.

### 4. Genomic Annotation
Assign binding sites to specific features to understand the RBP's binding preferences.

```r
# Assign to genes
bds <- assignToGenes(bds, anno.genes = gns)

# Assign to transcript regions (CDS, Intron, UTR)
bds <- assignToTranscriptRegions(bds, anno.transcriptRegionList = regions)

# Visualize results
targetGeneSpectrumPlot(bdsOut)
transcriptRegionSpectrumPlot(bdsOut, normalize = TRUE)
```

### 5. Differential Binding Analysis
Compare binding between conditions (e.g., WT vs KO) while correcting for transcript expression changes using a DESeq2-based framework.

```r
# 1. Combine datasets from two conditions
bds.comb <- bds.wt + bds.ko

# 2. Calculate background (non-binding) counts per gene
bds.diff <- calculateBsBackground(bds.comb, anno.genes = gns)

# 3. Filter for sufficient signal
bds.diff <- filterBsBackground(bds.diff)

# 4. Calculate fold changes (Likelihood Ratio Test)
bds.diff <- calculateBsFoldChange(bds.diff)

# 5. Visualize
plotBsMA(bds.diff, what = "bs")
geneRegulationPlot(bds.diff, plot.geneID = "ENSG...", anno.genes = gns)
```

## Visualization and Export
- **Coverage Plots**: `bindingSiteCoveragePlot(bdsOut, plotIdx = 1)` shows replicate-level signal.
- **BED Export**: `exportToBED(bdsOut, con = "results.bed")`.
- **Range Extraction**: `getRanges(bdsOut)` returns a GRanges object with all metadata (scores, gene assignments, etc.).

## Tips for Success
- **Binding Site Width**: If the RBP is known to have broad binding, increase `maxBsWidth` in estimation or set `bsSize` manually.
- **Reproducibility**: Use `reproducibilityScatterPlot()` to check if replicates correlate well before and after filtering.
- **Memory**: For large genomes, use `est.subsetChromosome` during the estimation phase to save time and memory.

## Reference documentation
- [Definition of binding sites from iCLIP signal](./references/vignette.md)