---
name: r-immunedeconv
description: The r-immunedeconv package provides a unified interface to multiple algorithms for estimating immune cell fractions from gene expression data. Use when user asks to estimate immune cell infiltration, perform deconvolution on human or mouse transcriptomic data, or calculate tumor purity scores.
homepage: https://cran.r-project.org/web/packages/immunedeconv/index.html
---


# r-immunedeconv

## Overview

The `immunedeconv` R package provides a standardized, easy-to-use interface to several state-of-the-art immune deconvolution algorithms. It simplifies the process of running different methods by handling gene symbol conversions and providing a uniform output format.

## Installation

To install the package from GitHub (recommended for the latest version):

```R
install.packages("remotes")
remotes::install_github("omnideconv/immunedeconv")
```

## Main Functions

### Human Data Deconvolution
The primary function is `deconvolute()`. It requires a gene expression matrix with HGNC gene symbols as rownames and sample names as colnames.

```R
# Basic usage
res <- immunedeconv::deconvolute(gene_expression_matrix, "quantiseq")
```

**Supported Methods:**
- `quantiseq`: Best for absolute fractions and intra-sample comparison.
- `timer`: Specifically designed for TCGA data.
- `cibersort` / `cibersort_abs`: Requires a license from Stanford.
- `mcp_counter`: Provides scores (not fractions) for inter-sample comparison.
- `xcell`: Provides scores for 64 cell types.
- `epic`: Estimates fractions including "other" (non-immune) cells.
- `abis`: Absolute deconvolution of immune cell types.
- `consensus_tme`: Consensus method for the tumor microenvironment.

### Mouse Data Deconvolution
Use `deconvolute_mouse()` with MGI gene symbols.

```R
res_mouse <- immunedeconv::deconvolute_mouse(gene_expression_matrix, "mmcp_counter")
```

**Supported Mouse Methods:** `mmcp_counter`, `seqimmucc`, `dcq`, `base`.

### Tumor Purity (ESTIMATE)
To calculate scores for stromal and immune infiltration and estimate tumor purity:

```R
purity_scores <- immunedeconv::deconvolute_estimate(gene_expression_matrix)
```

## Workflows

### 1. Standard Deconvolution Pipeline
1. Prepare a matrix where rows are Gene Symbols and columns are Samples.
2. Ensure data is in appropriate scale (usually TPM or linear scale; `quantiseq` and `epic` expect non-log data).
3. Run `deconvolute()`.
4. Visualize results (the output is a long-format tibble).

### 2. Mouse to Human Conversion
If you want to use human-calibrated methods on mouse data:

```R
# Convert mouse MGI symbols to human HGNC orthologs
gene_expression_matrix_human <- immunedeconv::mouse_genes_to_human(gene_expression_matrix)
# Run human method
res <- immunedeconv::deconvolute(gene_expression_matrix_human, "epic")
```

### 3. Custom Signatures
Certain methods allow user-provided signature matrices:
- `deconvolute_base_custom()`
- `deconvolute_cibersort_custom()`
- `deconvolute_epic_custom()`
- `deconvolute_consensus_tme_custom()`

## Tips
- **Gene Symbols:** Always ensure rownames are Gene Symbols. If you have Ensembl IDs, convert them first using `biomaRt`.
- **Data Scaling:** Most methods expect TPM or similar normalized values. Avoid using log-transformed data as input for `quantiseq`, `epic`, and `cibersort`.
- **CIBERSORT:** To use CIBERSORT, you must download `CIBERSORT.R` and the signature matrix from the official website and point the package to the file path using `set_cibersort_binary()` and `set_cibersort_mat()`.

## Reference documentation
- [CONTRIBUTING.md](./references/CONTRIBUTING.md)
- [LICENSE.md](./references/LICENSE.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)