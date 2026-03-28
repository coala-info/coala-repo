---
name: garnett-cli
description: "Garnett-cli provides command-line tools for automated cell type classification in single-cell transcriptomics data. Use when user asks to parse expression data, transform or validate marker files, train a cell type classifier, classify cells, or export classification results."
homepage: https://github.com/ebi-gene-expression-group/garnett-cli
---


# garnett-cli

## Overview

The `garnett-cli` provides a suite of R-based command-line tools to execute the Garnett workflow for single-cell analysis. It enables researchers to move from raw expression matrices to annotated cell types by leveraging marker gene hierarchies. The toolset covers the entire pipeline: data parsing, marker file transformation and validation, model training, and cell classification.

## Core Workflow and Commands

### 1. Data Preparation
Convert 10x Genomics style data into a CellDataSet (CDS) object required for Garnett.
```bash
parse_expr_data.R --input-10x-dir <path_to_10x_dir> --output-cds <output_path.rds>
```

### 2. Marker File Management
Garnett uses a specific marker file format. If you have markers from the Single Cell Expression Atlas (SCXA), transform them first:
```bash
transform_marker_file.R \
    --input-marker-file <scxa_markers.txt> \
    --marker-list <serialized_marker_obj.rds> \
    --garnett-marker-file <output_garnett_markers.txt>
```

### 3. Marker Validation and Refinement
Before training, verify that your markers are specific to the intended cell types.
*   **Check Markers**: Evaluates marker scores and generates quality plots.
    ```bash
    garnett_check_markers.R \
        --cds-object <data.rds> \
        --marker-file-path <markers.txt> \
        --database <org.Hs.eg.db|org.Mm.eg.db> \
        --cds-gene-id-type ENSEMBL \
        --marker-file-gene-id-type SYMBOL \
        --marker-output-path <scores.txt> \
        --plot-output-path <quality_plot.png>
    ```
*   **Update Marker File**: Automatically remove markers that performed poorly in the check step.
    ```bash
    update_marker_file.R \
        --marker-list-obj <markers.rds> \
        --marker-check-file <scores.txt> \
        --updated-marker-file <refined_markers.txt>
    ```

### 4. Training and Classification
*   **Train Classifier**: Build a custom model based on your data and markers.
    ```bash
    garnett_train_classifier.R \
        --cds-object <data.rds> \
        --marker-file-path <refined_markers.txt> \
        --database <org.Hs.eg.db> \
        --output-path <classifier.rds>
    ```
*   **Classify Cells**: Apply a trained (or pre-trained) classifier to new data.
    ```bash
    garnett_classify_cells.R \
        --cds-object <query_data.rds> \
        --classifier-object <classifier.rds> \
        --database <org.Hs.eg.db>
    ```

### 5. Exporting Results
Extract classification results into a standard TSV format for downstream analysis.
```bash
garnett_get_std_output.R \
    --input-object <classified_data.rds> \
    --predicted-cell-type-field "cell_type" \
    --output-file-path <results.tsv>
```

## Expert Tips and Best Practices

*   **Database Installation**: Ensure the Bioconductor annotation database (e.g., `org.Hs.eg.db` for human, `org.Mm.eg.db` for mouse) is installed in your Conda environment before running check, train, or classify commands.
*   **Gene ID Consistency**: Always verify the `--cds-gene-id-type` and `--marker-file-gene-id-type`. Mismatches between ENSEMBL IDs and Gene Symbols are the most common cause of "zero markers found" errors.
*   **Classification Overwrites**: When running `garnett_classify_cells.R` on a CDS object that has been classified before, you must manually remove the existing classification column from the metadata if you wish to re-run the process with different parameters.
*   **Feature Investigation**: Use `garnett_get_feature_genes.R` to see which genes the model actually prioritized. This is useful for biological validation of the classifier.
    ```bash
    garnett_get_feature_genes.R --classifier-object <model.rds> --database <db> --output-path <features.txt>
    ```



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/bin/garnett_get_feature_genes.R | Get feature genes for a given classifier object. |
| /usr/local/bin/garnett_get_std_output.R | Get standard output from a CDS object |
| /usr/local/bin/transform_marker_file.R | Transforms marker gene files into a format suitable for Garnett. |
| /usr/local/bin/update_marker_file.R | Update marker gene list based on assessment file. |
| garnett-cli_garnett_check_markers.R | Check marker genes for cell types. |
| garnett_classify_cells.R | Query CDS object holding expression data to be classified |
| garnett_train_classifier.R | Train a cell type classifier using Garnett. |

## Reference documentation
- [Garnett CLI GitHub README](./references/github_com_ebi-gene-expression-group_garnett-cli_blob_develop_README.md)
- [Check Markers Script Details](./references/github_com_ebi-gene-expression-group_garnett-cli_blob_develop_garnett_check_markers.R.md)