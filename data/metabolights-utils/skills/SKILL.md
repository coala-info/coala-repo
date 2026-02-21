---
name: metabolights-utils
description: The `metabolights-utils` skill provides a specialized workflow for managing metabolomics data within the MetaboLights ecosystem.
homepage: https://github.com/EBI-Metabolights/metabolights-utils
---

# metabolights-utils

## Overview
The `metabolights-utils` skill provides a specialized workflow for managing metabolomics data within the MetaboLights ecosystem. It allows for programmatic searching of the repository, efficient retrieval of study components (Investigation, Study, Assay, and Metabolite Assignment files), and local validation of study submissions. This tool is essential for researchers and bioinformaticians who need to automate data acquisition or ensure their metadata conforms to ISA-Tab standards before submission.

## Core CLI Usage Patterns

The primary entry point for the tool is the `mtbls` command.

### Exploring Public Studies
Use the `public` subcommand to browse and retrieve data from the repository.

*   **List all public studies:**
    `mtbls public list`
*   **List local copies of studies:**
    `mtbls public list -l`
*   **List specific folder content within a study:**
    `mtbls public list MTBLS3 FILES`

### Searching the Repository
The search functionality supports boolean operators and advanced filtering.

*   **Basic keyword search:**
    `mtbls public search "cancer"`
*   **Complex queries (using + for AND, | for OR):**
    `mtbls public search "targeted + lipid"`
*   **Retrieve only accession numbers:**
    `mtbls public search "mus musculus" --id`
*   **Pagination and limits:**
    `mtbls public search "lipid" --skip=10 --limit=10`

### Downloading Data
Downloads can target metadata only or include large data files.

*   **Download metadata files only (default):**
    `mtbls public download MTBLS3`
*   **Force overwrite existing local files:**
    `mtbls public download MTBLS3 -o`
*   **Download the entire FILES directory (raw data):**
    `mtbls public download MTBLS3 FILES`
*   **Download a specific file:**
    `mtbls public download MTBLS3 FILES/sample_data.raw`

### Metadata Extraction and Inspection
The `describe` command allows for targeted extraction of metadata using JSONPath-like syntax.

*   **View study summary:**
    `mtbls public describe MTBLS3`
*   **Extract specific fields (e.g., Study Title):**
    `mtbls public describe MTBLS3 "$.investigation.studies[0].title"`
*   **List assay techniques:**
    `mtbls public describe MTBLS3 "$.investigation.studies[0].study_assays.assays[*].assay_technique.name"`

## Understanding the Data Model
Before performing complex queries or updates, use the `model` command to understand the underlying schema.

*   **Explain the top-level model:**
    `mtbls model explain`
*   **Explain specific components:**
    `mtbls model explain investigation.studies`
    `mtbls model explain assays`

## Expert Tips
*   **Validation:** Use the `submission` commands (where applicable with credentials) to validate local ISA-Tab files against the MetaboLights validator to catch formatting errors before official submission.
*   **JSON Output:** For downstream automation, use the `--raw` flag with search commands to receive the full JSON response from the MetaboLights API.
*   **Virtual Environments:** Always run `mtbls` within a dedicated virtual environment (e.g., `python3 -m venv mtbls-venv`) to avoid dependency conflicts with other bioinformatics tools.

## Reference documentation
- [MetaboLights Utils Main Documentation](./references/github_com_EBI-Metabolights_metabolights-utils.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_metabolights-utils_overview.md)