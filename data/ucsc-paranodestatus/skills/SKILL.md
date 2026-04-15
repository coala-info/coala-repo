---
name: ucsc-paranodestatus
description: `ucsc-paranodestatus` checks the health and communication status of `paraNode` worker services in a Parasol cluster. Use when user asks to verify cluster health, identify unresponsive worker nodes, or confirm worker daemon restart after maintenance.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
metadata:
  docker_image: "quay.io/biocontainers/ucsc-paranodestatus:482--h0b57e2e_0"
---

# ucsc-paranodestatus

## Overview
The `ucsc-paranodestatus` tool is a specialized utility within the UCSC Genome Browser "kent" suite used for cluster administration. It functions as a health-check mechanism for the Parasol job control system. By querying a list of hostnames, the tool determines whether the `paraNode` service (the worker daemon) is active and communicating correctly with the cluster environment. This is essential for identifying "dead" nodes or network partitions that prevent genomic processing jobs from completing.

## Usage Instructions

### Installation and Setup
The tool is most easily managed via Bioconda. If using the standalone binary from the UCSC server, ensure the execution bit is set.

```bash
# Installation via Conda
conda install -c bioconda ucsc-paranodestatus

# Manual setup for downloaded binaries
chmod +x ./paraNodeStatus
```

### Basic Command Pattern
The tool typically requires a list of machines to check. This list is usually a simple text file containing one hostname or IP address per line.

```bash
paraNodeStatus machineList
```

### Common Workflow Patterns
1.  **Verify Cluster Health**: Before submitting a large batch of BLAT or alignment jobs, run `paraNodeStatus` on your node list to ensure the workers are ready.
2.  **Identify Hanging Nodes**: If the Parasol hub reports that jobs are timing out on specific workers, use this tool to check if the `paraNode` process on those specific machines has crashed or become unresponsive.
3.  **Post-Maintenance Check**: After rebooting worker nodes or updating the `kent` binaries, use this tool to confirm that the `paraNode` daemons have successfully restarted and are reachable.

### Expert Tips
*   **No Arguments for Help**: Like most UCSC Genome Browser utilities, running `paraNodeStatus` with no arguments will print the current version and a brief usage statement including any specific flags supported by your version.
*   **Network Requirements**: Ensure that the machine running `paraNodeStatus` has the necessary SSH or network permissions to communicate with the ports used by Parasol (typically high-numbered ports) on the worker nodes.
*   **Integration with Parasol**: This tool is a diagnostic companion to `paraHub` and `parasol`. While `parasol status` gives the hub's view of the world, `paraNodeStatus` provides a direct check of the worker daemons.

## Reference documentation
- [ucsc-paranodestatus Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-paranodestatus_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)