---
name: tbtamr
description: tbtamr infers antimicrobial resistance profiles and generates genomic drug susceptibility testing reports for Mycobacterium tuberculosis from annotated VCF files. Use when user asks to predict AMR profiles for M. tuberculosis, generate genomic DST reports for LIMS integration, or apply custom mutational catalogues to variant data.
homepage: https://github.com/MDU-PHL/tbtamr
---


# tbtamr

## Overview
tbtamr is a specialized bioinformatics tool designed for clinical and public health laboratories to infer AMR profiles for *M. tuberculosis*. It implements TB-Profiler logic but offers enhanced flexibility by allowing users to provide custom mutational catalogues and interpretative criteria in CSV format. This ensures that laboratories can update their diagnostic logic without requiring software developer intervention. Its primary output is a genomic DST report suitable for integration into Laboratory Information Management Systems (LIMS).

## Usage Guidelines

### Input Requirements
*   **VCF Files**: The core input must be a VCF file.
*   **Annotation**: VCFs must be annotated using **snpEff**. The tool is designed to be compatible with the variant description format used in the **WHO catalogue version 2**.
*   **Custom Criteria**: If you are not using the default mutational catalogue, you must provide your own in CSV format. Ensure your custom catalogue uses the same annotation format as your input VCF.
*   **Raw Reads**: While tbtamr is "VCF-first," it can process paired-end reads if the necessary mapping and variant-calling dependencies are installed in the environment.

### Best Practices
*   **Environment Setup**: Always use a dedicated Conda environment to manage dependencies.
    ```bash
    conda create -n tbtamr tbtamr
    conda activate tbtamr
    ```
*   **Validation**: When using custom interpretative criteria, validate the CSV format against the `example_criteria` provided in the repository to prevent parsing errors.
*   **Species Specificity**: tbtamr is strictly for *M. tuberculosis*. Do not use it for other mycobacteria or non-Mtb complex species.
*   **Reporting**: Use the tool's output for LIMS integration; note that tbtamr focuses on data generation rather than aesthetic PDF report formatting.

### Expert Tips
*   **Maintenance-Free Updates**: To update the tool's logic for new resistance markers (e.g., following a new WHO release), update the input CSV catalogue rather than the tool itself. This simplifies the re-verification process in accredited (ISO15189) settings.
*   **Pipeline Integration**: Because tbtamr is lightweight and "VCF-in," it is best used as a downstream module in existing WGS pipelines after variant calling and snpEff annotation are complete.

## Reference documentation
- [tbtAMR Wiki Home](./references/github_com_MDU-PHL_tbtamr_wiki.md)
- [tbtamr GitHub Repository](./references/github_com_MDU-PHL_tbtamr.md)