---
name: bioconductor-metnet
description: MetNet infers metabolic networks from untargeted high-resolution mass spectrometry data by combining structural transformations and statistical associations. Use when user asks to infer metabolic networks, identify biochemical transformations from m/z differences, calculate statistical associations between features, or integrate spectral similarity into network construction.
homepage: https://bioconductor.org/packages/release/bioc/html/MetNet.html
---


# bioconductor-metnet

name: bioconductor-metnet
description: Infer metabolic networks from untargeted high-resolution mass spectrometry (MS) data. Use this skill to create adjacency matrices based on structural properties (m/z differences/transformations) and statistical associations (correlation, LASSO, Random Forest, GGM). It is compatible with xcms/CAMERA output and supports consensus network construction and spectral similarity integration.

## Overview
MetNet is a Bioconductor package designed to bridge the gap between raw mass spectrometry features and biological pathways. It constructs metabolic networks by combining two layers of information:
1.  **Structural Layer:** Identifies potential biochemical transformations (e.g., hydroxylation, glycosylation) based on precise m/z differences between features.
2.  **Statistical Layer:** Infers relationships based on feature intensity patterns across samples using various algorithms (Pearson, Spearman, LASSO, Random Forest, etc.).

The package centers around the `AdjacencyMatrix` class, which extends `SummarizedExperiment` to store multiple network layers and metadata.

## Core Workflow

### 1. Data Preparation
Input data should be a matrix-like object where rows are features and columns are samples. It must contain an `"mz"` column.
```r
library(MetNet)
data("x_test", package = "MetNet")
x_test <- as.matrix(x_test)
# Quantitative data (intensities)
x_int <- x_test[, 3:ncol(x_test)]
```

### 2. Structural Network Inference
Define a search space of biochemical transformations and match them against m/z differences.
```r
# Define transformations: group, formula, mass (numeric), and optionally rt shift
transformations <- data.frame(
    group = c("Hydroxylation", "Acetylation"),
    mass = c(15.9949, 42.0105),
    rt = c("-", "-") # Expected RT shift
)

struct_adj <- structural(x = x_test, transformation = transformations, 
                         ppm = 10, directed = FALSE)

# Optional: Refine with Retention Time (RT) correction
struct_adj <- rtCorrection(am = struct_adj, x = x_test, 
                           transformation = transformations, var = "group")
```

### 3. Statistical Network Inference
Calculate associations using one or more models.
```r
# Supported models: "pearson", "spearman", "lasso", "randomForest", "clr", "aracne", "bayes", "ggm"
stat_adj <- statistical(x_int, model = c("pearson", "spearman"))

# Threshold to create a consensus unweighted matrix
# Types: "threshold" (fixed value), "top1", "top2", "mean" (rank-based)
args_thr <- list(filter = "abs(pearson_coef) > 0.95 & pearson_pvalue <= 0.05")
stat_adj_thr <- threshold(am = stat_adj, type = "threshold", args = args_thr)
```

### 4. Integrating Spectral Similarity
If MS2 data is available, incorporate spectral similarity (e.g., from the `Spectra` package).
```r
# ms2_similarity is a list of similarity matrices
spect_adj <- addSpectralSimilarity(am_structural = struct_adj, 
                                   ms2_similarity = list("ndotproduct" = adj_spec))
```

### 5. Combining Layers
Merge the structural and statistical evidence into a final consensus network.
```r
# am_statistical must be a thresholded AdjacencyMatrix
comb_adj <- combine(am_structural = struct_adj, am_statistical = stat_adj_thr)
```

## Visualization and Export
MetNet objects can be converted to standard R formats for downstream analysis.
```r
# Convert to data frame for filtering
df <- as.data.frame(comb_adj)

# Convert to igraph for visualization
library(igraph)
adj_mat <- assay(comb_adj, "combine_binary")
g <- graph_from_adjacency_matrix(adj_mat, mode = "undirected")
plot(g)
```

## Key Functions
- `structural()`: Creates adjacency based on m/z differences.
- `statistical()`: Computes weighted associations using various statistical frameworks.
- `threshold()`: Converts weighted statistical matrices into binary consensus matrices.
- `combine()`: Intersects structural and statistical matrices.
- `rtCorrection()`: Filters structural links based on expected retention time shifts.
- `mz_summary()` / `mz_vis()`: Summarize and visualize the distribution of identified transformations.

## Reference documentation
- [MetNet: Inferring metabolic networks from untargeted high-resolution mass spectrometry data](./references/MetNet.md)