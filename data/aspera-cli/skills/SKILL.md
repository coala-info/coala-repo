---
name: aspera-cli
description: The aspera-cli provides a unified command-line interface for managing high-speed data transfers and interacting with IBM Aspera service APIs. Use when user asks to transfer files via FASP, download packages from Aspera on Cloud, browse remote nodes, or automate Aspera server administration.
homepage: https://github.com/IBM/aspera-cli
metadata:
  docker_image: "quay.io/biocontainers/aspera-cli:4.20.0--hdfd78af_0"
---

# aspera-cli

## Overview
The `aspera-cli` (invoked via the `ascli` command) is a unified interface for managing and executing high-speed data transfers across the IBM Aspera ecosystem. It acts as a wrapper for Aspera REST APIs and the FASP transfer engine (`ascp`), allowing for programmatic file management, package distribution, and server administration. This skill provides the necessary patterns to configure the environment, initiate transfers, and troubleshoot connectivity across various Aspera service modules.

## Installation and Initial Setup
Before performing transfers, the FASP transfer engine must be initialized.

*   **Install the Transfer Engine**: Run `ascli config transferd install` to download and set up the `ascp` binary required for high-speed movement.
*   **Verify Installation**: Use `ascli -v` to check the version and ensure the environment is correctly configured.
*   **Update Tool**: If using RubyGems, use `gem install aspera-cli`.

## Common Command Patterns

### Aspera on Cloud (AoC)
AoC is one of the most common targets for `ascli`.

*   **Receive All Packages**: `ascli aoc packages recv ALL`
*   **Download Specific Package**: `ascli aoc packages download --id <package_id>`
*   **Browse Files**: `ascli aoc node browse /`
*   **Upload to a Node**: `ascli aoc node upload <local_path> --to <remote_path>`

### Configuration and Presets
To avoid re-entering credentials, use the configuration management features.

*   **List Configured Servers**: `ascli config server list`
*   **Use Presets**: Define connection details in the config file to simplify commands to `ascli <preset_name> <command>`.

### Transfer Management
*   **Monitor Transfers**: Use the `transferd` subcommand to manage the background transfer daemon.
*   **Dry Run**: Many commands support a dry-run mode to validate API calls without initiating a physical transfer.

## Expert Tips and Troubleshooting

*   **Debug Logging**: If a transfer fails or an API call returns an error, append `--log-level=debug` to the command to see the full REST request/response cycle and FASP transfer logs.
*   **Partial File Handling**: If you encounter "Cannot rename partial file" errors, check the destination permissions and ensure no other process is locking the `.partial` files created during FASP transfers.
*   **Automation**: When using `ascli` in scripts, use the `--once-only` flag with package downloads to prevent re-downloading the same content in a loop.
*   **API Direct Access**: You can use `ascli` to call raw REST API endpoints for any supported Aspera product using the `api` subcommand within that product's context.

## Reference documentation
- [IBM Aspera CLI Overview](./references/github_com_IBM_aspera-cli.md)
- [Aspera CLI Issues and Common Failures](./references/github_com_IBM_aspera-cli_issues.md)