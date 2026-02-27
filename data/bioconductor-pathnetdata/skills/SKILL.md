---
name: bioconductor-pathnetdata
description: This package provides experimental data and KEGG pathway connectivity matrices for use with the PathNet pathway analysis tool. Use when user asks to access Alzheimer's disease microarray datasets, load KEGG adjacency matrices, or retrieve benchmark data for topological pathway analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/PathNetData.html
---


# bioconductor-pathnetdata

name: bioconductor-pathnetdata
description: Access and use experimental data for the PathNet package, including Alzheimer's disease microarray datasets (brain regions and disease progression), KEGG pathway connectivity (adjacency matrices), and pooled pathway information. Use this skill when performing pathway analysis with the PathNet package or when requiring benchmark datasets for topological pathway analysis.

## Overview

The `PathNetData` package is a data-only experiment package providing the necessary resources to run the vignettes and examples in the `PathNet` package. It contains gene expression associations (direct evidence) for Alzheimer's disease across different brain regions and stages of severity, as well as topological information derived from the Kyoto Encyclopedia of Genes and Genomes (KEGG).

## Data Loading and Usage

All datasets in this package are loaded using the standard R `data()` function.

### 1. Adjacency Matrix (A)
The adjacency matrix `A` represents connectivity among genes in a pooled pathway of 130 non-metabolic KEGG pathways. It is a non-symmetric square matrix where rows and columns represent genes.

```r
library(PathNetData)
data(A)
# View a subset of the adjacency matrix
A[1:10, 1:10]
```

### 2. Brain Regions Dataset (brain_regions)
This dataset contains the association of genes with Alzheimer's disease in six brain regions (EC, HIP, MTG, PC, SFG, and VCX). Values are negative log10 transformed p-values from t-tests.

```r
data(brain_regions)
head(brain_regions)
```

### 3. Disease Progression Dataset (disease_progression)
This dataset tracks gene expression associations across different stages of Alzheimer's severity (incipient, moderate, and severe).

```r
data(disease_progression)
head(disease_progression)
```

### 4. Pathway Information (pathway)
This dataset provides the raw edge-list information for the pooled KEGG pathways.

```r
data(pathway)
# Columns: Index, Gene ID 1, Gene ID 2, Pathway Name
head(pathway)
```

## Typical Workflow with PathNet

`PathNetData` is designed to be used as input for the `PathNet` function. A common workflow involves:

1.  **Loading the Adjacency Matrix**: Use `data(A)` to provide the topological structure.
2.  **Loading Direct Evidence**: Use `data(brain_regions)` or `data(disease_progression)` to provide the differential expression significance.
3.  **Running PathNet**: Pass these objects to the `PathNet` function to identify significantly enriched pathways considering both expression and topology.

## Accessing Raw Text Files
If you need the raw data files instead of the R data objects, they are located in the `extdata` directory of the package:

```r
# Locate the path to the adjacency data text file
adj_file <- system.file("extdata", "adjacency_data.txt", package = "PathNetData")
# Read the file
adj_data <- read.table(adj_file, header = FALSE)
```

## Reference documentation

- [PathNetData Reference Manual](./references/reference_manual.md)