---
name: gxformat2
description: gxformat2 converts Galaxy workflows between native JSON and human-friendly YAML formats while providing tools for validation and visualization. Use when user asks to convert workflows between formats, lint workflow logic, visualize workflow structures, or export abstract workflow representations.
homepage: https://github.com/jmchilton/gxformat2
---

# gxformat2

## Overview
The gxformat2 toolset provides a bridge between the complex, machine-oriented native Galaxy workflow format (.ga) and a more concise, human-friendly YAML representation known as Format 2. This skill enables the efficient use of command-line utilities to validate workflow logic, visualize structures, and transform files between formats to facilitate better version control and manual editing of Galaxy workflows.

## CLI Usage Patterns

### Workflow Conversion
The primary use of gxformat2 is translating between workflow formats.

*   **Convert Format 2 to Native Galaxy**: Use this to prepare a human-written YAML workflow for import into a Galaxy instance.
    `gxwf-to-native workflow.yml`
*   **Convert Native Galaxy to Format 2**: Use this to turn an exported `.ga` file into a readable YAML format for version control or manual auditing.
    `gxwf-to-format2 workflow.ga`

### Validation and Linting
Before importing or sharing a workflow, ensure it adheres to the schema and contains no logical errors.

*   **Lint a Workflow**: Checks for common issues and schema violations.
    `gxwf-lint workflow.yml`

### Visualization
Generate a visual representation of the workflow steps and connections.

*   **Visualize a Workflow**: Creates a diagram of the workflow structure.
    `gxwf-viz workflow.yml`

### Abstract Export
*   **Export Abstract Workflow**: Generates an abstract representation of the workflow.
    `gxwf-abstract-export workflow.yml`

## Expert Tips and Best Practices

*   **Version Control**: Always convert native `.ga` files to Format 2 before committing to Git. The YAML representation is significantly more "diff-friendly" than the native JSON-based `.ga` format.
*   **Pre-conversion Linting**: Run `gxwf-lint` on any manually edited Format 2 files before attempting to convert them to native format to catch syntax errors early.
*   **Source References**: When manually editing workflows, remember that gxformat2 uses the `step_label/output_name` pattern for connections. If a label contains a `/`, the tool uses specific resolution logic defined in its model to disambiguate the reference.
*   **Normalization**: The tool automatically handles "step outs" and anonymous references during normalization, allowing for more concise workflow definitions than the native format requires.



## Subcommands

| Command | Description |
|---------|-------------|
| gxwf-abstract-export | This script converts an executable Galaxy workflow (in either format - Format 2 or native .ga) into an abstract CWL representation. In order to represent Galaxy tool executions in the Common Workflow Language workflow language, they are serialized as v1.2+ abstract 'Operation' classes. Because abstract 'Operation' classes are used, the resulting CWL workflow is not executable - either in Galaxy or by CWL implementations. The resulting CWL file should be thought of more as a common metadata specification describing the workflow structure. |
| gxwf-lint | Lint a workflow file. |
| gxwf-viz | This script converts an executable Galaxy workflow (in either format - Format 2 or native .ga) into a format for visualization with Cytoscape (https://cytoscape.org/). If the target output path ends with .html this script will output a HTML page with the workflow visualized using cytoscape.js. Otherwise, this script will output a JSON description of the workflow elements for consumption by Cytoscape. |

## Reference documentation
- [Galaxy Workflow Format 2 GitHub](./references/github_com_galaxyproject_gxformat2.md)
- [gxformat2 Project Structure and Patterns](./references/github_com_jmchilton_gxformat2_blob_main_CLAUDE.md)