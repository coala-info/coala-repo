---
name: womtool
description: The `womtool` skill provides a suite of utilities for managing the lifecycle of WDL workflows.
homepage: https://cromwell.readthedocs.io/en/develop/WOMtool/
---

# womtool

## Overview
The `womtool` skill provides a suite of utilities for managing the lifecycle of WDL workflows. It acts as a static analysis and helper tool that ensures WDL files are syntactically correct and semantically sound. Use this skill to automate the creation of input files, identify missing dependencies, and generate visual representations of complex workflow directed acyclic graphs (DAGs).

## Core CLI Usage

The basic syntax for all commands is:
`java -jar womtool.jar <action> <parameters>`

### Validation and Dependencies
*   **Full Validation**: Run `validate <WDL_file>` to check for syntax errors, missing tasks, or namespace collisions.
*   **List Dependencies**: Use the `-l` or `--list-dependencies` flag with `validate` to identify all local and HTTP imported WDL files.
    *   *Example*: `java -jar womtool.jar validate -l workflow.wdl`

### Input Management
*   **Generate Input Template**: Use `inputs <WDL_file>` to create a JSON skeleton. This maps all required workflow inputs to their expected types (e.g., `String`, `Array[File]`).
    *   *Tip*: Redirect output to a file to start configuring your run: `java -jar womtool.jar inputs my_wf.wdl > inputs.json`

### Visualization and Parsing
*   **Workflow Graph**: Use `graph <WDL_file>` to generate a `.dot` format DAG.
    *   *Note*: This command may have limited support for WDL 1.0; use `womgraph` for a more robust WOM-based representation.
*   **WOM Graph**: Use `womgraph <WDL_file> [ancillary_files]` to print a graph based on the Workflow Object Model (WOM) representation.
*   **Abstract Syntax Tree (AST)**: Use `parse <WDL_file>` to view the underlying grammar structure. This is useful for deep debugging of nested definitions.

### Formatting
*   **Syntax Highlighting**: Use `highlight <WDL_file> <html|console>` to reformat and colorize WDL code for documentation or terminal viewing.

## Best Practices
*   **Validate Early**: Always run `validate` before attempting to execute a workflow in Cromwell to catch "task not found" or "type mismatch" errors.
*   **Check Imports**: When working with complex pipelines, use the `--list-dependencies` flag to ensure all remote HTTP imports are reachable and local paths are correct.
*   **Input Mapping**: When `inputs` returns an `Array` type, ensure the resulting JSON uses standard square bracket notation `["item1", "item2"]`.

## Reference documentation
- [WOMtool Documentation](./references/cromwell_readthedocs_io_en_develop_WOMtool.md)
- [Bioconda Womtool Overview](./references/anaconda_org_channels_bioconda_packages_womtool_overview.md)