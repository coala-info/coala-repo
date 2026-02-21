---
name: ucsc-hgloadsqltab
description: `ucsc-hgloadsqltab` (commonly executed as the command `hgLoadSqlTab`) is a specialized data-loading utility from the UCSC Genome Browser "kent" source tree.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---

# ucsc-hgloadsqltab

## Overview

`ucsc-hgloadsqltab` (commonly executed as the command `hgLoadSqlTab`) is a specialized data-loading utility from the UCSC Genome Browser "kent" source tree. It streamlines the process of database table creation and data ingestion by combining a SQL schema definition with a flat data file. 

This tool is preferred over standard MySQL import commands in bioinformatics workflows because it is designed to handle the specific table structures used by the UCSC Genome Browser and ensures compatibility with the browser's underlying C libraries.

## Command Line Usage

The basic syntax for the tool requires the target database, the table name, the schema file, and the data file:

```bash
hgLoadSqlTab [database] [table] [schema.sql] [data.tab]
```

### Prerequisites
*   **Database Configuration**: The tool requires an `.hg.conf` file in your home directory to authenticate with the MySQL server. This file must contain the host, user, and password information.
*   **File Permissions**: Ensure the binary is executable. If you have just downloaded it, run:
    `chmod +x ./hgLoadSqlTab`

### Common CLI Patterns

1.  **Standard Load**:
    ```bash
    hgLoadSqlTab hg38 customTrackTable tableSchema.sql data.tab
    ```
    This creates `customTrackTable` in the `hg38` database using the structure in `tableSchema.sql` and loads the records from `data.tab`.

2.  **Loading without a local MySQL server**:
    If you are connecting to a remote database specified in your `.hg.conf`, ensure your network permissions allow traffic on port 3306.

## Best Practices and Expert Tips

*   **Schema Alignment**: The `.sql` file should contain a standard `CREATE TABLE` statement. Ensure that the number of columns and the data types in the `.sql` file exactly match the columns in your `.tab` file.
*   **Tab-Separated Format**: The data file must be strictly tab-separated. Leading or trailing whitespace in fields can sometimes cause insertion errors or unexpected data truncation.
*   **Handling Large Loads**: For very large datasets, ensure the MySQL `tmpdir` has enough space, as `hgLoadSqlTab` may use temporary files during the load process.
*   **Verification**: After loading, it is a best practice to use the `hgsql` utility (also part of the UCSC suite) to run a `SELECT COUNT(*)` or `DESCRIBE [table]` to verify the data was ingested correctly.
*   **Troubleshooting "Permission Denied"**: If you encounter a permission error despite having the binary, check if the filesystem is mounted with the `noexec` flag, which is common in some shared high-performance computing (HPC) environments.

## Reference documentation

- [UCSC Admin Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-hgloadsqltab Package](./references/anaconda_org_channels_bioconda_packages_ucsc-hgloadsqltab_overview.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)