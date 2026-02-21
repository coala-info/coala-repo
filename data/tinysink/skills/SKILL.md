---
name: tinysink
description: tinysink is a specialized utility designed for bioinformatics workflows involving Oxford Nanopore Technologies (ONT).
homepage: https://github.com/mbhall88/tinysink
---

# tinysink

## Overview

tinysink is a specialized utility designed for bioinformatics workflows involving Oxford Nanopore Technologies (ONT). It automates the synchronization of raw sequencing data from a local acquisition device to a remote server. The tool is built to be resilient to network interruptions and can be deployed either during an active sequencing run to offload data as it is generated or after a run is completed for batch transfers.

## Installation

The tool is available via Bioconda:

```bash
conda install bioconda::tinysink
```

## Command Line Usage

The basic syntax for running tinysink requires specifying the source, destination, and server credentials:

```bash
tinysink -s <local_dir_to_data> -d <destination_dir_on_server> -u <username> -n <servername>
```

### Parameters
- `-s`: The local directory containing the .fast5 or .fastq files.
- `-d`: The target directory on the remote server (will be created if it does not exist).
- `-u`: Your SSH username for the remote server.
- `-n`: The hostname or IP address of the destination server.

## Expert Tips and Best Practices

### Real-time Synchronization
For active sequencing runs, start tinysink immediately after the run begins. It will monitor the source directory and push new files to the server as they are written by the sequencing software.

### Connection Resilience
If the network connection drops, tinysink is designed to go to sleep for 3 minutes before attempting to reconnect. This prevents the script from crashing during transient internet dropouts. 
*   **Advanced Tweak**: To change the retry interval, you must manually edit the `WAIT_BETWEEN_SINK` variable at the top of the shell script.

### Safe Termination
To prevent accidental interruption of data transfers, tinysink requires a specific exit sequence:
- Press **Ctrl-c twice within 3 seconds** to stop the process. A single press is ignored.

### Data Retention Policy
By default, tinysink performs a copy operation and **does not delete** files from the local machine. 
- **To enable "Move" behavior**: You must modify the script's internal `rsync` command to include the `--remove-source-files` flag.
- **Recommendation**: It is generally safer to keep the local copy until the experiment is finished and verified on the server before manual deletion.

### File Type Customization
While optimized for `.fast5` and `.fastq`, the script can be modified to sync other file types by adjusting the file patterns within the source code.

## Reference documentation
- [tinysink Overview](./references/anaconda_org_channels_bioconda_packages_tinysink_overview.md)
- [tinysink README](./references/github_com_mbhall88_tinysink_blob_master_README.md)