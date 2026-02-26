---
name: pywdl
description: pywdl is a Python-based parser and object model for transforming Workflow Description Language source code into native Python objects or an Abstract Syntax Tree. Use when user asks to parse WDL files, inspect workflow structures programmatically, generate an AST, or validate WDL syntax using Python.
homepage: https://github.com/broadinstitute/pywdl
---


# pywdl

## Overview

pywdl is a Python-based parser and object model for the Workflow Description Language (WDL). It enables the transformation of WDL source code into native Python objects (like Workflows and Tasks) or a raw Abstract Syntax Tree (AST). This is particularly useful for developers building static analysis tools, custom WDL validators, or scripts that need to programmatically inspect the structure and commands of a bioinformatics workflow.

## Installation

Install the package via pip:

```bash
pip install wdl
```

## Core Workflows

### Parsing WDL into Python Objects
The most common use case is converting WDL source into a `WdlDocument` object to inspect workflows and tasks.

```python
import wdl

wdl_code = """
task hello {
  String name
  command { echo "hello ${name}" }
  output { String out = read_string(stdout()) }
}
workflow wf { call hello }
"""

# Parse string into Python objects
wdl_namespace = wdl.loads(wdl_code)

# Accessing workflow metadata
for workflow in wdl_namespace.workflows:
    print(f"Workflow: {workflow.name}")
    for call in workflow.calls():
        print(f"  Call: {call.name} (Task: {call.task.name})")

# Accessing task details
for task in wdl_namespace.tasks:
    print(f"Task: {task.name}")
    print(f"Command: {task.command}")
```

### Working with the Abstract Syntax Tree (AST)
For low-level analysis or when the high-level object model is insufficient, use the parser directly to generate an AST.

```python
import wdl.parser

# Parse to AST
ast = wdl.parser.parse(wdl_code).ast()

# Print indented AST structure
print(ast.dumps(indent=2))

# Find specific nodes (e.g., all Task definitions)
task_asts = wdl.find_asts(ast, 'Task')
for t in task_asts:
    print(t.attr('name').source_string)
```

### Command Line Usage
pywdl provides a CLI tool for quick inspection of WDL files.

*   **Parse and view AST**: Useful for debugging WDL syntax and seeing how the parser interprets the file.
    ```bash
    wdl parse example.wdl
    ```

## Expert Tips

*   **Command Instantiation**: You can programmatically "fill in" variables in a task's command block using a lookup function.
    ```python
    def my_lookup(var_name):
        return wdl.values.WdlString("world") if var_name == "name" else None

    instantiated_cmd = task.command.instantiate(my_lookup)
    ```
*   **AST Navigation**: Use the `.attr()` method on AST nodes to access children. Nodes are typically categorized as `Ast`, `AstList`, or `Terminal`.
*   **Base64 Encoding**: By default, `ast.dumps()` may base64 encode source strings to handle special characters. Set `b64_source=False` if you need human-readable output during debugging.

## Reference documentation
- [pywdl README](./references/github_com_broadinstitute_pywdl.md)