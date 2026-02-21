---
name: galaxy-parsec
description: The `galaxy-parsec` tool provides a suite of command-line utilities that wrap BioBlend functions, allowing for direct interaction with Galaxy servers without writing Python scripts.
homepage: https://github.com/galaxy-iuc/parsec
---

# galaxy-parsec

## Overview

The `galaxy-parsec` tool provides a suite of command-line utilities that wrap BioBlend functions, allowing for direct interaction with Galaxy servers without writing Python scripts. It transforms complex API calls into composable CLI commands, making it possible to manage histories, datasets, libraries, and workflows using standard Linux patterns. This skill should be used to automate repetitive Galaxy tasks, perform batch operations, or bridge Galaxy with other command-line bioinformatics tools.

## Getting Started

### Initialization
Before using parsec, you must configure your connection to a Galaxy instance.
- Run `parsec init` to set up your credentials.
- You will need the Galaxy server URL and your API key (found in Galaxy under User > Preferences > Manage API Key).
- Configuration is typically stored in `~/.planemo.yml`.

### Global Options
- `--galaxy_instance <name>`: Specify which Galaxy instance to use if multiple are configured.
- `-v, --verbose`: Enable verbose logging for debugging API interactions.
- `--help`: View available sub-commands for any level of the tool.

## Common CLI Patterns

Parsec outputs data in JSON format, making it highly compatible with `jq`.

### History Management
List all histories and extract the ID of the most recent one:
```bash
parsec histories get_histories | jq -r '.[0].id'
```

Show detailed information for a specific history:
```bash
parsec histories show_history <history_id>
```

### Dataset Operations
List datasets within a specific history:
```bash
parsec histories show_history <history_id> | jq '.state_ids.ok'
```

Download a dataset:
```bash
parsec datasets download_dataset <dataset_id> --file_path ./my_data.dat
```

### Batch Processing with xargs
To perform an action on multiple items, pipe the IDs from `jq` to `xargs`. For example, to show details for every history:
```bash
parsec histories get_histories | jq -r '.[].id' | xargs -n 1 parsec histories show_history
```

## Expert Tips and Best Practices

- **Admin Privileges**: Certain commands, such as creating data libraries or accessing other users' API keys, require an admin account on the Galaxy instance.
- **Filtering with jq**: Since Galaxy returns large JSON objects, always use `jq` to filter for the specific attributes you need (e.g., `.id`, `.name`, `.state`) to keep your pipeline readable.
- **Instance Selection**: If you work with multiple Galaxy servers (e.g., Main, EU, and a local dev instance), use the `--galaxy_instance` flag to ensure commands are sent to the correct environment.
- **Handling Deprecations**: Some methods (like certain download commands) may be marked as deprecated in the help text; always prefer the suggested alternative (e.g., using `datasets` commands over `histories` for specific file downloads).

## Reference documentation
- [Parsec GitHub Repository](./references/github_com_galaxy-iuc_parsec.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_galaxy-parsec_overview.md)