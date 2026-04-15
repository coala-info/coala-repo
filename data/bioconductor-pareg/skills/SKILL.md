---
name: bioconductor-pareg
description: This tool performs pathway enrichment analysis by regressing gene-level differential expression p-values on pathway membership using a regularized generalized linear model. Use when user asks to estimate pathway enrichment scores, account for pathway-pathway similarities using network regularization, or handle overlapping biological terms in enrichment results.
homepage: https://bioconductor.org/packages/3.16/bioc/html/pareg.html
---

# bioconductor-pareg

name: bioconductor-pareg
description: Perform pathway enrichment analysis using the pareg R package. Use this skill when you need to estimate pathway enrichment scores by regressing gene-level differential expression p-values on pathway membership. It is particularly useful for modular enrichment analysis where pathway-pathway similarities (network regularization) are used to account for overlapping biological terms.

# bioconductor-pareg

## Overview

The `pareg` package implements a regularized generalized linear model to estimate pathway enrichment. Unlike traditional over-representation analysis, it regresses differential expression p-values of all genes on their membership in biological pathways. It incorporates LASSO and network-based regularization, where the network is defined by pathway similarities (e.g., Jaccard index). This approach helps handle the redundancy often found in pathway databases.

## Installation

```r
if (!require("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
BiocManager::install("pareg")
```

## Core Workflow

### 1. Prepare Input Data
You need two primary data frames:
- **Study Data**: A data frame with columns `gene` and `pvalue`.
- **Term Data**: A data frame with columns `term` (pathway name) and `gene` defining the gene sets.

### 2. Compute Pathway Similarities
To use network regularization, compute a similarity matrix between pathways.

```r
library(pareg)

# Compute Jaccard similarity between terms
mat_similarities <- compute_term_similarities(
  df_terms,
  similarity_function = jaccard
)
```

### 3. Run Enrichment Analysis
The `pareg` function fits the model. The `network_param` controls the strength of the network regularization (0 to 1).

```r
fit <- pareg(
  df_study[, c("gene", "pvalue")],
  df_terms,
  network_param = 1,
  term_network = mat_similarities
)
```

### 4. Inspect and Visualize Results
Results can be extracted as a data frame or visualized using built-in plotting or `enrichplot` integration.

```r
# Get enrichment scores
results <- as.data.frame(fit)

# Basic network plot
plot(fit, min_similarity = 0.1)

# Integration with enrichplot
library(enrichplot)
obj <- as_enrichplot_object(fit)
dotplot(obj)
treeplot(obj)
```

## Advanced Usage

### Pre-computed Similarities
The package provides pre-computed similarity matrices for common databases like KEGG and GO.

```r
data(pathway_similarities, package = "pareg")
# Access KEGG Jaccard similarities
kegg_sim <- pathway_similarities$`C2@CP:KEGG`$jaccard %>% as_dense_sim()
```

### Regularization Tuning
- **LASSO**: Always applied to encourage sparsity in enriched pathways.
- **Network Regularization**: Controlled by `network_param`. If `term_network` is provided, it encourages similar pathways to have similar enrichment scores.

## Tips
- Ensure gene identifiers in `df_study` and `df_terms` match exactly.
- P-values should be raw (not adjusted), as the model handles the distribution internally (typically using a Beta distribution logic).
- For large pathway databases, computing the similarity matrix can be memory-intensive; consider using the pre-computed matrices if applicable.

## Reference documentation

- [Get started](./references/pareg.md)
- [Pathway similarities](./references/pathway_similarities.md)
- [Get started (Rmd)](./references/pareg.Rmd)
- [Pathway similarities (Rmd)](./references/pathway_similarities.Rmd)