---
name: relecov-tools
description: relecov-tools automates the data lifecycle for the Spanish Network for Genomic Surveillance of SARS-CoV-2 by managing metadata extraction, validation, and database submission. Use when user asks to download files from SFTP, process laboratory metadata, validate JSON schemas, map data to ENA or GISAID formats, or update the RELECOV database.
homepage: https://github.com/BU-ISCIII/relecov-tools
---


# relecov-tools

## Overview

The `relecov-tools` suite is a specialized collection of utilities designed to automate the data lifecycle for the Spanish Network for Genomic Surveillance of SARS-CoV-2 (RELECOV). It bridges the gap between raw laboratory output and public database submission by providing standardized workflows for metadata extraction, data validation, and format conversion. This tool is essential for ensuring that genomic data and its associated metadata meet the rigorous schema requirements of the RELECOV platform and international repositories.

## Core CLI Usage

The tool follows a standard command-line interface: `relecov-tools [OPTIONS] COMMAND [ARGS]...`.

### Data Acquisition
Use the `download` command to retrieve files from the RELECOV SFTP server.
- **Basic Download**: `relecov-tools download -u <username> -p <password> -o <output_directory>`
- **Cleanup**: Use `-d download_clean` to remove files from the SFTP server after a successful download.
- **Targeting**: Use `-t '["folder1", "folder2"]'` to limit the download to specific directories.

### Metadata Processing
- **Laboratory Metadata**: `relecov-tools read-lab-metadata` processes Excel files from labs into platform-compliant JSON.
- **Bioinformatics Metadata**: `relecov-tools read-bioinfo-metadata` extracts technical metrics from analysis pipelines.
- **Homogenization**: `relecov-tools metadata-homogeneizer` aligns disparate institution metadata formats into a single standard.

### Validation and Mapping
- **Schema Validation**: `relecov-tools validate` checks JSON files against the official RELECOV schema. This is a critical step before any database upload.
- **Repository Mapping**: `relecov-tools map` converts internal RELECOV data into formats required by ENA or GISAID.

### Submission and Storage
- **ENA Upload**: `relecov-tools upload-to-ena` generates the XML files required for European Nucleotide Archive submission.
- **GISAID Upload**: `relecov-tools upload-to-gisaid` prepares files for GISAID submission.
- **Database Update**: `relecov-tools update-db` pushes validated JSON data into the RELECOV platform's central database.

## Expert Tips and Best Practices

- **Avoid Overwrites**: By default, the tool generates a random hexadecimal code for output files. If you need to maintain consistency across multiple runs or prevent accidental overwrites, use the `--hex-code <TEXT>` flag to define a fixed identifier.
- **Debugging**: If a command fails without a clear error, use the `-d` or `--debug` flag to see the full Python traceback. Use `-v` or `--verbose` to see real-time logs in the console.
- **Batch Processing**: The `wrapper` command allows you to execute multiple modules sequentially based on a configuration file. This is the preferred method for production pipelines.
- **Log Management**: Use `relecov-tools logs-to-excel` to merge multiple JSON/log reports into a single Excel file for easier manual review of batch processing results.
- **System Requirements**: Ensure `p7zip` is installed on your system, as the tool relies on it for handling compressed genomic data.

## Reference documentation
- [relecov-tools GitHub Repository](./references/github_com_BU-ISCIII_relecov-tools.md)
- [relecov-tools Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_relecov-tools_overview.md)