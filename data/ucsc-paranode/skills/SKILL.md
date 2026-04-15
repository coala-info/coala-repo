---
name: ucsc-paranode
description: The ucsc-paranode suite manages worker nodes in a Parasol cluster for high-throughput genomic analysis. Use when user asks to start a node, stop a node, check node status, test job execution, fetch data, or sync node files.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
metadata:
  docker_image: "quay.io/biocontainers/ucsc-paranode:482--h0b57e2e_0"
---

# ucsc-paranode

## Overview
The `ucsc-paranode` suite provides the necessary binaries to manage worker nodes in a Parasol cluster, a job-scheduling system specifically designed by the UCSC Genome Bioinformatics group for high-throughput genomic analysis. This skill guides the execution of node-level operations, ensuring that compute resources are correctly registered with a Parasol hub and are capable of executing assigned tasks.

## Common CLI Patterns

### Node Management
The primary utilities for managing the lifecycle of a worker node are `paraNodeStart` and `paraNodeStop`.

*   **Start a node**: Initializes the node server to begin accepting jobs from the hub.
    ```bash
    paraNodeStart
    ```
*   **Stop a node**: Gracefully shuts down the node server.
    ```bash
    paraNodeStop
    ```
*   **Check node status**: Verifies if the local node server is active and reports its current state.
    ```bash
    paraNodeStatus
    ```

### Core Daemon and Testing
*   **Direct Daemon Execution**: The `paraNode` binary is the core server process. Running it without arguments typically displays version and configuration options.
    ```bash
    paraNode
    ```
*   **Testing Job Execution**: Use `paraTestJob` to verify that the node can successfully execute a task before adding it to a production cluster.
    ```bash
    paraTestJob [arguments]
    ```

### Data Synchronization and Fetching
Worker nodes often need to move data or stay in sync with the hub's state.
*   **Parallel Fetching**: Use `paraFetch` for high-speed data retrieval.
*   **Node Syncing**: Use `paraSync` to ensure local files match the required state for cluster jobs.

## Expert Tips and Best Practices

### Permission Requirements
UCSC binaries downloaded directly from the server require manual permission updates before they can be executed.
```bash
chmod +x ./paraNode
```

### Network and Environment
*   **Hub Connectivity**: Ensure the worker node has an unobstructed network path to the machine running `paraHub`. Parasol relies on specific ports for node-to-hub communication.
*   **MySQL Configuration**: If the jobs executed by the node require access to the UCSC public MySQL server, ensure an `.hg.conf` file is present in the user's home directory.
*   **Binary Architecture**: Always verify the machine architecture using `uname -a` and ensure you are using the matching binary (e.g., `linux.x86_64` vs `macOSX.arm64`).

### Troubleshooting
If a node fails to pick up jobs:
1.  Run `paraNodeStatus` to confirm the daemon is running.
2.  Check the hub's view of the node using the `parasol` administration tool (usually run from the hub).
3.  Verify that the node has sufficient disk space in its temporary directory, as many genomic tools generate large intermediate files.

## Reference documentation
- [UCSC Admin Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [Bioconda ucsc-paranode Package](./references/anaconda_org_channels_bioconda_packages_ucsc-paranode_overview.md)