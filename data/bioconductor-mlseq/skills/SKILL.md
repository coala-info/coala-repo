---
name: bioconductor-mlseq
description: This tool performs supervised classification and machine learning analysis on raw RNA-Seq count data using a variety of discrete and continuous classifiers. Use when user asks to perform RNA-Seq data classification, train machine learning models on sequencing counts, normalize or transform gene expression data for classification, and predict class labels for test samples.
homepage: https://bioconductor.org/packages/release/bioc/html/MLSeq.html
---

# bioconductor-mlseq

name: bioconductor-mlseq
description: Machine learning interface for RNA-Seq data classification using the MLSeq Bioconductor package. Use this skill to perform supervised classification on raw RNA-Seq count data, including data preprocessing (normalization/transformation), model training with 90+ classifiers (SVM, Random Forest, PLDA, NBLDA, voom-based methods), parameter optimization via cross-validation, and predicting class labels for test samples.

## Overview

MLSeq provides a unified interface for applying machine learning algorithms to RNA-Seq count data. It bridges the gap between discrete sequencing counts and traditional microarray-based classifiers by providing specialized normalization (DESeq, TMM) and transformation (vst, rlog, log-cpm, voom) methods. It supports both discrete-based classifiers (Poisson LDA, Negative Binomial LDA) and continuous classifiers via the `caret` ecosystem.

## Core Workflow

### 1. Data Preparation
MLSeq requires input data as a `DESeqDataSet` object. Ensure counts are raw integers.

```R
library(MLSeq)
library(DESeq2)

# Create DESeqDataSet
# countData: matrix of raw counts (rows=genes, cols=samples)
# colData: DataFrame with class labels (factors)
dds <- DESeqDataSetFromMatrix(countData = counts, 
                              colData = sample_info, 
                              design = ~ condition)

# Split into training and test sets
nTest <- ceiling(ncol(dds) * 0.3)
ind <- sample(ncol(dds), nTest)
data.trainS4 <- dds[, -ind]
data.testS4 <- dds[, ind]
```

### 2. Model Building (`classify`)
The `classify` function is the primary interface for training models.

*   **Continuous Classifiers:** Require `preProcessing` (e.g., "svmRadial", "rf", "pam").
*   **Discrete Classifiers:** Use `normalize` (e.g., "PLDA", "NBLDA").
*   **Voom-based Classifiers:** Specialized for RNA-Seq (e.g., "voomNSC", "voomDLDA").

```R
# Example: SVM with rlog transformation
ctrl <- trainControl(method = "repeatedcv", number = 5, repeats = 2)
fit <- classify(data = data.trainS4, 
                method = "svmRadial", 
                preProcessing = "deseq-rlog", 
                ref = "Tumor", 
                control = ctrl)

# Example: Voom-based Nearest Shrunken Centroids (Sparse)
v_ctrl <- voomControl(tuneLength = 20)
fit_voom <- classify(data = data.trainS4, 
                     method = "voomNSC", 
                     normalize = "deseq", 
                     control = v_ctrl)
```

### 3. Control Functions
Select the correct control function based on the classifier type:
*   `trainControl()`: For most continuous/caret-based models.
*   `discreteControl()`: For "PLDA", "PLDA2", and "NBLDA".
*   `voomControl()`: For "voomDLDA", "voomDQDA", and "voomNSC".

### 4. Prediction and Evaluation
Use the `predict` function on the trained MLSeq object. The test data must also be a `DESeqDataSet`.

```R
# Predict class labels
pred <- predict(fit, data.testS4)

# Evaluate performance
library(caret)
confusionMatrix(table(Predicted = pred, Actual = data.testS4$condition))
```

### 5. Feature Selection
For sparse classifiers ("voomNSC", "pam", "PLDA"), extract the most predictive biomarkers:

```R
selectedGenes(fit_voom)
```

## Key Functions and Parameters

*   **`availableMethods()`**: Lists all 90+ supported classification algorithms.
*   **`preProcessing`**: Options include `"deseq-vst"`, `"deseq-rlog"`, `"deseq-logcpm"`, and `"tmm-logcpm"`.
*   **`update()`**: If you modify an MLSeq object (e.g., changing the method via `method(fit) <- "rf"`), you must call `fit <- update(fit)` to re-run the analysis.
*   **`trained()`**: Accesses the underlying trained model object and cross-validation results.

## Tips for Success
*   **Reference Class**: Always define the `ref` argument in `classify` to specify which factor level is the "positive" or "target" class.
*   **Data Scaling**: Do not manually normalize or transform data before passing it to `classify`; the function handles this internally to ensure the test set is scaled using training set parameters (preventing data leakage).
*   **Sparsity**: If the goal is biomarker discovery, prefer `voomNSC` or `pam` (NSC) as they perform internal feature selection.

## Reference documentation
- [MLSeq: Machine Learning Interface to RNA-Seq](./references/MLSeq.md)