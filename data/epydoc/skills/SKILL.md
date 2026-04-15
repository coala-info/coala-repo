---
name: epydoc
description: Generates API documentation for Python projects. Use when user asks to generate documentation for Python code.
homepage: https://github.com/nltk/epydoc
metadata:
  docker_image: "quay.io/biocontainers/epydoc:3.0.1--py27_0"
---

# epydoc

epydoc/SKILL.md
---
name: epydoc
description: |
  Generates API documentation for Python projects. Use when you need to create
  or update documentation for Python code, especially for projects that
  follow standard Python docstring conventions. This tool is useful for
  generating HTML or text-based documentation from source code.
---
## Overview
epydoc is a tool for automatically generating API documentation from Python source code. It parses docstrings and code structure to create human-readable documentation, typically in HTML or text formats. Use epydoc when you need to document your Python project's modules, classes, functions, and methods in a structured and automated way.

## Usage Instructions

epydoc is primarily used via its command-line interface. The core command is `epydoc`.

### Basic Command Structure

The general syntax for running epydoc is:

```bash
epydoc [options] <module-path> ...
```

Where `<module-path>` can be a Python module, package, or a directory containing Python modules.

### Key Options and Patterns

*   **Output Format**:
    *   To generate HTML documentation:
        ```bash
        epydoc --html --output <output-directory> <module-path>
        ```
        The `--output` option specifies the directory where the generated HTML files will be placed.
    *   To generate text documentation:
        ```bash
        epydoc --output <output-directory> <module-path>
        ```
        If `--html` is not specified, epydoc defaults to generating text output.

*   **Module Specification**:
    *   Documenting a single module:
        ```bash
        epydoc --html --output ./docs my_module.py
        ```
    *   Documenting a package (directory):
        ```bash
        epydoc --html --output ./docs my_package/
        ```
        epydoc will recursively find and document modules within the specified package directory.

*   **Excluding Modules/Files**:
    Use the `--exclude` option to skip specific modules or files.
    ```bash
    epydoc --html --output ./docs --exclude test_*.py my_package/
    ```

*   **Graph Generation (UML)**:
    epydoc can generate UML diagrams if Graphviz is installed.
    ```bash
    epydoc --uml --output ./docs <module-path>
    ```
    Note: The provided documentation indicates that UML diagram generation might be an area with open issues or requiring specific configurations.

*   **Configuration Files**:
    For complex projects, you can use a configuration file to specify options. Create a file (e.g., `epydoc.conf`) and use the `--config` option:
    ```bash
    epydoc --config epydoc.conf <module-path>
    ```
    The configuration file can contain any valid epydoc command-line options, one per line.

### Expert Tips

*   **Docstring Conventions**: epydoc works best with well-formatted docstrings. Adhere to standard Python docstring conventions (e.g., PEP 257) for optimal results.
*   **Project Structure**: Organize your Python code into modules and packages for cleaner documentation generation.
*   **Version Control**: Keep your documentation generation process within your version control system. Commit generated documentation or the scripts to generate it.
*   **Troubleshooting UML**: If UML diagrams are not generating, ensure Graphviz is correctly installed and accessible in your system's PATH. Check the project's issue tracker for any known limitations or specific requirements.



## Subcommands

| Command | Description |
|---------|-------------|
| epydoc | epydoc is a tool for generating documentation from Python docstrings. |
| epydoc | epydoc |
| epydoc | epydoc is a tool for automatically generating API documentation for Python modules. |
| epydoc | epydoc |
| epydoc | epydoc is a tool for automatically generating API documentation for Python modules. |
| epydoc | epydoc [ACTION] [options] NAMES... |
| epydoc | epydoc |
| epydoc | Write and format documentation for Python modules |

## Reference documentation
- [Edward Loper's API Documentation Generation Tool](./references/anaconda_org_channels_bioconda_packages_epydoc_overview.md)
- [Automatic API Documentation Generation for Python](./references/github_com_nltk_epydoc.md)