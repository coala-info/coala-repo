---
name: varfish-cli
description: The `varfish-cli` tool provides a command-line interface to the VarFish REST API, enabling researchers and bioinformaticians to manage variant data programmatically.
homepage: https://github.com/bihealth/varfish-cli
---

# varfish-cli

## Overview

The `varfish-cli` tool provides a command-line interface to the VarFish REST API, enabling researchers and bioinformaticians to manage variant data programmatically. It bridges the gap between local variant calling pipelines and the VarFish web platform, primarily facilitating the import of VCF and pedigree files into the server for downstream filtration and prioritization.

## Configuration

Before using the tool, you must configure authentication and server details.

1. Create a configuration file at `~/.varfishrc.toml`.
2. Add your server URL and API token (generated in the VarFish web UI under user settings):

```toml
[global]
varfish_server_url = "https://varfish.example.com/"
varfish_api_token = "your-secret-api-token"
```

## Common CLI Patterns

### Command Discovery
The tool uses a nested command structure. Always use the `--help` flag to discover available subcommands and their specific arguments.

- List all top-level commands: `varfish-cli --help`
- Explore a specific subcommand: `varfish-cli [subcommand] --help` (e.g., `varfish-cli importer --help`)

### Data Import
The `importer` subcommand is the primary way to upload new cases to VarFish.

- **Prepare for Import**: Ensure you have your VCF files and a corresponding PED (pedigree) file ready.
- **Execute Import**: Use the `importer` command to push data to a specific project. You will typically need the project UUID from the VarFish web interface.

## Expert Tips

- **API Token Security**: Keep your `~/.varfishrc.toml` file secure (e.g., `chmod 600 ~/.varfishrc.toml`) as it contains your API credentials.
- **Automation**: Use `varfish-cli` within Bash scripts to automatically upload results at the end of a variant calling pipeline.
- **Version Consistency**: Ensure your `varfish-cli` version is compatible with your `varfish-server` version. Check your local version with `varfish-cli --version`.
- **Environment Overrides**: While the config file is standard, check subcommand help for environment variable overrides if you need to switch between production and staging servers frequently.

## Reference documentation
- [VarFish REST API client (CLI + Python package)](./references/github_com_varfish-org_varfish-cli.md)
- [varfish-cli - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_varfish-cli_overview.md)