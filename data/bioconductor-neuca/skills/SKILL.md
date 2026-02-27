---
name: bioconductor-neuca
description: NeuCA performs neural-network based cell type annotation for single-cell RNA-seq data using either standard or marker-guided hierarchical classification. Use when user asks to train a cell type classifier, predict cell labels in scRNA-seq datasets, or distinguish between highly correlated cell populations.
homepage: https://bioconductor.org/packages/3.14/bioc/html/NeuCA.html
---


# bioconductor-neuca

name: bioconductor-neuca
description: Neural-network based cell type annotation for single-cell RNA-seq data. Use this skill to train classifiers on labeled scRNA-seq datasets and predict cell labels in new datasets, especially when dealing with highly correlated cell types requiring hierarchical classification.

# bioconductor-neuca

## Overview

NeuCA (NEUral-network based Cell Annotation) is a supervised method for assigning cell type labels to single-cell RNA-seq (scRNA-seq) data. It utilizes a neural network architecture that automatically switches between a standard feed-forward network and a marker-guided hierarchical structure depending on the correlation between cell types in the training data. This makes it particularly effective for distinguishing between closely related cell populations.

## Core Workflow

### 1. Data Preparation

NeuCA requires input data to be in the `SingleCellExperiment` (SCE) format. Both the training and testing objects must have a `feature_symbol` column in their `rowData`.

```r
library(NeuCA)
library(SingleCellExperiment)

# Prepare Training Data
# Baron_counts: gene x cell matrix; Baron_true_cell_label: vector of labels
Baron_anno <- data.frame(Baron_true_cell_label, row.names = colnames(Baron_counts))
train_sce <- SingleCellExperiment(
    assays = list(normcounts = as.matrix(Baron_counts)),
    colData = Baron_anno
)
rowData(train_sce)$feature_symbol <- rownames(train_sce)
train_sce <- train_sce[!duplicated(rownames(train_sce)), ]

# Prepare Testing Data
test_sce <- SingleCellExperiment(
    assays = list(normcounts = as.matrix(Seg_counts))
)
rowData(test_sce)$feature_symbol <- rownames(test_sce)
test_sce <- test_sce[!duplicated(rownames(test_sce)), ]
```

### 2. Training and Prediction

The `NeuCA` function handles both model training and label assignment in a single step.

```r
predicted.label <- NeuCA(train = train_sce, 
                        test = test_sce,
                        model.size = "big", 
                        verbose = FALSE)
```

### 3. Model Size Selection

The `model.size` parameter controls the complexity of the neural network:

| Size | Layers | Nodes in Hidden Layers |
| :--- | :--- | :--- |
| **small** | 3 | 64 |
| **medium** | 4 | 64, 128 |
| **big** | 5 | 64, 128, 256 |

*Tip: "big" or "medium" are generally recommended for higher accuracy.*

## Interpreting Results

The output is a character vector containing the predicted cell type for each cell in the test dataset.

```r
# View first few predictions
head(predicted.label)

# Summary of predicted cell types
table(predicted.label)

# Evaluation (if true labels are known)
table(predicted.label, Seg_true_cell_label)
```

## Key Considerations

- **Dependencies**: NeuCA relies on `keras` for the neural network backend. Ensure a functional python/tensorflow environment is configured via `reticulate`.
- **Automatic Detection**: The package automatically determines if a hierarchical model is needed by calculating cell type correlations. You do not need to manually specify the hierarchy.
- **Feature Matching**: Ensure that the gene identifiers (feature symbols) used in the training set overlap significantly with those in the test set.

## Reference documentation

- [NeuCA Package User’s Guide](./references/NeuCA.md)