---
name: bioconductor-mousethymusageing
description: This package provides access to single-cell RNA sequencing datasets of the ageing mouse thymus from the Baran-Gale et al. (2020) study. Use when user asks to retrieve SMART-seq2 or droplet-based transcriptomic profiles of thymic epithelial cells, explore age-related changes in thymus composition, or load pre-processed SingleCellExperiment objects for mouse thymus analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/MouseThymusAgeing.html
---


# bioconductor-mousethymusageing

name: bioconductor-mousethymusageing
description: Access and analyze single-cell RNA sequencing (scRNA-seq) datasets of the ageing mouse thymus. Use this skill when a user needs to retrieve transcriptomic profiles of Thymic Epithelial Cells (TECs) from the Baran-Gale et al. (2020) study, including SMART-seq2 and droplet-based (10X) data.

# bioconductor-mousethymusageing

## Overview
The `MouseThymusAgeing` package provides convenient access to processed scRNA-seq datasets used to study how the epithelial composition of the mouse thymus changes with age. The package contains two major datasets:
1. **SMART-seq2 Data**: Plate-based sequencing of defined TEC populations (mTEClo, mTEChi, cTEC, and Dsg3+ TEC) from mice aged 1, 4, 16, 32, and 52 weeks.
2. **Droplet Data**: 10X Genomics sequencing from a transgenic lineage-tracing model (3xtg-beta5t) at 8, 20, and 36 weeks, utilizing hashtag oligos (HTO) for multiplexing.

All data are provided as `SingleCellExperiment` objects, which include count matrices, cell-level metadata, and pre-computed reduced dimensions (PCA).

## Typical Workflow

### 1. Explore Available Samples
Before downloading data, inspect the metadata objects to identify specific sorting days or samples of interest.
```r
library(MouseThymusAgeing)

# View metadata for SMART-seq2 samples
head(SMARTseqMetadata)

# View metadata for Droplet samples
head(DropletMetadata)
```

### 2. Load Data
Use the dedicated accessor functions. It is recommended to load only the necessary samples to save memory.
```r
# Load SMART-seq2 data for a specific day
smart.sce <- MouseSMARTseqData(samples = "day2")

# Load Droplet data for specific samples
drop.sce <- MouseDropletData(samples = "ZsG_1stRun1")
```

### 3. Data Inspection and Normalization
The objects contain raw counts. You should normalize them before downstream analysis. The package authors recommend using `scuttle`.
```r
library(scuttle)

# Access raw counts
raw_counts <- counts(smart.sce)

# Access size factors (pre-computed via scran)
sf <- sizeFactors(smart.sce)

# Generate log-normalized counts
smart.sce <- logNormCounts(smart.sce)
```

### 4. Accessing Metadata and Results
The `colData` contains experimental variables such as Age, Gender, and ClusterID. Pre-computed PCA results are also available.
```r
# View cell metadata
head(colData(smart.sce))

# Access pre-computed PCA
pca_results <- reducedDim(smart.sce, "PCA")
```

## Tips and Interpretation
- **Cell Types**: The SMART-seq2 data includes specific flow-sorted phenotypes (mTEClo, mTEChi, cTEC, Dsg3+).
- **Lineage Tracing**: The droplet dataset includes ZsGreen (ZsG) status, allowing for the tracking of cells derived from beta-5t expressing progenitors.
- **Batch Effects**: SMART-seq2 data is organized by "SortDay" (1-5) to help account for batch variation.
- **Sparse Matrices**: Counts are stored as sparse matrices (`dgCMatrix`) to minimize memory usage.

## Reference documentation
- [Overview of the MouseThymusAgeing datasets](./references/MouseThymusAgeing.Rmd)
- [Overview of the MouseThymusAgeing datasets](./references/MouseThymusAgeing.md)