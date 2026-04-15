---
name: multisub
description: The multisub tool automates the preparation and submission of SARS-CoV-2 genomic data to major sequence databases like GISAID, NCBI, and ENA. Use when user asks to initialize submission configurations, convert FASTA and metadata files into repository-specific formats, or perform automated data uploads to genomic repositories.
homepage: https://github.com/maximilianh/multiSub
metadata:
  docker_image: "quay.io/biocontainers/multisub:1.0.0--pyh5e36f6f_0"
---

# multisub

## Overview
The `multisub` tool is a specialized command-line utility designed to streamline the submission of SARS-CoV-2 genomic data. It acts as a bridge between raw laboratory outputs (FASTA and metadata tables) and the strict requirements of major sequence databases. The tool automates data cleaning—such as stripping flanking Ns and validating date formats—and handles the idiosyncratic naming conventions required by different repositories (e.g., "hCoV-19" for GISAID vs. "SARS-CoV-2" for NCBI).

## Core Workflows

### 1. Initial Configuration
Before first use, initialize the local configuration to set your institution's default metadata (email, country, etc.).
```bash
./multisub init
# Edit ~/.multiSub/config to set permanent defaults
```

### 2. Data Conversion and Preparation
To prepare files for submission without uploading them immediately, use the `conv` command. This generates the necessary repository-specific files in an output directory.
```bash
./multisub conv <sequences.fasta> <metadata.csv> <output_dir>/
```
*   **Input Requirements**: FASTA headers must match the first column of the metadata table. Metadata must include at least `isolate` and `date` fields.
*   **Format Selection**: Use `-f` to limit output to specific repositories (e.g., `-f gisaid,ncbi`).

### 3. NCBI Submission Workflow
NCBI submissions typically require a two-step process:
1.  **BioSample Registration**: Submit metadata first to obtain BioSample accessions.
2.  **Accession Injection**: Re-run `multisub` with the obtained accessions to update the GenBank submission files.
3.  **GenBank Submission**: Upload the updated files.

### 4. Automated Uploads
If credentials are configured, `multisub` can perform direct uploads:
*   **GISAID**: Uses the GISAID CLI/API to upload `.csv` and `.fa` files.
*   **ENA**: Generates and submits XML manifests to the EBI ENA REST API.

## Expert Tips and Best Practices
*   **Data Cleaning**: `multisub` automatically removes empty metadata rows and strips flanking Ns from sequences. Check the command output for warnings regarding skipped sequences.
*   **Date Formats**: Ensure dates are in ISO 8601 format (YYYY-MM-DD). While the tool attempts to fix common errors, consistent input prevents submission rejection.
*   **GISAID Excel Files**: To read `.xls` files from GISAID, ensure the `xlrd` Python package is installed (`pip install xlrd`).
*   **Virus Naming**: Do not manually change virus names to fit repository requirements; `multisub` handles the translation between "hCoV-19/" and "SARS-CoV-2/" prefixes automatically based on the target format.

## Reference documentation
- [multiSub GitHub Repository](./references/github_com_maximilianh_multiSub.md)
- [Bioconda multisub Package Overview](./references/anaconda_org_channels_bioconda_packages_multisub_overview.md)