---
name: biomaj
description: BioMAJ is a workflow engine designed to automate the synchronization, update, and post-processing of local mirrors for biological datasets. Use when user asks to maintain local databank mirrors, automate biological data downloads, or manage the lifecycle of public database updates.
homepage: https://github.com/genouest/biomaj
metadata:
  docker_image: "quay.io/biocontainers/biomaj:3.0.19--py35_0"
---

# biomaj

## Overview
BioMAJ (BIOlogie Mise A Jour) is a specialized workflow engine designed to maintain local mirrors of large biological datasets. It handles the entire lifecycle of a databank update: detecting remote changes, downloading files via various protocols (FTP, HTTP, etc.), verifying data integrity, executing post-processing scripts, and moving the final dataset into a production directory. It is particularly useful for bioinformatics facilities that need to provide consistent, versioned access to public data for local users and tools.

## CLI Usage Patterns

The primary interface for BioMAJ is `biomaj-cli.py`. Always ensure your environment is configured with a `global.properties` file before execution.

### Basic Management
*   **Check System Status**: Verify the database connection and general configuration.
    ```bash
    biomaj-cli.py --config global.properties --status
    ```
*   **List Available Templates**: View pre-configured bank templates provided by the community.
    ```bash
    biomaj-cli.py --data-list
    ```
*   **Import a Bank Template**: Create a new bank configuration from a template.
    ```bash
    biomaj-cli.py --data-import --bank <bank_name>
    ```

### Update Operations
*   **Run a Bank Update**: Trigger the synchronization and post-processing workflow for a specific bank.
    ```bash
    biomaj-cli.py --config global.properties --bank <bank_name> --update
    ```
*   **Force Update**: Useful if a previous run failed or if you need to re-run processes without remote changes.
    ```bash
    biomaj-cli.py --bank <bank_name> --update --force
    ```

## Configuration Best Practices

### Property Files
BioMAJ uses `.properties` files for configuration. 
*   **global.properties**: Defines system-wide settings like the MongoDB connection string, data directories, and logging levels.
*   **Bank properties**: Located in the `conf` directory, these define bank-specific logic (e.g., `protocol=ftp`, `db.url=ftp.ncbi.nih.gov`).

### Post-Processing
Post-processes are defined in the bank property file and executed after a successful download.
*   Store custom scripts in the directory defined by `process_dir` in your global configuration.
*   Use the `postprocess` key in bank properties to chain commands (e.g., `postprocess=blast_index,emboss_index`).

### Plugins
For complex download scenarios (e.g., scraping dynamic HTML pages), use the Python plugin system.
*   Define the plugin directory: `plugins_dir=/path/to/plugins`
*   Specify the plugin in the bank file: `release.plugin=github`
*   Pass arguments: `release.plugin_args=repo=osallou/biomaj`

## Expert Tips
*   **Integrity Checks**: BioMAJ automatically performs integrity checks on downloads. If a bank fails frequently, check the `remote.list` and `local.list` logs to identify mismatched file sizes or MD5 sums.
*   **Production Directories**: BioMAJ uses an incremental approach for releases. Ensure your file system has enough space for at least two versions (current and previous) to allow for seamless "production" switching.
*   **Microservices**: For production environments, use the microservice architecture (`biomaj-daemon`) to scale download and execution processes across multiple hosts.

## Reference documentation
- [BioMAJ README](./references/github_com_genouest_biomaj.md)
- [BioMAJ Wiki](./references/github_com_genouest_biomaj_wiki.md)