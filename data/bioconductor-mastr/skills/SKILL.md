---
name: bioconductor-mastr
description: The bioconductor-mastr package automates the screening and refinement of group-specific signature genes from differential expression analysis results. Use when user asks to identify cell-type markers, refine gene signatures by removing background noise, or generate robust biomarkers using rank product scores.
homepage: https://bioconductor.org/packages/release/bioc/html/mastR.html
---

# bioconductor-mastr

name: bioconductor-mastr
description: Automated screening and refinement of signature genes (markers) from differential expression analysis results (edgeR/limma). Use when identifying group-specific biomarkers, cell-type markers, or refining gene signatures by removing tissue-specific background noise.

# bioconductor-mastr

## Overview

The `mastR` package (Markers Automated Screening Tool in R) is designed to generate refined lists of signature genes for specific groups of interest (e.g., cell types, disease states). It builds upon the `edgeR` and `limma` differential expression (DE) frameworks, using rank product scores to identify robust markers across multiple comparisons. A key feature is its ability to remove "background noise"—genes highly expressed in specific tissues or cancer cells—to improve the specificity of the final signature.

## Core Workflow

### 1. Build a Markers Pool
Define a starting set of potential markers. This can be a custom list or generated from built-in sources like MSigDB, PanglaoDB, or CIBERSORT (LM7/LM22).

```r
library(mastR)
library(GSEABase)

# Example: Get NK cell markers from CIBERSORT matrices
data("lm7", "lm22")
LM <- get_lm_sig(lm7.pattern = "^NK", lm22.pattern = "NK cells")

# Merge multiple sources into one GeneSet
Markers <- merge_markers(GeneSetCollection(c(LM)))
```

### 2. Identify Group-Specific Signatures
Process expression data and perform feature selection based on DE results.

```r
# End-to-end processing: filtering, normalization, and linear modeling
proc_data <- process_data(
  data = your_expression_data,
  group_col = "cell_type",
  target_group = "NK",
  markers = geneIds(Markers)
)

# Select signature based on rank product scores
sig_res <- select_sig(proc_data, feature_selection = "auto")
up_genes <- geneIds(sig_res[["UP"]])
```

### 3. Refine by Background Expression
Remove genes that are highly expressed in a background context (e.g., tumor cells) to ensure the signature is specific to the target group within that tissue.

```r
# Refine markers by comparing signal (target cells) vs background (e.g., CRC cell lines)
refined_markers <- remove_bg_exp_mat(
  sig_mat = proc_data$vfit$E[, proc_data$samples$cell_type == "NK"],
  bg_mat = background_matrix,
  markers = up_genes,
  gene_id = c("SYMBOL", "SYMBOL")
)
```

### 4. Integrated Wrapper
Use `filter_subset_sig()` to perform Step 2 (and optionally Step 3) in a single call, especially useful for multiple datasets.

```r
final_sig <- filter_subset_sig(
  data = list(study1 = data1, study2 = data2),
  markers = geneIds(Markers),
  group_col = "group",
  target_group = "NK",
  comb = "RRA" # Robust Rank Aggregation for multiple datasets
)
```

## Visualization

`mastR` provides several functions to validate signature performance:

- `sig_heatmap()`: Compare expression patterns of refined vs. unrefined markers.
- `sig_boxplot()`: Visualize `singscore` or median expression across groups.
- `sig_scatter_plot()`: Check specificity by plotting target group expression vs. others.
- `sig_gseaplot()`: Perform GSEA to confirm enrichment of the signature.
- `pca_matrix_plot()`: Assess group separation using the identified features.

## Tips for Success

- **Gene Identifiers**: Ensure gene IDs (e.g., ENSEMBL vs. SYMBOL) match between your data, the markers pool, and background datasets. Use the `gene_id` parameter in functions to handle mapping.
- **Pseudo-bulk**: For scRNA-seq data, use `pseudo_samples()` to aggregate cells into pseudo-bulk samples before running the `mastR` workflow.
- **Feature Selection**: If you have very few DEGs (< 5), `select_sig` will automatically switch to `feature_selection = "none"`.
- **Background Data**: You can use the built-in `CCLE` data for background removal in cancer contexts by setting `bg_data = "CCLE"` in `remove_bg_exp()`.

## Reference documentation

- [mastR: Markers Automated Screening Tool in R](./references/mastR_Demo.md)
- [mastR: Markers Automated Screening Tool in R (Rmd)](./references/mastR_Demo.Rmd)
- [Customized Design in mastR](./references/mastR_customized_design.md)
- [Customized Design in mastR (Rmd)](./references/mastR_customized_design.Rmd)