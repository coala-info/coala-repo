---
name: wdltool
description: wdltool is a Java utility used to validate, parse, and prepare WDL scripts for workflow execution. Use when user asks to validate WDL syntax, generate input JSON templates, or visualize workflow data-flow graphs.
homepage: https://github.com/broadinstitute/wdltool
metadata:
  docker_image: "quay.io/biocontainers/wdltool:0.14--1"
---

# wdltool

## Overview

wdltool is a specialized Java utility designed to streamline the development and debugging of WDL scripts. It serves as a pre-execution toolkit that allows developers to perform static analysis, ensure semantic correctness, and prepare the necessary configuration files for workflow engines like Cromwell. By using wdltool, you can catch syntax errors early, understand complex data flows through visualization, and automatically generate the schemas required to provide workflow parameters.

## Command Line Usage

The tool is typically executed as a runnable JAR file. The basic syntax is:
`java -jar wdltool.jar <action> <parameters>`

### Core Actions

- **validate**: Performs full syntax and semantic checking. It resolves imports and ensures that all called tasks exist and namespaces do not conflict.
  - Example: `java -jar wdltool.jar validate my_workflow.wdl`
- **inputs**: Generates a JSON skeleton containing all required inputs for a workflow. This is the standard way to create a template for your parameter files.
  - Example: `java -jar wdltool.jar inputs my_workflow.wdl`
- **graph**: Generates a data-flow graph in `.dot` format. This is useful for visualizing the Directed Acyclic Graph (DAG) of your workflow.
  - Example: `java -jar wdltool.jar graph my_workflow.wdl > workflow_graph.dot`
  - Use the `--all` flag to include non-executable nodes like task declarations and outputs in the graph.
- **highlight**: Reformats and colorizes WDL code.
  - `console`: Outputs colorized text directly to the terminal.
  - `html`: Wraps WDL elements in `<span>` tags for web display.
- **parse**: Performs a low-level grammar check and outputs the Abstract Syntax Tree (AST). Note that `validate` is preferred for general use as it includes higher-level semantic checks.

## Best Practices and Expert Tips

- **Pre-flight Validation**: Always run the `validate` command before attempting to run a WDL on a production cluster. It catches common errors like missing task references or duplicate variable names that might only appear mid-execution otherwise.
- **Input Template Management**: When using the `inputs` command, the generated JSON values indicate the expected type (e.g., `"String"`, `"Array[Int]"`). Do not change the keys; only replace the type-string values with your actual data.
- **Visualizing Dependencies**: If a workflow is failing due to unexpected execution order, use `graph` to verify that your `call` dependencies are correctly linked via input/output mapping.
- **Standardizing Code**: Use `highlight <file> console` to quickly check the structure of a complex WDL file in a terminal environment; the colorization helps distinguish between keywords, variables, and command blocks.



## Subcommands

| Command | Description |
|---------|-------------|
| java -jar wdltool.jar | Performs various operations on WDL files. |
| wdltool | Validates a WDL file. |
| wdltool graph | Generate a graphviz DOT representation of a WDL workflow. |
| wdltool womgraph | Generate a DOT graph of a WDL workflow or CWL document. |
| wdltool_inputs | Generate JSON inputs for a WDL workflow. |
| wdltool_parse | Parses a WDL file and prints its Abstract Syntax Tree (AST). |

## Reference documentation

- [WDLtool README](./references/github_com_broadinstitute_wdltool_blob_develop_README.md)