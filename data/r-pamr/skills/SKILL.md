---
name: r-pamr
description: Some functions for sample classification in microarrays.</p>
homepage: https://cloud.r-project.org/web/packages/pamr/index.html
---

# r-pamr

name: r-pamr
description: Statistical technique for class prediction and feature selection in high-dimensional data, specifically microarrays. Use when performing Nearest Shrunken Centroids classification, identifying diagnostic gene sets, or conducting cross-validation for threshold selection in genomic datasets.

# r-pamr

## Overview
The `pamr` package implements the Nearest Shrunken Centroids method for classifying samples based on gene expression profiles. It identifies a subset of genes that best characterize each class and provides tools for cross-validation, visualization of centroids, and prediction on new datasets.

## Installation
Install the package from CRAN:
```R
install.packages("pamr")
library(pamr)
```

## Core Workflow

### 1. Data Preparation
The package requires data in a specific list format.
- `x`: A matrix of expression data (genes in rows, samples in columns).
- `y`: A vector of class labels.
- `genenames` (optional): Vector of gene names.
- `geneid` (optional): Vector of gene identifiers.

```R
# Example structure
mydata <- list(x = expression_matrix, y = class_labels, 
               genenames = row.names(expression_matrix), 
               geneid = as.character(1:nrow(expression_matrix)))
```

### 2. Training and Cross-Validation
Train the model and use cross-validation to determine the optimal shrinkage threshold.

```R
# Train the model
train_results <- pamr.train(mydata)

# Perform cross-validation
cv_results <- pamr.cv(train_results, mydata)

# Plot CV results to find the threshold with minimum error
pamr.plotcv(cv_results)
```

### 3. Threshold Selection and Gene Identification
Select a threshold (delta) that balances classification error and the number of genes included.

```R
# Define threshold
threshold <- 2.0 

# List significant genes at this threshold
pamr.listgenes(train_results, mydata, threshold = threshold)

# Plot the centroids
pamr.plotcentroid(train_results, mydata, threshold = threshold)
```

### 4. Prediction
Apply the trained model to new data. New data must be a matrix with the same number of rows (genes) as the training data.

```R
# Predict classes for new samples
predictions <- pamr.predict(train_results, new_data_matrix, threshold = threshold)

# Get class probabilities
probabilities <- pamr.predict(train_results, new_data_matrix, 
                              threshold = threshold, type = "posterior")
```

## Key Functions
- `pamr.train()`: Computes the centroids and shrunken centroids.
- `pamr.cv()`: Computes K-fold cross-validation for a range of threshold values.
- `pamr.plotcv()`: Visualizes the error rate and number of genes vs. threshold.
- `pamr.predict()`: Classifies new samples or extracts posterior probabilities.
- `pamr.listgenes()`: Returns a table of genes that survive the shrinkage threshold.
- `pamr.plotcen()`: Plots the shrunken centroids for each class.
- `pamr.makeconfmat()`: Generates a confusion matrix from CV or prediction results.

## Tips
- **Missing Values**: Use `pamr.knnimpute(mydata)` to fill missing values using K-nearest neighbors before training.
- **Gene Selection**: A higher threshold (delta) results in fewer genes being used for classification.
- **Batch Effects**: Ensure data is normalized and batch-corrected before using `pamr`, as the algorithm is sensitive to systematic biases.

## Reference documentation
- [README](./references/README.html.md)
- [Home Page](./references/home_page.md)