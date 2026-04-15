---
name: bioconductor-tcgacrcmrna
description: This Bioconductor package provides mRNA gene expression profiles and metadata for 450 primary colorectal cancer samples from the TCGA consortium. Use when user asks to load TCGA colorectal cancer transcriptomic data, access mRNA expression matrices, or retrieve clinical metadata for colorectal cancer samples.
homepage: https://bioconductor.org/packages/release/data/experiment/html/TCGAcrcmRNA.html
---

# bioconductor-tcgacrcmrna

name: bioconductor-tcgacrcmrna
description: Access and utilize the TCGAcrcmRNA Bioconductor data package containing mRNA gene expression profiles for 450 primary colorectal cancer samples. Use this skill when you need to load, analyze, or explore TCGA colorectal cancer (CRC) transcriptomic data, including associated phenotypic and probe information.

# bioconductor-tcgacrcmrna

## Overview
The `TCGAcrcmRNA` package is a Bioconductor data experiment package providing a curated `ExpressionSet` of 450 colorectal cancer samples. The data originates from the TCGA consortium (Level 3 data) and was generated using Illumina HiSeq and GenomeAnalyzer platforms. It includes gene expression profiles along with comprehensive metadata (phenoData) and feature information.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("TCGAcrcmRNA")
```

## Basic Usage

### Loading the Data
The primary dataset is stored as an `ExpressionSet` object named `TCGAmrna`.

```r
library(TCGAcrcmRNA)

# Load the dataset into the workspace
data(TCGAmrna)

# View the object summary
TCGAmrna
```

### Accessing Components
Since the data is stored as an `ExpressionSet`, use standard Biobase methods to access specific parts:

- **Expression Matrix**: `exprs(TCGAmrna)` returns the mRNA expression values.
- **Phenotypic Data**: `pData(TCGAmrna)` returns sample metadata (e.g., clinical information).
- **Feature Data**: `fData(TCGAmrna)` returns probe or gene-level information.

### Example Workflow
A typical starting point for analysis involves inspecting the sample metadata and subsetting the expression data.

```r
# Check available clinical variables
colnames(pData(TCGAmrna))

# Access expression for the first 5 genes across all samples
exprs(TCGAmrna)[1:5, ]

# Summary of a specific clinical trait (if available in pData)
table(TCGAmrna$vital_status)
```

## Tips
- The dataset represents a combination of colon and rectal cancer samples as described in the 2012 Nature publication by the TCGA Network.
- Ensure the `Biobase` package is loaded to utilize all methods for interacting with the `ExpressionSet` object.
- This package is primarily a data container; downstream analysis (differential expression, clustering) should be performed using packages like `limma`, `DESeq2`, or `cluster`.

## Reference documentation
- [TCGA CRC 450 dataset](./references/TcgaCrcVignette.md)