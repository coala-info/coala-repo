---
name: pyscaf
description: PyScaffold is a powerful project generator that automates the creation of high-quality Python packages.
homepage: https://github.com/pyscaffold/pyscaffold
---

# pyscaf

## Overview
PyScaffold is a powerful project generator that automates the creation of high-quality Python packages. Instead of manually creating boilerplate, this skill allows you to use the `putup` tool to set up a project that follows modern Python ecosystem best practices, including declarative configuration via `setup.cfg`, automated versioning through Git tags, and pre-configured testing environments.

## Core CLI Patterns

### Project Initialization
The primary command for PyScaffold is `putup`.
- **Basic Setup**: `putup project_name` creates a standard directory structure.
- **Interactive Mode**: `putup --interactive project_name` provides a guided walkthrough for configuration.
- **Adding Extensions**: Use flags to bundle common tools:
  - `putup --pre-commit project_name`: Includes pre-commit hook configuration.
  - `putup --cirrus project_name`: Adds Cirrus CI support.
  - `putup --license mit project_name`: Sets a specific license.

### Post-Scaffold Workflow
Once the project is generated, follow these steps to initialize the environment:
1. `cd project_name`
2. `pip install -e .` (Perform an editable install to link the source code).
3. `tox` (Run the automated test suite and documentation builder).

## Expert Tips and Best Practices

### Configuration Management
- **Prefer setup.cfg**: PyScaffold uses a declarative approach. Avoid modifying `setup.py` directly; instead, update metadata, dependencies, and tool settings in `setup.cfg`.
- **Versioning**: PyScaffold uses `setuptools_scm`. You do not need to manually update version strings. Simply tag your Git commits (e.g., `git tag v0.1.0`) and the tool will automatically infer the version for builds and `my_project.__version__`.

### Handling Package Data
- To include non-Python files (images, text files) in your distribution, place them inside the `src/` directory and ensure `include_package_data = True` is set in the `[options]` section of `setup.cfg`.
- Files tracked by Git are automatically included if they are within the package namespace.

### Automation with Tox
PyScaffold projects come with a pre-configured `tox.ini`. Use these common environments:
- `tox -e build`: Build the source and wheel distributions.
- `tox -e docs`: Generate HTML documentation using Sphinx.
- `tox -e publish`: Test the upload process to TestPyPI.

### Testing
- All tests should be placed in the `tests/` directory.
- PyScaffold configures `pytest` with `pytest-cov` by default. Run `pytest` directly or via `tox` to see coverage reports.

## Reference documentation
- [PyScaffold Main Documentation](./references/github_com_pyscaffold_pyscaffold.md)