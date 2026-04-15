---
name: snakemake-interface-executor-plugins
description: This package provides the stable API and interface definitions for developing Snakemake executor plugins that interact with external cluster managers or cloud services. Use when user asks to implement a new Snakemake executor, define custom executor settings, or manage job lifecycles in external execution environments.
homepage: https://github.com/snakemake/snakemake-interface-executor-plugins
metadata:
  docker_image: "quay.io/biocontainers/snakemake-interface-executor-plugins:9.3.9--pyhdfd78af_0"
---

# snakemake-interface-executor-plugins

## Overview

The `snakemake-interface-executor-plugins` package provides the stable API necessary for Snakemake to interact with external execution environments. Instead of hardcoding support for every possible cluster manager or cloud service, Snakemake uses this plugin architecture to delegate job submission, monitoring, and cancellation. This skill guides the implementation of the required Python interfaces to ensure plugins remain compatible across Snakemake versions and correctly handle job lifecycles, resource allocation, and file system assumptions.

## Implementation Workflow

### 1. Project Initialization
The recommended way to start a new executor plugin is using Snakedeploy to generate the package skeleton.
- **Installation**: `conda install bioconda::snakemake-interface-executor-plugins`
- **Dependency Management**: Always pin this package in your `pyproject.toml` or `setup.cfg` using `>=a.b.c,<d` (where d = a+1) to ensure interface stability.

### 2. Defining Executor Settings
Custom parameters for your executor are defined using a dataclass inheriting from `ExecutorSettingsBase`. These parameters automatically become available in the Snakemake CLI as `--<executor-name>-<param-name>`.

- **Field Requirements**: All fields must be `Optional` with a default value (usually `None`).
- **Metadata Keys**:
  - `help`: Description for the CLI help message.
  - `env_var`: Set to `True` only for sensitive data (passwords/usernames) to enable `SNAKEMAKE_<EXECUTOR>_<PARAM>` environment variables.
  - `required`: Boolean indicating if the parameter is mandatory when the executor is active.
  - `parse_func` / `unparse_func`: Used for complex type conversion from CLI strings.

### 3. Configuring Common Settings
The `CommonSettings` object defines how Snakemake treats the execution environment:
- `non_local_exec`: Set to `True` for cluster/cloud; `False` only for local-style executors.
- `implies_no_shared_fs`: Set to `True` if the execution nodes do not share a filesystem with the main Snakemake process.
- `pass_envvar_declarations_to_cmd`: Set to `True` to pass environment variables via the command line; otherwise, use `self.envvars()` within the plugin logic.

### 4. Implementing the Executor Class
Inherit from `RemoteExecutor` and implement the following core methods:

#### run_job(self, job: JobExecutorInterface)
- Access job resources via `job.resources`.
- Submit the job to your backend.
- **Critical**: Call `self.report_job_submission(job_info)` after submission.
- Use `SubmittedJobInfo(job, external_jobid="...")` to track the backend's ID.

#### check_active_jobs(self, active_jobs)
- This is an `async` generator.
- Iterate through `active_jobs`.
- Use `self.status_rate_limiter` to avoid overwhelming the backend API:
  ```python
  async with self.status_rate_limiter:
      # query backend status
  ```
- Call `self.report_job_success(active_job)` or `self.report_job_error(active_job)` based on status.
- `yield` jobs that are still running.

#### cancel_jobs(self, active_jobs)
- Implement logic to terminate jobs on the backend when Snakemake is interrupted.

## Expert Tips and Best Practices

- **Stability**: Only access methods and properties of Snakemake objects (Workflow, Persistence, etc.) that are explicitly defined in `snakemake-interface-executor-plugins` or `snakemake-interface-common`.
- **Error Handling**: Raise `WorkflowError` for issues occurring outside of specific job execution.
- **Resource Management**: When `implies_no_shared_fs` is True, ensure `auto_deploy_default_storage_provider` is set to True in `CommonSettings` to handle data transfer automatically.
- **Path Encoding**: If your backend requires CLI arguments to be passed through complex shells, use the utility functions for base64 encoding provided in the interface to avoid escaping issues.

## Reference documentation
- [Snakemake Executor Plugin Interface GitHub](./references/github_com_snakemake_snakemake-interface-executor-plugins.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_snakemake-interface-executor-plugins_overview.md)