---
name: atlas-data-import
description: This tool retrieves single-cell RNA-seq expression data, experimental metadata, and pre-trained cell type classifiers from the EBI Gene Expression Group. Use when user asks to download experiment matrices, fetch metadata files, retrieve marker gene sets, or import machine learning classifiers for cell type annotation.
homepage: https://github.com/ebi-gene-expression-group/atlas-data-import
---

# atlas-data-import

## Overview
The `atlas-data-import` skill provides a specialized workflow for interacting with the EBI Gene Expression Group's data retrieval scripts. It enables the automated fetching of single-cell RNA-seq data, including raw or normalized counts (CPM/TPM), experimental design files, and marker gene sets. Additionally, it supports the bulk import of pre-trained machine learning classifiers used for cell type annotation across various species.

## Core Commands and Usage

### 1. Fetching Experiment Data
Use `get_experiment_data.R` to download specific study components. You must provide an accession code (e.g., E-MTAB-6912) and a matrix type.

**Basic Pattern:**
```bash
get_experiment_data.R \
    --accession-code <ACCESSION> \
    --matrix-type <raw|filtered|TPM|CPM> \
    --get-expression-data \
    --output-dir-name <DIR_NAME>
```

**High-Utility Options:**
- **Metadata Only**: Omit `--get-expression-data` and use `--get-sdrf`, `--get-condensed-sdrf`, or `--get-idf` to fetch only the experimental design and sample attributes.
- **Marker Genes**: Use `--get-marker-genes` combined with `--markers-cell-grouping` (default is "inferred_cell_type_-_ontology_labels") to retrieve cluster-specific markers.
- **10x Compatibility**: By default, expression data is stored in a `10x_data` subdirectory. Use `--exp-data-dir` to change this or `--use-default-expr-names` to avoid 10x-style naming conventions.

### 2. Importing Classifiers
Use `import_classification_data.R` to retrieve pre-trained models for cell type prediction.

**Basic Pattern:**
```bash
import_classification_data.R \
    --tool <TOOL_NAME> \
    --species <SPECIES_NAME> \
    --classifiers-output-dir <DIR_NAME>
```

**Expert Tips:**
- **Tool Selection**: Common tools supported include `scpred`.
- **Species Format**: Use underscores for species names (e.g., `mus_musculus`, `homo_sapiens`).
- **Bulk Import**: If `--accession-code` is omitted, the script attempts to download all available classifiers for the specified tool and species from the EBI FTP server.
- **Performance Metrics**: Include `--get-tool-perf-table` to download the associated p-value/performance tables for the classifiers.

## Best Practices
- **Environment Isolation**: Always run these scripts within a dedicated Conda environment to manage R dependencies like `optparse` and `workflowscriptscommon`.
- **Accession Formatting**: When requesting multiple datasets in `import_classification_data.R`, provide them as a comma-separated string without spaces.
- **Retry Logic**: The scripts include built-in retry mechanisms for downloads. If working on a restricted network, ensure the URL prefixes (defaulting to `ftp.ebi.ac.uk`) are whitelisted.
- **Row Decoration**: Use `--decorated-rows` if you require gene symbols/names instead of just Ensembl IDs in the matrix row files.



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/bin/get_experiment_data.R | Downloads data from the ArrayExpress database. |
| /usr/local/bin/import_classification_data.R | Imports classifiers for specified dataset accession codes, tools, or species. |

## Reference documentation
- [Main README](./references/github_com_ebi-gene-expression-group_atlas-data-import_blob_develop_README.md)
- [Experiment Data Script Reference](./references/github_com_ebi-gene-expression-group_atlas-data-import_blob_develop_get_experiment_data.R.md)
- [Classification Data Script Reference](./references/github_com_ebi-gene-expression-group_atlas-data-import_blob_develop_import_classification_data.R.md)