---
name: cwltool
description: The `cwltool` utility is the primary reference implementation for the Common Workflow Language standards.
homepage: https://github.com/common-workflow-language/cwltool
---

# cwltool

## Overview
The `cwltool` utility is the primary reference implementation for the Common Workflow Language standards. It provides a robust command-line interface for running portable data analysis workflows across different environments. This skill focuses on the operational management of the `cwltool` executable, including environment configuration, container engine selection, and execution optimization.

## Command Line Usage

### Basic Execution
The standard way to invoke the tool is by providing the workflow/tool descriptor and the input object:
```bash
cwltool [options] <workflow_file> <input_object>
```
If `cwlref-runner` is installed, it acts as an alias for the default CWL interpreter on the system.

### Environment Configuration
You can pre-configure global options using the `CWLTOOL_OPTIONS` environment variable to avoid repetitive flag entry:
```bash
export CWLTOOL_OPTIONS="--debug --timestamp"
```

### Container Runtime Management
`cwltool` relies on container engines to ensure process isolation and portability.
- **Docker (Default)**: Ensure the Docker daemon is running.
- **Singularity/Apptainer**: Use the `--singularity` flag. This is often preferred in HPC environments.
- **Podman**: Use the `--podman` flag.
- **uDocker**: Use the `--udocker` flag (requires Node.js for expression evaluation).
- **No Container**: Use `--no-container` if the software is installed locally, though this reduces portability.

### Optimization and Parallelism
- **Parallel Execution**: Control the number of parallel steps with `--parallel-max <int>`.
- **Fast Parser**: For large workflows, enable the experimental fast parser using `--fast-parser`.
- **Caching**: Use `--cachedir <dir>` to cache intermediate results and avoid redundant computations.

### Troubleshooting and Debugging
- **Verbose Logging**: Use `--debug` to see detailed execution logs and shell commands being executed inside containers.
- **Temporary Files**: On macOS (especially with boot2docker), default temp paths may fail. Redirect them using:
  ```bash
  cwltool --tmp-outdir-prefix=/Users/name/project --tmpdir-prefix=/Users/name/project ...
```
- **Validation Only**: Use `--validate` to check the syntax and integrity of files without executing them.

### Resource Overrides
If a workflow requires more resources than the local machine provides, or if you need to test constraints, use the `--overrides` flag to point to a configuration file that modifies requirements at load time.

## Reference documentation
- [Common Workflow Language reference implementation](./references/github_com_common-workflow-language_cwltool.md)
- [cwltool - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_cwltool_overview.md)
- [cwltool Commits - Parallel Max Feature](./references/github_com_common-workflow-language_cwltool_commits_main.md)