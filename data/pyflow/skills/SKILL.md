---
name: pyflow
description: PyFlow is a modular visual scripting framework for Python that allows users to build and execute logic through a node-based interface. Use when user asks to create visual dataflow pipelines, convert Python functions into reusable nodes, or execute node-based graphs in GUI or headless environments.
homepage: https://github.com/pedroCabrera/PyFlow
metadata:
  docker_image: "biocontainers/pyflow:v1.1.20-1-deb-py2_cv1"
---

# pyflow

## Overview
PyFlow is a modular, general-purpose visual scripting framework for Python. It allows users to build complex logic through a node-based interface, similar to Blueprints in Unreal Engine or Houdini's VOPs. This skill enables the creation and management of dataflow-oriented pipelines, the conversion of standard Python functions into reusable visual nodes, and the execution of these graphs in both GUI and headless environments.

## Installation and Setup
To get started with the latest development version:
```bash
pip install git+https://github.com/pedroCabrera/PyFlow.git@master
```
After installation, the tool can be invoked directly via `pyflow` (Windows/Unix) or by running `python pyflow.py` from the repository root.

## Core CLI Usage
PyFlow provides several entry points depending on the desired mode of operation:

- **Launch GUI**: Run `pyflow` or `python pyflow.py` to open the visual editor.
- **Headless Evaluation**: Use `python pyflow_run.py` to evaluate exported programs without the user interface. This is essential for CI/CD pipelines or server-side execution of visual logic.
- **MDI Mode**: Use `python pyflow-mdi.py` for the Multiple Document Interface version of the editor.

## Expert Tips and Best Practices

### 1. Fast Node Generation
Instead of manually creating node classes, use the function decorator pattern to quickly expose Python logic to the PyFlow environment. This is the most efficient way to bridge existing Python libraries with the visual editor.

### 2. Modular Package Development
PyFlow is highly modular. When building custom tools:
- Use the **Plugin Wizards** to generate package templates.
- Keep logic and UI separated; ensure your `Node` and `Pin` classes can function without GUI dependencies to maintain compatibility with `pyflow_run.py`.
- Store custom node sets in a dedicated directory and load them using the package discovery system.

### 3. Managing Complexity
- **Subgraphs**: Collapse repetitive or complex logic into subgraphs to keep the main canvas clean.
- **Variables**: Use the internal variable system to share data across the graph without creating "spaghetti" wires.
- **Comments**: Use "Sticky" nodes and "Comment" nodes to document the flow of data for other users.

### 4. Performance Considerations
The runtime execution model is optimized for flexibility rather than raw speed. For performance-critical loops:
- Avoid putting heavy delays inside standard `for loop` nodes.
- Prefer wrapping high-performance Python/C++ logic into a single node rather than building the performance-heavy loop visually.

## Reference documentation
- [PyFlow Overview](./references/github_com_pedroCabrera_PyFlow.md)
- [PyFlow Wiki](./references/github_com_pedroCabrera_PyFlow_wiki.md)