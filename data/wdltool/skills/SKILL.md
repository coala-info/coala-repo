---
name: wdltool
description: wdltool is a command-line utility for validating, parsing, and generating artifacts for WDL workflows. Use when user asks to validate WDL workflows, generate input templates, visualize workflow logic, highlight WDL syntax, or parse WDL files.
homepage: https://github.com/broadinstitute/wdltool
---


# wdltool

## Overview

wdltool is a specialized command-line utility designed to assist bioinformaticians and pipeline developers in managing WDL workflows. It acts as a pre-execution suite that ensures workflow scripts are syntactically and semantically sound before they are submitted to an execution engine like Cromwell. Use this skill to automate the generation of input templates, visualize workflow logic through directed acyclic graphs (DAGs), and debug complex import structures within WDL files.

## Core CLI Commands

The basic syntax for all operations is:
`java -jar wdltool.jar <action> <parameters>`

### 1. Validation
Performs full syntax and semantic checking, including resolving imports and verifying that called tasks exist.
- **Command**: `java -jar wdltool.jar validate <workflow.wdl>`
- **Expert Tip**: Always run validation after modifying task signatures or import paths. It catches "task not found" errors and namespace collisions that simple parsers might miss.

### 2. Generating Input Templates
Computes all required inputs for a workflow and outputs a JSON skeleton.
- **Command**: `java -jar wdltool.jar inputs <workflow.wdl>`
- **Usage**: Redirect the output to a file: `java -jar wdltool.jar inputs my_wf.wdl > inputs.json`.
- **Best Practice**: Use this command to ensure your input JSON matches the expected types (e.g., `Array[String]`, `Int`, `File`) exactly as defined in the WDL.

### 3. Workflow Graphing
Generates a data-flow graph in Graphviz DOT format to visualize the execution path.
- **Command**: `java -jar wdltool.jar graph <workflow.wdl>`
- **Advanced Flag**: Use `--all` to include all nodes, including task declarations and call outputs, even if they are not explicitly executed in the main flow.
- **Visualization**: Pipe the output to Graphviz: `java -jar wdltool.jar graph my_wf.wdl | dot -Tpng -o workflow_graph.png`.

### 4. Syntax Highlighting
Reformats and colorizes WDL code for documentation or terminal viewing.
- **Command**: `java -jar wdltool.jar highlight <workflow.wdl> <html|console>`
- **Output**: `html` wraps elements in `<span>` tags; `console` uses ANSI color codes.

### 5. Parsing
Performs low-level grammar checks and outputs an Abstract Syntax Tree (AST).
- **Command**: `java -jar wdltool.jar parse <workflow.wdl>`
- **Note**: This is a lower-level check than `validate`. Use `validate` for functional workflow verification and `parse` only for debugging grammar-specific issues.

## Best Practices and Tips

- **Exit Codes**: wdltool returns non-zero exit codes on validation failures. Use this in CI/CD pipelines to block broken workflows from being deployed.
- **Standard Input**: You can pipe WDL content directly into the parser using `/dev/stdin`:
  `echo "workflow wf {}" | java -jar wdltool.jar parse /dev/stdin`
- **Legacy Status**: Note that wdltool was succeeded by WOMtool. If you encounter features in newer WDL versions (1.0+) that fail validation, consider using the WOMtool JAR provided with Cromwell releases.

## Reference documentation
- [wdltool GitHub Repository](./references/github_com_broadinstitute_wdltool.md)
- [wdltool Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_wdltool_overview.md)