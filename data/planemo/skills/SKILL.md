---
name: planemo
description: Planemo is the primary command-line toolkit designed to assist developers in creating and maintaining Galaxy tools.
homepage: https://github.com/galaxyproject/planemo
---

# planemo

## Overview
Planemo is the primary command-line toolkit designed to assist developers in creating and maintaining Galaxy tools. It simplifies the development lifecycle by providing automated utilities for scaffolding new projects, validating tool XML files against best practices, and executing functional tests. By managing disposable Galaxy instances, Planemo allows developers to preview and verify tool behavior without requiring a permanent, manually configured Galaxy server.

## Core Workflows

### Project Initialization
To start a new Galaxy tool project from a template:
- **Demo project**: `planemo project_init --template=demo my_tool_dir`
- **Navigate**: Always `cd` into the created directory before running further commands.

### Linting and Validation
Use the `lint` command (alias: `l`) to check tool XML files for syntax errors, missing requirements, and adherence to Galaxy best practices.
- **Current directory**: `planemo lint`
- **Specific file**: `planemo l tool_name.xml`
- **Help and options**: `planemo l --help` (useful for adjusting reporting levels or exit codes).

### Testing Tools
The `test` command executes the functional tests defined within the tool's XML `<tests>` block.
- **Standard test**: `planemo test tool_name.xml`
- **Using a local Galaxy**: `planemo test --galaxy_root=/path/to/galaxy tool_name.xml`
- **Disposable Galaxy**: If no root is specified, Planemo downloads and configures a temporary Galaxy instance automatically.
- **Outputs**: By default, it produces `tool_test_output.html`. Use `--test_output` to specify a custom path.

### Local Preview (Serving)
To view the tool interface as it would appear in a live Galaxy instance, use the `serve` (alias: `s`) command.
- **Launch server**: `planemo serve tool_name.xml`
- **Auto-install Galaxy**: Use `planemo serve --install_galaxy` to have Planemo set up the environment for you.

## Expert Tips
- **Aliases**: Use `l` for `lint` and `s` for `serve` to speed up the development loop.
- **Dependency Management**: Planemo integrates with Conda to resolve tool dependencies. Ensure Conda is installed to allow Planemo to build the necessary environments for testing.
- **Tool Shed Publishing**: Once a tool is linted and tested, Planemo can automate the process of uploading and updating repositories in the Galaxy Tool Shed.

## Reference documentation
- [Planemo GitHub Repository](./references/github_com_galaxyproject_planemo.md)
- [Bioconda Planemo Package](./references/anaconda_org_channels_bioconda_packages_planemo_overview.md)