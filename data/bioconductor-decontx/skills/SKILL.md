---
name: bioconductor-decontx
description: bioconductor-decontx identifies and removes ambient RNA and background protein contamination from single-cell sequencing datasets and estimates a contamination fraction for each cell. Use when user asks to decontaminate scRNA-seq or CITE-seq data, correct ambient RNA or soup, estimate per-cell contamination, or remove background noise from count matrices.
homepage: https://bioconductor.org/packages/release/bioc/html/decontX.html
---

# bioconductor-decontx

name: bioconductor-decontx
description: Decontamination of single-cell RNA-seq (scRNA-seq) and protein expression (CITE-seq/Total-seq) data. Use this skill to estimate and remove ambient RNA or background protein contamination from count matrices or SingleCellExperiment objects using the decontX and decontPro algorithms.

# bioconductor-decontx

## Overview

The `decontX` package provides Bayesian methods to identify and remove contamination in single-cell datasets. It contains two primary algorithms:
1. **decontX**: Designed for scRNA-seq data to remove ambient RNA cross-contamination.
2. **decontPro**: Designed for single-cell protein expression data (e.g., ADT counts from CITE-seq) to remove ambient and non-specific background contamination.

Both methods decompose observed counts into native expression and contamination components, improving downstream clustering and visualization.

## Workflow for scRNA-seq (decontX)

### 1. Data Input
`decontX` accepts either a `SingleCellExperiment` (SCE) object or a sparse counts matrix.

```r
library(decontX)
# Using a SingleCellExperiment
sce <- decontX(sce)

# Using a matrix
result <- decontX(counts_matrix)
# Decontaminated counts are in result$decontXcounts
```

### 2. Using Background Data
`background` takes the contamination profile from a "raw" or "droplet" matrix of empty droplets
instead of from the other cell clusters.

```r
sce <- decontX(sce, background = sce_raw)
```

It does not always help. With few or shallow empty droplets the profile is noisy and the
estimates can rise. Run both, compare the mean contamination and the share of counts removed,
and keep the one your checks favour.

### 3. Cell Clustering
`decontX` performs heuristic clustering by default. If you have pre-defined cell labels, provide them via the `z` parameter to improve accuracy.

```r
sce <- decontX(sce, z = my_cluster_labels)
```

### 4. Accessing Results
* **Contamination Score**: Found in `colData(sce)$decontX_contamination` (0 to 1 scale).
* **Decontaminated Counts**: Accessed via `decontXcounts(sce)`.

## Run one channel at a time
Ambient RNA differs between channels (10x lanes; in aggregated data the barcode suffix `-1`,
`-2`, ... names the channel). Run `decontX` on each channel's cells separately, with
`set.seed()` before each call: results move a little between seeds.

## Per-cell contamination with the channel's own soup
DecontX estimates each cell's contamination fraction well (`$contamination`, or
`colData(sce)$decontX_contamination`). Its corrected counts, however, remove a mixture of the
other clusters' native profiles, not the soup measured in the channel's empty droplets. When
the ambient profile carries channel-specific genes, use the two parts separately: the soup
profile from the channel's empty droplets, the fraction from DecontX. This is SoupX's model
(Young & Behjati 2020) with a fraction per cell:

```python
# one channel: O genes x cells (cells only), E genes x empty droplets, rho from DecontX
soup = E.sum(axis=1) / E.sum()          # the channel's soup profile
N = O.sum(axis=0)                       # each cell's total count
C = np.rint(np.maximum(O - np.outer(soup, rho * N), 0))   # floor each gene at zero
```

On sparse data, compute only where `O > 0`: an entry that is 0 stays 0.

- SoupX takes the per-cell vector too: `setContaminationFraction(sc, rho_named_by_barcode,
  forceAccept = TRUE)`, then `adjustCounts(sc, roundToInt = TRUE)`. Its subtraction keeps
  removing counts from other genes when a gene reaches zero, so it removes more than the
  floor-at-zero form. Compare both.
- When a task states its own correction formula, apply that formula as stated, with these
  estimates.
- Report the DecontX fraction as the per-cell contamination.

## Checks after a correction
- The share of counts removed in each channel against the mean contamination fraction.
- Genes enriched in one channel's soup over the other channels: their counts in that
  channel's cells should fall.
- Markers of one population in cells of another population should fall; markers in their
  own population should not.
- No cell or gene dropped, every corrected count at most the observed count.

## Installation
Tested: image `bioconductor/bioconductor_docker:RELEASE_3_20` with
`BiocManager::install("decontX")` into a writable library (`.libPaths(c("/rlib", .libPaths()))`).

## Workflow for Protein Data (decontPro)

### 1. Preparation
`decontPro` requires a counts matrix and a vector of cell clusters.

```r
# counts: matrix of ADT counts
# clusters: integer vector of cluster assignments
out <- decontPro(counts, clusters)
```

### 2. Tuning Priors
For small or highly contaminated datasets, adjust `delta_sd` and `background_sd`. Larger values increase the model's flexibility to identify contamination.

```r
out <- decontPro(counts, clusters, delta_sd = 2e-4, background_sd = 2e-5)
```

### 3. Results
The decontaminated matrix is stored in `out$decontaminated_counts`.

## Visualization and QC

### scRNA-seq (celda package integration)
Use the `celda` package for specialized `decontX` plots:
* `plotDecontXContamination(sce)`: Visualizes contamination levels on a UMAP.
* `plotDecontXMarkerPercentage(sce, markers = list(...))`: Compares marker detection before and after decontamination.
* `plotDecontXMarkerExpression(sce, markers = c(...))`: Violin plots of marker expression.

### Protein Data
* `plotDensity(counts, decont_counts, features)`: Compares ADT density distributions. Background peaks should disappear after decontamination.
* `plotBoxByCluster(counts, decont_counts, clusters, features)`: Visualizes changes per cluster.

## Integration with Seurat

To use `decontX` results in a Seurat workflow:

```r
# From Seurat to decontX
counts <- GetAssayData(seurat_obj, slot = "counts")
sce <- SingleCellExperiment(list(counts = counts))
sce <- decontX(sce)

# Back to Seurat (Note: round decontaminated counts)
seurat_obj[["decontXcounts"]] <- CreateAssayObject(counts = round(decontXcounts(sce)))
```

## Reference documentation

- [Decontamination of single cell protein expression data with DecontPro](./references/decontPro.md)
- [Decontamination of ambient RNA in single-cell genomic data with DecontX](./references/decontX.md)