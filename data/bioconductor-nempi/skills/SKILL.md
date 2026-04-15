---
name: bioconductor-nempi
description: This tool infers unobserved perturbations and causal networks from gene expression data using Nested Effects Models. Use when user asks to infer signaling networks between perturbed genes, predict unobserved perturbation labels in screen data, or augment perturbation profiles using downstream gene expression.
homepage: https://bioconductor.org/packages/release/bioc/html/nempi.html
---

# bioconductor-nempi

name: bioconductor-nempi
description: Inference of unobserved perturbations and causal network augmentation using gene expression data. Use when analyzing perturbation screens where some samples have unknown or incomplete perturbation labels, or when needing to infer the underlying signaling network between perturbed genes (P-genes) and their effect on downstream genes (E-genes).

# bioconductor-nempi

## Overview

The `nempi` package implements Nested Effects Model-based perturbation inference (NEM$\pi$). It is designed to handle datasets where many genes are perturbed, but not all perturbations are observed in every sample. The package iteratively infers:
1. A causal network ($\phi$) of perturbed genes (P-genes).
2. The attachment ($\theta$) of effect genes (E-genes) to P-genes.
3. A perturbation profile that augments observed data and predicts unobserved perturbations.

## Core Workflow

### 1. Data Preparation
The input should be a data matrix where:
- **Rows**: E-genes (genes showing downstream effects).
- **Columns**: Samples.
- **Column Names**: Labeled with the perturbed P-gene(s). Unlabeled samples (unobserved perturbations) should be represented by an empty string `""`.

```r
library(nempi)

# Example: data is a matrix of log-odds ratios
# colnames(data) might look like: c("GeneA", "GeneB", "", "GeneA", "")
```

### 2. Perturbation Inference
The primary function is `nempi()`. It performs the iterative inference of the network and the perturbation matrix.

```r
# Basic inference
res <- nempi(data)

# Plot results
# heatlist and barlist control the appearance of the heatmap and annotation bars
col <- rgb(seq(0,1,length.out=10), seq(1,0,length.out=10), seq(1,0,length.out=10))
plot(res, heatlist=list(col="RdBu"), barlist=list(col=col))
```

### 3. Using a Prior Matrix
If you have prior probabilistic knowledge about which genes might be perturbed in which samples, you can provide a prior matrix $\Gamma$.
- **Rows**: Potential P-genes.
- **Columns**: Samples.
- **Values**: Probabilities (columns must sum to 1).

```r
# Gamma is a P-gene x Sample matrix
res <- nempi(data, Gamma = Gamma)
```

### 4. Alternative Classification Methods
For comparison or cases where the network is sparse/disconnected, `nempi` provides `classpi()` to use standard machine learning classifiers:

```r
# Using Support Vector Machines (default)
ressvm <- classpi(data, method = "svm")

# Using Random Forest
resrf <- classpi(data, method = "randomForest")

# Using Neural Networks
resnn <- classpi(data, method = "nnet")
```

## Interpreting Results

### The Final Perturbation Matrix ($\Omega$)
The inferred perturbation matrix $\Gamma$ in the result object denotes the most upstream P-gene perturbed. To compute the final perturbation matrix $\Omega$ (accounting for downstream effects in the inferred network), use matrix multiplication with the transitive closure of the inferred adjacency matrix:

```r
# Get the adjacency matrix from the result
adj_matrix <- res$res$adj

# Compute transitive closure and multiply by inferred Gamma
library(mnem)
Omega <- t(mnem::transitive.closure(adj_matrix)) %*% res$Gamma

# Visualize the final perturbation probabilities
epiNEM::HeatmapOP(Omega, col = "RdBu", bordercol = "transparent")
```

### Evaluation
If ground truth is available (e.g., in simulated data), use `pifit()` to calculate accuracy metrics like the Area Under the Precision-Recall Curve (AUC).

```r
# fit contains the AUC and other performance metrics
fit <- pifit(res, ground_truth_object, data)
print(fit$auc)
```

## Tips
- **Network Density**: NEM$\pi$ is generally more powerful when P-genes are connected in a denser network.
- **Combinatorial Perturbations**: While NEM$\pi$ handles single perturbations well, alternative classifiers in `classpi()` may profit more from combinatorial perturbation data.
- **Data Scale**: Ensure your input data (usually log-odds) is appropriately normalized for gene expression analysis.

## Reference documentation
- [Nested Effects Models-based perturbation inference](./references/nempi.md)
- [nempi Vignette (Rmd)](./references/nempi.Rmd)