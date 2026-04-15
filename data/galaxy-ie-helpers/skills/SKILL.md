---
name: galaxy-ie-helpers
description: galaxy-ie-helpers provides command-line utilities to transfer data between Galaxy histories and Interactive Environments. Use when user asks to get datasets from Galaxy, put files back into a Galaxy history, or retrieve user history metadata.
homepage: https://github.com/bgruening/galaxy_ie_helpers
metadata:
  docker_image: "quay.io/biocontainers/galaxy-ie-helpers:0.2.7--pyh7cba7a3_0"
---

# galaxy-ie-helpers

## Overview

galaxy-ie-helpers is a specialized suite of Python scripts designed to bridge the gap between Galaxy's core history and its Interactive Environments (such as Jupyter, RStudio, or Ethercalc). It simplifies data management by providing high-level command-line utilities that handle the underlying BioBlend API calls. This allows users to automate the process of importing data for analysis and exporting results back to Galaxy without manually navigating the web interface or writing custom API integration code.

## Command Line Usage

The tool provides three primary executable scripts. These are typically available in the system PATH within a Galaxy Interactive Environment.

### Fetching Data
Use the `get` command to pull datasets from your current Galaxy history into the local IE file system.
- **Pattern**: `get <dataset_index_or_id> [target_filename]`
- **Tip**: In many IEs, you can reference datasets by their integer position in the history.

### Sending Data to Galaxy
Use the `put` command to upload local files or analysis results back to your active Galaxy history.
- **Pattern**: `put <local_file_path>`
- **Best Practice**: Use this at the end of a notebook or script to ensure your generated plots, tables, or models are persisted in your Galaxy account.

### Querying History
Use `get_user_history` to retrieve metadata about the current user's history.
- **Pattern**: `get_user_history`
- **Output**: Typically returns JSON or formatted text containing history IDs and dataset lists, useful for scripting dynamic data lookups.

## Expert Tips

- **Environment Variables**: These scripts rely on environment variables automatically injected by Galaxy (like `GALAXY_URL` and `API_KEY`). If running in a custom sub-shell, ensure these variables are exported.
- **BioBlend Integration**: Since the tool is built on BioBlend, it is highly reliable for handling large file transfers and API authentication within the Galaxy ecosystem.
- **Automation**: Incorporate `get` and `put` into bash scripts or Python `os.system` calls to create reproducible "Import-Analyze-Export" workflows within your interactive session.



## Subcommands

| Command | Description |
|---------|-------------|
| get | Get datasets from Galaxy. |
| put | Put datasets back into Galaxy. |

## Reference documentation

- [Galaxy IE Helpers Repository Overview](./references/github_com_bgruening_galaxy_ie_helpers_blob_master_README.md)
- [Package Configuration and Script Definitions](./references/github_com_bgruening_galaxy_ie_helpers_blob_master_setup.py.md)