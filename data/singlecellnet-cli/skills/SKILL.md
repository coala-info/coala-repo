---
name: singlecellnet-cli
description: singlecellnet-cli constructs and applies random forest classifiers for cell type annotation in single-cell transcriptomics data. Use when user asks to train a classifier from a reference dataset or predict cell types in a query dataset.
homepage: https://github.com/ebi-gene-expression-group/singlecellnet-cli
---

# singlecellnet-cli

## Overview

The `singlecellnet-cli` provides a streamlined interface for the singleCellNet R package, enabling the construction and application of random forest classifiers specifically designed for single-cell transcriptomics. You should use this skill when you need to:
1. **Train a classifier**: Build a model using a reference dataset with known cell type annotations.
2. **Predict cell types**: Assign labels to a query dataset based on a previously trained model.

The tool is particularly robust because it uses "Top-Pair" transformation, making it less sensitive to technical variation between different datasets or species.

## Installation and Setup

The tool is available via Bioconda:
```bash
conda install singlecellnet-cli
```

## Training a Model

Use `scn-train-model.R` to generate a classifier from a reference SingleCellExperiment object.

### Required Parameters
- `--input-object`: Path to the reference SCE object (.rds).
- `--cell-type-col`: The metadata column containing ground-truth cell type labels.
- `--cell-barcode-col`: The metadata column containing unique cell identifiers.
- `--output-path`: Destination for the trained classifier (.rds).

### Expert Tips for Training
- **Data Cleaning**: The tool automatically filters out cells labeled as "unknown", "unassigned", "ambiguous", or "rand". Ensure your reference labels are clean before training.
- **Assay Selection**: The script looks for a `counts` slot first. If missing, it will attempt to use `normcounts`. Ensure your SCE object has one of these populated.
- **Feature Selection**: Adjust `--n-top-genes` (default 10) and `--n-top-gene-pairs` (default 25) to balance between classification speed and accuracy. Increasing these can improve performance on complex datasets but increases memory usage.

### Example Command
```bash
scn-train-model.R \
    --input-object reference_data.rds \
    --cell-type-col "cell_ontology_class" \
    --cell-barcode-col "barcode" \
    --n-trees 1000 \
    --output-path my_classifier.rds
```

## Predicting Cell Types

Use `scn-predict.R` to classify cells in a query dataset using your trained model.

### Required Parameters
- `--input-classifier-object`: Path to the classifier generated during the training step.
- `--query-expression-data`: Path to the query SCE object (.rds).
- `--prediction-output`: Path for the output file.

### Handling Missing Genes
A common issue in cross-platform classification is the absence of specific feature genes in the query data. `singlecellnet-cli` handles this automatically by:
1. Identifying classification genes missing from the query.
2. Performing mean imputation for those missing values to allow the classifier to proceed.

### Output Formats
- **Default (TSV)**: Produces a tab-separated table containing `cell_id`, `predicted_label`, and the classification `score`.
- **Raw (RDS)**: Use the `--return-raw-output` flag to save the full prediction matrix as an .rds file, which is useful for downstream analysis in R.

### Example Command
```bash
scn-predict.R \
    --input-classifier-object my_classifier.rds \
    --query-expression-data query_data.rds \
    --prediction-output results.tsv
```

## Best Practices
- **Dataset ID**: When training, use `--dataset-id` to tag your classifier. This ID is embedded in the prediction output headers, providing better provenance for your analysis.
- **Random Profiles**: The `--n-rand` (training) and `--n-rand-prof` (prediction) parameters control the generation of "random" cell profiles used to set a baseline for "unassigned" classifications. If you get too many false positives, consider increasing these values.
- **Memory Management**: For very large datasets, ensure your environment has sufficient RAM, as the Top-Pair transformation creates a large matrix of gene-pair comparisons.



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/bin/scn-train-model.R | Train a single cell classifier model. |
| scn-predict.R | Predict cell types using a trained classifier. |

## Reference documentation
- [singlecellnet-cli README](./references/github_com_ebi-gene-expression-group_singlecellnet-cli_blob_main_README.md)
- [Model Training Script Details](./references/github_com_ebi-gene-expression-group_singlecellnet-cli_blob_main_scn-train-model.R.md)
- [Prediction Script Details](./references/github_com_ebi-gene-expression-group_singlecellnet-cli_blob_main_scn-predict.R.md)