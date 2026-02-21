---
name: ucsc-hgbbidblink
description: The `ucsc-hgbbidblink` tool (internally referred to as `hgBbiDbLink`) is a specialized utility for genomic database management.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---

# ucsc-hgbbidblink

# ucsc-hgbbidblink

## Overview
The `ucsc-hgbbidblink` tool (internally referred to as `hgBbiDbLink`) is a specialized utility for genomic database management. Its primary purpose is to "link" large binary files—specifically BigWig and BigBed formats—into a UCSC-style MySQL database. Instead of loading the massive amount of data contained in these files into SQL tables, this tool creates a small metadata table containing a pointer (file path) to the BBI file. This is a critical step for administrators setting up local Genome Browser mirrors or custom track hubs that require database integration.

## Common CLI Patterns and Usage

### Basic Command Structure
The tool follows a standard positional argument pattern:
```bash
hgBbiDbLink [database] [tableName] [path/to/file.bbi]
```
*   **database**: The target UCSC database (e.g., hg38, mm10).
*   **tableName**: The name of the track table to be created in the database.
*   **path/to/file.bbi**: The absolute or relative path to the BigWig or BigBed file.

### Database Configuration (.hg.conf)
Because this tool interacts directly with MySQL databases, it requires a configuration file to manage credentials.
*   **Requirement**: You must have an `.hg.conf` file in your home directory.
*   **Content**: This file should define the `db.host`, `db.user`, and `db.password`.
*   **Public Server**: If connecting to the UCSC public MySQL server, ensure your configuration matches the settings provided at `http://genome.ucsc.edu/goldenPath/help/mysql.html`.

### File Permissions
When downloading the binary directly from the UCSC servers:
1.  Ensure the binary is executable: `chmod +x ./hgBbiDbLink`
2.  Verify the path to the BBI file is accessible by the user running the Genome Browser CGI scripts, otherwise, the browser will fail to display the track even if the link is successfully created in the database.

## Expert Tips
*   **Usage Discovery**: If you are unsure of specific version-dependent flags, run the binary with no arguments to trigger the built-in usage statement.
*   **Architecture Matching**: Ensure you are using the binary that matches your system architecture (e.g., `linux.x86_64` vs `macOSX.arm64`). Using the wrong binary will result in "Exec format error".
*   **Data Integrity**: Always run `bigWigInfo` or `bigBedInfo` on your BBI file before linking it to ensure the file is not truncated or corrupted.

## Reference documentation
- [ucsc-hgbbidblink - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-hgbbidblink_overview.md)
- [Index of /admin/exe](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Index of /admin/exe/linux.x86_64](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)