---
name: bioconductor-spatiallibd
description: The spatialLIBD package provides tools for the interactive visualization, spatial registration, and analysis of spatially-resolved transcriptomics data from the 10x Genomics Visium platform. Use when user asks to explore Visium data interactively via Shiny, map single-cell RNA-seq data to spatial references, or generate spatial gene expression plots.
homepage: https://bioconductor.org/packages/release/data/experiment/html/spatialLIBD.html
---

# bioconductor-spatiallibd

## Overview

The `spatialLIBD` package is designed for the interactive visualization and analysis of spatially-resolved transcriptomics data, specifically optimized for the 10x Genomics Visium platform. It provides a robust framework for exploring gene expression across tissue sections, performing spatial registration (correlating query data like snRNA-seq with reference spatial maps), and generating publication-quality spatial plots.

## Core Workflows

### 1. Data Import and Preparation
The package uses the `SpatialExperiment` class. You can import SpaceRanger outputs directly using a wrapper that prepares the object for `spatialLIBD` features.

```r
library(spatialLIBD)

# Recommended: Use the wrapper to automate colData and rowData preparation
spe <- read10xVisiumWrapper(
    samples = "/path/to/spaceranger/outs",
    sample_id = "sample01",
    type = "sparse", 
    data = "filtered",
    images = c("lowres", "hires"), 
    load = TRUE,
    reference_gtf = "path/to/genes.gtf" # Optional but recommended for gene info
)

# Manual preparation of an existing SpatialExperiment object
spe <- add_key(spe) # Adds unique spot identifiers
spe$sum_umi <- colSums(counts(spe))
spe$sum_gene <- colSums(counts(spe) > 0)
spe$ManualAnnotation <- "NA" # Required for the Shiny app
```

### 2. Interactive Exploration
The hallmark of `spatialLIBD` is its Shiny web application.

```r
run_app(
    spe,
    sce_layer = NULL, # Optional: pseudo-bulk results
    title = "My Visium Project",
    spe_discrete_vars = c("10x_graphclust", "ManualAnnotation"),
    spe_continuous_vars = c("sum_umi", "sum_gene", "expr_chrM_ratio")
)
```

### 3. Spatial Registration
Map query datasets (e.g., snRNA-seq) to a reference spatial dataset by correlating enrichment statistics.

```r
# 1. Compute enrichment stats for query (e.g., cell types in snRNA-seq)
query_stats <- registration_wrapper(
    sce = sce_query,
    var_registration = "cellType",
    var_sample_id = "donor",
    gene_ensembl = "gene_id",
    gene_name = "gene_name"
)

# 2. Correlate with reference (e.g., DLPFC layers)
cor_layer <- layer_stat_cor(
    stats = query_stats$enrichment,
    modeling_results = fetch_data(type = "modeling_results"),
    model_type = "enrichment"
)

# 3. Visualize and annotate
layer_stat_cor_plot(cor_layer)
annotations <- annotate_registered_clusters(cor_layer)
```

### 4. Advanced Spatial Plotting
Visualize single genes or summarized multi-gene signatures.

```r
# Single gene
vis_gene(spe, geneid = "GFAP; ENSG00000131095")

# Multi-gene summary (z-score, pca, or sparsity)
white_matter_genes <- c("MBP", "PLP1", "GFAP")
vis_gene(
    spe, 
    geneid = white_matter_genes, 
    multi_gene_method = "z_score" # Averages scaled expression
)
```

## Tips for Success
- **Gene Search**: Always format `rowData(spe)$gene_search` as `SYMBOL; ENSEMBL_ID` to enable the user-friendly search bar in the Shiny app.
- **Memory Management**: Visium objects can be large. Use `lobstr::obj_size(spe)` to monitor memory. For deployment on `shinyapps.io`, consider filtering lowly expressed genes or using larger instance sizes.
- **Mitochondrial Ratio**: Always compute `expr_chrM_ratio` as it is often a key quality control metric that correlates with spatial architecture.

## Reference documentation
- [Using spatialLIBD with 10x Genomics public datasets](./references/TenX_data_download.md)
- [Guide to Spatial Registration](./references/guide_to_spatial_registration.md)
- [Guide to Multi-Gene Plots](./references/multi_gene_plots.md)
- [Introduction to spatialLIBD](./references/spatialLIBD.md)