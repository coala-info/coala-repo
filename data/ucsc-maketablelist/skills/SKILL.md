---
name: ucsc-maketablelist
description: This tool creates or updates a table list cache in a MySQL database. Use when user asks to 'add new tracks', 'update table structures', 'set up a new genomic database', or 'synchronize the database cache'.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---


# ucsc-maketablelist

## Overview
The `makeTableList` utility is a specialized database maintenance tool from the UCSC Kent toolkit. Its primary purpose is to create or update a "table list" cache within a MySQL database. In large-scale genomic databases like those used by the UCSC Genome Browser, executing `SHOW TABLES` or `DESCRIBE` repeatedly can be computationally expensive. This tool pre-calculates this metadata and stores it in a dedicated table, allowing the Genome Browser CGI and other Kent utilities to retrieve schema information much faster.

You should use this skill when you have added new tracks to a local UCSC mirror, updated table structures, or are setting up a new genomic database that needs to be compatible with UCSC's internal metadata expectations.

## Command Line Usage

### Basic Syntax
The tool typically requires the name of the database to process:
```bash
makeTableList [databaseName]
```

### Prerequisites: MySQL Configuration
Like most UCSC utilities that connect to MySQL, `makeTableList` requires a configuration file named `.hg.conf` in your home directory. This file must contain the credentials for the database server.

**Example `.hg.conf` content:**
```text
db.host=localhost
db.user=your_username
db.password=your_password
```

### Common Workflow Patterns
1.  **Post-Update Refresh**: Always run `makeTableList` after loading new data tracks or performing bulk table deletions to ensure the browser's internal cache remains synchronized with the actual database state.
2.  **Permission Requirements**: Ensure the MySQL user defined in your `.hg.conf` has `CREATE`, `INSERT`, and `DROP` privileges on the target database, as the tool will drop and recreate the cache tables.

## Expert Tips
*   **Public MySQL Access**: While this tool is primarily for local mirrors, it is part of the suite that interacts with UCSC's public MySQL server (`genome-mysql.soe.ucsc.edu`). However, you cannot run this tool against the public server as you lack write permissions for their cache tables.
*   **Binary Execution**: If you encounter a "permission denied" error when running the binary, use `chmod +x` to make it executable.
*   **Architecture Matching**: Ensure you are using the binary that matches your system architecture (e.g., `linux.x86_64` or `macOSX.arm64`). Using the wrong binary will result in execution errors.

## Reference documentation
- [ucsc-maketablelist Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-maketablelist_overview.md)
- [UCSC Admin Executables Guide](./references/hgdownload_cse_ucsc_edu_admin_exe.md)