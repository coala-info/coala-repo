---
name: nebulizer
description: Nebulizer is a command-line suite for performing administrative tasks and batch operations on Galaxy instances via the Bioblend library. Use when user asks to manage Galaxy users, install or update tools, organize data libraries, or modify system quotas.
homepage: https://github.com/pjbriggs/nebulizer
metadata:
  docker_image: "quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0"
---

# nebulizer

## Overview

Nebulizer is a specialized suite of CLI tools built on the Bioblend library, designed to streamline administrative tasks for Galaxy instances. It allows administrators to perform batch operations and remote management without using the Galaxy web interface. This skill provides the necessary command patterns for user management, tool installation, and data library organization.

## Authentication and Setup

Nebulizer requires a Galaxy URL and an API key (or user credentials) for all operations.

- **Store an Alias**: Avoid re-entering credentials by creating a named alias for your instance.
  `nebulizer add_key <alias_name> <galaxy_url> <api_key>`
- **Fetch Key via Login**: If you don't have the API key handy:
  `nebulizer -u <email> add_key <alias_name> <galaxy_url>`
- **Check Connection**: Verify the instance is reachable.
  `nebulizer ping <alias_name>`

## Common Command Patterns

### User Management
- **List Users**: `nebulizer list_users <alias_name>`
- **Create Single User**: `nebulizer create_user <alias_name> <email> <password> <username>`
- **Batch Creation**: Create multiple users from a file (one per line: email password username).
  `nebulizer create_users_from_file <alias_name> <users_file>`

### Tool Management
- **Search Toolshed**: Find tools to install.
  `nebulizer search_toolshed <query>`
- **List Installed Tools**: View tools currently on the instance.
  `nebulizer list_tools <alias_name>`
- **Install a Tool**: Requires the toolshed URL, owner, and name.
  `nebulizer install_tool <alias_name> <toolshed_url> <owner> <tool_name>`
- **Update/Uninstall**:
  `nebulizer update_tool <alias_name> <tool_id>`
  `nebulizer uninstall_tool <alias_name> <tool_id>`

### Data Libraries
- **List Libraries**: `nebulizer list_libraries <alias_name>`
- **Create Library**: `nebulizer create_library <alias_name> <library_name>`
- **Manage Folders**: `nebulizer create_library_folder <alias_name> <library_id> <folder_name>`

### Quota Management
- **View Quotas**: `nebulizer quotas <alias_name>`
- **Modify Quota**: `nebulizer quota_mod <alias_name> <quota_name> --amount <size>`

## Expert Tips
- **Caution on Production**: Nebulizer operations (like `delete_user` or library creation) are often irreversible. Always test commands on a staging instance first.
- **Configuration Inspection**: Use `nebulizer config <alias_name>` to quickly check server-side settings like allowed file extensions or upload limits.
- **Password Security**: Avoid using the `-P` flag in shell history; let Nebulizer prompt you for the password interactively when not using stored keys.



## Subcommands

| Command | Description |
|---------|-------------|
| nebulizer add_key | Store new Galaxy URL and API key. |
| nebulizer add_library_datasets | Add datasets to a data library. |
| nebulizer config | Report the Galaxy configuration. |
| nebulizer create_batch_users | Create multiple Galaxy users from a template. |
| nebulizer create_library | Create new data library. |
| nebulizer create_library_folder | Create new folder in a data library. |
| nebulizer create_user | Create new Galaxy user. |
| nebulizer create_users_from_file | Create multiple Galaxy users from a file. |
| nebulizer delete_user | Delete a user account from a Galaxy instance |
| nebulizer install_tool | Install tool(s) from toolshed. |
| nebulizer list_libraries | List data libraries and contents. |
| nebulizer list_tool_panel | List tool panel contents. |
| nebulizer list_tools | List information about tools and installed tool repositories. |
| nebulizer list_users | List users in Galaxy instance. |
| nebulizer ping | Sends a request to GALAXY and reports the status of the response and the time taken. |
| nebulizer quota_add | Create new quota. |
| nebulizer quota_del | Deletes QUOTA from GALAXY. |
| nebulizer quota_mod | Modify an existing quota. |
| nebulizer quotas | List quotas in Galaxy instance. |
| nebulizer remove_key | Remove stored Galaxy API key. |
| nebulizer search_toolshed | Search for repositories on a Galaxy toolshed. |
| nebulizer uninstall_tool | Uninstall previously installed tool. |
| nebulizer update_key | Update stored Galaxy API key. |
| nebulizer update_tool | Update tool installed from toolshed. |
| nebulizer whoami | Print user details associated with API key. |
| nebulizer_list_keys | List stored Galaxy API key aliases. |

## Reference documentation
- [Nebulizer GitHub Overview](./references/github_com_pjbriggs_nebulizer.md)
- [Nebulizer Wiki Home](./references/github_com_pjbriggs_nebulizer_wiki.md)