---
name: sphinxcontrib-programoutput
description: This Sphinx extension executes shell commands during the documentation build and captures their output directly into the document. Use when user asks to insert command output into Sphinx documentation, simulate terminal sessions, or display help menus and version information automatically.
homepage: https://github.com/OpenNTI/sphinxcontrib-programoutput
---


# sphinxcontrib-programoutput

## Overview
The `sphinxcontrib-programoutput` extension allows Sphinx to execute arbitrary shell commands during the documentation build process and capture their output (stdout and stderr) directly into the document. This eliminates the need to manually copy-paste terminal output, which frequently becomes outdated as software evolves. It provides two primary directives: one for raw output and another for simulated shell sessions.

## Installation and Setup
To use this extension, it must be installed in the Python environment where Sphinx runs:

```bash
pip install sphinxcontrib-programoutput
```

Enable the extension by adding it to the `extensions` list in your Sphinx `conf.py` file:

```python
extensions = ['sphinxcontrib.programoutput']
```

## Core Directives

### program-output
Use this directive to insert the literal output of a command. This is ideal for displaying version information or the contents of a help menu.

```rst
.. program-output:: python -V
```

### command-output
Use this directive to mimic a terminal session. It automatically prefixes the command with a shell prompt (defaulting to `$`), making it suitable for tutorials and "Getting Started" guides.

```rst
.. command-output:: python --help
```

## Usage Best Practices

### Customizing Output Language
By default, the output is treated as plain text. Use the `:language:` option to apply specific syntax highlighting (e.g., json, bash, or python) to the captured output.

```rst
.. program-output:: my-tool --generate-json
   :language: json
```

### Handling Working Directories
If the command needs to run from a specific location relative to the documentation source, use the `:cwd:` option.

```rst
.. program-output:: cat config.json
   :cwd: ../examples
```

### Capturing Specific Lines
To avoid cluttering documentation with long outputs, use the `:ellipsis:` option to truncate the result. You can also use `:nostderr:` if you only want to show successful output and hide error messages.

### Return Code Validation
By default, the extension expects a return code of 0. If a command is expected to fail (e.g., demonstrating an error message), specify the expected return code to prevent the Sphinx build from failing:

```rst
.. command-output:: my-tool --invalid-flag
   :returncode: 2
```

## Reference documentation
- [Main README](./references/github_com_OpenNTI_sphinxcontrib-programoutput.md)