---
name: nebulizer
description: Nebulizer provides a suite of command-line utilities for remote Galaxy administration and automation. Use when user asks to manage Galaxy users, install or update tools, organize data libraries, or configure storage quotas.
homepage: https://github.com/pjbriggs/nebulizer
---


# nebulizer

## Overview
Nebulizer provides a suite of command-line utilities for remote Galaxy administration. It simplifies complex API interactions into straightforward subcommands for managing users, tools, and data. It is particularly useful for batch operations, server-to-server data management, and automation tasks where the web UI is inefficient.

## Authentication and Aliases
To interact with a Galaxy instance, you need the URL and either an API key or user credentials.

### Managing API Keys
Instead of providing credentials for every command, store them as aliases to simplify your workflow and keep keys out of your shell history:
- **Store a key manually**: `nebulizer add_key <alias> <url> <api_key>`
- **Fetch and store a key via login**: `nebulizer -u <user@domain> add_key <alias> <url>`

Once stored, use the alias in place of the URL:
`nebulizer list_libraries <alias>`

## Common Administrative Workflows

### User Management
- **List all users**: `nebulizer list_users <alias>`
- **Bulk onboarding**: Use `create_batch_users` for multiple accounts or `create_users_from_file <alias> <file>` to import users from a structured list.
- **Cleanup**: `nebulizer delete_user <alias> <username_or_email>`

### Tool Management
Nebulizer interacts with the Galaxy ToolShed to manage software lifecycle:
- **Search**: `nebulizer search_toolshed <query>`
- **Install**: `nebulizer install_tool <alias> <tool_id>`
- **Update**: `nebulizer update_tool <alias> <tool_id>`
- **Replication**: Use `nebulizer list_tools <alias> --mode=export` to generate a list of installed tools, which can be used to mirror the toolset on another instance.

### Data Library Management
- **Create Library**: `nebulizer create_library <alias> "Library Name"`
- **Organize**: `nebulizer create_library_folder <alias> <library_id> "Folder Name"`
- **Upload**: `nebulizer add_library_datasets <alias> <library_id> <file_paths>`

### Quota Management
- **View Quotas**: `nebulizer quotas <alias>`
- **Modify**: Use `quota_add`, `quota_mod`, and `quota_del` to manage storage limits for different user groups.

## System Queries
- **Health Check**: `nebulizer ping <alias>` to verify if the Galaxy instance is alive and the API is responsive.
- **Configuration**: `nebulizer config <alias>` to fetch the configuration and version details of the target Galaxy instance.

## Best Practices
- **Caution with Production**: Nebulizer operations are often irreversible. Always test user deletion or batch creation on a staging instance first.
- **Secure Credentials**: Prefer using the `-u` (user) option to prompt for a password rather than passing the password via the `-P` flag in plain text.
- **Virtual Environments**: Install nebulizer in a dedicated virtual environment (`pip install nebulizer`) to avoid dependency conflicts with other Bioblend-based tools.

## Reference documentation
- [Nebulizer GitHub Repository](./references/github_com_pjbriggs_nebulizer.md)
- [Bioconda Nebulizer Overview](./references/anaconda_org_channels_bioconda_packages_nebulizer_overview.md)