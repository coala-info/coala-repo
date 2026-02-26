---
name: galaxy-job-config-init
description: This utility programmatically generates job configuration files for Galaxy administrators to define interactions with resource managers and container runtimes. Use when user asks to initialize a new job configuration, configure job runners like Slurm or Kubernetes, setup Docker or Singularity containerization, or manage volume mounts and job routing.
homepage: https://github.com/galaxyproject/galaxy-job-config-init
---


# galaxy-job-config-init

## Overview
`galaxy-job-config-init` is a specialized utility designed for Galaxy administrators to programmatically generate job configuration files. It simplifies the process of defining how Galaxy interacts with distributed resource managers (DRMs) and container runtimes. Use this skill when you need to initialize a new job configuration, switch runners, or configure complex volume mounts for containerized tools without manually authoring verbose configuration files from scratch.

## CLI Usage Patterns

### Basic Initialization
To generate a standard local job configuration for the current Galaxy version:
`galaxy-job-config-init`

### Configuring Job Runners
Target specific execution environments using the `--runner` flag. Supported runners include `local`, `slurm`, `pbs`, `condor`, and `kubernetes`.
`galaxy-job-config-init --runner slurm`

### Containerization Setup
Enable and configure container runtimes for job execution.

**Docker Configuration:**
`galaxy-job-config-init --docker --docker-cmd /usr/bin/docker --docker-sudo`

**Singularity Configuration:**
`galaxy-job-config-init --singularity --singularity-cmd /usr/bin/singularity`

### Volume Management
For containerized environments, use multiple volume flags to map host paths to the container. This is essential for ensuring tools have access to reference data and scratch space.
`galaxy-job-config-init --docker --docker-extra-volume /data/db:/data/db --docker-extra-volume /scratch:/scratch`

### Advanced Routing and Handling
- **TPV Integration**: Enable the Total Perspective Vortex shared database for dynamic job routing and scheduling.
  `galaxy-job-config-init --tpv`
- **All-in-One Handling**: Use this flag for simplified Galaxy instances where job handling and web tasks are combined in a single process.
  `galaxy-job-config-init --all-in-one-handling`
- **Temporary Directories**: Explicitly configure how Galaxy handles job temporary directories to manage disk I/O or shared filesystem constraints.
  `galaxy-job-config-init --tmp-dir /path/to/custom/tmp`

## Expert Tips
- **Version Specificity**: Always provide the `--galaxy-version` flag if targeting a specific release to ensure the generated configuration is compatible with that version's internal schema.
- **Configuration Verification**: After generating a configuration, run `galaxy-job-config-init-summary` to produce a concise report of the defined runners, handlers, and container settings.
- **Sudo Requirements**: If the Galaxy system user lacks direct permissions to the Docker socket or Singularity executable, ensure the `--docker-sudo` or `--singularity-sudo` flags are applied.
- **Docker Host**: If running Docker on a remote daemon, use `--docker-host` to specify the appropriate TCP or Unix socket.

## Reference documentation
- [Galaxy Job Config Init GitHub](./references/github_com_galaxyproject_galaxy-job-config-init.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_galaxy-job-config-init_overview.md)