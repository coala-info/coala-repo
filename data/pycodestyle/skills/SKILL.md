---
name: pycodestyle
description: pycodestyle (formerly known as pep8) is a lightweight, single-file Python utility designed to check source code against the style conventions defined in PEP 8.
homepage: https://github.com/PyCQA/pycodestyle
---

# pycodestyle

## Overview
pycodestyle (formerly known as pep8) is a lightweight, single-file Python utility designed to check source code against the style conventions defined in PEP 8. It provides a plugin-based architecture that makes it easy to identify specific formatting violations, ranging from indentation errors to improper whitespace around operators. This skill focuses on the native command-line interface and configuration patterns used to integrate style checking into a Python development workflow.

## Installation
Install the tool via pip:
```bash
pip install pycodestyle
```

## Common CLI Patterns

### Basic Auditing
To check a single file or an entire directory:
```bash
pycodestyle my_script.py
pycodestyle my_project/
```

### Educational Output
If you are unsure why a specific error is being triggered, use these flags to see the source line and the relevant PEP 8 documentation:
```bash
pycodestyle --show-source --show-pep8 path/to/code.py
```

### Reporting and Statistics
To get a high-level overview of the most frequent style violations in a codebase:
```bash
pycodestyle --statistics -qq .
```

### Filtering Results
You can limit the check to specific error codes or ignore others entirely:
```bash
# Only check for indentation (E1) and blank line (E3) issues
pycodestyle --select=E1,E3 .

# Ignore line length (E501) and trailing whitespace (W291)
pycodestyle --ignore=E501,W291 .
```

## Configuration
Instead of passing flags every time, pycodestyle looks for configuration in `setup.cfg` or `tox.ini` files.

### Example setup.cfg / tox.ini
```ini
[pycodestyle]
count = False
ignore = E226,E302,E41
max-line-length = 120
statistics = True
exclude = .venv,build,dist
```

## Expert Tips
- **Single File Portability**: The tool is contained in a single file (`pycodestyle.py`). You can include this file directly in a project if you want to avoid external dependencies.
- **Exit Codes**: pycodestyle returns a non-zero exit code if any errors are found. This makes it ideal for use in pre-commit hooks or CI/CD pipelines to block poorly formatted code.
- **Diff Checking**: You can pipe a git diff into pycodestyle to check only the lines you have changed, though this often requires external wrappers or specific shell scripting.
- **Renaming Note**: If you encounter older documentation or scripts referencing the `pep8` command, it is functionally identical to `pycodestyle`.

## Reference documentation
- [pycodestyle README](./references/github_com_PyCQA_pycodestyle.md)
- [pycodestyle Wiki](./references/github_com_PyCQA_pycodestyle_wiki.md)