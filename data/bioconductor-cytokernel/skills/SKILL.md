---
name: bioconductor-cytokernel
description: This tool performs nonlinear differential expression analysis on high-dimensional biological data using kernel-based score tests. Use when user asks to identify differentially expressed features, calculate shrunken effect sizes, or generate heatmaps of significant features in datasets like CyTOF or RNA-seq.
homepage: https://bioconductor.org/packages/release/bioc/html/cytoKernel.html
---


# bioconductor-cytokernel

name: bioconductor-cytokernel
description: Perform nonlinear differential expression analysis on high-dimensional biological data (e.g., CyTOF, gene expression, RNA-seq) using kernel-based score tests. Use this skill to identify differentially expressed features between two groups, calculate shrunken effect sizes via the Adaptive Shrinkage (ash) procedure, and generate heatmaps of significant features.

# bioconductor-cytokernel

## Overview

The `cytoKernel` package provides a nonlinear approach to detect differentially expressed (DE) features in high-dimensional biological datasets. Unlike standard linear models, it uses a kernel-based score test within a Reproducible Kernel Hilbert Space (RKHS) to capture complex, nonlinear relationships among features (such as signaling markers in cell subpopulations). It is particularly effective for mass cytometry (CyTOF) data but is applicable to any feature-sample matrix.

## Core Workflow

1.  **Prepare Data**: Use a `SummarizedExperiment` object, matrix, or data frame where rows are features (e.g., cluster-marker combinations) and columns are samples.
2.  **Define Groups**: Create a binary `group_factor` (0 and 1) representing the experimental conditions for each sample.
3.  **Run Analysis**: Execute `CytoK()` to perform the score test and calculate shrunken effect sizes.
4.  **Extract Results**: Use helper functions to retrieve p-values, adjusted p-values (FDR), and effect sizes.
5.  **Filter and Visualize**: Subset the data to significant features and generate heatmaps.

## Main Functions

### CytoK()
The primary function for differential expression analysis.
- `object`: Data object (matrix, data.frame, or `SummarizedExperiment`).
- `group_factor`: Binary vector (0/1) for group labels.
- `lowerRho` / `upperRho`: Bounds for the kernel parameter (default 2 to 12).
- `gridRho`: Number of grid points for kernel parameter optimization (default 4).
- `alpha`: Significance level for FDR control (default 0.05).

### Result Extraction
- `CytoKFeatures(output)`: Returns a data frame of results (cluster, EffectSize, EffectSizeSD, pvalue, padj).
- `CytoKFeaturesOrdered(output)`: Returns results sorted by adjusted p-value (ascending).
- `CytoKDEfeatures(output)`: Returns the percentage of features identified as differentially expressed.

### Data Manipulation and Visualization
- `CytoKDEData(output, by = "features")`: Returns a `SummarizedExperiment` containing only the DE features.
- `plotCytoK(output, group_factor, topK = 10)`: Generates a heatmap of the top K differentially expressed features.

## Usage Example

```r
library(cytoKernel)

# Load example data (SummarizedExperiment)
data("cytoHDBMW")

# Define groups (e.g., 4 control vs 4 treated)
groups <- rep(c(0, 1), each = 4)

# Run the kernel-based score test
results <- CytoK(cytoHDBMW, group_factor = groups)

# View top significant features
head(CytoKFeaturesOrdered(results))

# Get percentage of DE features
CytoKDEfeatures(results)

# Extract DE data for further analysis
de_data <- CytoKDEData(results, by = "features")

# Plot heatmap of top 10 DE features
plotCytoK(results, group_factor = groups, topK = 10)
```

## Tips for Analysis

- **Kernel Parameters**: The `rho` parameters control the Gaussian distance-based kernel. While defaults usually suffice, you can adjust `lowerRho`, `upperRho`, and `gridRho` if the score test fails to converge or if you need a finer search for the optimal kernel parameter.
- **Feature Identification**: If using a `SummarizedExperiment`, the function automatically uses row variables. For other formats, ensure rows are correctly labeled as features.
- **Integration**: The output of `CytoKDEData` is a standard `SummarizedExperiment`, making it compatible with other Bioconductor visualization tools like `ComplexHeatmap` or `scater`.

## Reference documentation

- [The cytoKernel user's guide](./references/cytoKernel.Rmd)
- [The cytoKernel user's guide (Markdown)](./references/cytoKernel.md)