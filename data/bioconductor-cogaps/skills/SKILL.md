---
name: bioconductor-cogaps
description: CoGAPS is a Bayesian Nonnegative Matrix Factorization algorithm that decomposes gene expression data into amplitude and pattern matrices to identify latent biological processes. Use when user asks to perform matrix factorization on gene expression data, identify marker genes for specific patterns, or discover latent biological features like cell types and pathways.
homepage: https://bioconductor.org/packages/release/bioc/html/CoGAPS.html
---


# bioconductor-cogaps

## Overview
CoGAPS (Coordinated Gene Association in Pattern Sets) is a Bayesian Nonnegative Matrix Factorization (NMF) algorithm designed for gene expression analysis. It decomposes a data matrix into two related matrices: the Amplitude (A) matrix (gene weights/loadings) and the Pattern (P) matrix (sample weights/factors). This additive decomposition allows for the discovery of biologically intuitive latent spaces representing processes like cell types, pathways, or experimental perturbations.

## Core Workflow

### 1. Parameter Configuration
CoGAPS uses a `CogapsParams` object to manage execution settings.

```r
library(CoGAPS)

# Initialize parameters
params <- new("CogapsParams", nPatterns=5)

# View and modify parameters
params
params <- setParam(params, "nIterations", 50000)
params <- setParam(params, "seed", 42)
params <- setParam(params, "sparseOptimization", TRUE) # Recommended for single-cell
```

### 2. Running CoGAPS
The `CoGAPS()` function accepts matrices, DataFrames, `SummarizedExperiment`, or `SingleCellExperiment` objects.

```r
# Standard run
result <- CoGAPS(data_matrix, params)

# Distributed run (for large datasets)
# Options: "genome-wide" (parallelize genes) or "single-cell" (parallelize samples)
params <- setParam(params, "distributed", "genome-wide")
params <- setDistributedParams(params, nSets=7)
result <- CoGAPS(data_matrix, params)
```

### 3. Accessing Results
The output is a `CogapsResult` object.

```r
# Extract Sample Factors (P matrix)
sample_weights <- result@sampleFactors

# Extract Feature Loadings (A matrix)
gene_loadings <- result@featureLoadings

# Standard deviations for uncertainty
sample_sd <- result@factorStdDev
gene_sd <- result@loadingStdDev
```

## Downstream Analysis

### Pattern Markers
Identify genes most uniquely associated with specific patterns.

```r
# threshold="all" (default): each gene assigned to one pattern
# threshold="cut": genes can belong to multiple patterns based on rank
pm <- patternMarkers(result, threshold="all")

# Access marker genes for Pattern 1
pm$PatternMarkers[[1]]
```

### Integration with Seurat
Map pattern weights back to single-cell embeddings.

```r
library(Seurat)
# Add patterns as a new assay
patterns <- t(result@sampleFactors[colnames(seurat_obj),])
seurat_obj[["CoGAPS"]] <- CreateAssayObject(counts = patterns)

# Visualize Pattern 1 on UMAP
DefaultAssay(seurat_obj) <- "CoGAPS"
FeaturePlot(seurat_obj, features = "Pattern_1")
```

### Gene Set Enrichment (GSEA)
Test for overrepresentation of functional sets in pattern markers.

```r
# gene_sets should be a named list of gene symbols
gs_results <- getPatternGeneSet(result, 
                                gene.sets = gene_sets, 
                                method = "overrepresentation")

# Plot results for Pattern 1
plotPatternGeneSet(gs_results, whichpattern = 1, padj_threshold = 0.05)
```

### Statistical Association (MANOVA)
Test if patterns correlate with metadata variables (e.g., QC metrics or clinical traits).

```r
meta_vars <- cbind(seurat_obj$nCount_RNA, seurat_obj$percent.mt)
manova_res <- MANOVA(meta_vars, result)
```

## Tips for Success
- **Iterations**: For publication-quality results, 50,000 iterations are typically recommended.
- **Sparsity**: Always set `sparseOptimization = TRUE` when working with single-cell RNA-seq data.
- **Parallelization**: Use `distributed = "genome-wide"` for datasets with many genes and `"single-cell"` for datasets with many cells.
- **Persistence**: CoGAPS is stochastic and computationally expensive; save results immediately using `saveRDS(result, "file.Rds")` or `toCSV(result, "path")`.

## Reference documentation
- [CoGAPS](./references/CoGAPS.md)