---
name: bioconductor-mitoodedata
description: This package provides cell count time-series data and metadata from the Mitocheck genome-wide RNAi screen for dynamical modeling of cell populations. Use when user asks to access Mitocheck screen results, map siRNA identifiers to genes, or retrieve time-course cell count data for morphological classes.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/mitoODEdata.html
---


# bioconductor-mitoodedata

## Overview
The `mitoODEdata` package is a data-only package providing results from the Mitocheck screen, a large-scale time-lapse imaging assay. It contains cell count time series for 16 morphological classes (aggregated into 4 main types) across thousands of siRNA treatments. This package is typically used in conjunction with the `mitoODE` package for dynamical modeling of cell populations.

## Data Structures
Loading the library automatically populates two objects in the global environment:
- `tab`: A data frame of spot metadata (plate, replicate, spot ID, quality control, siRNA ID).
- `anno`: A data frame mapping siRNAs to genes (Ensembl, HGNC symbol, Entrez, and Gene Name).

```r
library(mitoODEdata)
head(tab)
head(anno)
```

## Key Functions and Workflows

### 1. Mapping Identifiers
Use these functions to convert between biological entities and experimental IDs:
- `getsirna(ann="GENE_SYMBOL")`: Returns siRNA IDs for a given gene.
- `getspot(ann="GENE_SYMBOL")`: Returns all spot IDs associated with a gene.
- `getanno(spot=ID, field=c("hgnc", "entrez"))`: Retrieves gene metadata for a specific spot.

### 2. Accessing Time-Course Data
The primary data consists of cell counts across four categories:
- **i**: Interphase
- **m**: Mitotic
- **s**: Polynucleated
- **a**: Apoptotic (Dead)

```r
# Get spot ID for a gene of interest
spotid <- getspot(ann="FGFR2")[1]

# Read the count matrix (rows = frames, cols = cell types)
# Frames start 18h post-transfection, captured every 30 mins for 48h
y <- readspot(spotid)

# Visualize the population dynamics
plotspot(spotid)
```

## Data Interpretation
- **Temporal Resolution**: The first row of the matrix returned by `readspot` represents 18 hours post-seeding. Subsequent rows are at 30-minute intervals.
- **Cell Types**: The "interphase" category in this package is an aggregate of several Mitocheck classes (Large, Elongated, Folded, etc.). The "mitotic" category includes Metaphase, Anaphase, and Prometaphase.

## Reference documentation
- [mitoODEdata: Dynamical modelling of phenotypes in a genome-wide RNAi live-cell imaging assay](./references/mitoODEdata-introduction.md)