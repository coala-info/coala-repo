---
name: galaxy-ie-helpers
description: The `galaxy-ie-helpers` package is a collection of utility scripts designed to bridge the gap between Galaxy's web-based history and the local file system of an Interactive Environment.
homepage: https://github.com/bgruening/galaxy_ie_helpers
---

# galaxy-ie-helpers

## Overview

The `galaxy-ie-helpers` package is a collection of utility scripts designed to bridge the gap between Galaxy's web-based history and the local file system of an Interactive Environment. It automates the retrieval of input datasets and the submission of output files, allowing for seamless data integration within a terminal or notebook session. Use this skill to manage data flow without relying on manual uploads or downloads through the Galaxy user interface.

## Common CLI Patterns

### Importing Data from Galaxy
To bring datasets from your current Galaxy history into the Interactive Environment, use the `get` command.

*   **Fetch by Dataset ID**:
    `get <dataset_id>`
*   **Fetch by Name (Regex)**:
    `get -n "search_pattern"`
*   **Fetch Multiple Datasets**:
    The tool supports retrieving multiple files simultaneously when patterns match multiple history items.
*   **Include Datatype**:
    Use the `--datatype` flag if you need the script to return or handle specific Galaxy metadata types.

### Exporting Data to Galaxy
To send results or generated files back to your Galaxy history, use the `put` command.

*   **Upload a Single File**:
    `put <local_file_path>`
*   **Upload with Specific Metadata**:
    You can often specify the target name or file type to ensure it appears correctly in the Galaxy history.

### Searching History
If you are unsure of the IDs or exact names of your datasets, use the search utilities.

*   **Find History IDs**:
    `find_matching_history_ids <search_term>`
    This is particularly useful in scripts or notebooks to dynamically identify input files based on partial names or tags.

## Best Practices

*   **Environment Variables**: Ensure `GALAXY_URL` and `API_KEY` are set in your environment. In most official Galaxy Interactive Environments, these are pre-configured.
*   **Dataset Collections**: When working with collections, use the updated versions of the scripts (v0.2.7+) which include specific logic for handling grouped datasets.
*   **Scripting Workflows**: Use `find_matching_history_ids` in combination with `get` to create robust scripts that don't rely on hardcoded dataset IDs, which change between different Galaxy histories.
*   **Verification**: After running a `put` command, check your Galaxy history panel; the new dataset should appear in a "queued" or "running" state as it is ingested.

## Reference documentation
- [galaxy-ie-helpers Overview](./references/anaconda_org_channels_bioconda_packages_galaxy-ie-helpers_overview.md)
- [Galaxy IE Helpers Repository](./references/github_com_bgruening_galaxy_ie_helpers.md)
- [Commit History and Feature Updates](./references/github_com_bgruening_galaxy_ie_helpers_commits_master.md)