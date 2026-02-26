---
name: ucsc-hgsqldump
description: ucsc-hgsqldump extracts data from UCSC Genome Browser databases. Use when user asks to dump a specific table, dump multiple tables, or dump an entire database from a UCSC Genome Browser.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---


# ucsc-hgsqldump

## Overview
ucsc-hgsqldump is a specialized wrapper for the standard `mysqldump` utility, designed specifically for the UCSC Genome Browser database environment. Its primary purpose is to streamline data extraction by automatically sourcing connection parameters—such as the host, username, and password—from a central configuration file (`.hg.conf`). This is particularly useful for researchers and bioinformaticians who frequently interact with UCSC's public MySQL server or maintain local mirrors and want to avoid hardcoding credentials in scripts.

## Configuration and Setup
Before using the tool, you must have a configuration file named `.hg.conf` in your home directory. This file allows the tool to authenticate with the UCSC database (or your local mirror) automatically.

### Example .hg.conf
Create a file at `~/.hg.conf` with the following structure (using UCSC public server credentials as an example):

```text
db.host=genome-mysql.soe.ucsc.edu
db.user=genomep
db.password=password
```

Ensure the file permissions are restrictive for security:
`chmod 600 ~/.hg.conf`

## Common CLI Patterns

### Basic Table Dump
To dump a specific table from a database (e.g., the `chromInfo` table from the `hg38` database):
`hgsqldump hg38 chromInfo > chromInfo_hg38.sql`

### Dumping Multiple Tables
You can specify multiple tables after the database name:
`hgsqldump hg38 table1 table2 table3 > tables_backup.sql`

### Dumping an Entire Database
To dump every table within a specific assembly database:
`hgsqldump hg38 > hg38_full_backup.sql`

### Passing mysqldump Options
Since `ucsc-hgsqldump` acts as a wrapper, you can often pass standard `mysqldump` flags to modify the output (such as suppressing table creation logic):
`hgsqldump --no-create-info hg38 chromInfo > chromInfo_data_only.sql`

## Expert Tips
- **Binary Permissions**: If you downloaded the binary directly from the UCSC server and receive a "permission denied" error, you must set the executable bit: `chmod +x ./hgsqldump`.
- **Public Server Limits**: When connecting to `genome-mysql.soe.ucsc.edu`, be mindful of the connection limits. For very large data extractions, consider using the UCSC `bigBed` or `bigWig` files via `rsync` instead of SQL dumps.
- **Environment Variables**: If you cannot place `.hg.conf` in your home directory, some versions of the kent tools allow you to specify the location via the `HGCONF` environment variable.

## Reference documentation
- [ucsc-hgsqldump Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-hgsqldump_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binaries List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)