---
name: bioconductor-mlinterfaces
description: This tool provides a uniform interface for performing supervised and unsupervised machine learning on biological datasets in R. Use when user asks to train classification models, perform cross-validation, evaluate model performance with confusion matrices, or conduct clustering on ExpressionSet objects.
homepage: https://bioconductor.org/packages/release/bioc/html/MLInterfaces.html
---


# bioconductor-mlinterfaces

name: bioconductor-mlinterfaces
description: Expert guidance for using the Bioconductor package MLInterfaces for machine learning in R. Use this skill when performing supervised or unsupervised learning on biological datasets (like ExpressionSets), including classification (Random Forest, SVM, LDA, Neural Nets), clustering, and cross-validation workflows.

# bioconductor-mlinterfaces

## Overview

MLInterfaces provides a uniform interface to various R machine learning packages (like `randomForest`, `rpart`, `MASS`, `e1071`, and `nnet`). Its primary workhorse is the `MLearn` function, which standardizes the syntax for training models, making predictions, and evaluating performance across different algorithms. It is particularly well-integrated with Bioconductor's `ExpressionSet` objects but also supports standard R `data.frame` objects.

## Core Workflow: Supervised Learning

The standard pattern for classification involves using `MLearn` with a formula, a dataset, a learner schema (ending in `I`), and a training index.

### 1. Basic Classification
```R
library(MLInterfaces)
library(MASS)
data(crabs)

# Define training indices (e.g., first 120 rows)
train_idx <- 1:120

# Run Random Forest
rf_res <- MLearn(sp ~ CL + RW, data = crabs, randomForestI, train_idx, ntree = 100)

# Run Support Vector Machine
svm_res <- MLearn(sp ~ CL + RW, data = crabs, svmI, train_idx)
```

### 2. Common Learner Schemas
- `randomForestI`: Random Forest classification.
- `svmI`: Support Vector Machines.
- `ldaI` / `dldaI`: Linear Discriminant Analysis / Diagonal LDA.
- `nnetI`: Neural Networks (requires `size` and `decay` parameters).
- `rpartI`: Recursive Partitioning (Decision Trees).
- `knnI(k=3)`: K-Nearest Neighbors (parameterized).
- `glmI.logistic(thresh=0.5)`: Logistic Regression.

### 3. Evaluating Results
MLearn returns a `classifierOutput` object. Use these methods to inspect it:
- `confuMat(obj)`: Generates a confusion matrix for the test set.
- `testPredictions(obj)`: Returns the predicted classes for the test set.
- `testScores(obj)`: Returns the underlying scores/probabilities.
- `RObject(obj)`: Accesses the original model object (e.g., the `randomForest` object).

## Cross-Validation

Instead of a numeric training index, pass an `xvalSpec` object to the `trainInd` argument.

```R
# 5-fold cross-validation using LDA
cv_res <- MLearn(sp ~ CL + RW, data = crabs, ldaI, 
                xvalSpec("LOG", 5, balKfold.xvspec(5)))

confuMat(cv_res)
```

### Feature Selection in CV
You can embed feature selection within the cross-validation loop to avoid selection bias:
```R
# Select top 30 features by absolute t-statistic in each fold
fs_res <- MLearn(mol.biol ~ ., data = fusk, dldaI, 
                xvalSpec("LOG", 5, balKfold.xvspec(5), fs.absT(30)))
```

## Unsupervised Learning (Clustering)

MLInterfaces supports clustering via `MLearn` using a similar interface, typically applied to `ExpressionSet` objects.

```R
# K-means clustering on an ExpressionSet
# Note: .method uses B suffix for some clustering interfaces
km_res <- MLearn(~., eset, kmeansB, centers = 3)
```

## Working with ExpressionSets

When using genomic data, MLInterfaces handles the metadata automatically.
```R
# Predict 'mol.biol' phenotype using all features in the ExpressionSet
# trainInd can be a numeric vector of column indices
model <- MLearn(mol.biol ~ ., data = myExpressionSet, randomForestI, 1:40)
```

## Tips for Success
- **Factor Responses**: Ensure your target variable (response) is a `factor` for classification tasks.
- **Schema Parameters**: Some schemas like `knnI` or `BgbmI` are functions that return a schema; call them with parentheses: `knnI(k=5)`.
- **Parallelization**: For large cross-validations, `MLearn` can accept a `cluster` argument (from the `snow` package) to distribute tasks.
- **Custom Schemas**: Use `makeLearnerSchema` to wrap any R function that follows the formula/data idiom into the MLInterfaces framework.

## Reference documentation
- [MLInterfaces 2.0 – a new design](./references/MLint_devel.md)
- [A machine learning tutorial: applications of the Bioconductor MLInterfaces package to gene expression data](./references/MLprac2_2.md)
- [Using xval and clusters of computers for cross-validation](./references/xvalComputerClusters.md)