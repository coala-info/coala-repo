---
name: bioconductor-oligodata
description: This package provides sample microarray datasets stored as FeatureSet objects for testing and demonstrating workflows in the oligo package. Use when user asks to access example Affymetrix or NimbleGen data, test microarray preprocessing pipelines, or load sample FeatureSet objects for Bioconductor analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/oligoData.html
---

# bioconductor-oligodata

name: bioconductor-oligodata
description: Provides access to sample datasets for the oligo package, including Affymetrix (Expression, Gene, Exon, SNP) and NimbleGen (Expression, Tiling) data. Use this skill when you need example FeatureSet objects to demonstrate or test microarray analysis workflows in Bioconductor.

# bioconductor-oligodata

## Overview

The `oligoData` package is a data-only repository providing sample datasets for the `oligo` package. These datasets are stored as `FeatureSet` extensions (e.g., `ExpressionFeatureSet`, `ExonFeatureSet`, `SnpFeatureSet`). They are essential for testing preprocessing, normalization, and analysis pipelines without requiring large external CEL files.

## Usage

To use these datasets, you must load the `oligoData` library and use the `data()` function to load specific objects into your R environment.

### Available Datasets

| Object Name | Class | Array Type |
| :--- | :--- | :--- |
| `affyExpressionFS` | ExpressionFeatureSet | Affymetrix Expression |
| `affyExonFS` | ExonFeatureSet | Affymetrix Exon |
| `affyGeneFS` | GeneFeatureSet | Affymetrix Gene |
| `affySnpFS` | SnpFeatureSet | Affymetrix SNP |
| `nimbleExpressionFS` | ExpressionFeatureSet | NimbleGen Expression |
| `nimbleTilingFS` | TilingFeatureSet | NimbleGen Tiling |

### Loading Data

```r
library(oligoData)

# Load a specific dataset
data(affyExpressionFS)

# Inspect the object
show(affyExpressionFS)
abstract(affyExpressionFS)
```

### Typical Workflow

These datasets are designed to be passed directly into `oligo` functions for preprocessing:

```r
library(oligo)
library(oligoData)

# Load Affymetrix Expression data
data(affyExpressionFS)

# Background correction, normalization, and summarization (RMA)
eset <- rma(affyExpressionFS)

# For Exon/Gene arrays
data(affyExonFS)
eset_exon <- rma(affyExonFS, target = "core")
```

## Tips

- **Annotation Requirements**: These datasets require the respective annotation packages (e.g., `pd.hg18.6.0.tap`) to be installed on the system to be fully functional for certain `oligo` operations.
- **Object Classes**: Use `class(objName)` to verify the type of FeatureSet you are working with, as different classes support different downstream methods (e.g., `SnpFeatureSet` for genotyping).

## Reference documentation

- [oligoData Reference Manual](./references/reference_manual.md)