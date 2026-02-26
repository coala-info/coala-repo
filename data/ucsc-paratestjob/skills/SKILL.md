---
name: ucsc-paratestjob
description: ucsc-paratestjob verifies the functionality of a UCSC Parasol batch system cluster by submitting and tracking test jobs. Use when user asks to verify cluster functionality, test a Parasol cluster, ensure the cluster environment is ready for processing tasks, simulate a workload, or diagnose Parasol environment issues.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---


# ucsc-paratestjob

## Overview
The `ucsc-paratestjob` utility is a component of the UCSC Genome Browser's Parasol batch system. It is primarily used to verify the functionality of a Parasol cluster by submitting and tracking test jobs. This skill provides guidance on using the tool to ensure that the cluster environment is ready for large-scale genomic data processing tasks, such as sequence alignment (BLAT) or track building.

## Usage Patterns and Best Practices

### Basic Job Testing
The primary function of `paraTestJob` is to simulate a workload to ensure the `paraHub` and `paraNode` components are communicating correctly.

```bash
paraTestJob <numJobs> <secondsPerJob>
```

*   **numJobs**: The number of individual tasks to submit to the batch system.
*   **secondsPerJob**: The duration each task should sleep/run to simulate processing time.

### Environment Setup
Before running `paraTestJob` or any other Parasol-related utility, ensure your environment is configured to communicate with the cluster hub.

1.  **Permissions**: Ensure the binary has execution permissions.
    ```bash
    chmod +x ./paraTestJob
    ```
2.  **Configuration**: Parasol utilities often require an `.hg.conf` file in your home directory if they interact with UCSC MySQL databases, though `paraTestJob` is generally used for system validation.
3.  **Pathing**: Add the directory containing the UCSC binaries to your `$PATH` to call the tools without absolute paths.

### Troubleshooting Cluster Connectivity
If `paraTestJob` fails, use the following sequence to diagnose the Parasol environment:

*   **Check Node Status**: Use `paraNodeStatus` to see if worker nodes are checking in.
*   **Verify Hub**: Ensure the `paraHub` process is active on the master machine.
*   **Stop/Start Services**: Use `paraHubStop` and `paraNodeStop` if a reset of the test environment is required.

### Integration with Kent Utilities
`paraTestJob` is often the first tool run after installing the UCSC "userApps" suite. Once `paraTestJob` confirms the cluster is healthy, you can proceed to use the parallel versions of other tools:
*   **paraFetch**: For parallelized downloading of genomic files.
*   **blat**: Often wrapped in parallel scripts for large-scale alignments.

## Reference documentation
- [UCSC Admin Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [Bioconda Package Metadata](./references/anaconda_org_channels_bioconda_packages_ucsc-paratestjob_overview.md)