---
name: assembly_uploader
description: The assembly_uploader tool automates the submission of metagenomic assembly data and metadata to the European Nucleotide Archive. Use when user asks to register a study, generate assembly manifests, or upload genomic data to the ENA.
homepage: https://github.com/EBI-Metagenomics/assembly_uploader
metadata:
  docker_image: "quay.io/biocontainers/assemblycomparator2:2.7.1--hdfd78af_2"
---

# assembly_uploader

## Overview
The `assembly_uploader` tool streamlines the complex process of submitting metagenomic data to the ENA. It automates the generation of required XML metadata and manifest files, ensuring they meet ENA's specific formatting standards. This skill guides you through the sequential workflow of study registration, manifest creation, and data transmission, including the use of the `webin_cli_handler` for robust uploads.

## Prerequisites
Before starting the submission process, ensure the following are ready:
- **Environment Variables**: Set your ENA credentials.
  ```bash
  export ENA_WEBIN=Webin-XXXXX
  export ENA_WEBIN_PASSWORD=your_password
  ```
- **Metadata File**: A CSV file containing assembly details (runs, coverage, assembler, version, filepath).
- **Data Files**: Compressed assembly FASTA files as defined in your metadata CSV.

## Core Workflow

### 1. Register a New Study
If you do not have an existing ENA study accession, generate the registration XMLs first.
```bash
study_xmls --study <RAW_READS_STUDY_ID> --library metagenome --center <CENTER_NAME>
```
*   **Tip**: Use `--tpa` if the submission is a Third Party Assembly.
*   **Tip**: Use `--private` if the data should remain private until a specific hold date.

### 2. Submit Study to ENA
Submit the generated XMLs to receive a new assembly study accession.
```bash
submit_study --study <RAW_READS_STUDY_ID> --directory <PATH_TO_XML_FOLDER> --test
```
*   **Expert Practice**: Always run with `--test` first. If successful, re-run without the flag for the live submission. Record the generated accession ID immediately.

### 3. Generate Assembly Manifests
Create the manifest files required by `webin-cli`.
```bash
assembly_manifest --study <RAW_READS_STUDY_ID> --assembly_study <NEW_ACCESSION> --data <METADATA_CSV>
```
*   **Co-assembly Note**: All runs in a co-assembly must share the same privacy status. If using multiple biological samples, you must register a co-assembly sample first and include it in the `Sample` column of your CSV.

### 4. Upload Assemblies
Use the handler to validate and then submit your data.
```bash
# Step A: Validation
webin_cli_handler --manifest *.manifest --context genome --mode validate

# Step B: Live Submission
webin_cli_handler --manifest *.manifest --context genome --mode submit
```
*   **Automation**: If `webin-cli` is not installed, add the `--download-webin-cli` flag to the command.
*   **Performance**: Adjust memory usage for large assemblies using `--java-heap-size-max` (default is 10GB).

## Common CLI Patterns
- **Releasing Data**: To move a private study to the public domain:
  ```bash
  release_study --study <STUDY_ID>
  ```
- **Forcing Updates**: If you need to regenerate manifests due to metadata changes, use the `--force` flag in `assembly_manifest`.

## Reference documentation
- [Assembly Uploader Overview](./references/anaconda_org_channels_bioconda_packages_assembly_uploader_overview.md)
- [GitHub Repository and README](./references/github_com_EBI-Metagenomics_assembly_uploader.md)