---
name: bioconductor-catscradle
description: CatsCradle performs gene-centric clustering and spatial transcriptomics analysis by transposing expression matrices and evaluating spatial cell relationships. Use when user asks to transpose Seurat objects for gene-based UMAPs, calculate the statistical significance of gene set clustering, analyze spatial neighborhoods via Delaunay triangulation, or perform ligand-receptor interaction mapping.
homepage: https://bioconductor.org/packages/release/bioc/html/CatsCradle.html
---

# bioconductor-catscradle

name: bioconductor-catscradle
description: Analysis of gene clustering and spatial transcriptomics in single-cell RNA-seq data. Use this skill to transpose Seurat objects for gene-centric analysis, calculate statistical significance of gene set clustering (curdling), analyze spatial neighborhoods, and perform ligand-receptor interaction analysis on spatial data.

# bioconductor-catscradle

## Overview
CatsCradle is an R package designed to analyze the clustering of genes in single-cell RNA-seq data and provide tools for spatial transcriptomics. Its core innovation is the transposition of the standard gene-by-cell expression matrix into a cell-by-gene matrix, allowing genes to be treated as "samples" that can be clustered and visualized (e.g., via UMAP) based on their expression patterns across cells. It also provides extensive tools for spatial neighborhood analysis, including Delaunay triangulation and ligand-receptor interaction mapping.

## Core Workflows

### 1. Gene-Centric Analysis (Transposition)
To analyze genes as clusters rather than cells, transpose a standard Seurat object.

```r
library(CatsCradle)
library(Seurat)

# Create the transposed gene-centric Seurat object
# This runs FindVariableFeatures, ScaleData, RunPCA, RunUMAP, and FindClusters on genes
STranspose = transposeObject(exSeuratObj)

# Visualize gene clusters
DimPlot(STranspose, reduction = "umap", label = TRUE)
```

### 2. Statistical Significance of Gene Clustering
Determine if a specific gene set (e.g., Hallmark pathways) is significantly "curdled" (clustered together) on the gene UMAP.

```r
# Get clustering statistics for a subset of genes
# Uses median complement distance compared to random permutations
stats = getObjectSubsetClusteringStatistics(STranspose, 
                                            subsetGenes = gene_list, 
                                            numTrials = 1000)

# Access p-value and z-score
stats$pValue
stats$zScore
```

### 3. Spatial Neighborhood Analysis
Analyze the spatial relationships between cells using Delaunay triangulation or Euclidean distance.

```r
# Get Delaunay neighbors from a spatial Seurat object
delaunayNB = getNearbyCells(spatialObj, metric = "delaunay")

# Compute cell-type composition of neighborhoods
NBHDByCTMatrix = computeNBHDVsCTMatrix(spatialObj, delaunayNB)

# Cluster neighborhoods based on cell-type composition
NBHDSeurat = computeNBHDVsCTObject(spatialObj, delaunayNB)
```

### 4. Aggregate Gene Expression in Neighborhoods
Treat neighborhoods as "meta-cells" by aggregating gene expression of a cell and its neighbors.

```r
# Create a Seurat object where columns are neighborhoods
aggSeurat = aggregateGeneExpression(spatialObj, 
                                    neighborhoods = delaunayNB)
```

### 5. Ligand-Receptor Analysis
Identify interactions between neighboring cells in spatial data.

```r
# Perform analysis using Nichenetr-based pairs
lrResults = performLigandReceptorAnalysis(spatialObj, 
                                          edges = delaunayNB)

# Check enrichment p-values for specific cell-type interactions
lrResults$pValue
```

## Tips and Best Practices
- **Example Data**: Use `getExample = make.getExample()` and `getExample('STranspose')` to load pre-computed objects for testing.
- **Interactive Visualization**: For gene UMAPs, use `plotly` to identify individual genes by hovering over points.
- **Bioconductor Compatibility**: Most functions support `SingleCellExperiment` and `SpatialExperiment` objects via the `returnType` parameter.
- **Z-Scores**: Use `meanZPerClusterOnUMAP()` to visualize which cell clusters drive the location of genes on the gene UMAP.

## Reference documentation
- [CatsCradle](./references/CatsCradle.md)
- [CatsCradle Example Data](./references/CatsCradleExampleData.md)
- [CatsCradle Quick Start](./references/CatsCradleQuickStart.md)
- [CatsCradle SingleCellExperiment Quick Start](./references/CatsCradleSingleCellExperimentQuickStart.md)
- [CatsCradle Spatial](./references/CatsCradleSpatial.md)