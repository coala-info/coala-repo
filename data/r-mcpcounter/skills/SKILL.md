---
name: r-mcpcounter
description: R package mcpcounter (documentation from project home).
homepage: https://cran.r-project.org/web/packages/mcpcounter/index.html
---

# r-mcpcounter

## Overview
The `mcpcounter` (Microenvironment Cell Populations-counter) package implements a methodology to quantify the absolute abundance of eight immune cell types (T cells, CD8+ T cells, Cytotoxic lymphocytes, B lineage, NK cells, Monocytic lineage, Myeloid dendritic cells, Neutrophils) and two stromal cell types (Endothelial cells, Fibroblasts) from transcriptomic profiles. It uses highly specific marker genes validated through extensive transcriptomic datasets.

## Installation
To install the package from GitHub (as it is primarily hosted there):
```R
if (!require("devtools")) install.packages("devtools")
devtools::install_github("ebecht/MCPcounter", ref="master", subdir="Source")
```

## Main Functions and Workflows

### Estimating Cell Abundance
The primary function is `MCPcounter.estimate`. It requires a gene expression matrix where rows are genes and columns are samples.

```R
library(MCPcounter)

# Basic usage
# expression_matrix: a numeric matrix or data frame (non-log transformed for RNA-seq is recommended)
# featuresType: "HUGO_symbols", "EntrezID", or "PROBE_ID"
results <- MCPcounter.estimate(expression_matrix, featuresType = "HUGO_symbols")
```

### Key Parameters
- `expression`: Matrix or data frame of expression values.
- `featuresType`: The type of identifiers used in your matrix. Supported: `HUGO_symbols`, `EntrezID`, `PROBE_ID` (Affymetrix HG-U133 Plus 2.0).
- `probesets`: (Optional) A custom data frame for mapping probes to cell types.
- `genes`: (Optional) A custom data frame for mapping genes to cell types.

### Data Preparation Tips
- **Normalization**: Input data should be normalized (e.g., fpm, tpm, or rma).
- **Transformation**: The algorithm is designed for linear-scale data. If your data is log-transformed, it is generally recommended to exponentiate it back to linear scale before running the estimation, as the scores represent abundance.
- **Identifiers**: Ensure your row names match the `featuresType` specified. HUGO symbols are the most common choice for RNA-seq data.

## Workflow Example
```R
# Load your data
my_data <- read.table("expression_data.txt", header = TRUE, row.names = 1)

# Run MCP-counter
estimates <- MCPcounter.estimate(my_data, featuresType = "HUGO_symbols")

# The output is a matrix with cell types as rows and samples as columns
# Visualize results (e.g., heatmap)
heatmap(estimates)
```

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)