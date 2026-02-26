---
name: spyder
description: "Spyder is a scientific integrated development environment designed for data exploration, interactive execution, and Python development. Use when user asks to launch the IDE, manage development environments, inspect variables, or perform static code analysis and profiling."
homepage: https://github.com/spyder-ide/spyder
---


# spyder

## Overview

Spyder (the Scientific Python Development Environment) is a powerful IDE tailored for scientists, engineers, and data analysts. Unlike general-purpose editors, it integrates data exploration and interactive execution directly into the development workflow. This skill enables agents to assist users in leveraging Spyder's advanced features—such as real-time variable inspection, multi-console management, and static code analysis—while providing specific command-line patterns for configuration and development.

## Core CLI Usage

While Spyder is primarily a GUI-based environment, the following command-line patterns are essential for management and development:

### Standard Operations
- **Launch Spyder**: `spyder`
- **Reset Configuration**: `spyder --reset` (Use this if the IDE fails to start or UI elements are misplaced).
- **Open New Instance**: `spyder --new-instance`
- **Specify Project**: `spyder --project <path_to_project_folder>`

### Development and Testing
If working directly with the Spyder source code:
- **Run from Source**: `python bootstrap.py` (Executes Spyder from a git clone without installation).
- **Execute Test Suite**: `python runtests.py`
- **Install Dev Dependencies**: `python install_dev_repos.py`

## Expert Workflows and Best Practices

### Environment Management
The most common point of failure in Spyder is environment mismatch.
- **Recommended Setup**: Always prefer the Anaconda/Miniconda distribution for installation to ensure compatibility with scientific libraries.
- **External Kernels**: To use a different Python environment within Spyder, you must install `spyder-kernels` in that environment:
  `conda install -n my-env spyder-kernels` or `pip install spyder-kernels`
- **Linking**: Point Spyder to the external interpreter via `Preferences > Python interpreter > Use the following Python interpreter`.

### Data Exploration
- **Variable Explorer**: Use this to inspect Numpy arrays, Pandas DataFrames, and PIL images. It supports direct editing of lists, dictionaries, and dataframes.
- **IPython Console**: You can open multiple consoles. Use them to isolate different experiments or to run code in parallel.
- **Plots**: By default, plots are rendered inline. Use the "Plots" pane to browse history or toggle to "Automatic" in `Preferences > IPython console > Graphics` for interactive windows.

### Code Quality and Analysis
- **Static Analysis**: Spyder integrates `pyflakes`, `pylint`, and `pycodestyle`. Check the "Code Analysis" pane (F8) for a comprehensive report on code smells and errors.
- **Profiling**: Use the Profiler (F10) to identify bottlenecks in scientific scripts. It provides a breakdown of time spent in each function call.

## Troubleshooting Tips
- **Dependency Mismatches**: If the Variable Explorer fails to show Numpy or Pandas objects, ensure the version of the library in the active environment matches the version Spyder expects.
- **Segfaults**: If Spyder crashes during PyQt/PySide operations, launch with `spyder --debug-info verbose` to capture the traceback.
- **Update Issues**: If using the standalone installer, use the built-in updater. If using Conda, always update via `conda update spyder`.

## Reference documentation
- [Spyder README](./references/github_com_spyder-ide_spyder.md)
- [Spyder Wiki Home](./references/github_com_spyder-ide_spyder_wiki.md)
- [Security Policy](./references/github_com_spyder-ide_spyder_security.md)