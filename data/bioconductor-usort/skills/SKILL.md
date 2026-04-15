---
name: bioconductor-usort
description: uSORT is an R package that uncovers intrinsic cell progression paths and trajectories from single-cell RNA-seq data. Use when user asks to perform cell ordering, reconstruct developmental trajectories, or identify driver genes from single-cell expression matrices.
homepage: https://bioconductor.org/packages/release/bioc/html/uSORT.html
---

# bioconductor-usort

## Overview
uSORT (universal Single-cell Ordering Ranking Tool) is an R package designed to uncover intrinsic cell progression paths from single-cell RNA-seq data. It provides a comprehensive pipeline that includes data pre-processing (log transformation, outlier removal), feature selection (PCA-based and driving force analysis), and cell ordering. The package is particularly flexible, allowing users to combine different preliminary and refined sorting methods to optimize the trajectory reconstruction.

## Typical Workflow

The standard uSORT workflow consists of two main stages: preliminary ordering and refined ordering.

### 1. Data Preparation
uSORT typically expects expression data in TPM or CPM format.
```r
library(uSORT)

# Load your expression matrix (rows = samples/cells, columns = genes)
# Or use the example file provided in the package
dir <- system.file('extdata', package='uSORT')
exprs_file <- list.files(dir, pattern='.txt$', full=TRUE)
```

### 2. Running the Main Pipeline
The `uSORT` function executes the entire workflow. Key parameters include the choice of sorting methods for both the preliminary and refined stages.

```r
uSORT_results <- uSORT(
    exprs_file = exprs_file,
    project_name = "my_trajectory_analysis",
    log_transform = TRUE,
    remove_outliers = TRUE,
    preliminary_sorting_method = "autoSPIN", # Options: autoSPIN, sWanderlust, monocle, Wanderlust, SPIN, none
    refine_sorting_method = "sWanderlust",    # Options: autoSPIN, sWanderlust, monocle, Wanderlust, SPIN, none
    nCores = 1,
    save_results = TRUE
)
```

### 3. Interpreting Results
The output is a list containing processed data and ordering information:
- `trimmed_log2exp`: The log2-transformed expression matrix after outlier removal.
- `preliminary_sorting_order`: Cell IDs in the order determined by the first pass.
- `refined_sorting_order`: The final optimized cell trajectory.
- `refined_sorting_genes`: The "driver genes" identified as contributing most to the trajectory.

### 4. Visualization
You can validate the trajectory by plotting heatmaps of known signature genes against the refined cell order.

```r
# Extract final ordered expression
ref_log2ex <- uSORT_results$trimmed_log2exp[uSORT_results$refined_sorting_order, ]

# Filter for signature genes of interest
sig_genes <- c("GeneA", "GeneB", "GeneC")
sig_matrix <- t(ref_log2ex[, colnames(ref_log2ex) %in% sig_genes])

# Plot heatmap
library(gplots)
heatmap.2(as.matrix(sig_matrix),
          dendrogram='row',
          trace='none',
          Colv=FALSE, # Keep the uSORT order
          scale='row',
          col=bluered)
```

## Key Functions and Parameters

- `uSORT()`: The primary wrapper function.
    - `pre_data_type` / `ref_data_type`: Set to "linear" for most trajectories or "cyclical" for cell cycle studies.
    - `pre_autoSPIN_alpha`: Controls the step size in the SPIN algorithm (default 0.2).
    - `nCores`: Set > 1 to enable parallel processing for computationally intensive methods like Wanderlust.
- `uSORT_GUI()`: Launches a Tcl/Tk graphical interface for users who prefer a point-and-click workflow.

## Tips for Success
- **Method Selection**: `autoSPIN` is often a robust choice for preliminary sorting as it doesn't require a starting cell. `sWanderlust` is effective for refining the path.
- **Outlier Removal**: The `remove_outliers = TRUE` setting is recommended for noisy scRNA-seq data to prevent extreme cells from skewing the trajectory.
- **File Formats**: When using the `exprs_file` argument, ensure the text file is tab-delimited with gene names as columns and cell IDs as rows.

## Reference documentation
- [uSORT: Quick Start](./references/uSORT_quick_start.md)