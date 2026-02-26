---
name: ephemeris
description: Ephemeris automates the administrative bootstrapping and management of Galaxy servers, including tool installation, workflow deployment, and data library setup. Use when user asks to install tools from the Tool Shed, extract tool lists from workflows or instances, setup data libraries, or validate Galaxy configurations.
homepage: https://github.com/galaxyproject/ephemeris
---


# ephemeris

## Overview
Ephemeris is a specialized Python library and suite of command-line utilities designed to automate the administrative "bootstrapping" of a Galaxy server. It streamlines the process of managing Galaxy plugins—specifically tools from the Tool Shed, data libraries, and workflows. This skill enables the programmatic setup of Galaxy instances, allowing administrators to move away from manual GUI-based configurations toward reproducible, scriptable infrastructure.

## CLI Usage and Best Practices

### Tool Management with `shed-tools`
The `shed-tools` command is the primary utility for interacting with the Galaxy Tool Shed.
- **Installation**: Use `shed-tools install` to automate the deployment of tools to a Galaxy instance.
- **Testing**: Use `shed-tools test` to verify that installed tools are functioning correctly within the environment.
- **Filtering**: When targeting specific tools, use the `--name` and `--owner` flags to narrow the scope of the operation.
- **Error Handling**: Be aware that `shed-tools` may not always return a non-zero exit code on installation errors; always verify the output logs in critical automation paths.

### Extracting and Converting Tool Lists
- **`get-tool-list`**: Use this to extract a list of currently installed tools from a running Galaxy instance. This is essential for "cloning" the tool state of one server to another.
- **`workflow-to-tool`**: Use this to parse a Galaxy workflow file (`.ga`) and generate a list of all tools required to run that workflow. This ensures that an instance is prepared to execute specific pipelines.

### Data Library Setup
- **`setup-data-library`**: Use this to automate the creation of data libraries and the uploading of datasets.
- **Optimization**: Use the `--link` flag (where supported) to link to data files rather than copying them, which saves significant disk space and reduces I/O overhead during bootstrapping.

### Instance Configuration and Validation
- **`check_galaxy_config`**: Use this utility when upgrading a Galaxy instance to validate the configuration and ensure compatibility with the new version.
- **`galaxy-tool-test`**: A dedicated command for running functional tests on tools already integrated into the Galaxy instance.

### Expert Tips
- **Verbosity**: Use the `--verbose` argument during initial script development to capture detailed transaction logs between Ephemeris and the Galaxy API.
- **Workflow Integration**: When building a new Galaxy environment, the recommended pattern is:
    1. Extract tool requirements from workflows using `workflow-to-tool`.
    2. Install those tools using `shed-tools install`.
    3. Populate required reference data using `setup-data-library`.
- **SSL Verification**: If working with local or development Galaxy instances using self-signed certificates, look for flags to skip SSL verification to prevent connection failures.

## Reference documentation
- [Ephemeris Overview (Bioconda)](./references/anaconda_org_channels_bioconda_packages_ephemeris_overview.md)
- [Galaxy Project Ephemeris Repository](./references/github_com_galaxyproject_ephemeris.md)
- [Ephemeris Issues and Command References](./references/github_com_galaxyproject_ephemeris_issues.md)
- [Ephemeris Pull Requests and Feature Updates](./references/github_com_galaxyproject_ephemeris_pulls.md)