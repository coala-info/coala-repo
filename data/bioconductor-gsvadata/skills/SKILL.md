---
name: bioconductor-gsvadata
description: The GSVAdata package provides curated gene expression datasets, gene set collections, and genomic annotations for demonstrating and testing Gene Set Variation Analysis workflows. Use when user asks to load example expression matrices, access MSigDB gene sets, or perform benchmarking and demonstrations of enrichment methods.
homepage: https://bioconductor.org/packages/release/data/experiment/html/GSVAdata.html
---

# bioconductor-gsvadata

## Overview

The `GSVAdata` package is a companion data package for the `GSVA` (Gene Set Variation Analysis) package. It provides a collection of curated datasets, including gene expression matrices (microarray and RNA-seq), gene set collections (MSigDB, brain cell types), and genomic annotations. These datasets are primarily used for demonstrating GSVA workflows, testing enrichment methods, and performing cross-platform comparisons (e.g., microarray vs. RNA-seq).

## Loading Data

To use the datasets, first load the library and then use the `data()` function.

```r
library(GSVAdata)

# List available datasets in the package
data(package="GSVAdata")
```

## Key Datasets and Workflows

### 1. Gene Set Collections
These are used as the `gset.idx.list` or `genesets` argument in GSVA functions.

*   **c2BroadSets**: A `GeneSetCollection` object containing C2 canonical pathways from MSigDB 3.0.
*   **brainTxDbSets**: A list of gene signatures for four brain cell types (astrocytes, oligodendrocytes, neurons, and astroglial cells).

```r
data(c2BroadSets)
data(brainTxDbSets)

# Inspecting a GeneSetCollection
library(GSEABase)
c2BroadSets
```

### 2. Expression Datasets (ExpressionSet & SummarizedExperiment)
These datasets provide the expression matrices for analysis.

*   **leukemia_eset**: Microarray data (ALL vs MLL) from Armstrong et al. (2002).
*   **gbm_eset**: TCGA Glioblastoma Multiforme microarray data (Verhaak et al., 2010).
*   **geneprotExpCostaEtAl2021**: `SummarizedExperiment` containing RNA-seq and protein expression data.
*   **commonPickrellHuang**: Matching microarray and RNA-seq data for the same 36 samples, useful for benchmarking GSVA across technologies.

```r
# Loading Leukemia data
data(leukemia)
leukemia_eset

# Accessing expression matrix and phenotype data
exp_matrix <- exprs(leukemia_eset)
pheno_data <- pData(leukemia_eset)
```

### 3. Genomic Annotations
*   **annotEntrez220212**: Data frame with gene length and G+C content for Entrez IDs.
*   **genderGenesEntrez**: Vectors of Entrez IDs for genes with sex-specific expression (Y chromosome and X-inactivation escapees).

```r
data(genderGenesEntrez)
# Contains msYgenesEntrez and XiEgenesEntrez
```

## Typical GSVA Workflow with GSVAdata

A common use case is running GSVA on the provided leukemia dataset using the MSigDB pathways.

```r
library(GSVA)
library(GSVAdata)
library(GSEABase)

# Load data
data(leukemia)
data(c2BroadSets)

# Run GSVA (using default 'gsva' method)
# Note: Ensure the feature names in leukemia_eset match the IDs in c2BroadSets (Entrez)
gsva_results <- gsva(leukemia_eset, c2BroadSets, min.sz=10, max.sz=500)

# Visualize results
library(limma)
design <- model.matrix(~ leukemia_eset$subtype)
fit <- lmFit(gsva_results, design)
fit <- eBayes(fit)
topTable(fit)
```

## Tips for Usage
*   **ID Matching**: Most datasets in `GSVAdata` use Entrez Gene identifiers. Ensure your gene sets or expression data are mapped to Entrez IDs before running GSVA.
*   **Object Types**: Be aware that older datasets use `ExpressionSet` (Biobase), while newer ones like `geneprotExpCostaEtAl2021` use `SummarizedExperiment`. Use `assay()` for `SummarizedExperiment` and `exprs()` for `ExpressionSet`.
*   **Cross-Platform Benchmarking**: Use `commonPickrellHuang` to test how enrichment scores vary between RMA-normalized microarray data and CQN-normalized RNA-seq counts.

## Reference documentation
- [GSVAdata Reference Manual](./references/reference_manual.md)