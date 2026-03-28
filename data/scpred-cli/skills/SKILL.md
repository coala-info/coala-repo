---
name: scpred-cli
description: scpred-cli automates cell type classification in single-cell transcriptomic data using a low-dimensional representation of the data. Use when user asks to identify cell populations in new datasets, build custom classifiers from annotated Seurat objects, or train models to predict cell types.
homepage: https://github.com/ebi-gene-expression-group/scPred-cli
---

# scpred-cli

## Overview
The `scpred-cli` toolset is a collection of R scripts designed to automate the classification of cell types in single-cell transcriptomic data. It utilizes a low-dimensional representation of the data (Principal Components) to build high-accuracy classifiers. Use this skill when you need to project new single-cell datasets onto a trained reference model to identify cell populations, or when building custom classifiers from annotated Seurat objects in a Linux/Unix environment.

## Core Workflow

### 1. Feature Space Selection
Before training, you must identify which principal components (PCs) significantly explain the variance between cell types.

```bash
scpred_get_feature_space.R \
    --input-object reference_data.rds \
    --prediction-column cell_type \
    --output-path feature_space.rds
```
*   **Tip**: Use the `--correction-method` (default: fdr) and `--significance-threshold` to fine-tune how many PCs are retained as features.

### 2. Model Training
Train a classification model using the features identified in the previous step. `scPred` supports models available in the R `caret` package.

```bash
scpred_train_model.R \
    --input-object feature_space.rds \
    --model svmRadial \
    --num-cores 4 \
    --output-path trained_model.rds
```
*   **Expert Tip**: Enable `--allow-parallel TRUE` and specify `--num-cores` to significantly speed up the resampling and tuning process for large datasets.
*   **Validation**: Use `--train-probs-plot` to generate a PNG visualization of the training probabilities to assess model confidence.

### 3. Cell Type Prediction
Apply the trained model to a query (unlabeled) dataset.

```bash
scpred_predict.R \
    --input-object trained_model.rds \
    --pred-data query_data.rds \
    --threshold-level 0.7 \
    --output-path predictions.txt
```
*   **Critical**: If your query data is not yet processed, use `--normalise-data` and ensure the `--normalisation-method` matches exactly what was used for the reference data (e.g., `LogNormalize`).
*   **Thresholding**: The `--threshold-level` determines the confidence required to assign a label; cells below this value will be labeled as "unassigned".

### 4. Standardizing Output
Convert the prediction results into a standardized table for downstream analysis.

```bash
scpred_get_std_output.R \
    --predictions-object predictions.rds \
    --classifier trained_model.rds \
    --get-scores TRUE \
    --output-table final_results.tsv
```

## Best Practices
- **Input Format**: All input objects must be serialized Seurat or scPred objects in `.rds` format.
- **Feature Consistency**: Ensure that the reduction method (default: `pca`) used in `scpred_get_feature_space.R` exists in the input Seurat object.
- **Memory Management**: Single-cell objects can be large. When training models like `svmRadial` or `rf`, ensure your environment has sufficient RAM, especially when using parallel processing.
- **Testing**: Run `get_test_data.R` to generate a small PBMC reference and query set to verify your installation and command syntax.



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/bin/scpred_get_std_output.R | Get standard output from SCPRED predictions. |
| scpred-cli_scpred_get_feature_space.R | Get the feature space for scPred |
| scpred_predict.R | Predicts cell types using scPred. |
| scpred_train_model.R | Trains a cell type classifier using scPred. |

## Reference documentation
- [scPred-cli README](./references/github_com_ebi-gene-expression-group_scpred-cli_blob_develop_README.md)
- [Feature Space Selection Script](./references/github_com_ebi-gene-expression-group_scpred-cli_blob_develop_scpred_get_feature_space.R.md)
- [Model Training Script](./references/github_com_ebi-gene-expression-group_scpred-cli_blob_develop_scpred_train_model.R.md)
- [Prediction Script](./references/github_com_ebi-gene-expression-group_scpred-cli_blob_develop_scpred_predict.R.md)