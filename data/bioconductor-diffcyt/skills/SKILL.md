---
name: bioconductor-diffcyt
description: Bioconductor-diffcyt provides statistical methods for differential discovery in high-dimensional cytometry data such as flow cytometry and CyTOF. Use when user asks to perform differential abundance analysis, conduct differential state analysis, or identify changes in cell population proportions and functional marker expression.
homepage: https://bioconductor.org/packages/release/bioc/html/diffcyt.html
---

# bioconductor-diffcyt

name: bioconductor-diffcyt
description: Statistical methods for differential discovery in high-dimensional cytometry data (flow cytometry, CyTOF). Use this skill when performing differential abundance (DA) or differential state (DS) analysis on cytometry datasets, including data preprocessing, high-resolution clustering with FlowSOM, and empirical Bayes moderated testing.

# bioconductor-diffcyt

## Overview
The `diffcyt` package provides a framework for differential discovery in high-dimensional cytometry data. It utilizes high-resolution clustering (typically FlowSOM) to define cell populations and applies statistical methods adapted from transcriptomics (edgeR, limma, voom) or mixed models to identify:
1. **Differential Abundance (DA):** Changes in the proportion of cell populations across conditions.
2. **Differential States (DS):** Changes in the expression of functional/signaling markers within specific cell populations.

## Typical Workflow

### 1. Data Preparation
Input data can be a `flowSet` (from `.fcs` files) or a `daFrame` from the `CATALYST` package.

```r
library(diffcyt)
library(HDCytoData)

# Load example data (flowSet)
d_flowSet <- Bodenmiller_BCR_XL_flowSet()

# Define marker classes: "type" (for clustering) and "state" (for DS testing)
# marker_info should have columns: channel_name, marker_name, marker_class
marker_info <- data.frame(
  channel_name = colnames(d_flowSet),
  marker_name = gsub("\\(.*$", "", colnames(d_flowSet)),
  marker_class = factor(c(rep("none", 2), rep("type", 10), rep("state", 14), rep("none", 13)))
)

# Define experiment info: sample_id, group_id, and optional blocking factors (e.g., patient_id)
experiment_info <- data.frame(
  sample_id = sample_names(d_flowSet),
  group_id = factor(rep(c("Reference", "BCR-XL"), 8)),
  patient_id = factor(rep(paste0("patient", 1:8), each = 2))
)
```

### 2. Experimental Design and Contrasts
Create a design matrix for fixed effects and a contrast vector for the comparison of interest.

```r
# Design matrix (including patient_id for paired analysis)
design <- createDesignMatrix(experiment_info, cols_design = c("group_id", "patient_id"))

# Contrast: compare BCR-XL (2nd col) vs Reference (Intercept)
contrast <- createContrast(c(0, 1, rep(0, 7)))
```

### 3. Running the Analysis (Wrapper Function)
The `diffcyt()` function is the primary entry point.

```r
# Differential Abundance (DA)
out_DA <- diffcyt(d_input = d_flowSet,
                  experiment_info = experiment_info,
                  marker_info = marker_info,
                  design = design,
                  contrast = contrast,
                  analysis_type = "DA",
                  seed_clustering = 123)

# Differential State (DS)
out_DS <- diffcyt(d_input = d_flowSet,
                  experiment_info = experiment_info,
                  marker_info = marker_info,
                  design = design,
                  contrast = contrast,
                  analysis_type = "DS",
                  seed_clustering = 123)
```

### 4. Interpreting Results
Use `topTable()` to extract significant clusters or cluster-marker combinations.

```r
# View top results
topTable(out_DA, format_vals = TRUE)
topTable(out_DS, format_vals = TRUE)

# Filter by FDR threshold
res <- topTable(out_DS, all = TRUE)
sig_results <- res[res$p_adj <= 0.1, ]
```

## Advanced Usage: Individual Functions
For more control, run the pipeline steps manually:
1. `prepareData()`: Convert input to `SummarizedExperiment`.
2. `transformData()`: Apply `arcsinh` transformation (default cofactor = 5).
3. `generateClusters()`: Run FlowSOM clustering.
4. `calcCounts()` and `calcMedians()`: Calculate cluster features.
5. `testDA_edgeR()` or `testDS_limma()`: Perform statistical testing.

## Visualization
While `diffcyt` provides `plotHeatmap()`, it is highly compatible with `CATALYST`.
```r
library(CATALYST)
# Plot results using CATALYST's enhanced heatmaps
plotDiffHeatmap(out_DA$d_se, out_DA$res)
```

## Tips
- **Marker Classification:** Ensure `marker_class` is correctly set to "type" for lineage markers and "state" for functional markers.
- **Transformation:** Mass cytometry data requires `arcsinh` transformation. `diffcyt` handles this automatically in the wrapper, but check cofactors if using flow cytometry.
- **Reproducibility:** Always set `seed_clustering` for consistent FlowSOM results.
- **Mixed Models:** For complex designs with random effects, use `method_DA = "diffcyt-DA-GLMM"` or `method_DS = "diffcyt-DS-LMM"`.

## Reference documentation
- [diffcyt workflow](./references/diffcyt_workflow.md)