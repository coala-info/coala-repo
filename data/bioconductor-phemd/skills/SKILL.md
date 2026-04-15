---
name: bioconductor-phemd
description: PhEMD compares multiple single-cell samples by mapping them to a common phenotypic landscape and calculating Earth Mover’s Distance between their cell-state distributions. Use when user asks to compare single-cell datasets across different patients or conditions, define a common cell-state manifold using Monocle 2, or calculate inter-sample distances based on cell subtype abundance and similarity.
homepage: https://bioconductor.org/packages/3.9/bioc/html/phemd.html
---

# bioconductor-phemd

## Overview

PhEMD is a specialized R package designed to compare multiple single-cell samples (e.g., from different patients or experimental conditions). It addresses the challenge of sample heterogeneity by first defining a common cell-state landscape (manifold) across all samples and then measuring the "distance" between samples based on how their cells are distributed across that landscape. It integrates Monocle 2 for dimensionality reduction and uses the Earth Mover’s Distance (EMD) metric to account for both the abundance of cell types and the biological similarity between those types.

## Core Workflow

### 1. Data Initialization
PhEMD expects data as a list of matrices, where each matrix represents a sample (cells x markers).

```R
library(phemd)
library(monocle)

# Create PhEMD object
# all_expn_data: list of matrices; all_genes: vector of marker names; snames: sample names
myobj <- createDataObj(all_expn_data, all_genes, as.character(snames))

# Optional: Filter small samples
myobj <- removeTinySamples(myobj, min_sz = 20)

# Aggregate cells for manifold construction
myobj <- aggregateSamples(myobj, max_cells = 12000)
```

### 2. Cell State Embedding (Monocle 2)
Define the phenotypic landscape by embedding the aggregated cells.

```R
# Feature selection
myobj <- selectFeatures(myobj, selected_genes)

# Generate embedding
# data_model: 'gaussianff' for log-transformed/normalized data, 'negbinomial_sz' for raw counts
myobj <- embedCells(myobj, data_model = 'gaussianff', sigma = 0.02)

# Order cells in pseudotime
myobj <- orderCellsMonocle(myobj)

# Visualization
plotEmbeddings(myobj, cell_model = 'monocle2')
plotHeatmaps(myobj, cell_model = 'monocle2', selected_genes = heatmap_genes)
```

### 3. Sample Deconvolution and Comparison
Quantify the abundance of cell subtypes in each sample and compute inter-sample distances.

```R
# Deconvolute: Determine cell subtype frequency per sample
myobj <- clusterIndividualSamples(myobj)

# Generate Ground Distance Matrix (GDM): Dissimilarity between cell subtypes
myobj <- generateGDM(myobj)

# Compare Samples: Compute EMD distance matrix
my_distmat <- compareSamples(myobj)
```

### 4. Downstream Analysis and Visualization
Group similar samples and visualize the sample-level relationships.

```R
# Cluster samples based on EMD distance
group_assignments <- groupSamples(my_distmat, distfun = 'hclust', ncluster = 5)

# Visualize sample relationships via Diffusion Map
plotGroupedSamplesDmap(my_distmat, group_assignments)

# Plot representative histograms of cell subtype distributions for groups
plotSummaryHistograms(myobj, group_assignments, cell_model = 'monocle2')

# Check cell yield per sample
plotCellYield(myobj, group_assignments)
```

## Usage Tips
- **Sigma Parameter**: In `embedCells`, the `sigma` parameter controls cluster granularity. Values between 0.01 and 0.1 are typically effective for normalized data.
- **Data Models**: Use `gaussianff` for log-transformed TPM/FPKM or arcsin-transformed CyTOF data. Use `negbinomial_sz` for raw UMI counts.
- **EMD Logic**: The distance between samples is small if they have similar proportions of similar cell types. It is large if they have high proportions of biologically distinct cell types.

## Reference documentation
- [Tutorial on using PhEMD to analyze multi-sample single-cell experiments](./references/phemd.md)