---
name: bioconductor-screpertoire
description: scRepertoire processes and analyzes single-cell immune receptor sequencing data by bridging raw contig outputs with downstream transcriptomic frameworks. Use when user asks to load immune receptor contigs, assign clonotypes, calculate diversity metrics, or integrate TCR/BCR data with Seurat or SingleCellExperiment objects.
homepage: https://bioconductor.org/packages/release/bioc/html/scRepertoire.html
---


# bioconductor-screpertoire

## Overview
`scRepertoire` is an R package designed to process and analyze single-cell immune receptor sequencing data. It bridges the gap between raw contig outputs (like those from 10x Genomics Cell Ranger) and downstream analytical frameworks like `Seurat` or `SingleCellExperiment`. It supports clonotype assignment, diversity metrics, clonal overlap, and visualization of clonal expansion within the context of transcriptomic clusters.

## Core Workflow

### 1. Loading Data
The package primarily uses `filtered_contig_annotations.csv` from 10x Genomics, but supports other formats (TRUST4, BD, MiXCR, etc.) via `loadContigs()`.

```r
library(scRepertoire)

# Load 10x data manually
S1 <- read.csv("Sample1/outs/filtered_contig_annotations.csv")
S2 <- read.csv("Sample2/outs/filtered_contig_annotations.csv")
contig_list <- list(S1, S2)

# Or use loadContigs for various formats
contig_list <- loadContigs(input = "path/to/contigs/", format = "10X")
```

### 2. Combining Contigs into Clones
Use `combineTCR()` for T cells or `combineBCR()` for B cells. These functions consolidate contigs to the cell barcode level.

```r
# TCR Processing
combined.TCR <- combineTCR(contig_list, 
                           samples = c("S1", "S2"),
                           removeNA = FALSE, 
                           removeMulti = FALSE)

# BCR Processing (includes similarity clustering for SHM)
combined.BCR <- combineBCR(BCR_contig_list, 
                           samples = "Patient1", 
                           threshold = 0.85)
```

### 3. Basic Clonal Analysis
`scRepertoire` provides several functions to visualize the repertoire before integration with mRNA data.

*   **Quantification**: `clonalQuant(combined.TCR, cloneCall="strict", scale=TRUE)`
*   **Abundance**: `clonalAbundance(combined.TCR, cloneCall="gene")`
*   **Length**: `clonalLength(combined.TCR, cloneCall="aa", chain="both")`
*   **Compare**: `clonalCompare(combined.TCR, top.clones=10, samples=c("S1", "S2"), cloneCall="aa")`

### 4. Integration with Single-Cell Objects
The `combineExpression()` function attaches clonal metadata to a Seurat or SingleCellExperiment object.

```r
# Attach to Seurat object
seurat_obj <- combineExpression(combined.TCR, 
                                 seurat_obj, 
                                 cloneCall="gene", 
                                 group.by = "sample", 
                                 proportion = TRUE)

# Visualize on UMAP
Seurat::DimPlot(seurat_obj, group.by = "cloneSize")
```

### 5. Advanced Visualizations
Once integrated, use specialized functions to explore clonal dynamics:
*   **Clonal Overlay**: `clonalOverlay(seurat_obj, reduction="umap", cutpoint=1)`
*   **Clonal Network**: `clonalNetwork(seurat_obj, reduction="umap", group.by="ident")`
*   **Clonal Occupancy**: `clonalOccupy(seurat_obj, x.axis="seurat_clusters")`
*   **Alluvial Plots**: `alluvialClones(seurat_obj, cloneCall="aa", y.axes=c("Patient", "ident"))`

## Key Parameters & Definitions
*   **cloneCall**: 
    * `gene`: VDJC genes.
    * `nt`: CDR3 nucleotide sequence.
    * `aa`: CDR3 amino acid sequence.
    * `strict`: VDJC genes + CDR3 nucleotide sequence.
*   **cloneSize**: Default bins are Rare (0-0.0001), Small (0.0001-0.001), Medium (0.001-0.01), Large (0.01-0.1), and Hyperexpanded (0.1-1).
*   **chain**: Specify `TRA`, `TRB`, `IGH`, `IGL`, or `both`.

## Tips for Success
1.  **Barcode Matching**: Ensure barcodes in your contig files match the barcodes in your Seurat/SCE object. If your Seurat object has prefixes (e.g., `S1_AAAC...`), use the `samples` argument in `combineTCR/BCR` to match.
2.  **VDJ Gene Bias**: VDJ genes are highly variable. Use `quietTCRgenes()` or `quietBCRgenes()` to remove them from variable features before clustering to prevent clonal expansion from driving the clustering.
3.  **Downsampling**: For diversity metrics (`clonalDiversity`), the package uses bootstrapping to account for differences in library size.

## Reference documentation
- [Starting work with scRepertoire.](./references/vignette.md)
- [Using scRepertoire (Rmd Source)](./references/vignette.Rmd)