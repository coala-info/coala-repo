---
name: bioconductor-catalyst
description: CATALYST is a Bioconductor package for preprocessing, clustering, and visualizing high-dimensional cytometry data. Use when user asks to convert FCS files to SingleCellExperiment objects, perform FlowSOM clustering, run dimensionality reduction like UMAP or t-SNE, and conduct differential abundance or differential state analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/CATALYST.html
---

# bioconductor-catalyst

## Overview
CATALYST (Cytometry dATA anaLYsis Tools) is a Bioconductor package designed for the analysis of high-dimensional cytometry data. It provides a streamlined workflow for data preprocessing, unsupervised clustering, and complex visualizations. It is particularly powerful for identifying differences in cell population composition (Differential Abundance) and marker expression profiles (Differential State) across experimental conditions by integrating with the `diffcyt` framework.

## Core Workflow

### 1. Data Preparation
CATALYST uses the `SingleCellExperiment` (SCE) class. Use `prepData()` to convert raw FCS files or a `flowSet` into a compatible SCE object.

```r
# Required inputs: flowSet (fs), panel data.frame, and metadata data.frame (md)
sce <- prepData(fs, panel, md, 
                panel_cols = list(channel = "fcs_colname", antigen = "antigen"),
                md_cols = list(file = "file_name", id = "sample_id", 
                               factors = c("condition", "patient_id")))
```

### 2. Clustering and Merging
CATALYST wraps `FlowSOM` for high-resolution clustering and `ConsensusClusterPlus` for metaclustering.

*   **Clustering:** `sce <- cluster(sce, features = "type", xdim = 10, ydim = 10, maxK = 20)`
*   **Manual Merging:** Use `mergeClusters()` with a custom lookup table to combine fine-grained clusters into biologically meaningful populations.
*   **Evaluation:** Use `delta_area(sce)` to determine the optimal number of clusters (look for the "elbow" or plateau).

### 3. Dimensionality Reduction
Use `runDR()` to compute UMAP or t-SNE. It is often efficient to run this on a subset of cells.

```r
set.seed(123)
sce <- runDR(sce, dr = "UMAP", cells = 500, features = "type")
plotDR(sce, color_by = "meta8", facet_by = "condition")
```

### 4. Visualization Suite
CATALYST provides high-level plotting functions that return `ggplot` or `ComplexHeatmap` objects.

*   **Abundances:** `plotAbundances(sce, k = "meta12", by = "sample_id", group_by = "condition")`
*   **Expression Heatmaps:** `plotExprHeatmap(sce, features = "type", by = "cluster_id", k = "meta10")`
*   **Multi-panel Heatmaps:** `plotMultiHeatmap(sce, hm1 = "type", hm2 = "abundances", k = "meta8")`
*   **MDS Plots:** `pbMDS(sce, color_by = "condition", shape_by = "patient_id")`
*   **CLR Plots:** `clrDR(sce, by = "sample_id", k = "meta12")` for compositional analysis.

### 5. Differential Testing
Integrate with `diffcyt` for statistical testing.

```r
# Create design and contrast
design <- createDesignMatrix(ei(sce), cols_design = "condition")
contrast <- createContrast(c(0, 1))

# Test for Differential Abundance (DA) or Differential State (DS)
res_DA <- diffcyt(sce, clustering_to_use = "meta10", analysis_type = "DA",
                  method_DA = "diffcyt-DA-edgeR", design = design, contrast = contrast)

# Visualize results
plotDiffHeatmap(sce, rowData(res_DA$res), all = TRUE, fdr = 0.05)
```

## Tips and Best Practices
*   **Marker Classes:** Ensure your panel defines markers as "type" (for clustering/cell identity) or "state" (for functional readouts).
*   **Scaling:** In `plotExprHeatmap`, use `scale = "first"` to scale markers between 0 and 1 before aggregation, or `scale = "last"` to scale after aggregation to highlight differences.
*   **Filtering:** Use `filterSCE()` to subset the data by sample, patient, or cluster using `dplyr`-like syntax.
*   **FCS Export:** Use `sce2fcs()` to convert the SCE back to FCS format for use in external tools like Cytobank, ensuring data is split by cluster or sample as needed.

## Reference documentation
- [Differential discovery with CATALYST](./references/differential.md)
- [Preprocessing and Workflow](./references/preprocessing.md)