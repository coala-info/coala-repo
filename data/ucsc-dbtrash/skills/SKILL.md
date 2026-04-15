---
name: ucsc-dbtrash
description: ucsc-dbtrash removes tables from a MySQL database that are older than a specified age threshold. Use when user asks to 'clean up old database tables', 'delete temporary data structures', 'perform routine database maintenance', or 'prevent database storage bloat'.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-dbtrash:482--h0b57e2e_0"
---

# ucsc-dbtrash

## Overview
`ucsc-dbtrash` is a specialized database maintenance utility from the UCSC Genome Browser "kent" toolset. It is designed to keep databases lean by identifying and removing tables that have exceeded a specific age threshold. Use this tool when you need to automate the rotation or deletion of temporary data structures to prevent storage bloat in MySQL environments.

## Usage Instructions

### Prerequisites
Before running the tool, ensure you have a valid `.hg.conf` file in your home directory. This file provides the necessary credentials and host information to connect to the MySQL server.

Example `.hg.conf` structure:
```conf
host=localhost
user=your_username
password=your_password
```

### Basic Command Pattern
The tool follows a simple positional argument structure:

```bash
dbTrash [database] [N]
```

- **database**: The name of the MySQL database to scan.
- **N**: The age threshold in hours. Tables older than this value will be dropped.

### Common Workflow Patterns
1. **Routine Maintenance**: Run via a cron job to clear out temporary tables every 24 hours.
   ```bash
   dbTrash custom_trash_db 24
   ```

2. **Aggressive Cleanup**: For high-traffic mirrors with limited storage, use a shorter window.
   ```bash
   dbTrash session_db 4
   ```

### Expert Tips and Best Practices
- **Permission Requirements**: The MySQL user defined in your `.hg.conf` must have `DROP` privileges on the target database.
- **Execution Environment**: If you encounter a "permission denied" error when running the binary directly, ensure the execution bit is set: `chmod +x dbTrash`.
- **Public MySQL Access**: While many UCSC tools connect to `genome-mysql.soe.ucsc.edu`, `dbTrash` is typically used on local mirrors or private databases where you have write/drop permissions.
- **Verification**: Always verify the database name before execution, as the "drop" operation is immediate and irreversible.

## Reference documentation
- [ucsc-dbtrash Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-dbtrash_overview.md)
- [UCSC Admin Executables Guide](./references/hgdownload_cse_ucsc_edu_admin_exe.md)