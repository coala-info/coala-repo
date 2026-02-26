---
name: stemcnv-check
description: StemCNV-check is a bioinformatics pipeline for monitoring the genomic integrity of stem cell lines by detecting de-novo aberrations from SNP array data. Use when user asks to detect copy number variations in stem cells, monitor genomic integrity during cell culture, or generate QC reports from idat files.
homepage: https://github.com/bihealth/StemCNV-check
---


# stemcnv-check

## Overview
StemCNV-check is a specialized bioinformatics pipeline designed for the genomic integrity monitoring of stem cell lines. It automates the transition from raw `.idat` files to detailed QC reports, focusing on detecting de-novo aberrations that may occur during cell culture. By leveraging a Snakemake-based workflow, it provides a standardized method to compare pluripotent samples against parental references, ensuring that any detected variations are accurately categorized by their potential impact on cell line quality.

## Installation
The tool is primarily distributed via Bioconda. It requires a Linux environment or Windows Subsystem for Linux (WSL).

```bash
conda install bioconda::stemcnv-check
```

## Core Workflow Commands
The analysis follows a three-step execution pattern:

1.  **Initialization**: Generate the necessary template files for your project.
    ```bash
    stemcnv-check setup-files
    ```
    This creates a template sample table and a configuration file. You must populate the sample table with your sample metadata and `.idat` file locations.

2.  **Static Data Preparation**: Generate array-specific reference data. This only needs to be performed once for a specific array type.
    ```bash
    stemcnv-check make-staticdata
    ```

3.  **Execution**: Run the full analysis pipeline.
    ```bash
    stemcnv-check run
    ```

## Best Practices and Expert Tips
- **Reference Selection**: Always include a (parental) reference sample in your sample table. The tool's primary strength is the side-by-side comparison to distinguish between inherited variants and de-novo mutations acquired during culture.
- **Environment Consistency**: Ensure `conda` or `mamba` is correctly initialized in your shell before running the `run` command, as the tool manages internal dependencies via Snakemake environments.
- **Data Requirements**: Ensure raw `.idat` files are accessible at the paths specified in your sample table. The tool expects standard Illumina SNP array output.
- **Report Interpretation**: Focus on the "Check-Score" in the generated reports. This score prioritizes CNVs based on size, copy number, and overlap with known stem cell hotspots or cancer driver genes.
- **Troubleshooting WSL**: If running on Windows via WSL, ensure your file paths follow Linux conventions (e.g., `/mnt/c/...`) and that the underlying filesystem has sufficient permissions for Snakemake to create lock files.

## Reference documentation
- [StemCNV-check Overview](./references/anaconda_org_channels_bioconda_packages_stemcnv-check_overview.md)
- [StemCNV-check GitHub Repository](./references/github_com_bihealth_StemCNV-check.md)