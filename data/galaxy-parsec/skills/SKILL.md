---
name: galaxy-parsec
description: Galaxy-parsec provides command-line wrappers for BioBlend functions to interact with Galaxy instances through a terminal. Use when user asks to manage Galaxy histories, download datasets, or automate Galaxy tasks using shell scripts and JSON processing.
homepage: https://github.com/galaxy-iuc/parsec
metadata:
  docker_image: "quay.io/biocontainers/galaxy-parsec:1.16.0--pyh5e36f6f_0"
---

# galaxy-parsec

## Overview
Galaxy-parsec (or simply `parsec`) provides a comprehensive suite of command-line wrappers for BioBlend functions, allowing for "linux-friendly" interaction with Galaxy instances. It transforms complex API calls into composable CLI commands, enabling users to build powerful automation pipelines using standard shell utilities. This skill focuses on the core CLI operations for managing remote Galaxy resources efficiently.

## Core Configuration
Before executing functional commands, the environment must be initialized to point to a specific Galaxy instance.

- **Initialization**: Run `parsec init` to configure the API key and Galaxy URL.
- **Instance Selection**: Use the `--galaxy_instance <name>` global flag to switch between different servers defined in your configuration.
- **Verbosity**: Use `-v` or `--verbose` to debug API communication issues.

## Common CLI Patterns

### History Management
Histories are the primary containers for Galaxy analysis.
- **List all histories**: `parsec histories get_histories`
- **Filter for a specific ID**: `parsec histories get_histories | jq '.[0].id'`
- **View detailed history metadata**: `parsec histories show_history <history_id>`
- **Create a new history**: `parsec histories create_history "My New Analysis"`

### Dataset Operations
Datasets reside within histories and are identified by unique IDs.
- **List datasets in a history**: `parsec histories show_history <history_id> | jq '.state_ids.ok'`
- **Download a dataset**: `parsec datasets download_dataset <dataset_id> --file_path ./local_file.dat`
- **Delete a dataset**: `parsec histories delete_dataset <history_id> <dataset_id>`

### Composing with Shell Tools
The true power of `parsec` lies in piping JSON outputs to `jq` and `xargs`.
- **Batch processing**: To run an action on all histories, pipe the IDs:
  `parsec histories get_histories | jq -r '.[].id' | xargs -I {} parsec histories show_history {}`

## Expert Tips
- **JSON Output**: Almost all `parsec` commands return JSON. Always have `jq` available to parse specific fields like `id`, `state`, or `name`.
- **Admin Requirements**: Certain commands (like data library creation or accessing other users' API keys) require an admin account on the Galaxy instance.
- **Deprecated Methods**: Avoid `download_dataset` within the `histories` subcommand; use the top-level `datasets download_dataset` command for better stability.
- **State Checking**: When automating, check the `state` field of a history or dataset. Valid states include `ok`, `running`, `queued`, and `error`.



## Subcommands

| Command | Description |
|---------|-------------|
| galaxy-parsec_parsec | Initialize Galaxy parsec connection. |
| parsec | Command line wrappers around BioBlend functions. While this sounds unexciting, with parsec and jq you can easily build powerful command line scripts. |

## Reference documentation
- [Parsec GitHub Overview](./references/github_com_galaxy-iuc_parsec.md)
- [Parsec Wiki](./references/github_com_galaxy-iuc_parsec_wiki.md)