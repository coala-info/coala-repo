---
name: r-riborex
description: This tool identifies differential translation by integrating Ribo-seq and RNA-seq data using various statistical engines. Use when user asks to identify genes with significant changes in translation efficiency, analyze ribosome profiling data alongside RNA-seq, or perform differential translation analysis using DESeq2 or edgeR.
homepage: https://cran.r-project.org/web/packages/riborex/index.html
---


# r-riborex

name: r-riborex
description: Identification of differential translation from Ribo-seq data using the riborex R package. Use this skill when analyzing ribosome profiling data alongside RNA-seq data to find genes with significant changes in translation efficiency across different conditions.

## Overview

riborex is an R package designed for the fast and flexible identification of differential translation. It integrates Ribo-seq and RNA-seq data to model the relationship between mRNA abundance and protein synthesis. It supports multiple underlying engines for statistical analysis, including DESeq2, edgeR, and fdrtool, allowing for robust discovery of genes where translation efficiency changes independently of transcript levels.

## Installation

To install the package from CRAN:

```R
install.packages("riborex")
```

To install the development version from GitHub:

```R
if (!require("devtools")) install.packages("devtools")
devtools::install_github("smithlabcode/riborex")
```

## Core Workflow

The primary function in the package is `riborex()`. It requires count matrices for both Ribo-seq and RNA-seq data, along with experimental design information.

### 1. Prepare Data
You need two count matrices (rows as genes, columns as samples) and a condition vector.

```R
# Example data structure
# rnaCounts: matrix of RNA-seq counts
# riboCounts: matrix of Ribo-seq counts
# conditions: factor indicating groups (e.g., c("CTL", "CTL", "TREAT", "TREAT"))
```

### 2. Run Differential Translation Analysis
The `riborex` function wraps the complexity of modeling the interaction between the sequencing types and the conditions.

```R
library(riborex)

# Using DESeq2 engine (default)
res <- riborex(rnaCounts, riboCounts, rnaCond, riboCond, engine = "DESeq2")

# Using edgeR engine
res_edgeR <- riborex(rnaCounts, riboCounts, rnaCond, riboCond, engine = "edgeR")
```

### 3. Parameters
- `rnaCounts` / `riboCounts`: Integer matrices of counts.
- `rnaCond` / `riboCond`: Factors defining the experimental groups for each library.
- `engine`: The statistical framework to use ("DESeq2", "edgeR", "vst", or "voom").
- `contrast`: A character vector defining the comparison (e.g., `c("condition", "TREAT", "CTL")`).

## Tips for Success

- **Matching IDs**: Ensure that the row names (Gene IDs) of your RNA-seq and Ribo-seq matrices are identical and in the same order.
- **Filtering**: It is often beneficial to filter out genes with very low counts across all samples before running `riborex` to improve statistical power and speed.
- **Engine Selection**: 
    - Use `DESeq2` or `edgeR` for standard replicated experiments.
    - Use `fdrtool` integration if you need to correct for potential test statistic inflation.
- **Output**: The result is typically a data frame or a results object (depending on the engine) containing log2 fold changes and p-values specifically for the differential translation effect (the interaction term).

## Reference documentation

- [CHANGELOG.md](./references/CHANGELOG.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)