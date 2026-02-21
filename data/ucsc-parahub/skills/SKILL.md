---
name: ucsc-parahub
description: The `ucsc-parahub` package is a component of the Parasol system, a lightweight job control system developed by the UCSC Genome Browser team.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---

# ucsc-parahub

## Overview

The `ucsc-parahub` package is a component of the Parasol system, a lightweight job control system developed by the UCSC Genome Browser team. It is specifically designed to manage large batches of short-to-medium length jobs across a cluster of machines. This skill enables an agent to configure the hub server (`paraHub`), manage worker nodes, and utilize the Parasol administration utilities to facilitate distributed sequence analysis.

## Installation and Setup

The tool is primarily distributed via Bioconda.

```bash
# Install via conda
conda install bioconda::ucsc-parahub
```

### Permissions and Environment
- **Executable Permissions**: If downloading binaries directly from the UCSC server instead of using Conda, ensure execution bits are set: `chmod +x ./paraHub`.
- **MySQL Configuration**: Some utilities in the Kent suite require a database connection. If the task involves UCSC database access, ensure an `.hg.conf` file is present in the home directory with appropriate credentials.

## Core CLI Patterns

### Managing the Hub Server
The hub acts as the central scheduler. It must be running on a "master" node that all worker nodes can reach via the network.

- **Start the Hub**: Run `paraHub` on the master machine.
- **Stop the Hub**: Use `paraHubStop` to gracefully shut down the scheduling service.

### Managing Worker Nodes
Worker nodes must be initialized to communicate with the hub.

- **Start a Node**: Use `paraNodeStart` on a worker machine to join the cluster.
- **Check Node Status**: Use `paraNodeStatus` to verify if a node is active and communicating with the hub.
- **Stop a Node**: Use `paraNodeStop` to remove a machine from the active compute pool.

### Job Control and Testing
- **parasol**: This is the main user interface for the system. Use it to submit job lists, check the queue, and manage priorities.
- **paraTestJob**: Use this utility to verify that the environment on a worker node is correctly configured before launching a massive batch.
- **paraSync**: Useful for ensuring files are synchronized across the cluster nodes if a shared filesystem is not being used.

## Expert Tips

1. **Usage Discovery**: Most Parasol binaries (e.g., `para`, `parasol`, `paraHub`) will print a comprehensive help message and list of available flags when executed with no arguments.
2. **Network Requirements**: Ensure that the ports used by `paraHub` are open between the master and worker nodes. Parasol relies on simple socket communication.
3. **Batch Files**: When using the `parasol` client, jobs are typically defined in a "batch" file where each line is a single command to be executed.
4. **Architecture Matching**: Ensure the binaries match the machine architecture. Use `uname -a` to check if you need `linux.x86_64` or `linux.aarch64` versions.

## Reference documentation
- [UCSC Admin Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-parahub Package Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-parahub_overview.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)