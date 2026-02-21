---
name: mavis
description: MAVIS (Merging, Annotation, Validation, and Illustration of Structural variants) is a specialized bioinformatics suite for the post-processing of structural variant calls.
homepage: https://github.com/bcgsc/mavis.git
---

# mavis

## Overview

MAVIS (Merging, Annotation, Validation, and Illustration of Structural variants) is a specialized bioinformatics suite for the post-processing of structural variant calls. It is designed to take raw SV predictions and refine them through a multi-stage pipeline that includes breakpoint validation, functional annotation (such as gene fusion detection), and visualization. Use this skill to navigate the command-line interface and execute the standard MAVIS workflow.

## Pipeline Stages

The MAVIS workflow consists of six primary stages. Each stage can be accessed as a sub-command of the main `mavis` entry point:

1.  **convert**: Standardizes input SV calls from various callers into a unified format.
2.  **cluster**: Groups overlapping or similar SV calls to reduce redundancy and identify consensus events.
3.  **validate**: Re-examines the evidence for breakpoints using the original sequence data (BAM files) to confirm variant existence.
4.  **annotate**: Determines the functional impact of the SVs, such as identifying affected genes or potential fusion products.
5.  **pairing**: Links related variants, such as reciprocal translocations.
6.  **summary**: Aggregates all findings into a final report with illustrations.

## Command Line Usage

### Getting Help
Access the main help menu or specific sub-command documentation:
- View all available stages: `mavis -h`
- View options for a specific stage: `mavis <stage> -h` (e.g., `mavis cluster -h`)

### Standard Execution Pattern
While individual stages can be run manually, the recommended way to execute the full pipeline is via Snakemake. This ensures all dependencies and intermediate steps are managed correctly.

1.  **Initialize Configuration**: Install the configuration utility to prepare the environment.
    ```bash
    pip install mavis_config
    ```

2.  **Run the Pipeline**: Execute the workflow using the MAVIS Snakefile. It is highly recommended to use Singularity to handle external tool dependencies (like aligners).
    ```bash
    snakemake -j <MAX_JOBS> --configfile <YOUR_CONFIG_FILE> --use-singularity -s Snakefile
    ```

## Best Practices

- **Containerization**: Always prefer running MAVIS via Singularity or Docker. The tool relies on specific versions of aligners and external libraries that are pre-configured in the official containers.
- **Resource Management**: Use the `-j` flag in Snakemake to specify the number of concurrent threads/jobs, as the `validate` and `annotate` stages can be computationally intensive.
- **Input Validation**: Ensure that input BAM files are indexed and that the reference genome matches the one used for the initial SV calling.

## Reference documentation
- [MAVIS Overview](./references/anaconda_org_channels_bioconda_packages_mavis_overview.md)
- [MAVIS GitHub Repository and Usage](./references/github_com_bcgsc_mavis.md)