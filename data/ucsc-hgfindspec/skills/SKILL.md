---
name: ucsc-hgfindspec
description: The `hgFindSpec` utility is a core component of the UCSC Genome Browser "kent" suite.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---

# ucsc-hgfindspec

## Overview
The `hgFindSpec` utility is a core component of the UCSC Genome Browser "kent" suite. Its primary purpose is to translate search specifications defined in `trackDb.ra` files into a database-resident `hgFindSpec` table. This table tells the Genome Browser how to parse user queries in the search box and which tracks/tables to query to find matching genomic features. This skill also covers the use of `checkHgFindSpec` for verifying the integrity of these search configurations.

## Common CLI Patterns

### Generating the hgFindSpec Table
The standard usage requires the target database name, the name of the table to be created (usually `hgFindSpec`), and the path to the input `.ra` file.

```bash
hgFindSpec [database] [tableName] [trackDb.ra]
```

### Validating Search Specifications
Use the companion tool to ensure that the specifications in the database are valid and that the referenced tables exist.

```bash
checkHgFindSpec [database] [tableName]
```

## Expert Tips and Best Practices

### Environment Configuration
*   **MySQL Connection**: `hgFindSpec` often needs to connect to a local or UCSC MySQL instance. Ensure an `.hg.conf` file is present in your home directory with the correct credentials (host, user, password).
*   **File Permissions**: If you have just downloaded the binary from the UCSC server, ensure it is executable:
    ```bash
    chmod +x ./hgFindSpec
    ```

### Workflow Integration
*   **TrackDb Relationship**: `hgFindSpec` is typically run after `hgTrackDb`. While `hgTrackDb` handles the visualization and metadata of tracks, `hgFindSpec` specifically handles the "find" (search) logic.
*   **Search Triggers**: In your `trackDb.ra` file, ensure you have defined `searchTable`, `searchMethod`, and `searchType` correctly before running this tool, as these fields are what `hgFindSpec` parses to build the search index.

### Troubleshooting
*   **Permission Denied**: If you encounter a "permission denied" error even after `chmod +x`, check if the filesystem is mounted with `noexec` or if you have the necessary database privileges to create/drop tables in the target assembly.
*   **Missing Tables**: If `checkHgFindSpec` fails, it is often because the `searchTable` defined in the `.ra` file has not been loaded into the database yet. Load the data tables before finalizing the search specifications.

## Reference documentation
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-hgfindspec Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-hgfindspec_overview.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [Linux AArch64 Binary List (v492)](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.aarch64.v492.md)