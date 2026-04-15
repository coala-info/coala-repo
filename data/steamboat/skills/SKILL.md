---
name: steamboat
description: Steamboat formats and batches bioinformatics results with metadata for submission to public health surveillance repositories. Use when user asks to format data for GISAID, prepare wastewater surveillance results for NWSS, or batch antibiotic resistance data for ARLN.
homepage: https://github.com/rpetit3/steamboat-py
metadata:
  docker_image: "quay.io/biocontainers/steamboat:1.1.1--pyhdfd78af_0"
---

# steamboat

## Overview
`steamboat` is a specialized utility designed for microbial bioinformaticians and public health researchers. Its primary function is to bridge the gap between raw bioinformatics pipeline outputs and the rigid submission formats required by global surveillance networks. By providing dedicated subcommands for different repositories, it automates the merging of metadata with sequence analysis results, ensuring that submissions are consistent and formatted correctly for downstream ingestion.

## Core Subcommands and Usage
The tool operates through a set of "batch" commands tailored to specific surveillance programs.

### GISAID Submissions
Use the `gisaid-batch` command when preparing viral genomic data (such as SARS-CoV-2) for the Global Initiative on Sharing All Influenza Data.
- **Purpose**: Combines consensus sequences and bioinformatics metrics with required GISAID metadata fields.
- **Context**: Use this after completing assembly and lineage assignment pipelines.

### Wastewater Surveillance (NWSS)
Use the `nwss-batch` command for submissions to the National Wastewater Surveillance System.
- **Purpose**: Batches metadata and bioinformatics results specifically for environmental/wastewater samples.
- **Tip**: This command includes verbosity controls to help debug metadata mapping issues during the batching process.

### Antibiotic Resistance (ARLN)
Use the `arln-batch` command for Antibiotic Resistance Laboratory Network submissions.
- **Purpose**: Specifically designed to batch sample metadata with GigaTyper results.
- **Context**: Use this when your workflow involves characterizing bacterial isolates for antibiotic resistance surveillance.

## Expert Tips and Best Practices
- **Installation**: The tool is best managed via `conda` or `mamba` using the `bioconda` and `conda-forge` channels to ensure all dependencies (like `packaging` and `python >=3.7`) are correctly satisfied.
- **Metadata Preparation**: Before running any batch command, ensure your metadata is in a structured format (typically TSV or CSV). The tool relies on matching sample IDs between your bioinformatics results and your metadata file.
- **Workflow Integration**: While `steamboat` is a standalone CLI tool, it is most effective when placed at the end of a primary analysis pipeline to transform "research-ready" data into "submission-ready" data.
- **Version Awareness**: Public health submission requirements (especially for NWSS and GISAID) change frequently. Always ensure you are using the latest release of `steamboat` to maintain compatibility with repository schemas.



## Subcommands

| Command | Description |
|---------|-------------|
| gisaid-batch | Format data for GISAID submission. |
| nwss-batch | Format data for NWSS submission. |

## Reference documentation
- [CHANGELOG.md](./references/github_com_rpetit3_steamboat-py_blob_main_CHANGELOG.md)
- [README.md](./references/github_com_rpetit3_steamboat-py_blob_main_README.md)