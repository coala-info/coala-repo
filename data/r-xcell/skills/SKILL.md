---
name: r-xcell
description: This tool performs cell type enrichment analysis to estimate the abundance of immune and stromal cells from bulk gene expression data. Use when user asks to estimate cell type proportions, perform signature-based enrichment analysis, or analyze tissue cellular heterogeneity in transcriptomic datasets.
homepage: https://cran.r-project.org/web/packages/xcell/index.html
---


# r-xcell

name: r-xcell
description: Cell type enrichment analysis for bulk transcriptomes using the xCell R package. Use this skill when you need to estimate the abundance of 64 immune and stroma cell types from gene expression data, perform signature-based enrichment, or analyze tissue cellular heterogeneity.

## Overview

xCell is a gene signature-based method that performs cell type enrichment analysis for 64 immune and stroma cell types. It uses a novel technique to reduce associations between closely related cell types and transforms enrichment scores into values that resemble percentages. It is specifically designed for bulk gene expression data and performs best with heterogeneous datasets.

## Installation

To install the xCell package from GitHub:

```R
if (!require("devtools")) install.packages("devtools")
devtools::install_github('dviraran/xCell')
```

## Core Workflow

The primary function `xCellAnalysis` performs the full pipeline: raw enrichment, score transformation, and spillover compensation.

### Basic Usage

```R
library(xCell)

# Load your expression matrix (genes in rows, samples in columns)
# Rownames must be Gene Symbols.
expr_matrix <- read.table("expression_data.txt", header = TRUE, row.names = 1, as.is = TRUE)

# Run the full analysis
# Returns a matrix of enrichment scores (cell types x samples)
scores <- xCellAnalysis(expr_matrix)
```

### Significance Assessment

To assess the null hypothesis that a cell type is not present in the mixture:

```R
# Recommended: uses predefined beta distribution parameters
p_values <- xCellSignifcanceBetaDist(scores)

# Alternative: uses a random matrix to calculate parameters
p_values_random <- xCellSignifcanceRandomMatrix(expr_matrix)
```

## Usage Tips and Constraints

1. **Data Requirements**: Input should be a matrix with Gene Symbols as row names. xCell uses expression ranking, so while normalization to gene length (e.g., TPM, FPKM) is required, standard scaling/normalization across samples has little effect on the ranking.
2. **Heterogeneity**: xCell relies on variability among samples for its linear transformation. Always process all samples (e.g., cases and controls) together in one run. Do not run small, homogeneous batches separately.
3. **Interpretation**: xCell produces **enrichment scores**, not absolute percentages. While scores are calibrated to resemble percentages, they are best used for comparing the same cell type across different samples, rather than comparing different cell types within the same sample.
4. **Bulk vs. Single-Cell**: xCell is trained for **bulk transcriptomes**. It is not recommended for single-cell RNA-seq data (use `SingleR` for scRNA-seq instead).
5. **Calibration**: If a cell type shows high scores that are known to be false positives, you can manually tweak calibration parameters found in `xCell.data$spill$fv$V3`.

## Reference documentation

- [README.Md](./references/README.Md.md)
- [GitHub Articles](./references/articles.md)
- [xCell Home Page](./references/home_page.md)