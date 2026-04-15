---
name: harvest-tools
description: Harvest-tools is a modular reconnaissance framework designed for automated web-based information gathering and infrastructure discovery. Use when user asks to conduct reconnaissance, manage workspaces, install modules, manage API keys, or query harvested data.
homepage: https://github.com/lanmaster53/recon-ng
metadata:
  docker_image: "biocontainers/harvest-tools:v1.3-4-deb_cv1"
---

# harvest-tools

## Overview
Recon-ng is a modular reconnaissance framework designed to conduct thorough web-based information gathering. It utilizes a workspace-based environment to organize harvested data into structured database tables, such as domains, hosts, ports, and contacts. By leveraging a marketplace of independent modules, it allows for the automated discovery of infrastructure and personnel information from a wide variety of public APIs and web sources.

## Core Workflow Patterns

### Workspace Management
Always isolate different targets or engagements using workspaces to prevent data contamination.
- Create a new workspace: `workspaces create <name>`
- List existing workspaces: `workspaces list`
- Switch to a workspace: `workspaces load <name>`

### Module Discovery and Installation
Recon-ng uses a marketplace model where modules must be installed before use.
- Search for modules by keyword: `marketplace search <keyword>`
- Install a specific module: `marketplace install <path/to/module>`
- Update all installed modules: `marketplace update`

### Executing Modules
The framework follows a "load, configure, run" pattern similar to Metasploit.
- Load a module: `modules load <module_path>`
- View module details and required options: `info`
- Set module parameters: `options set <name> <value>`
- Execute the module: `run`
- Return to the main prompt: `back`

### Database Interaction
Data harvested by modules is automatically stored in the local database.
- View collected data: `show <hosts|contacts|domains|leaks|locations>`
- Add manual notes to a specific record: `db notes`
- Query the database directly: `db query <SQL_statement>`
- Delete data from a table: `db delete <table_name> <id>`

## Expert Tips and Best Practices

### API Key Management
Most high-utility modules require API keys. Manage these globally to ensure they are available across all workspaces.
- Add an API key: `keys add <key_name> <value>`
- List configured keys: `keys list`
- Remove a key: `keys remove <key_name>`

### Global Options
Use `goptions` to set variables that persist across different modules and workspaces.
- Set a global proxy: `goptions set PROXY <address:port>`
- Set a global user-agent: `goptions set USER-AGENT <string>`
- View all global settings: `goptions list`

### Automation with recon-cli
For non-interactive use or scripting, utilize the `recon-cli` interface.
- Run a specific module and exit: `./recon-cli -w <workspace> -m <module> -x`
- Chain multiple commands: `./recon-cli -C "workspaces load <name>; modules load <module>; run"`

### Data Maintenance
- Use the `db notes` command frequently during an engagement to document the significance of specific hosts or contacts.
- If a module fails to return results, check `info` to ensure all required options (like SOURCE) are correctly pointed to a database column or a specific string.

## Reference documentation
- [The Recon-ng Framework](./references/github_com_lanmaster53_recon-ng.md)
- [Recon-ng Wiki Home](./references/github_com_lanmaster53_recon-ng_wiki.md)
- [Recon-ng Commit History](./references/github_com_lanmaster53_recon-ng_commits_master.md)