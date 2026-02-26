---
name: bioconductor-hipathia
description: This tool performs high-throughput functional analysis of signaling pathways by transforming gene expression data into mechanistic signal intensities. Use when user asks to calculate pathway activation signals, perform differential signaling analysis between experimental groups, or visualize functional profiles on pathway topologies.
homepage: https://bioconductor.org/packages/release/bioc/html/hipathia.html
---


# bioconductor-hipathia

name: bioconductor-hipathia
description: Perform high-throughput functional analysis of signaling pathways using gene expression data. Use this skill when you need to transform transcriptomic data into pathway-level activation signals, conduct differential pathway signaling analysis, or visualize functional profiles using the hipathia R package.

# bioconductor-hipathia

## Overview
Hipathia is a mechanistic model for the interpretation of gene expression experiments. It allows for the calculation of the signal intensity transmitted through signaling pathways, transforming gene-level information into functional information. Unlike standard enrichment methods, hipathia models the topology of the pathways (primarily from KEGG) to estimate the activation of specific sub-pathways leading to biological functions.

## Core Workflow

### 1. Load Pathway Information
Before processing expression data, you must load the pathway definitions for the target species.
```r
library(hipathia)
# Load human pathways (hsa). Other options: mmu (mouse), rno (rat)
pathways <- load_pathways(species = "hsa")
```

### 2. Data Preprocessing
Input data must be a normalized expression matrix with Entrez IDs as row names.
- **Normalization**: Data should be normalized (e.g., TMM, TPM) and preferably log-transformed.
- **ID Translation**: Use `translate_data` if your IDs are Gene Symbols or Ensembl IDs.
- **Scaling**: Hipathia requires values between 0 and 1. Use `normalize_data`.

```r
# Translate IDs to Entrez
exp_data <- translate_data(raw_data, "hsa")

# Scale data to [0,1] range
trans_data <- normalize_data(exp_data)
```

### 3. Calculate Pathway Signaling
The core function computes the signal intensity for each sub-pathway.
```r
results <- hipathia(trans_data, pathways, verbose = TRUE)

# Extract the signal matrix
path_signals <- get_results_data(results)
```

### 4. Differential Signaling Analysis
Compare two groups (e.g., Control vs. Disease) to find significantly activated or deactivated pathways.
```r
# group is a factor vector defining the classes of the columns in trans_data
comp <- get_paths_diff(results, group, cond1 = "Control", cond2 = "Disease")
```

### 5. Visualization and Interpretation
Hipathia provides tools to visualize results on the pathway topology or via heatmaps.
```r
# Create a heatmap of the top differential pathways
pathway_heatmap(path_signals, group)

# Visualize a specific pathway (e.g., MAPK signaling)
# This generates an interactive HTML report
visualize_report(comp, pathways, "pathways_report")

# Plot a specific pathway map with signal values
pathway_comparison_plot(comp, metaginfo = pathways, path_id = "hsa04010")
```

## Key Functions Reference
- `load_pathways()`: Downloads/loads the pathway graph information.
- `hipathia()`: Computes the signal values for all sub-pathways.
- `normalize_data()`: Scales expression data to the [0,1] range required by the model.
- `get_paths_diff()`: Performs a Wilcoxon test to find differentially expressed pathways.
- `get_pathways_summary()`: Summarizes sub-pathway signals into functional blocks.

## Tips for Success
- **Entrez IDs**: Ensure your row names are character strings of Entrez IDs.
- **Species Support**: Check `list_pathways("hsa")` to see available pathways for a species.
- **Memory**: Calculating signals for all pathways can be memory-intensive; ensure the R session has sufficient RAM for large cohorts.
- **Experimental Design**: The `group` factor in `get_paths_diff` must match the column order of your input expression matrix.

## Reference documentation
- [Hipathia Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/hipathia.html)