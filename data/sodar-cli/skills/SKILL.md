---
name: sodar-cli
description: The `sodar-cli` tool is a command-line interface and Python library used to interact with SODAR servers.
homepage: https://github.com/bihealth/sodar-cli
---

# sodar-cli

## Overview
The `sodar-cli` tool is a command-line interface and Python library used to interact with SODAR servers. It enables the automation of data management tasks that would otherwise require the SODAR web interface, specifically focusing on project metadata, user roles, and file storage integration (iRODS). Use this skill to set up the environment, configure authentication, and understand the functional modules available for data operations.

## Installation and Setup
The tool is available via Bioconda or can be installed directly from the source for development purposes.

### Using Conda
```bash
conda install bioconda::sodar-cli
```

### From Source (Development)
```bash
git clone git@github.com:bihealth/sodar-cli.git
cd sodar-cli
conda create -n sodar-cli python=3.9
conda activate sodar-cli
pip install -e .
```

## Configuration
The CLI requires a configuration file to authenticate with the SODAR REST API.

1. Create a configuration file at `~/.sodarrc.toml`.
2. Populate it with your server URL and API token:

```toml
[global]
# The base URL of your SODAR instance
sodar_server_url = "https://sodar.example.com/"
# Your personal API token generated in the SODAR web UI
sodar_api_token = "YOUR_SECRET_TOKEN"
```

## Functional Modules
The CLI is structured around specific SODAR modules. When using the tool, target these functional areas:

- **Project Roles**: Used for querying and managing project-level metadata and user permissions.
- **iRODS Info**: Retrieves configuration details required to connect to the underlying iRODS storage for mass data transfer.
- **File Operations**: Supports checking for file existence and listing files within the SODAR environment.

## Best Practices
- **Security**: Since `~/.sodarrc.toml` contains a sensitive API token, ensure the file permissions are restricted (e.g., `chmod 600 ~/.sodarrc.toml`).
- **Version Compatibility**: Ensure the CLI version matches the SODAR server API version. Recent updates (v0.2.0+) include compatibility fixes for newer SODAR API endpoints.
- **Automation**: Use the Python package directly (`import sodar_cli`) within scripts when complex logic is required that exceeds simple CLI command chaining.

## Reference documentation
- [SODAR CLI Overview](./references/anaconda_org_channels_bioconda_packages_sodar-cli_overview.md)
- [SODAR CLI GitHub Repository](./references/github_com_bihealth_sodar-cli.md)