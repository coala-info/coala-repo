---
name: biomaj3
description: BioMAJ3 is a workflow engine that automates the management and update cycle of biological data banks. Use when user asks to install the tool with a PostgreSQL backend, configure bank properties, monitor workflow status, or manage session history.
homepage: https://github.com/horkko/biomaj-postgres
---


# biomaj3

## Overview
BioMAJ3 is a workflow engine dedicated to the management of biological data banks. It automates the cycle of data bank updates, including download, transformation, and integration. This skill focuses on the BioMAJ3 environment configured with a PostgreSQL backend, providing guidance on installation, configuration via property files, and command-line status monitoring.

## Installation and Setup
To use BioMAJ3 with a PostgreSQL backend, ensure the environment is prepared with the necessary Linux utilities and database access.

- **Dependencies**: Requires Python, PostgreSQL (local or remote), and standard compression tools (`tar`, `unzip`, `gunzip`, `bunzip`).
- **Installation**: Execute `python setup.py install` within the source directory. It is highly recommended to use a Python virtual environment (`virtualenv`).
- **Configuration**: Copy and modify the `global.properties` file found in `tools/examples` to match your local environment and database credentials.

## CLI Usage and Patterns
The tool provides specific command-line utilities for managing the database transition and monitoring bank status.

- **Database Configuration**: Use the command line to specify the PostgreSQL database name if not hardcoded in the configuration files.
- **Status Monitoring**: Use the `--status-ko` option to identify and manage error cases within the workflow. This is particularly useful for differentiating between workflows that are still in progress and those that have failed.
- **Session Management**: 
    - Use the `keep.old.session` parameter to retain session history in the database even after releases are removed.
    - The system adds a `deleted` tag to sessions when the bank's data has been removed from the disk to maintain a temporal trace.

## Best Practices
- **Database Trust**: Rely on database values rather than local configuration files for bank metadata to ensure consistency across distributed environments.
- **Release Formatting**: Use the `release.format` parameter in `global.properties` to specify how bank releases should be versioned and identified.
- **File Management**: Move local files from the database to the cache directory (similar to `download_files`) to optimize storage and retrieval performance.

## Reference documentation
- [BioMAJ3 - PostgreSQL README](./references/github_com_horkko_biomaj-postgres.md)
- [Commit History and CLI Flags](./references/github_com_horkko_biomaj-postgres_commits_master.md)