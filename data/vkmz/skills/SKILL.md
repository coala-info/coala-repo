---
name: vkmz
description: vkmz transforms LC-MS feature lists into interactive van Krevelen Diagrams to facilitate the identification of chemical classes. Use when user asks to generate van Krevelen Diagrams, identify chemical classes from mass spectrometry data, or process LC-MS feature tables and molecular formulas.
homepage: https://github.com/HegemanLab/VKMZ
metadata:
  docker_image: "quay.io/biocontainers/vkmz:1.4.6--py_0"
---

# vkmz

## Overview

vkmz is a specialized tool for metabolomics that transforms LC-MS feature lists into interactive van Krevelen Diagrams. It facilitates the identification of chemical classes (such as lipids, proteins, or carbohydrates) by plotting molecules based on their oxygen-to-carbon (O:C) and hydrogen-to-carbon (H:C) ratios. The tool supports both raw mass-to-charge (m/z) data—where it predicts formulas using an internal database—and pre-annotated formula lists.

## Core Workflows

### 1. Tabular Mode (Generic LC-MS Data)
Use this mode for standard feature tables. The input file must contain the following columns: `sample_name`, `polarity`, `mz`, `rt`, and `intensity`.

```bash
vkmz tabular --input data.csv --output output_prefix --error 10
```

*   **Mass Error**: Specified in ppm (parts-per-million). For high-resolution data, 5-10 ppm is standard.
*   **Polarity**: Values must be "positive" or "negative".
*   **Neutral Mass**: If your input already contains neutral masses instead of m/z, use the `--neutral` flag.

### 2. Formula Mode (Pre-annotated Data)
Use this mode if you already have molecular formulas and simply need to generate the VKD visualization.

```bash
vkmz formula --input annotated_data.csv --output output_prefix
```

### 3. W4M-XCMS Mode
Specifically for data processed via Workflow4Metabolomics (Galaxy). Requires three distinct files.

```bash
vkmz w4m-xcms -xd datamatrix.csv -xv variableMetadata.csv -xs sampleMetadata.csv -o output_prefix -e 10
```

## Expert Tips and Best Practices

*   **Charge Handling**: By default, vkmz removes features without charge information if a charge column exists. Use `--impute-charge` (or `--impute`) to force a charge of "1" for missing values, but be aware this may increase false positives in formula prediction.
*   **Monoisotopic Filtering**: If CAMERA annotation is detected in the input, vkmz automatically filters for monoisotopic features to ensure accurate VKD plotting.
*   **Output Formats**: While the primary output is an interactive D3-based HTML page, you can export data for downstream analysis using:
    *   `--json`: Saves results in JSON format.
    *   `--sql`: Saves results to a SQLite database.
*   **Custom Databases**: You can point the tool to a custom formula-mass lookup table using `--database [PATH]`.
*   **Ambiguous Matches**: By default, vkmz picks the best match. Use the `--alternate` flag to retain features that have multiple formula predictions within the error range.



## Subcommands

| Command | Description |
|---------|-------------|
| vkmz formula | Parses a tabular formula file and outputs results in various formats. |
| vkmz w4m-xcms | Process XCMS data with various metadata and output options. |
| vkmz_tabular | Parses tabular files for mass spectrometry data. |

## Reference documentation
- [vkmz README](./references/github_com_HegemanLab_vkmz_blob_master_README.md)
- [Tabular Data Example](./references/github_com_HegemanLab_vkmz_blob_master_test-data_tabular.tabular.md)
- [Annotated Formula Example](./references/github_com_HegemanLab_vkmz_blob_master_test-data_annotation.tabular.md)