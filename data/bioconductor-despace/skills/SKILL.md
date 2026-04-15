---
name: bioconductor-despace
description: DESpace identifies spatially variable genes and differential spatial variable patterns in spatial transcriptomics data using pre-annotated spatial clusters. Use when user asks to identify spatially variable genes, find differential spatial patterns across conditions, or perform individual cluster testing in SpatialExperiment or SingleCellExperiment objects.
homepage: https://bioconductor.org/packages/release/bioc/html/DESpace.html
---

# bioconductor-despace

name: bioconductor-despace
description: Identifying spatially variable genes (SVGs) and differential spatial variable pattern (DSP) genes in spatial transcriptomics data. Use this skill when analyzing SpatialExperiment or SingleCellExperiment objects to find genes whose expression is associated with spatial clusters or whose spatial patterns change across experimental conditions (e.g., treatment groups, time points).

# bioconductor-despace

## Overview

DESpace is a framework that leverages pre-annotated spatial clusters to identify spatially variable genes (SVGs) and differential spatial variable pattern (DSP) genes. It uses a negative binomial model (via `edgeR`) with spatial clusters as covariates. This approach is significantly faster than many other SVG methods and allows for joint modeling of multiple samples and testing of individual clusters to pinpoint specific regions of spatial variability.

## Core Workflows

### 1. Identifying Spatially Variable Genes (SVG)

To find genes that vary across spatial clusters in a single sample or across biological replicates:

```r
library(DESpace)

# For a single sample
results <- svg_test(spe = spe, 
                    cluster_col = "layer_guess", 
                    verbose = TRUE)

# For multiple biological replicates (joint modeling)
multi_results <- svg_test(spe = spe_combined,
                          cluster_col = "layer_guess",
                          sample_col = "sample_id",
                          replicates = TRUE)

# Access results
head(results$gene_results)
```

### 2. Identifying Differential Spatial Patterns (DSP)

To find genes where the spatial expression pattern changes across conditions (e.g., Healthy vs. Diseased):

```r
# Test for interaction between clusters and conditions
dsp_results <- dsp_test(spe = spe,
                        cluster_col = "spatial_cluster",
                        sample_col = "sample_id",
                        condition_col = "condition",
                        test = "QLF") # QLF for error control, LRT for sensitivity

head(dsp_results$gene_results)
```

### 3. Individual Cluster Testing

To identify genes specifically over- or under-abundant in a particular cluster compared to the rest of the tissue:

```r
# For SVGs
cluster_svgs <- individual_svg(spe, 
                               cluster_col = "layer_guess",
                               edgeR_y = results$estimated_y) # Use pre-computed dispersion to save time

# For DSPs
cluster_dsps <- individual_dsp(spe,
                               cluster_col = "spatial_cluster",
                               sample_col = "sample_id",
                               condition_col = "condition")

# Combine gene-level and cluster-level results
merged <- top_results(results$gene_results, cluster_svgs)
```

### 4. Modeling Time with Splines

For time-course spatial data, use a custom design matrix with splines:

```r
library(splines)
design_model <- model.matrix(~ cluster * ns(day, df = 2), data = metadata)
results <- dsp_test(spe,
                    design = design_model,
                    cluster_col = "spatial_cluster",
                    sample_col = "sample_id",
                    condition_col = "condition")
```

## Visualization

Use `FeaturePlot` to visualize gene expression in physical space, optionally with cluster outlines:

```r
# Basic expression plot
FeaturePlot(spe, feature = "ENSG000001", coordinates = c("x", "y"))

# Plot with cluster outlines
FeaturePlot(spe, feature = "ENSG000001", 
            cluster_col = "layer_guess", 
            cluster = "WM", # Outline specific cluster
            annotation_cluster = TRUE)
```

## Tips and Best Practices

- **Cluster Consistency:** When analyzing multiple samples, ensure cluster labels are consistent (e.g., "Cluster 1" must represent the same tissue type across all samples).
- **Filtering:** Always perform quality control and filter lowly abundant genes (e.g., genes detected in < 20 spots) before running DESpace.
- **Dispersion Estimates:** When running `individual_svg`, passing the `estimated_y` object from the global `svg_test` to the `edgeR_y` argument significantly speeds up computation.
- **Input Objects:** DESpace primarily works with `SpatialExperiment` objects. Ensure `colData` contains the necessary columns for clusters, samples, and conditions.

## Reference documentation

- [Differential Spatial Pattern between conditions](./references/DSP.md)
- [A framework to discover Spatially Variable genes via spatial clusters](./references/SVG.md)