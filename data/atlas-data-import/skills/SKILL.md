---
name: atlas-data-import
description: This tool fetches standardized expression matrices, metadata, and cell-type classifiers directly from the Single Cell Expression Atlas. Use when user asks to download experiment data, retrieve marker genes, or import pre-trained classification models and performance metrics.
homepage: https://github.com/ebi-gene-expression-group/atlas-data-import
---


# atlas-data-import

## Overview
The `atlas-data-import` tool provides a suite of R scripts designed to interface with the Single Cell Expression Atlas. It allows researchers to bypass manual downloads by fetching standardized expression matrices and experimental metadata directly via the command line. It is particularly useful for large-scale meta-analyses or when building automated pipelines that require specific versions of experiment data or cell-type classifiers.

## Installation
Install the package via Bioconda. It is recommended to use a dedicated environment to avoid dependency conflicts:
```bash
conda create -n atlas-import
conda activate atlas-import
conda install -c bioconda atlas-data-import
```

## Core Workflows

### 1. Fetching Experiment Data
Use `get_experiment_data.R` to download specific components of a dataset.

**Basic usage (Expression + Metadata):**
```bash
get_experiment_data.R --accession-code E-MTAB-5061 \
                      --get-expression-data TRUE \
                      --get-sdrf TRUE \
                      --output-dir-name ./data_output
```

**Advanced Data Retrieval:**
*   **Marker Genes:** Set `--get-marker-genes TRUE` and specify the grouping type with `--markers-cell-grouping` (e.g., 'inferred_cell_type_-_ontology_labels').
*   **Matrix Types:** Use `--matrix-type` to specify the format (e.g., 'raw' or 'filtered').
*   **Naming:** Use `--use-default-names TRUE` to keep the original Atlas filenames, or `--use-full-names TRUE` for descriptive non-expression filenames.

### 2. Importing Classifiers
Use `import_classification_data.R` to retrieve pre-trained cell-type classifiers and performance tables.

**Download classifiers for specific studies:**
```bash
import_classification_data.R --accession-code E-MTAB-5061,E-GEOD-81608 \
                             --tool scpred \
                             --species "Homo sapiens" \
                             --classifiers-output-dir ./classifiers
```

**Retrieve Performance Metrics:**
To evaluate the reliability of the imported classifiers, include the performance table flag:
```bash
import_classification_data.R --accession-code E-MTAB-5061 \
                             --get-tool-perf-table TRUE \
                             --tool-perf-table-output-path ./metrics.txt
```

## Expert Tips & Best Practices
*   **Accession Codes:** Always verify the accession code on the [SCXA website](https://www.ebi.ac.uk/gxa/sc/home) before running scripts to ensure the dataset is public and available.
*   **Condensed SDRF:** When fetching metadata, prefer `--get-condensed-sdrf TRUE` if you only need the experimental variables and cell attributes, as the full SDRF can be significantly larger and contains technical processing metadata.
*   **Directory Management:** The scripts will not error if a directory already exists, but they may overwrite files. Always specify a unique `--output-dir-name` for different experiments to prevent data mixing.
*   **Species Formatting:** When using `import_classification_data.R`, ensure the `--species` string matches the scientific name used in the Atlas (e.g., "Mus musculus" instead of "mouse").

## Reference documentation
- [atlas-data-import GitHub Repository](./references/github_com_ebi-gene-expression-group_atlas-data-import.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_atlas-data-import_overview.md)