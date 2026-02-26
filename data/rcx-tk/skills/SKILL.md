---
name: rcx-tk
description: The rcx-tk utility preprocesses and validates environmental chemistry and mass spectrometry metadata spreadsheets for downstream analysis. Use when user asks to process general metadata, handle alkane retention index files, validate injection numbers, or generate standardized sample identifiers.
homepage: https://github.com/RECETOX/rcx-tk
---


# rcx-tk

## Overview

The `rcx-tk` (RECETOX Toolkit) is a specialized utility for preprocessing environmental chemistry and mass spectrometry metadata. It transforms raw, user-provided spreadsheets into cleaned, validated dataframes suitable for downstream analysis. The tool is particularly useful when you need to ensure that `injectionNumber` columns are correctly typed as integers, validate file names, or generate consistent identifiers such as `sampleName`, `sequenceIdentifier`, `sampleIdentifier`, and `localOrder`.

## CLI Usage and Methods

The tool is executed as a Python module. You must specify a processing method, an input file path, and an output destination.

### Basic Command Structure
```bash
python3 -m rcx_tk --method='<method_name>' <input_file> <output_file>
```

### Available Methods
*   **metadata**: Processes general metadata files. It performs column rearrangement and validates that the `injectionNumber` column contains only integers.
*   **alkane_ri**: Specifically handles alkane Retention Index (RI) files.

### Supported File Formats
The tool accepts the following input formats:
*   Tab-Separated Values (`.tsv`)
*   Comma-Separated Values (`.csv`)
*   Excel Workbooks (`.xls`, `.xlsx`)

## Workflow Steps

When you run `rcx-tk`, it performs the following operations automatically:
1.  **Format Conversion**: Converts the input file into a structured dataframe.
2.  **Column Rearrangement**: Organizes columns into the standard RECETOX schema.
3.  **Validation**: 
    *   Verifies that file names are valid.
    *   Ensures the `injectionNumber` column is strictly integer-based.
4.  **Metadata Derivation**: Generates four key fields:
    *   `sampleName`
    *   `sequenceIdentifier`
    *   `sampleIdentifier`
    *   `localOrder`
5.  **Export**: Saves the processed data to the specified output path.

## Installation

If the tool is not present in the environment, it can be installed via Bioconda:
```bash
conda install bioconda::rcx-tk
```

## Reference documentation
- [rcx-tk GitHub Repository](./references/github_com_RECETOX_rcx-tk.md)
- [rcx-tk Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_rcx-tk_overview.md)