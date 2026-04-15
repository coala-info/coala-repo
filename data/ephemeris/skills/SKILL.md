---
name: ephemeris
description: Ephemeris automates the management of Galaxy servers by programmatically installing tools, workflows, and reference data. Use when user asks to install tools from the Tool Shed, manage reference data via Data Managers, import workflows, or extract tool lists from a Galaxy instance.
homepage: https://github.com/galaxyproject/ephemeris
metadata:
  docker_image: "quay.io/biocontainers/ephemeris:0.10.11--pyhdfd78af_0"
---

# ephemeris

## Overview
Ephemeris is a specialized Python library and CLI toolset designed to automate the "day 1" and "day 2" operations of a Galaxy server. It provides a bridge between a fresh Galaxy installation and a fully functional bioinformatics platform by programmatically handling the installation of tools from the Tool Shed, managing reference data via Data Managers, and importing complex workflows. It is the standard tool for Galaxy administrators to ensure reproducible environment setups.

## Core Commands and Usage

### Waiting for Galaxy Connectivity
Before running any automation scripts (especially in Docker or CI environments), use `galaxy-wait` to ensure the API is reachable.
```bash
# Wait for a local Galaxy instance with a 60-second timeout
galaxy-wait -g http://localhost:8080 --timeout 60 -v
```

### Tool Management
The `shed-tools` command is the primary interface for installing and updating tools from the Galaxy Tool Shed.

*   **Install tools from a list:**
    ```bash
    shed-tools install -g https://galaxy-url.org -a <API_KEY> -t tool_list.yaml
    ```
*   **Update all installed tools to the latest revision:**
    ```bash
    shed-tools update -g https://galaxy-url.org -a <API_KEY>
    ```
*   **Test installed tools:**
    ```bash
    shed-tools test -g https://galaxy-url.org -a <API_KEY> --test-user admin@example.org
    ```

### Extracting Tool Lists
To replicate an environment, use `get-tool-list` to generate a YAML file representing all tools currently on a Galaxy instance.
```bash
get-tool-list -g https://usegalaxy.org -o my_tools.yaml --include-tool-panel-id
```

### Workflow and Data Management
*   **Install Workflows:** Import `.ga` files into a Galaxy instance.
    ```bash
    workflow-install -g https://galaxy-url.org -a <API_KEY> -w ./my_workflows/ --publish-workflows
    ```
*   **Generate Tool Lists from Workflows:** Extract a list of required tools from a workflow file to ensure they are installed before the workflow is run.
    ```bash
    workflow-to-tools -w workflow.ga -o required_tools.yaml -l "Workflow Tools"
    ```
*   **Setup Data Libraries:** Bulk upload data into Galaxy Data Libraries using a folder or file.
    ```bash
    setup-data-libraries -g https://galaxy-url.org -a <API_KEY> -i data_manifest.yaml
    ```
*   **Run Data Managers:** Automate the indexing of reference genomes.
    ```bash
    run-data-managers -g https://galaxy-url.org -a <API_KEY> --config data_manager_config.yaml
    ```

## Expert Tips
*   **API Keys:** Most commands require a Galaxy Admin API key. Ensure the user associated with the key has administrative privileges.
*   **Tool Panel Organization:** When installing tools via `shed-tools`, use the `--section-label` argument to automatically create or place tools into specific categories in the Galaxy UI.
*   **Idempotency:** `run-data-managers` checks if a data table entry (like a genome index) already exists before running, making it safe to run repeatedly in setup scripts.
*   **Verbosity:** Use the `-v` flag to debug connection issues or monitor the progress of long-running tool installations.



## Subcommands

| Command | Description |
|---------|-------------|
| galaxy-tool-test | Script to quickly run a tool test against a running Galaxy instance. |
| get-tool-list | Generates a tool_list.yml file for Galaxy. |
| shed-tools | A command-line tool for managing tools in Galaxy from the Tool Shed. |

## Reference documentation
- [Ephemeris Commands Overview](./references/ephemeris_readthedocs_io_en_latest_commands.html.md)
- [Galaxy-wait Documentation](./references/ephemeris_readthedocs_io_en_latest_commands_galaxy-wait.html.md)
- [Shed-tools Documentation](./references/ephemeris_readthedocs_io_en_latest_commands_shed-tools.html.md)
- [Run-data-managers Documentation](./references/ephemeris_readthedocs_io_en_latest_commands_run-data-managers.html.md)