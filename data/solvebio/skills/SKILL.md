---
name: solvebio
description: The solvebio tool provides a command-line interface and Python client for managing genomic data, authenticating environments, and interacting with data vaults on the SolveBio platform. Use when user asks to login to SolveBio, configure API credentials, upload or download genomic datasets, and list resources within data vaults.
homepage: https://github.com/solvebio/solvebio-python
---


# solvebio

## Overview
The `solvebio` skill provides a streamlined interface for managing genomic data and workflows on the SolveBio platform. It allows for the setup of secure authentication, environment configuration, and direct interaction with SolveBio's data vaults. While the package is currently in a maintenance phase (with a planned transition to `quartzbio`), it remains the primary tool for legacy SolveBio environments and specific bioinformatics pipelines requiring native CLI access.

## Installation and Setup
To get started with the SolveBio Python client and CLI:

```bash
pip install solvebio
```

For interactive environments, it is recommended to include `ipython` and `gnureadline` for an enhanced shell experience.

## Authentication
The CLI uses a persistent credentials file. To authenticate your environment:

```bash
solvebio login
```
This command will prompt for your SolveBio credentials and store them locally (typically in `~/.solvebio/credentials.json`).

## Configuration via Environment Variables
You can override local credentials or configure client behavior using the following environment variables. This is particularly useful for CI/CD pipelines or headless environments:

*   **SOLVEBIO_API_KEY**: Your API Key for authentication.
*   **SOLVEBIO_ACCESS_TOKEN**: An OAuth2 access token.
*   **SOLVEBIO_API_HOST**: The URL of the target API backend (if different from the default).
*   **SOLVEBIO_LOGLEVEL**: Set the verbosity of logs (e.g., `INFO`, `DEBUG`, `WARN`).
*   **SOLVEBIO_RETRY_ALL**: Set to a truthy value to enable aggressive retries for all request types, including non-idempotent operations like `POST`.

**Credential Lookup Order:**
1. Access Token
2. API Key
3. Local Credentials file

## Common CLI Patterns
The `solvebio` CLI supports several commands for navigating and managing data:

*   **List Resources**: Use `ls` to view files, datasets, and shortcuts within your vaults.
*   **Data Upload**: Use the `upload` command to push local files to a SolveBio vault.
*   **Data Download**: Use the `download` command to retrieve files or specific dataset commits.

## Expert Tips
*   **Deprecation Warning**: Be aware that `solvebio-python` is deprecated and scheduled for end-of-life after March 31, 2026. For new projects, prefer the `quartzbio` package.
*   **Log Management**: If you need to audit CLI actions, set `SOLVEBIO_LOGFILE` to a specific path; otherwise, logs default to `~/.solvebio/solvebio.log`.
*   **Windows Paths**: When using the `upload` command on Windows, ensure paths are properly escaped or quoted to handle backslashes correctly.

## Reference documentation
- [SolveBio Python Client README](./references/github_com_solvebio_solvebio-python.md)
- [SolveBio Package Overview](./references/anaconda_org_channels_bioconda_packages_solvebio_overview.md)