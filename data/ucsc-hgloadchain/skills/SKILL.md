---
name: ucsc-hgloadchain
description: `hgLoadChain` parses generic chain files and imports them into a structured SQL table. Use when user asks to import chain files into a database, load chain files for genome assembly hubs, prepare chain files for comparative genomics, or visualize synteny and cross-species mappings.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-hgloadchain:482--h0b57e2e_0"
---

# ucsc-hgloadchain

## Overview
The `hgLoadChain` utility is part of the UCSC Genome Browser "kent" toolset. It parses generic chain files—which describe gapless blocks of alignments between two genomes—and imports them into a structured SQL table. This is a critical step in genome assembly hub creation and comparative genomics workflows, as it transforms flat files into a queryable format used by the Genome Browser to visualize synteny and cross-species mappings.

## Usage Instructions

### Prerequisites
1. **Database Configuration**: You must have an `.hg.conf` file in your home directory to provide database credentials.
2. **Table Schema**: The tool typically creates the table automatically, but it must be run against an existing database (e.g., a local mirror of `hg38`).
3. **Permissions**: Ensure the binary is executable:
   ```bash
   chmod +x hgLoadChain
   ```

### Basic Command Pattern
The standard syntax follows the pattern of most UCSC "hgLoad" utilities:
```bash
hgLoadChain [options] database tableName file.chain
```

### Common CLI Patterns
*   **Standard Load**: Imports a chain file into a specific database table.
    ```bash
    hgLoadChain hg38 chainRhesus file.chain
    ```
*   **Viewing Usage**: Run the tool without arguments to see specific version-dependent flags and options.
    ```bash
    hgLoadChain
    ```

### Expert Tips and Best Practices
*   **The .hg.conf Requirement**: If you encounter connection errors, verify that your `~/.hg.conf` contains the correct `db.host`, `db.user`, and `db.password` entries. For public UCSC data, you may need to point to `genome-mysql.soe.ucsc.edu`.
*   **Naming Conventions**: By convention, chain tables in the UCSC browser are often named `chain<Species>`, where `<Species>` is the target organism (e.g., `chainMm10`).
*   **Data Integrity**: Always validate your chain files with `checkChain` (if available in your environment) before loading to ensure the coordinates are consistent with the target database assembly.
*   **Large Scale Loading**: For very large chain files, ensure your MySQL server's `tmpdir` has sufficient space, as the tool may perform large batch inserts.

## Reference documentation
- [UCSC Admin Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-hgloadchain Package](./references/anaconda_org_channels_bioconda_packages_ucsc-hgloadchain_overview.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)