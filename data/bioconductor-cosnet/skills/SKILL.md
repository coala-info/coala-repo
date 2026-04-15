---
name: bioconductor-cosnet
description: This tool predicts binary labels in partially-labeled graphs using a cost-sensitive Hopfield network designed for highly imbalanced datasets. Use when user asks to classify nodes in a graph, predict gene functions, categorize drugs, or rank unlabeled nodes in a network.
homepage: https://bioconductor.org/packages/release/bioc/html/COSNet.html
---

# bioconductor-cosnet

name: bioconductor-cosnet
description: Predicts binary labels in partially-labeled graphs using a cost-sensitive Hopfield network. Use this skill when you need to classify nodes in a graph (e.g., gene function prediction, drug categorization) where labels are highly unbalanced (few positives vs. many negatives). It supports semi-supervised learning, cross-validation, and ranking of unlabeled nodes.

# bioconductor-cosnet

## Overview
COSNet (Cost-Sensitive Network) is an R package designed for semi-supervised node label prediction in graphs. It is particularly effective for "imbalanced" datasets where the positive class is a small minority. The algorithm transforms the graph into a parametric Hopfield network, learns optimal activation parameters ($\alpha$ and $\gamma$) to handle the class imbalance, and reaches an equilibrium state to infer labels for unknown nodes.

## Core Workflow

### 1. Data Preparation
COSNet requires a symmetric similarity matrix $W$ (values in $[0, 1]$) and a labeling vector or matrix.
- **Similarity Matrix**: A square matrix where $W_{ij}$ represents the similarity between node $i$ and $j$.
- **Labels**: Binary labels must be coded as $\{1, -1\}$ for known nodes and $0$ for unlabeled nodes.

```r
library(COSNet)
# Example: Convert 0/1 labels to 1/-1 for COSNet
labels[labels == 0] <- -1
# Hide labels for the test set by setting them to 0
labels[test_indices] <- 0
```

### 2. Automated Prediction (High-Level)
The simplest way to use COSNet is through the high-level wrapper or cross-validation functions.

```r
# Single run on a specific labeling
# W: similarity matrix, labels: vector with {1, -1, 0}
results <- COSNet(W, labels, cost = 0.0001)

# 5-fold Cross-validation
# labeling: matrix where columns are different classes
out <- cosnet.cross.validation(labeling, W, 5, cost = 0.0001)
```

### 3. Manual Parameter Learning (Low-Level)
For more control, you can separate the parameter learning from the network execution.

```r
# 1. Generate 2D projections for training
# training_labels should contain 1, -1, and 0 for the test set
points <- generate_points(W, test_indices, training_labels)

# 2. Optimize alpha and gamma parameters
opt <- optimizep(points$pos_vect[train_indices], 
                 points$neg_vect[train_indices], 
                 training_labels[train_indices])

# 3. Run the sub-network to infer labels for the 0-labeled nodes
res <- runSubnet(W, training_labels, opt$alpha, opt$c, cost = 0.0001)
```

## Interpreting Results
The output (from `COSNet` or `runSubnet`) typically contains:
- `state`: Predicted binary labels (1 or -1).
- `scores`: Ranking scores based on internal energy at equilibrium. Higher scores indicate higher confidence in the positive class.
- `alpha` / `c`: The learned activation values and thresholds.

## Performance Evaluation
Since COSNet is often used for imbalanced data, use the `PerfMeas` package to evaluate results via F-score, AUC, or Precision at Recall (PxR).

```r
library(PerfMeas)
# AUC for a single class
auc_val <- AUC.single(res$scores, ground_truth_labels)

# F-measure
f_val <- F.measure.single(res$state, ground_truth_labels)
```

## Tips
- **Cost Parameter**: The `cost` parameter regularizes the model. Small values (e.g., 0.0001) often improve generalization.
- **Imbalance**: COSNet is specifically designed for cases where the positive class is rare. If your classes are balanced, standard graph-based methods might suffice, but COSNet will still function.
- **Input Matrix**: Ensure the similarity matrix $W$ is symmetric and has a null diagonal.

## Reference documentation
- [COSNet: An R Package for Predicting Binary Labels in Partially-Labeled Graphs](./references/COSNet_v.md)