---
name: bioconductor-predictionet
description: This tool infers predictive gene interaction networks by integrating prior biological knowledge with high-dimensional genomic expression data. Use when user asks to perform regression-based network inference, assess edge stability through cross-validation, calculate gene-specific prediction scores, or export networks for visualization.
homepage: https://bioconductor.org/packages/3.8/bioc/html/predictionet.html
---


# bioconductor-predictionet

name: bioconductor-predictionet
description: Inferring predictive networks from high-dimensional genomic data by combining prior biological knowledge and gene expression data. Use this skill when you need to perform regression-based network inference, assess edge stability, calculate gene-specific prediction scores, or export networks for visualization in Cytoscape.

# bioconductor-predictionet

## Overview
The `predictionet` package provides a framework for inferring gene interaction networks. It is unique in its ability to integrate prior knowledge (e.g., from literature or databases) with experimental gene expression data using a regression-based approach. It supports causality inference, cross-validation for stability assessment, and predictive modeling to estimate how well parent genes explain the expression of their children.

## Core Workflow

### 1. Data Preparation
The package requires gene expression data (continuous or categorical) and, optionally, a prior knowledge matrix.
- **Expression Data**: A matrix with observations in rows and genes in columns.
- **Priors**: A square matrix where $P_{ij}$ represents the prior evidence for an interaction from gene $i$ to gene $j$.

### 2. Network Inference
The primary function is `netinf`. It combines Maximum Relevance Minimum Redundancy (MRMR) feature selection with causality inference.

```r
library(predictionet)

# Basic inference using data and priors
# priors.weight: 0 (data only) to 1 (priors only)
mynet <- netinf(
  data = expression_matrix, 
  priors = prior_matrix, 
  priors.count = TRUE, 
  priors.weight = 0.5, 
  maxparents = 4, 
  method = "regrnet", 
  causal = TRUE
)

# Access the adjacency matrix
topology <- mynet$topology
```

### 3. Stability and Performance Assessment
Use `netinf.cv` to perform cross-validation. This assesses how robust the edges are and provides prediction scores (R², NRMSE, MCC).

```r
# 10-fold cross-validation
cv_res <- netinf.cv(
  data = expression_matrix, 
  priors = prior_matrix, 
  nfold = 10,
  priors.weight = 0.5,
  maxparents = 4
)

# Edge stability (frequency of edge appearance across folds)
stability <- cv_res$edge.stability

# Gene-specific prediction scores (e.g., R-squared)
r2_scores <- apply(cv_res$prediction.score.cv$r2, 2, mean, na.rm = TRUE)
```

### 4. Independent Validation
To test a model on a new dataset:
1. Convert the network to a predictive model using `net2pred`.
2. Predict expression in the new data using `netinf.predict`.
3. Score the predictions using `pred.score`.

```r
# Fit regression models to the topology
pred_model <- net2pred(net = mynet, data = training_data, method = "linear")

# Predict on new data
predictions <- netinf.predict(net = pred_model, data = test_data)

# Calculate performance (MCC or R2)
mcc_scores <- pred.score(data = test_data, pred = predictions, method = "mcc", categories = 3)
```

### 5. Visualization and Export
While standard R `network` plots work, `predictionet` supports exporting to GML for Cytoscape.

```r
# Export to GML and a properties file for Cytoscape
netinf2gml(object = cv_res, file = "my_network_results")
```

## Key Parameters for `netinf`
- `categories`: Number of bins for discretization (if data is continuous and categorical inference is desired).
- `priors.count`: Set to `TRUE` if priors are raw counts (citations); the package will scale them.
- `maxparents`: Limits the complexity of the network by restricting the number of incoming edges per gene.
- `causal`: If `TRUE`, uses the "explaining away" effect (interaction information) to orient edges.

## Reference documentation
- [predictionet](./references/predictionet.md)