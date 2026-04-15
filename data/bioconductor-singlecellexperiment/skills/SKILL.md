---
name: bioconductor-singlecellexperiment
description: This package provides a standardized S4 container for storing, manipulating, and analyzing multi-modal single-cell genomics data within the Bioconductor ecosystem. Use when user asks to create SingleCellExperiment objects, manage dimensionality reduction results, handle alternative experiments like spike-ins or ADTs, or store cell and row pairings.
homepage: https://bioconductor.org/packages/release/bioc/html/SingleCellExperiment.html
---

# bioconductor-singlecellexperiment

name: bioconductor-singlecellexperiment
description: Comprehensive guide for using the SingleCellExperiment Bioconductor package. Use when creating, manipulating, or analyzing single-cell genomics data containers. This skill covers SCE object construction, dimensionality reduction storage (PCA/t-SNE), alternative experiments (e.g., spike-ins, ADTs), cell/row pairings, and applying functions across multi-modal data.

# bioconductor-singlecellexperiment

## Overview
The `SingleCellExperiment` (SCE) class is the standard S4 container for single-cell genomics data in the Bioconductor ecosystem. It extends `RangedSummarizedExperiment` to provide specialized slots for single-cell workflows, including low-dimensional embeddings, alternative feature sets (like spike-ins or antibody tags), and cell-cell/gene-gene relational graphs.

## Core Workflows

### 1. Object Construction
Create an SCE object from a count matrix or by coercing a `SummarizedExperiment`.
```r
library(SingleCellExperiment)

# From a matrix
counts <- matrix(rpois(100, lambda = 10), ncol=10, nrow=10)
sce <- SingleCellExperiment(list(counts=counts),
    colData=DataFrame(Batch=rep(c("A", "B"), each=5)),
    rowData=DataFrame(ID=paste0("Gene", 1:10)))

# Coercion
se <- SummarizedExperiment(list(counts=counts))
sce <- as(se, "SingleCellExperiment")
```

### 2. Managing Assays
SCE supports standardized naming for common data types.
- `counts(sce)`: Raw count data.
- `logcounts(sce)`: Log-transformed normalized data.
- `normcounts(sce)`: Normalized values on the original scale.
- `tpm(sce)` / `cpm(sce)`: Transcripts or counts per million.

### 3. Dimensionality Reduction
Store and retrieve results from PCA, t-SNE, or UMAP. Results are automatically subsetted when the SCE object is filtered by column.
```r
# Adding results
reducedDim(sce, "PCA") <- pca_matrix 
reducedDims(sce) <- list(PCA=pca_mat, TSNE=tsne_mat)

# Retrieval
head(reducedDim(sce, "PCA"))
reducedDimNames(sce)
```

### 4. Alternative Experiments
Use `altExps` to store data for different feature types (e.g., ERCC spike-ins, CITE-seq ADTs) that share the same cells but have different rows.
```r
# Adding an alternative experiment
altExp(sce, "ERCC") <- SingleCellExperiment(list(counts=ercc_counts))

# Splitting existing data into an altExp
sce <- splitAltExps(sce, feature_types)

# Swapping an altExp to the main experiment
sce <- swapAltExp(sce, "ERCC", saved="original_genes")
```

### 5. Cell and Row Pairings
Store relational data such as nearest-neighbor graphs or gene co-expression networks.
```r
# Store cell-cell distances/relationships
colPair(sce, "knn") <- SelfHits(from=idx1, to=idx2, nnode=ncol(sce))

# Retrieve as sparse matrix
adj <- colPair(sce, "knn", asSparse=TRUE)
```

### 6. Specialized Metadata
- `sizeFactors(sce)`: Get or set scaling factors for normalization.
- `colLabels(sce)`: Store primary cell cluster assignments or annotations.
- `rowSubset(sce, "name")`: Store logical/integer vectors identifying specific gene sets.

## Applying Functions Across Modalities
The `applySCE` framework allows you to run a function on the main experiment and all alternative experiments simultaneously.
```r
# Apply a function to all experiments
# If FUN returns an SCE, applySCE attempts to return a simplified SCE
truncated_sce <- applySCE(sce, FUN=head, n=5)

# Custom arguments per modality
results <- applySCE(sce, FUN=my_func, 
    ALT.ARGS=list(ERCC=list(multiplier=10)))
```

## Developer Guidelines
When developing packages that extend SCE:
- **Internal Fields**: Use `int_colData()`, `int_elementMetadata()`, and `int_metadata()` to store package-specific hidden data.
- **Namespace Protection**: Use "Inception-style" nesting to avoid clobbering other packages.
  ```r
  # Recommended pattern
  int_colData(sce)$MyPackageName <- DataFrame(internal_var = values)
  ```

## Reference documentation
- [An introduction to the SingleCellExperiment class](./references/intro.md)
- [Applying a function over a SingleCellExperiment’s contents](./references/apply.md)
- [Developing around the SingleCellExperiment class](./references/devel.md)