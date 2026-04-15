---
name: relecov-tools
description: relecov-tools manages the end-to-end lifecycle of SARS-CoV-2 genomic data by handling metadata standardization, schema validation, and database submission. Use when user asks to transform laboratory metadata, validate JSON files against schemas, map data for ENA or GISAID submissions, or update the central RELECOV database.
homepage: https://github.com/BU-ISCIII/relecov-tools
metadata:
  docker_image: "quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0"
---

# relecov-tools

## Overview

The `relecov-tools` suite is a specialized toolkit designed for the Spanish Network for genomic surveillance of SARS-CoV-2 (RELECOV). It facilitates the end-to-end lifecycle of genomic data management, including secure data retrieval, metadata standardization, schema validation, and submission to international databases. Use this skill to automate the processing of laboratory results and bioinformatic outputs into compliant formats for public health reporting and database storage.

## Core CLI Usage

The tool follows a standard command-line interface pattern: `relecov-tools [OPTIONS] COMMAND [ARGS]...`.

### Global Options
- **Verbose Output**: Use `-v` or `--verbose` to print logs to the console during execution.
- **Debugging**: Use `-d` or `--debug` to show full tracebacks on error.
- **Logging**: Use `-l <path>` or `--log-path <path>` to save execution logs to a specific directory.
- **Hex-code**: Use `-h <hex>` or `--hex-code <hex>` to define a specific hexadecimal identifier for the execution. This is useful for grouping related files or forcing the overwrite of existing files with the same code.

### Common Command Patterns

- **Metadata Preparation**:
  - `read-lab-metadata`: Use this to transform laboratory spreadsheets into the JSON format required by the RELECOV schema.
  - `read-bioinfo-metadata`: Use this to extract and format bioinformatic analysis results.
  - `metadata-homogeneizer`: Use this to normalize institution-specific metadata into the standard RELECOV format.

- **Validation and Mapping**:
  - `validate`: Always run this command to check your JSON files against the official schema before attempting uploads or database updates.
  - `map`: Use this to convert internal data schemas into specific formats required by ENA or GISAID.

- **Data Submission**:
  - `upload-to-ena`: Generates the XML files necessary for European Nucleotide Archive submissions.
  - `upload-to-gisaid`: Prepares files for GISAID submission.
  - `update-db`: Synchronizes the processed JSON information with the central RELECOV database.

- **Workflow Automation**:
  - `wrapper`: Executes a sequence of modules as defined in the local configuration.
  - `pipeline-manager`: Manages symbolic links for samples that need to be processed through specific bioinformatic pipelines.

## Best Practices and Tips

- **Environment Requirements**: Ensure Python >= 3.10 and `p7zip` (7-Zip) are installed. The tool relies on `p7zip` for handling compressed genomic data.
- **Configuration Profiles**: The tool supports different project profiles (e.g., `relecov`, `mepram`, `EQA2026`). Use the `add-extra-config` command to load or overwrite specific configuration parameters for these projects.
- **Log Management**: For large batches, use `logs-to-excel` to merge multiple JSON and log reports into a single, readable Excel file for auditing.
- **Schema Updates**: If the metadata requirements change, use `build-schema` to regenerate or update the JSON Schema files from the underlying Python definitions.



## Subcommands

| Command | Description |
|---------|-------------|
| relecov-tools build-schema | Generates and updates JSON Schema files from Excel-based database definitions. |
| relecov-tools download | Download files located in sftp server. |
| relecov-tools logs-to-excel | Creates a merged xlsx and Json report from all the log summary jsons given as input |
| relecov-tools map | Convert data between phage plus schema to ENA, GISAID, or any other schema |
| relecov-tools metadata-homogeneizer | Parse institution metadata lab to the one used in relecov |
| relecov-tools pipeline-manager | Create the symbolic links for the samples which are validated to prepare for bioinformatics pipeline execution. |
| relecov-tools read-bioinfo-metadata | Create the json compliant from the Bioinfo Metadata. |
| relecov-tools read-lab-metadata | Create the json compliant to the relecov schema from the Metadata file. |
| relecov-tools send-mail | Send a sample validation report by mail. |
| relecov-tools update-db | upload the information included in json file to the database |
| relecov-tools upload-to-ena | parse data to create xml files to upload to ena |
| relecov-tools upload-to-gisaid | parsed data to create files to upload to gisaid |
| relecov-tools validate | Validate json file against schema. |

## Reference documentation
- [Main README](./references/github_com_BU-ISCIII_relecov-tools_blob_main_README.md)
- [Project Changelog](./references/github_com_BU-ISCIII_relecov-tools_blob_main_CHANGELOG.md)
- [RELECOV Schema Definition](./references/github_com_BU-ISCIII_relecov-tools_blob_main_relecov_tools_schema_relecov_schema.json.md)