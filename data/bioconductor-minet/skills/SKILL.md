---
name: bioconductor-minet
description: The minet package provides a framework for inferring gene regulatory networks from expression data using mutual information and various pruning algorithms. Use when user asks to build a mutual information matrix, infer networks using ARACNE, CLR, or MRNET, and validate network performance against a gold standard.
homepage: https://bioconductor.org/packages/release/bioc/html/minet.html
---


# bioconductor-minet

## Overview
The `minet` package provides a framework for Mutual Information NETwork inference. It transforms a dataset (typically gene expression) into a network by first calculating a Mutual Information Matrix (MIM) and then applying an inference algorithm to prune edges and identify significant interactions.

## Core Workflow

### 1. Data Preparation
Input data should be a `data.frame` or `matrix` where columns are variables (genes) and rows are samples.
```r
library(minet)
data(syn.data) # Example dataset: 100 samples, 50 genes
```

### 2. Building the Mutual Information Matrix (MIM)
The MIM is the foundation for all inference methods in this package.
```r
# Using Spearman correlation (default)
mim <- build.mim(syn.data, estimator="spearman")

# Using discrete estimators (requires discretization)
mim_discrete <- build.mim(syn.data, estimator="mi.mm", disc="equalfreq", nbins=10)
```
**Estimators:**
- Correlation-based: `"pearson"`, `"spearman"`, `"kendall"`.
- Entropy-based (via `infotheo`): `"mi.empirical"`, `"mi.mm"`, `"mi.shrink"`, `"mi.sg"`.

### 3. Network Inference
You can use the wrapper function `minet()` or call specific algorithms directly.

#### The `minet` Wrapper
```r
# Default: method="mrnet", estimator="spearman"
net <- minet(syn.data)
```

#### Specific Algorithms
- **ARACNE**: Prunes the weakest edge in every triplet based on the Data Processing Inequality.
  ```r
  net_aracne <- aracne(mim, eps=0.1)
  ```
- **CLR (Context Likelihood of Relatedness)**: Normalizes MI scores based on the distribution of MI values for each node.
  ```r
  net_clr <- clr(mim)
  ```
- **MRNET / MRNETB**: Uses Maximum Relevance Minimum Redundancy (MRMR) feature selection. `mrnetb` uses backward elimination.
  ```r
  net_mrnet <- mrnet(mim)
  net_mrnetb <- mrnetb(mim)
  ```

### 4. Validation and Visualization
Compare an inferred network against a true underlying network (gold standard).

```r
data(syn.net) # True network
table <- validate(net, syn.net)

# Calculate performance metrics
auc_roc <- auc.roc(table)
auc_pr <- auc.pr(table)
f_scores <- fscores(table)

# Plotting
show.pr(table, col="blue", main="Precision-Recall Curve")
show.roc(table, col="red", main="ROC Curve")
```

## Tips for Success
- **Discretization**: If using entropy-based estimators (e.g., `mi.mm`), ensure you set the `disc` argument (e.g., `"equalfreq"`) unless your data is already discrete.
- **Network Format**: Inference functions return a weighted adjacency matrix. To visualize the graph structure, use `Rgraphviz`: `plot(as(net, "graphNEL"))`.
- **Memory**: For very large datasets, correlation-based estimators are significantly faster than entropy-based ones.

## Reference documentation
- [minet Reference Manual](./references/reference_manual.md)