---
name: bioconductor-mousegastrulationdata
description: The MouseGastrulationData package provides streamlined access to annotated single-cell and spatial datasets covering mouse development from embryonic days 6.5 to 8.5. Use when user asks to access the mouse embryo atlas, analyze chimera knockout data, retrieve spatial transcriptomics, or load multi-modal gastrulation datasets.
homepage: https://bioconductor.org/packages/release/data/experiment/html/MouseGastrulationData.html
---

# bioconductor-mousegastrulationdata

## Overview

The `MouseGastrulationData` package provides a streamlined interface to high-quality, annotated datasets covering mouse development from embryonic days (E) 6.5 to 8.5. It is a primary resource for studying lineage commitment, spatial patterning, and gene knockouts (via chimeras) during gastrulation. Data is typically returned as `SingleCellExperiment` objects, which integrate count matrices with extensive cell-level metadata (cell types, stages, clusters) and gene-level metadata (Ensembl IDs, symbols).

## Core Workflows

### 1. Accessing the Embryo Atlas (scRNA-seq)
The main atlas contains over 100,000 cells across multiple timepoints. Use `AtlasSampleMetadata` to identify samples of interest before loading.

```r
library(MouseGastrulationData)

# View available samples
head(AtlasSampleMetadata)

# Load specific samples (e.g., E7.5 samples)
# 'samples' refers to the 'sample' column in AtlasSampleMetadata
sce <- EmbryoAtlasData(samples = c(2, 3))

# Access counts and metadata
counts(sce)
colData(sce) # Contains 'celltype', 'stage', 'cluster'
rowData(sce) # Contains 'SYMBOL' and 'ENSEMBL'
```

### 2. Working with Chimera Data
These datasets compare host (wild-type) cells with injected cells (often gene knockouts).

*   **WT Chimeras:** `WTChimeraData()`
*   **Tal1 Knockout:** `Tal1ChimeraData()`
*   **T (Brachyury) Knockout:** `TChimeraData()`

```r
sce_tal1 <- Tal1ChimeraData(samples = 1)

# Identify injected vs host cells
table(sce_tal1$tomato) # TRUE = injected, FALSE = host
```

### 3. Multi-modal and Spatial Data
The package includes specialized datasets for chromatin accessibility and spatial transcriptomics.

*   **snATAC-seq:** `BPSATACData()` returns chromatin accessibility data.
*   **seqFISH (Spatial):** `LohoffSeqFISHData()` returns a `SpatialExperiment` object including cell coordinates and segmentation masks.
*   **10x Multiome:** `RAMultiomeData()` provides simultaneous RNA and ATAC-seq.

```r
# 10x Multiome access
sce_multi <- RAMultiomeData(samples = 1)
# Access ATAC data stored as alternative experiments
altExp(sce_multi, "ATAC_peak_counts")
```

### 4. Visualization and Normalization
The package provides standard colors used in the original publications to ensure consistent visualization.

```r
# Use the provided celltype color palette
plot(reducedDim(sce, "umap"), 
     col = EmbryoCelltypeColours[sce$celltype], 
     pch = 16)
```

To normalize the data, use the `sizeFactors` already present in the `colData` with the `scuttle` package:
```r
library(scuttle)
sce <- logNormCounts(sce) # Uses internal sizeFactors(sce)
```

## Tips and Best Practices
*   **Memory Management:** The full atlas is large. Always use the `samples` argument in `EmbryoAtlasData()` to load only the subsets necessary for your analysis.
*   **Splicing Information:** If performing RNA velocity or similar analyses, set `get.spliced = TRUE` in `EmbryoAtlasData()` to retrieve spliced/unspliced count matrices.
*   **Technical Artifacts:** When plotting or analyzing, filter out doublets and cytoplasm-stripped nuclei using the `doublet` and `stripped` columns in `colData(sce)`.
*   **Gene Annotations:** All data uses Ensembl 92 (mouse genome build mm10).

## Reference documentation
- [Overview of the MouseGastrulationData datasets](./references/MouseGastrulationData.md)