---
name: rabix-bunny
description: Rabix Bunny is a lightweight command-line engine used to execute and test Common Workflow Language workflows on a single node. Use when user asks to execute CWL 1.0 or draft-2 workflows, run tools in Docker containers, or override workflow input parameters via the command line.
homepage: https://github.com/rabix/bunny
---


# rabix-bunny

## Overview

Rabix Bunny is a lightweight, Java-based command-line engine used to execute computational workflows. While it is a legacy tool, it remains a stable choice for local testing and development of workflows that adhere to the Common Workflow Language (CWL) 1.0 or the earlier Seven Bridges draft-2 specifications. It functions by orchestrating the execution of individual tools, typically within Docker containers, and managing the data flow between them on a single node.

## Command Line Usage

The primary interface for the executor is the `rabix` executable.

### Basic Execution
To run a workflow or tool with a predefined set of inputs:
```bash
rabix <app_path> <inputs_path>
```

### Overriding Inputs via CLI
You can provide or override specific input parameters directly in the command line by using the `--` separator after the standard arguments.
```bash
rabix <app_path> <inputs_path> -- --<input_id> <value>
```

### Handling Array/List Inputs
When an input port accepts a list of values, repeat the flag for each item in the list:
```bash
rabix tool.json inputs.json -- --sample_file file1.fastq --sample_file file2.fastq
```

### Execution Environment Control
By default, Rabix Bunny attempts to run tools inside Docker containers as specified in the tool definition.
*   **Local Execution**: Use the `--no-container` flag to run the tool directly on the host machine. This requires all software dependencies (e.g., Python, R, Samtools) to be pre-installed in the local environment.
    ```bash
    rabix --no-container <app_path> <inputs_path>
    ```

## Best Practices and Expert Tips

*   **Java Requirement**: Ensure Java Runtime Environment (JRE) version 8 or higher is installed. Rabix Bunny is known to have compatibility issues with Java 10+ on certain operating systems like Windows.
*   **Docker Dependency**: Unless using `--no-container`, Docker must be running on the host system to pull and execute the required tool images.
*   **Path Resolution**: 
    *   Relative paths provided within an input JSON file are resolved relative to the location of that JSON file.
    *   Relative paths provided via the command line (after the `--` separator) are resolved relative to the current working directory.
*   **Legacy Compatibility**: Use Rabix Bunny specifically when working with `sbg:draft-2` workflows. For modern CWL versions (1.1, 1.2+), consider using `cwltool` or `Toil` as Rabix Bunny development is focused on maintaining 1.0 and draft-2 stability.
*   **Resource Monitoring**: Since Bunny is a single-node executor, ensure the host machine has sufficient CPU and RAM to handle the peak requirements of the workflow steps, as it does not natively support distributed cluster scheduling without additional backend configuration (like TES).

## Reference documentation
- [Rabix Bunny GitHub Repository](./references/github_com_rabix_bunny.md)
- [Rabix Bunny Wiki](./references/github_com_rabix_bunny_wiki.md)
- [Bioconda Rabix-Bunny Package](./references/anaconda_org_channels_bioconda_packages_rabix-bunny_overview.md)