---
name: bioconductor-sconify
description: Sconify performs K-Nearest Neighbor statistics on high-dimensional cytometry data to compare biological conditions on a per-cell basis. Use when user asks to analyze CyTOF data, detect subtle shifts in marker expression, find the ideal k for imputation, or visualize neighborhood density and fold changes on a t-SNE map.
homepage: https://bioconductor.org/packages/release/bioc/html/Sconify.html
---

# bioconductor-sconify

## Overview

Sconify is a Bioconductor package designed for the analysis of high-dimensional cytometry data, specifically CyTOF. It uses K-Nearest Neighbor (KNN) statistics to compare biological conditions (e.g., basal vs. stimulated) on a per-cell basis. By treating each cell's neighborhood as a local sample, it allows for the detection of subtle shifts in marker expression and manifold density that might be missed by global clustering methods.

## Core Workflow

### 1. Pre-Processing
The initial step involves converting .fcs files into tidy data frames (tibbles) and selecting markers for KNN input (usually surface markers) and functional analysis (usually phospho-markers).

```r
library(Sconify)

# 1. Extract marker names to a CSV for manual selection/categorization
basal_file <- "path/to/basal_condition.fcs"
GetMarkerNames(basal_file) 

# 2. Process multiple files (concatenation, subsampling, and transformation)
# 'surface' is a vector of marker names used for KNN distance calculation
files <- c("sample_basal.fcs", "sample_IL7.fcs")
combined_data <- ProcessMultipleFiles(files = files, 
                                      input = surface_markers, 
                                      numcells = 20000)
```

### 2. Finding Ideal K
The choice of $k$ (number of neighbors) is a bias-variance tradeoff. Sconify provides a titration function to find the $k$ that minimizes imputation error.

```r
k_titration <- seq(10, 100, by = 10)
ideal_k_results <- ImputeTesting(k.titration = k_titration,
                                 cells = combined_data,
                                 input.markers = surface_markers,
                                 test.markers = functional_markers)
# Select the k at the local minimum of the output
```

### 3. The SCONE Workflow
This step calculates the KNN indices and computes the statistics (fold change and q-values) for the functional markers across conditions.

```r
# 1. Generate KNN indices and distances
nn_matrix <- Fnn(cell.df = combined_data, 
                 input.markers = surface_markers, 
                 k = 30)

# 2. Compute SCONE values (statistics per neighborhood)
scone_results <- SconeValues(nn.matrix = nn_matrix,
                             cell.data = combined_data,
                             scone.markers = functional_markers,
                             unstim = "basal")
```

### 4. Post-Processing and Visualization
Merge the statistics back into the original data and visualize using t-SNE.

```r
# Merge results and run t-SNE
final_data <- PostProcessing(scone.output = scone_results,
                             cell.data = combined_data,
                             input = surface_markers,
                             tsne = TRUE)

# Visualize a specific marker change on the t-SNE map
TsneVis(final_data, "pSTAT5.IL7.change", "IL-7 induced pSTAT5 Change")

# Visualize neighborhood density
TsneVis(final_data, "density")
```

## Key Functions

- `FcsToTibble()`: Converts a single FCS file to a tibble with optional asinh transformation.
- `ProcessMultipleFiles()`: Concatenates files, adds a "condition" column, and performs optional quantile normalization.
- `SplitFile()`: Splits a single file into two groups to create a synthetic "control vs treated" comparison.
- `MakeHist()`: Plots the distribution of condition fractions per KNN to assess manifold overlap/technical variance.
- `GetKnnDe()`: Calculates KNN density estimation (1 / average distance to neighbors).

## Data Quality Assessment
A primary use case for Sconify is checking if two replicates overlap correctly. In a perfect overlap of two equal-sized files, the fraction of cells from condition B in any neighborhood should follow a binomial distribution centered at 0.5.
- **High Standard Deviation**: Indicates technical drift or biological manifold shifts.
- **Ideal SD**: Approximately $0.5 / \sqrt{k}$.

## Reference documentation
- [Assessing quality of CyTOF data with KNN](./references/DataQuality.md)
- [Selection of the number of nearest neighbors](./references/FindingIdealK.md)
- [Pre-Processing FCS files](./references/Step1.PreProcessing.md)
- [The Scone Workflow](./references/Step2.TheSconeWorkflow.md)
- [Post-Processing and Visualization](./references/Step3.PostProcessing.md)