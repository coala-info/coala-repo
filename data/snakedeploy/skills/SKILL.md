---
name: snakedeploy
description: Snakedeploy automates the deployment and management of Snakemake workflows from remote repositories to local execution environments. Use when user asks to deploy a workflow, pin Conda environments, update Snakemake wrappers, or scaffold new plugins.
homepage: https://github.com/snakemake/snakedeploy
metadata:
  docker_image: "quay.io/biocontainers/snakedeploy:0.16.0--pyhdfd78af_0"
---

# snakedeploy

## Overview

Snakedeploy is the official companion tool for Snakemake designed to simplify the transition from a remote workflow repository to a local, production-ready execution environment. It automates the creation of local configuration files and directory structures, ensuring that users can deploy complex pipelines with a single command while maintaining a clean separation between the workflow logic (stored in Git) and local data/configuration.

## Core CLI Patterns

### Deploying a Workflow
To initialize a local deployment of a remote Snakemake workflow, use the `deploy-workflow` command. This creates a local `config/` directory and a `Snakefile` that sources the remote rules.

```bash
snakedeploy deploy-workflow https://github.com/user/repo . --tag v1.0.0
```
*   **Best Practice**: Always specify a `--tag` or `--branch` to ensure reproducibility. Deploying from `main` can lead to breaking changes if the remote repository updates.
*   **Tip**: Use `.` as the destination to deploy into the current directory.

### Managing Conda Environments
Snakedeploy can pin Conda dependencies to specific hashes to ensure environment stability across different machines.

```bash
# Pin all conda environments in a workflow
snakedeploy pin-conda-envs Snakefile
```
*   **Expert Tip**: Use the `--create-pr` flag (if configured with a GitHub token) to automatically submit the updated pins back to the upstream repository.

### Updating Snakemake Wrappers
If your workflow relies on the Snakemake Wrapper Repository, you can synchronize them to the latest versions.

```bash
snakedeploy update-snakemake-wrappers Snakefile
```
*   **Note**: This command parses your `Snakefile`, identifies wrapper strings, and updates the version tags to the most recent compatible releases.

### Scaffolding Plugins
For developers building Snakemake extensions, snakedeploy provides templates for various plugin types.

```bash
# Create a scaffold for a new executor plugin
snakedeploy scaffold-plugin . --type executor
```
*   Supported types include `executor`, `storage`, and `scheduler`.

## Expert Tips

1.  **Profile Deployment**: When deploying a workflow, snakedeploy can also pull in `profiles/` defined in the source repository. This is essential for cluster-ready pipelines that require specific resource configurations.
2.  **Input Registration**: Use the `register-inputs` subcommand to collect local data files into a tabular structure (like a sample sheet) that the deployed workflow can immediately consume.
3.  **Configuration Discovery**: After running `deploy-workflow`, check the generated `config/config.yaml`. Snakedeploy automatically extracts the default configuration schema from the source repository to help you fill in required parameters.



## Subcommands

| Command | Description |
|---------|-------------|
| snakedeploy | A tool for managing Snakemake workflows and their dependencies. |
| snakedeploy | A tool for deploying and managing Snakemake workflows. |
| snakedeploy | A tool for deploying and managing Snakemake workflows. |
| snakedeploy | A tool for deploying Snakemake workflows and managing their dependencies. |
| snakedeploy | Deploy Snakemake workflows and manage their environments. |
| snakedeploy | snakedeploy: error: argument subcommand: invalid choice: 'package' (choose from deploy-workflow, collect-files, pin-conda-envs, update-conda-envs, update-snakemake-wrappers, scaffold-snakemake-plugin) |
| snakedeploy | A tool for deploying and managing Snakemake workflows. |
| snakedeploy | A tool for deploying and managing Snakemake workflows. |
| snakedeploy collect-files | Collect files into a tabular structure, given input from STDIN formats glob patterns defined in a config sheet. |
| snakedeploy deploy-workflow | Deploy a workflow from a git repository. |
| snakedeploy scaffold-snakemake-plugin | Scaffold a snakemake plugin by adding recommended dependencies and code snippets. |
| snakedeploy update-conda-envs | Update given conda environment definition files (in YAML format) so that all contained packages are set to the latest feasible versions. |
| snakedeploy update-snakemake-wrappers | Update all snakemake wrappers in given Snakefiles to their latest versions. |
| snakedeploy_pin-conda-envs | Pin/lock given conda environment definition files (in YAML format) into a list of explicit package URLs including checksums, stored in a file <prefix>.<platform>.pin.txt with prefix being the path to the original definition file and <platform> being the name of the platform the pinning was performed on (e.g. linux-64). The resulting file will be automatically used by Snakemake to restore exactly the pinned environment. Also you can use it manually, e.g. with 'conda create -f <path-to-pin-file> -n <env-name>'. |

## Reference documentation
- [Workflow Deployment Guide](./references/snakedeploy_readthedocs_io_en_stable_workflow_users_workflow_deployment.html.md)
- [Updating Conda Environments](./references/snakedeploy_readthedocs_io_en_stable_workflow_developers_update_conda_envs.html.md)
- [Updating Snakemake Wrappers](./references/snakedeploy_readthedocs_io_en_stable_workflow_developers_update_snakemake_wrappers.html.md)
- [Plugin Scaffolding](./references/snakedeploy_readthedocs_io_en_stable_snakemake_developers_scaffold_snakemake_plugins.html.md)