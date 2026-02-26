---
name: garnett-cli
description: The garnett-cli tool provides a suite of R-based wrapper scripts for classifying and annotating cell types in single-cell RNA-seq data. Use when user asks to convert 10x Genomics data to CDS format, validate marker gene quality, train custom classifiers, or classify cells based on expression profiles.
homepage: https://github.com/ebi-gene-expression-group/garnett-cli
---


# garnett-cli

## Overview

The `garnett-cli` tool provides a suite of R-based wrapper scripts for the Garnett scRNA-seq classification framework. It enables researchers to move from raw expression data to annotated cell types through a structured pipeline. Key capabilities include converting 10x Genomics data into CellDataSet (CDS) objects, verifying the quality of marker genes against specific datasets, training custom classifiers, and generating standardized output tables for downstream analysis.

## Core Workflow and Commands

### 1. Data Preparation
Convert raw 10x-style expression data into the required CDS format (.rds).

```bash
parse_expr_data.R --input-10x-dir <path_to_10x_dir> --output-cds <output_file.rds>
```

### 2. Marker Gene Management
Garnett requires a specific marker file format. You can transform existing marker lists or validate them against your data.

*   **Transform SCXA markers**:
    ```bash
    transform_marker_file.R --input-marker-file <scxa_file> --marker-list <serialized_obj> --garnett-marker-file <output.txt>
    ```
*   **Check Marker Quality**: Essential for verifying that markers accurately represent cell types in your specific dataset.
    ```bash
    garnett_check_markers.R --cds-object <data.rds> --marker-file-path <markers.txt> --database <org.db_package> --cds-gene-id-type <ID_type> --marker-file-gene-id-type <ID_type> --marker-output-path <analysis.txt> --plot-output-path <plot.png>
    ```
*   **Prune Markers**: Automatically remove suboptimal markers identified in the check step.
    ```bash
    update_marker_file.R --marker-list-obj <serialized_obj> --marker-check-file <analysis.txt> --updated-marker-file <clean_markers.txt>
    ```

### 3. Training and Classification
Train a model de novo or apply an existing classifier to your cells.

*   **Train**:
    ```bash
    garnett_train_classifier.R --cds-object <data.rds> --marker-file-path <markers.txt> --database <org.db_package> --output-path <classifier.rds>
    ```
*   **Classify**:
    ```bash
    garnett_classify_cells.R --cds-object <data.rds> --classifier-object <classifier.rds> --database <org.db_package>
    ```

### 4. Results Extraction
Extract the classification results into a standard TSV format.

```bash
garnett_get_std_output.R --input-object <classified_data.rds> --cell-id-field <id_col> --predicted-cell-type-field <prediction_col> --output-file-path <results.tsv>
```

## Expert Tips and Best Practices

*   **Database Installation**: Before running commands, ensure the relevant Bioconductor annotation database (e.g., `org.Hs.eg.db` for human or `org.Mm.eg.db` for mouse) is installed in your Conda environment.
*   **Gene ID Consistency**: Ensure `--cds-gene-id-type` and `--marker-file-gene-id-type` match your data (e.g., "ENSEMBL" or "SYMBOL"). Mismatched IDs are the most common cause of classification failure.
*   **Classification Overwrites**: If repeating classification on the same CDS object, you must manually delete the previous classification column from the metadata before re-running `garnett_classify_cells.R`.
*   **Feature Inspection**: Use `garnett_get_feature_genes.R` to see which genes the model actually prioritized for classification to ensure biological relevance.
*   **Post-Install Test**: Verify your installation by running:
    ```bash
    garnett-cli-post-install-tests.sh 'test' 'false'
    ```

## Reference documentation
- [Garnett-cli GitHub Repository](./references/github_com_ebi-gene-expression-group_garnett-cli.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_garnett-cli_overview.md)