---
name: r-archr
description: "ArchR is a high-performance R package for the comprehensive analysis of single-cell ATAC-seq data. Use when user asks to create Arrow files, perform doublet inference, conduct dimensionality reduction using Iterative LSI, or visualize single-cell chromatin accessibility data."
homepage: https://cran.r-project.org/web/packages/archr/index.html
---


# r-archr

## Overview
ArchR (Analysis of Regulatory Chromatin in R) is a high-performance R package designed for analyzing single-cell ATAC-seq data. It is optimized for speed and memory efficiency, capable of processing millions of cells. ArchR uses a custom "Arrow file" format (based on HDF5) to store data on disk, allowing for fast access without loading entire datasets into RAM.

## Installation
ArchR is primarily hosted on GitHub and requires several Bioconductor dependencies. It is designed for Unix-based systems (macOS and Linux) and is not supported on Windows.

```R
# Install devtools and BiocManager if needed
if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")

# Install ArchR
devtools::install_github("GreenleafLab/ArchR", ref="master", repos = BiocManager::repositories())

# Install extra dependencies (highly recommended)
library(ArchR)
ArchR::installExtraPackages()
```

## Core Workflow

### 1. Initialization and Data Input
Always start by setting threads and the reference genome.
```R
library(ArchR)
addArchRThreads(threads = 16)
addArchRGenome("hg19") # Supports hg19, hg38, mm9, mm10

# Input: paths to fragment files (.tsv.gz)
inputFiles <- c("Sample1" = "path/to/sample1.fragments.tsv.gz")
```

### 2. Creating Arrow Files
This step performs QC, calculates TSS enrichment, and creates tile/gene score matrices.
```R
ArrowFiles <- createArrowFiles(
  inputFiles = inputFiles,
  sampleNames = names(inputFiles),
  filterTSS = 4, 
  filterFrags = 1000,
  addTileMat = TRUE,
  addGeneScoreMat = TRUE
)
```

### 3. Doublet Inference and Project Creation
Identify potential doublets before creating the `ArchRProject`.
```R
doubScores <- addDoubletScores(input = ArrowFiles)

proj <- ArchRProject(
  ArrowFiles = ArrowFiles, 
  outputDirectory = "MyProject",
  copyArrows = TRUE
)

# Filter the doublets identified previously
proj <- filterDoublets(ArchRProj = proj)
```

### 4. Dimensionality Reduction and Clustering
ArchR uses Iterative Latent Semantic Indexing (LSI).
```R
# Dimensionality Reduction
proj <- addIterativeLSI(ArchRProj = proj, useMatrix = "TileMatrix", name = "IterativeLSI")

# Clustering (Seurat-based Louvain)
proj <- addClusters(input = proj, reducedDims = "IterativeLSI")

# UMAP Visualization
proj <- addUMAP(ArchRProj = proj, reducedDims = "IterativeLSI")
```

### 5. Visualization and Gene Scores
Visualize clusters and marker genes. Use MAGIC imputation to smooth gene scores for visualization.
```R
# Plot UMAP colored by Clusters
p1 <- plotEmbedding(ArchRProj = proj, colorBy = "cellColData", name = "Clusters")

# Add Imputation Weights
proj <- addImputeWeights(proj)

# Plot Marker Genes
p2 <- plotEmbedding(
    ArchRProj = proj, 
    colorBy = "GeneScoreMatrix", 
    name = c("CD34", "CD14"), 
    imputeWeights = getImputeWeights(proj)
)

# Save plots to PDF
plotPDF(p1, p2, name = "UMAP_Plots.pdf", ArchRProj = proj)
```

### 6. Genome Browser Tracks
Generate per-cluster accessibility tracks for specific loci.
```R
p <- plotBrowserTrack(
    ArchRProj = proj, 
    groupBy = "Clusters", 
    geneSymbol = c("CD34"),
    upstream = 50000,
    downstream = 50000
)
# Display track
grid::grid.draw(p$CD34)
```

## Key Functions Reference
- `createArrowFiles()`: Initial processing of fragment files.
- `addDoubletScores()`: Calculates likelihood of a droplet containing multiple cells.
- `ArchRProject()`: Creates the central object for analysis.
- `addIterativeLSI()`: Primary dimensionality reduction method.
- `addClusters()`: Groups cells based on reduced dimensions.
- `addUMAP()`: Generates 2D embedding for visualization.
- `plotEmbedding()`: Creates ggplot2 objects of UMAP/t-SNE.
- `plotBrowserTrack()`: Generates signal tracks for genomic regions.
- `saveArchRProject()` / `loadArchRProject()`: Persistent storage of analysis state.

## Reference documentation
- [ArchR Home Page](./references/home_page.md)
- [ArchR Brief Tutorial](./references/tutorial.html.md)