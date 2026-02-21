---
name: ucsc-websync
description: The `ucsc-websync` utility is a specialized synchronization tool designed to efficiently download data from the UCSC Genome Browser's HTTPS servers.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---

# ucsc-websync

## Overview
The `ucsc-websync` utility is a specialized synchronization tool designed to efficiently download data from the UCSC Genome Browser's HTTPS servers. Unlike generic downloaders, it leverages a `files.txt` manifest located on the server side to determine the list of available files, ensuring that local directories stay in sync with the remote repository. It is particularly useful for bioinformaticians and genomic researchers who need to automate the retrieval of large-scale genomic tracks, assembly data, or utility binaries.

## Installation and Setup
The tool is primarily distributed via Bioconda and is part of the UCSC "kent" utility suite.

```bash
# Install via conda
conda install bioconda::ucsc-websync
```

**Note on Permissions**: If you download the binary directly from the UCSC `admin/exe` directory, you must grant execution permissions before use:
```bash
chmod +x ucsc-websync
```

## Usage Patterns and Best Practices

### Basic Synchronization
The primary use case is pointing the tool at a UCSC HTTPS directory that contains a `files.txt` manifest.
```bash
ucsc-websync https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/ ./local_dir/
```

### Key Operational Behaviors
- **Manifest-Driven**: The tool specifically looks for a `files.txt` file on the remote server to build the download queue. If this file is missing, the tool may not function as expected.
- **HTTPS Protocol**: While UCSC supports `rsync` for many directories, `ucsc-websync` is the preferred lightweight method for synchronization over HTTPS.
- **Platform Support**: Binaries are available for `linux-64`, `linux-aarch64`, and `macOSX` (both ARM and x86). Ensure you are using the version matching your architecture (e.g., `macOSX.arm64` for M1/M2/M3 Macs).

### Expert Tips
- **Check for Updates**: UCSC frequently updates their "kent" utilities (often indicated by version numbers like v469). If synchronization fails or is slow, ensure you are using the latest version from the `admin/exe` directory.
- **MySQL Configuration**: Some UCSC utilities that might be used alongside `websync` require a `.hg.conf` file in your home directory to connect to the public MySQL server (`genome-mysql.soe.ucsc.edu`).
- **Rsync Alternative**: If you need to mirror an entire directory tree and have `rsync` access, the following pattern is often used as an alternative to `websync`:
  ```bash
  rsync -aP rsync://hgdownload.soe.ucsc.edu/genome/admin/exe/linux.x86_64/ ./local_dir/
  ```

## Reference documentation
- [UCSC Admin Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-websync Package Details](./references/anaconda_org_channels_bioconda_packages_ucsc-websync_overview.md)
- [Linux x86_64 Binary Index](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)