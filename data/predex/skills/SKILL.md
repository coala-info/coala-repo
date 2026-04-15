---
name: predex
description: Predex is a data preprocessing utility that prepares expression matrices and sequencing data for differential gene expression analysis. Use when user asks to format count data for the dgeAnalysis pipeline, process IPA files, perform sample comparisons, or generate experimental designs and annotations.
homepage: https://github.com/tomkuipers1402/predex
metadata:
  docker_image: "quay.io/biocontainers/predex:0.9.3--pyh5e36f6f_0"
---

# predex

## Overview
Predex is a specialized data preprocessing utility designed to bridge the gap between raw sequencing outputs and downstream differential gene expression (DGE) analysis. It streamlines the preparation of expression matrices, ensuring that data structures, gene identifiers, and file formats are compatible with the dgeAnalysis framework developed by LUMC. It is particularly useful for researchers needing to clean count data or integrate IPA-specific processing into their bioinformatics workflows.

## CLI Usage and Patterns

### Basic Data Preparation
The primary function of predex is to take raw expression data and format it for the dgeAnalysis pipeline.

```bash
# Standard execution to prepare a dataset
predex [INPUT_FILE] [OUTPUT_DIRECTORY]
```

### IPA (Ingenuity Pathway Analysis) Processing
Predex includes specific logic for handling IPA files, which often require unique parsing to extract relevant expression values and metadata.

```bash
# Process IPA-specific data
predex --ipa [IPA_INPUT_FILE] [OUTPUT_DIRECTORY]
```

### Common Workflow Patterns
1.  **Validation**: Before running full DGE pipelines, use predex to ensure your count matrix headers and gene IDs are correctly formatted.
2.  **LUMC Pipeline Integration**: Predex is the standard entry point for data destined for the LUMC `dgeAnalysis` toolset.
3.  **Batch Processing**: While predex typically handles individual datasets, it can be wrapped in shell loops to process multiple samples into a unified directory structure.

## Expert Tips
*   **Output Structure**: Predex creates a structured output directory. Ensure the target directory is empty or new to avoid file permission conflicts or data mixing.
*   **Gene ID Consistency**: Ensure your input files use consistent naming conventions (e.g., Ensembl IDs or Gene Symbols) as predex relies on these for proper mapping during the preparation phase.
*   **Environment Setup**: Since predex is available via Bioconda, it is best used within a dedicated Conda environment to manage dependencies like Python 3.x and specific bioinformatics libraries.



## Subcommands

| Command | Description |
|---------|-------------|
| predex comparison | Perform comparisons between samples based on a design matrix and a specified column. |
| predex ipa | Input dir with IPA downloaded table |
| predex_annotation | Perform annotation using predex. |
| predex_design | Design experiment based on input count matrix. |

## Reference documentation
- [github_com_tomkuipers1402_predex.md](./references/github_com_tomkuipers1402_predex.md)
- [github_com_tomkuipers1402_predex_blob_master_README.rst.md](./references/github_com_tomkuipers1402_predex_blob_master_README.rst.md)
- [github_com_tomkuipers1402_predex_blob_master_HISTORY.rst.md](./references/github_com_tomkuipers1402_predex_blob_master_HISTORY.rst.md)