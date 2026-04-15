---
name: ucsc-parahubstop
description: The `ucsc-parahubstop` utility terminates the `paraHub` daemon gracefully. Use when user asks to stop the paraHub, shut down the paraHub, or terminate the paraHub daemon.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
metadata:
  docker_image: "quay.io/biocontainers/ucsc-parahubstop:482--h0b57e2e_0"
---

# ucsc-parahubstop

## Overview
The `ucsc-parahubstop` utility is a specialized administrative tool used to terminate the `paraHub` daemon. In the UCSC Parasol system—a job control system often used for large-scale genomic tasks like BLAT alignments—the `paraHub` acts as the central server that coordinates jobs across multiple `paraNode` instances. This tool sends a signal to the hub to shut down gracefully, ensuring the management process exits correctly.

## Usage Instructions

### Basic Command Pattern
To stop a running paraHub, execute the command followed by the hostname of the machine where the hub is running:

```bash
paraHubStop <hub-hostname>
```

### Common Workflow
1. **Identify the Hub**: Determine the hostname or IP address of the server currently acting as the Parasol hub.
2. **Permissions**: Ensure you have the necessary network permissions to communicate with the hub's management port (default is usually 4444).
3. **Execution**: Run the stop command.
4. **Verification**: Use `paraNodeStatus` or check the process list on the hub server to confirm the daemon has exited.

### Expert Tips
- **Graceful Shutdown**: Unlike killing the process manually with `kill -9`, using `paraHubStop` allows the hub to attempt a cleaner exit.
- **Binary Permissions**: If you have just downloaded the tool from the UCSC servers, you must set the execution bit:
  `chmod +x paraHubStop`
- **Environment**: If the tool requires connection to a UCSC database (though less common for the stop utility itself), ensure your `~/.hg.conf` file is correctly configured.
- **No Arguments**: Running the tool with no arguments will typically display the version and a brief usage summary.

## Reference documentation
- [ucsc-parahubstop Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-parahubstop_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binaries List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)