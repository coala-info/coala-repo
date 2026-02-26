---
name: vkmz
description: vkmz visualizes and annotates metabolomics LC-MS data using van Krevelen Diagrams. Use when user asks to visualize metabolomics data, generate van Krevelen Diagrams, predict molecular formulas, process LC-MS feature lists, or visualize data that already has molecular formulas.
homepage: https://github.com/HegemanLab/VKMZ
---


# vkmz

## Overview

vkmz is a specialized visualization and annotation tool for metabolomics research. It transforms LC-MS feature data into van Krevelen Diagrams (VKD), which plot molecules based on their elemental ratios (typically O:C vs H:C). This allows for the rapid identification of biochemical families such as lipids, proteins, or carbohydrates within a sample. The tool can perform formula prediction by matching neutral masses against a lookup table or visualize data that has already been annotated with molecular formulas.

## Core Workflows

### 1. Tabular Mode (Generic Data)
Use this mode for standard LC-MS feature lists. The input file must contain columns for `sample_name`, `polarity`, `mz`, `rt`, and `intensity`.

```bash
vkmz tabular --input data.csv --output output_dir --error 10
```

*   **Mass Error**: Specified in ppm via `--error`. Adjust based on your instrument's mass accuracy (e.g., 5-10 ppm for Orbitrap/FT-ICR).
*   **Polarity**: If your file lacks a polarity column, force it using `--polarity positive` or `--polarity negative`.
*   **Neutral Mass**: If your input already contains neutral masses instead of m/z, use the `--neutral` flag.

### 2. W4M-XCMS Mode
Use this mode when working with outputs from Workflow4Metabolomics (Galaxy). It requires three specific files: the data matrix, variable metadata, and sample metadata.

```bash
vkmz w4m-xcms -xd datamatrix.tab -xv variableMetadata.tab -xs sampleMetadata.tab -o output_dir -e 10 --impute
```

*   **Charge Imputation**: Use `--impute` (or `--impute-charge`) to assume a charge of 1 for features missing annotation. Without this, features lacking charge info are discarded.

### 3. Formula Mode
Use this mode if you already have molecular formulas (e.g., from Sirius or other annotation software) and only need to generate the VKD.

```bash
vkmz formula -i annotated_data.csv -o output_dir
```

## Expert Tips and Best Practices

*   **Handling Multiple Predictions**: By default, vkmz may filter ambiguous matches. Use the `--alternate` flag in tabular mode to keep features that match multiple potential formula predictions.
*   **Output Formats**: Beyond the interactive HTML VKD, you can export data for downstream analysis using `--json` or `--sql` flags.
*   **Custom Databases**: If you have a specific library of mass-formula pairs, point vkmz to it using `--database /path/to/db`.
*   **Data Cleaning**: vkmz automatically filters for monoisotopic features if CAMERA annotation is detected in the input. If your results seem sparse, check if your input features were correctly flagged as monoisotopic.

## Reference documentation
- [vkmz GitHub Repository](./references/github_com_HegemanLab_vkmz.md)
- [vkmz Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vkmz_overview.md)