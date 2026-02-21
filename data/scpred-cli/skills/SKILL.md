---
name: scpred-cli
description: The `scpred-cli` toolset provides a modular command-line interface for the scPred R package, enabling automated cell-type annotation workflows.
homepage: https://github.com/ebi-gene-expression-group/scPred-cli
---

# scpred-cli

## Overview
The `scpred-cli` toolset provides a modular command-line interface for the scPred R package, enabling automated cell-type annotation workflows. It is used to identify principal components that best discriminate cell types, train classifiers on reference datasets, and project those labels onto query datasets. This skill is essential for bioinformaticians needing to execute scPred tasks within shell environments or automated pipelines without writing custom R scripts.

## Core Workflow

### 1. Feature Space Selection
Identify the principal components (PCs) that will serve as features for the classification model.
```bash
scpred_get_feature_space.R \
  --input-object reference_seurat.rds \
  --prediction-column cell_type \
  --output-path feature_space.rds
```
*   **Tip**: Use `--correction` (default: fdr) and `--significance-threshold` to tune the sensitivity of PC selection.

### 2. Model Training
Train a classification model using the selected feature space.
```bash
scpred_train_model.R \
  --input-object feature_space.rds \
  --model svmRadial \
  --num-cores 4 \
  --output-path trained_model.rds
```
*   **Best Practice**: Enable `--allow-parallel TRUE` and specify `--num-cores` to significantly speed up the training process for large datasets.
*   **Model Selection**: Any model supported by the R `caret` package can be used (e.g., `rf`, `svmRadial`, `knn`).

### 3. Cell Type Prediction
Apply the trained model to a new (query) dataset.
```bash
scpred_predict.R \
  --input-object trained_model.rds \
  --pred-data query_dataset.rds \
  --normalise-data TRUE \
  --output-path predictions.rds
```
*   **Critical**: If `--normalise-data` is set to TRUE, the `--normalisation-method` must be identical to the one used for the reference data (default: `LogNormalize`).

### 4. Standardizing Output
Convert the prediction object into a flat, readable text table for downstream analysis.
```bash
scpred_get_std_output.R \
  --predictions-object predictions.rds \
  --classifier trained_model.rds \
  --output-table final_assignments.tsv
```

## Expert Tips
- **Input Formats**: All input objects must be serialized R objects (`.rds`). Ensure your Seurat objects are saved using `saveRDS()`.
- **Memory Management**: Single-cell objects can be large. Ensure your environment has sufficient RAM, especially during the `scpred_train_model.R` step.
- **Evaluation**: Use the `--train-probs-plot` flag in the training step to generate a PNG visualization of the model's performance on the training set.
- **Thresholding**: In `scpred_predict.R`, use `--threshold-level` to adjust the confidence required for a cell to be assigned a label; cells below this threshold will be labeled as "unassigned".

## Reference documentation
- [scPred-cli GitHub Repository](./references/github_com_ebi-gene-expression-group_scpred-cli.md)