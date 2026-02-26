---
name: im2deep
description: im2deep is a deep learning framework for predicting the collisional cross-section of peptides, including modified and multiconformational ions. Use when user asks to predict peptide CCS values, perform calibrated CCS predictions, or generate multi-output predictions for multiconformational peptide ions.
homepage: https://github.com/compomics/im2deep
---


# im2deep

## Overview
im2deep is a specialized deep learning framework for predicting the Collisional Cross-Section (CCS) of peptides. It is particularly robust because it can accurately predict CCS for modified peptides even if those specific modifications were not observed during the model's training phase. Additionally, it supports multi-output predictions for multiconformational peptide ions, making it a versatile tool for advanced ion mobility mass spectrometry workflows.

## Installation
Depending on the required functionality, use one of the following commands:
- **Standard prediction**: `pip install im2deep`
- **Multiconformational prediction**: `pip install 'im2deep[er]'`

## Command Line Usage

### Basic Prediction
To generate CCS predictions for a list of peptides:
```bash
im2deep <path/to/peptide_file.csv>
```

### Calibrated Prediction (Recommended)
For the highest accuracy, provide a calibration file containing experimental CCS values. This allows the model to adjust its predictions to your specific experimental setup:
```bash
im2deep <path/to/peptide_file.csv> --calibration-file <path/to/experimental_ccs.csv>
```

### Multiconformational Prediction
If you have installed the `[er]` extra dependencies, use the `-e` flag to enable the multi-output model:
```bash
im2deep <path/to/peptide_file.csv> --calibration-file <path/to/experimental_ccs.csv> -e
```

## Input Data Preparation
Input files (both for prediction and calibration) must be in CSV format with the following columns:

| Column | Description |
| :--- | :--- |
| `seq` | The unmodified amino acid sequence. |
| `modifications` | Pipe-separated list of modifications in `location\|name` format. |
| `charge` | The integer precursor charge state. |
| `CCS` | Experimental collisional cross-section (Required for calibration files only). |

### Modification Syntax
Modifications must follow the `location|name` convention:
- **Location**: 1-based index for amino acids. Use `0` for N-terminal and `-1` for C-terminal modifications.
- **Name**: Must correspond to a valid **Unimod (PSI-MS)** name.
- **Multiple Mods**: Separate with a pipe (`|`).

**Example Row:**
`GVEVLSLTPSFMDIPEK, 12|Oxidation, 2, 464.65`

## Best Practices
- **Always Calibrate**: Prediction accuracy is significantly improved when providing a calibration file from the same instrument run.
- **Unimod Compliance**: Ensure modification names match Unimod exactly (e.g., `Oxidation`, `Carbamidomethyl`, `Acetyl`).
- **Check Dependencies**: If the `-e` flag fails, verify that you installed the package using the `im2deep[er]` specifier to include the necessary multi-output model dependencies.

## Reference documentation
- [IM2Deep GitHub Repository](./references/github_com_CompOmics_IM2Deep.md)
- [im2deep Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_im2deep_overview.md)