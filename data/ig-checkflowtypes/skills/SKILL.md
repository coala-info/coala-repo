---
name: ig-checkflowtypes
description: This utility validates the identity and integrity of flow cytometry data files and Bioconductor objects. Use when user asks to validate FCS files, check flowFrame objects, verify flowSet objects, or validate FlowSOM objects.
homepage: https://github.com/ImmPortDB/ig-checkflowtypes
---


# ig-checkflowtypes

## Overview
The `ig-checkflowtypes` utility provides a set of R-based validation scripts used to confirm the identity and integrity of flow cytometry data. By checking files against specific Bioconductor-related data structures, it prevents format-related errors in downstream analysis. It is most effective when used as a pre-processing or "sanity check" step in automated pipelines to ensure that input data matches the expected object class.

## Command Line Usage
The tool is implemented as a series of R scripts. You can execute these from the terminal using `Rscript`.

### Basic Patterns
To check a specific file or object, run the corresponding script:

*   **Validate FCS files:**
    `Rscript checkFCS.R <input_file>`
*   **Validate flowFrame objects:**
    `Rscript checkFlowframe.R <input_file>`
*   **Validate flowSet objects:**
    `Rscript checkFlowSet.R <input_file>`
*   **Validate FlowSOM objects:**
    `Rscript checkFlowSOM.R <input_file>`

## Best Practices and Expert Tips
*   **Environment Requirements:** Since these scripts are written in R and target flow cytometry types, ensure that the `flowCore` and `FlowSOM` Bioconductor packages are installed in your R environment, as the scripts rely on these libraries to parse and validate the objects.
*   **Pipeline Integration:** Use these scripts as "Gatekeepers." In a multi-step flow cytometry workflow, run the relevant `check*.R` script before passing data to heavy computational tools (like clustering or dimensionality reduction) to avoid late-stage failures due to corrupted or mislabeled data.
*   **Galaxy Datatype Validation:** If you are developing for Galaxy, these scripts serve as the underlying logic for custom datatype sniffers or metadata validators to ensure the "flow" datatypes are correctly assigned upon upload.
*   **Exit Codes:** Monitor the exit status of the scripts. Typically, a non-zero exit code indicates a validation failure, which can be used to halt automated bash scripts or CI/CD pipelines.

## Reference documentation
- [Bioconda ig-checkflowtypes Overview](./references/anaconda_org_channels_bioconda_packages_ig-checkflowtypes_overview.md)
- [GitHub Repository README](./references/github_com_ImmPortDB_ig-checkflowtypes_blob_master_README.md)
- [Source Code: checkFCS.R](./references/github_com_ImmPortDB_ig-checkflowtypes_blob_master_checkFCS.R.md)