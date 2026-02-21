---
name: bioconductor-hsmmsinglecell
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/HSMMSingleCell.html
---

# bioconductor-hsmmsinglecell

name: bioconductor-hsmmsinglecell
description: A specialized skill for accessing and using the HSMMSingleCell Bioconductor experiment data package. Use this skill when you need to load, explore, or analyze single-cell RNA-Seq data from differentiating human skeletal muscle myoblasts (HSMM). This is particularly useful for workflows involving the Monocle R package, as the data is provided as a CellDataSet object.

## Overview

The `HSMMSingleCell` package provides a high-quality single-cell RNA-Seq dataset tracking the differentiation of primary human skeletal muscle myoblasts (HSMM). The data captures cells at four time points (0, 24, 48, and 72 hours) after switching from high-mitogen growth medium (GM) to low-mitogen differentiation medium (DM). 

The dataset is stored as a `CellDataSet` object, which is the native format for the `monocle` package. It contains expression values in FPKM (Fragments Per Kilobase of transcript per Million mapped reads) calculated via Cufflinks.

## Typical Workflow

### 1. Loading the Data
To use the dataset, you must load the library and then call the `HSMM` data object.

```r
# Install if necessary
# BiocManager::install("HSMMSingleCell")

# Load the package
library(HSMMSingleCell)

# Load the dataset
data(HSMM)

# Inspect the object
HSMM
```

### 2. Exploring the CellDataSet
Since the data is a `CellDataSet` (which extends the `ExpressionSet` class), you can use standard accessor functions:

- `exprs(HSMM)`: Access the FPKM expression matrix.
- `pData(HSMM)`: Access cell-level metadata (e.g., Hours, Media, Cell ID).
- `fData(HSMM)`: Access feature-level (gene) metadata.

### 3. Integration with Monocle
This package is designed to be the primary example dataset for the `monocle` R package for trajectory analysis (pseudotime).

```r
library(monocle)

# Example: Plotting the distribution of mRNA totals
HSMM <- estimateSizeFactors(HSMM)
HSMM <- estimateDispersions(HSMM)

# Filter genes or cells based on Monocle workflows
# (e.g., detecting genes expressed in at least 5% of cells)
HSMM <- detectGenes(HSMM, min_expr = 0.1)
```

## Data Characteristics
- **Cell Count:** Several hundred cells (approx. 49-77 per time point).
- **Time Points:** 0, 24, 48, and 72 hours.
- **Units:** FPKM.
- **Platform:** Fluidigm C1 microfluidic system.

## Tips
- **Object Class:** Ensure you have the `monocle` package installed to fully interact with the `HSMM` object, as it defines the `CellDataSet` class.
- **Filtering:** The dataset has already been pre-filtered for quality (libraries with >1M reads and >80% mapping to non-mitochondrial protein-coding genes).
- **Normalization:** While FPKM values are provided, Monocle workflows often perform additional normalization or transformation (like log-transformation) depending on the specific analysis step.

## Reference documentation
- [HSMMSingleCell Reference Manual](./references/reference_manual.md)