---
name: ucsc-paranodestop
description: This tool remotely terminates the `paraNode` daemon on multiple compute nodes in a Parasol cluster. Use when user asks to stop paraNode daemons, shut down a Parasol cluster, reconfigure a Parasol cluster, or perform cluster maintenance.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---


# ucsc-paranodestop

## Overview
`ucsc-paranodestop` is a specialized administrative tool from the UCSC Kent toolkit used to remotely terminate the `paraNode` daemon on multiple compute nodes. In a Parasol cluster, the `paraNode` process runs on worker machines to manage job execution; this utility allows an administrator to stop those processes across a list of hostnames simultaneously, facilitating cluster-wide shutdowns or reconfigurations.

## Command Line Usage

The primary executable is `paraNodeStop`. Like most UCSC Genome Browser utilities, running the command with no arguments will display the specific usage statement and available options.

### Basic Syntax
```bash
paraNodeStop machineList
```

### Key Components
*   **machineList**: A text file containing the list of hostnames (one per line) where the `paraNode` daemon should be stopped.
*   **Permissions**: Ensure the binary has execution permissions before use:
    ```bash
    chmod +x paraNodeStop
    ```

## Expert Tips and Best Practices

### Cluster Maintenance Workflow
`paraNodeStop` is typically the final step in a cluster teardown. The standard sequence for stopping a Parasol environment is:
1.  Stop the hub using `paraHubStop`.
2.  Stop the nodes using `paraNodeStop`.

### Verification
After running the command, it is best practice to verify the status of the nodes to ensure the daemons have terminated successfully. You can use `paraNodeStatus` to check the current state of the workers.

### Network Requirements
Since this tool communicates with remote daemons, ensure that:
*   The control machine has network visibility to all nodes listed in the `machineList`.
*   Firewalls allow communication on the ports used by Parasol (default is often 4444, but check your specific configuration).

### Troubleshooting "Permission Denied"
If you encounter a "permission denied" error when attempting to run the tool, it is usually a filesystem permission issue rather than a Parasol authentication issue. Use `chmod +x` on the binary. If the error occurs during the remote shutdown, ensure the user running the command has the necessary administrative privileges within the Parasol configuration.

## Reference documentation
- [ucsc-paranodestop bioconda overview](./references/anaconda_org_channels_bioconda_packages_ucsc-paranodestop_overview.md)
- [UCSC Admin Executables Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)