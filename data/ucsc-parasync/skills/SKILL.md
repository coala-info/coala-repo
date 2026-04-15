---
name: ucsc-parasync
description: ucsc-parasync mirrors remote directories to a local path using parallelized downloads. Use when user asks to mirror remote directories, synchronize large data repositories, or download UCSC Genome Browser files.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-parasync:482--h0b57e2e_0"
---

# ucsc-parasync

## Overview

The `ucsc-parasync` utility is a specialized data transfer tool designed to mirror remote directories to a local path. Unlike standard download tools, it utilizes `paraFetch` logic to perform recursive, parallelized downloads, making it the preferred choice for researchers needing to synchronize large portions of the UCSC Genome Browser's binary or data repositories. It is particularly effective when dealing with deep directory structures and massive file counts common in bioinformatics.

## Usage Instructions

### Basic Command Pattern
The primary use case for `ucsc-parasync` is mirroring a remote URL to a local destination:

```bash
paraSync {URL} {localPath}
```

### Environment Setup
1.  **Installation**: If not already present, the tool is most easily managed via Bioconda:
    ```bash
    conda install bioconda::ucsc-parasync
    ```
2.  **Permissions**: If downloading the binary directly from the UCSC `admin/exe` directory, ensure the execution bit is set:
    ```bash
    chmod +x ./paraSync
    ```

### Best Practices
*   **Targeting UCSC Repositories**: Use this tool specifically for mirroring directories from `hgdownload.soe.ucsc.edu/admin/exe/` or genomic data tracks.
*   **Parallelization**: The tool automatically handles parallel fetching. Ensure your local filesystem can handle high I/O throughput if running on a high-bandwidth connection.
*   **Verification**: After a sync, you can verify the integrity of the mirrored directory by checking file sizes against the remote index.
*   **MySQL Configuration**: While `paraSync` focuses on file mirroring, if you use associated UCSC tools that connect to their public MySQL server, ensure you have a valid `.hg.conf` file in your home directory.

### Troubleshooting
*   **Permission Denied**: If you encounter a "permission denied" error when running the utility, verify the `chmod +x` step was successful.
*   **Usage Statement**: To see specific version-dependent flags or options, run the binary with no arguments:
    ```bash
    paraSync
    ```

## Reference documentation
- [ucsc-parasync Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-parasync_overview.md)
- [UCSC Admin Executables Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary Repository](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)