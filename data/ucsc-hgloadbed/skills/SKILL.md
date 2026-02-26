---
name: ucsc-hgloadbed
description: The `ucsc-hgloadbed` tool transforms flat BED files into database tables for the UCSC Genome Browser. Use when user asks to load BED files into a database, upload genomic annotations, create database tables for genomic data, or load custom BED fields.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-hgloadbed

## Overview
The `hgLoadBed` utility is a core component of the UCSC Genome Browser "kent" tool suite. It automates the process of transforming flat BED files into database tables. It handles the creation of the table schema, the calculation of binning indexes for high-performance spatial queries, and the actual data upload. This tool is essential for bioinformaticians maintaining local UCSC mirrors or those who need to programmatically manage large-scale genomic annotation databases.

## Usage Patterns and Best Practices

### Basic Command Structure
The standard syntax requires the target database, the table name, and the input BED file:
```bash
hgLoadBed [options] database tableName input.bed
```

### Database Configuration
`hgLoadBed` requires a connection to a MySQL server. By default, it looks for a configuration file named `.hg.conf` in your home directory.
*   **Expert Tip**: Ensure your `.hg.conf` contains the correct `db.host`, `db.user`, and `db.password` for the target database.
*   **Permissions**: You must have `CREATE` and `INSERT` privileges on the target MySQL database.

### Common CLI Options
*   **-noBin**: Use this if you do not want the tool to add a `bin` column. Note that the UCSC Genome Browser generally requires the `bin` column for performance.
*   **-tab**: Tells the tool that the input is tab-separated (standard for BED).
*   **-sqlTable=file.sql**: Provide a custom `.sql` file to define the table schema instead of letting the tool auto-generate it.
*   **-notStrict**: Skip some of the stricter validation checks on the BED format.
*   **-renameSqlTable**: Useful if the internal table name in a provided SQL file differs from the `tableName` argument.

### Handling Custom BED Fields
If your BED file has more than the standard 3 to 12 columns (e.g., BED+ format), you should provide an AutoSql (`.as`) file to define the extra fields:
```bash
hgLoadBed -customAs=myFields.as database tableName input.bed
```

### Performance and Validation
1.  **Sorting**: While `hgLoadBed` can handle unsorted files, it is a best practice to run `bedSort` on your input file before loading to ensure data integrity and optimal database indexing.
2.  **Chromosomes**: Ensure the chromosome names in your BED file exactly match the `chrom` table in your target database (e.g., `chr1` vs `1`).
3.  **Large Files**: For extremely large datasets, ensure your MySQL `tmpdir` has enough space, as the tool may create temporary files during the load process.

## Troubleshooting
*   **Permission Denied**: If running the binary directly after download, ensure it is executable: `chmod +x hgLoadBed`.
*   **Connection Errors**: If the tool cannot find the database, verify the `HGDB_CONF` environment variable points to your `.hg.conf` file if it is not in the default home directory location.

## Reference documentation
- [UCSC Genome Browser Admin Executables](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-hgloadbed Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-hgloadbed_overview.md)
- [Linux x86_64 Binary Index](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)