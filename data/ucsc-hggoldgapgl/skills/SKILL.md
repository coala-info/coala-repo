---
name: ucsc-hggoldgapgl
description: The `hgGoldGapGl` utility is a specialized tool within the UCSC Genome Browser "kent" suite.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---

# ucsc-hggoldgapgl

## Overview
The `hgGoldGapGl` utility is a specialized tool within the UCSC Genome Browser "kent" suite. It automates the process of taking assembly specification files and inserting them into the relational database structure required by the Genome Browser. This is a fundamental step when building a local mirror of the browser or setting up a custom assembly database. It translates the physical layout of clones and contigs described in AGP files into the database tables that the browser uses to render the "Base Position" and "Assembly" tracks.

## Command Line Usage

### Prerequisites
Before running the tool, ensure you have a valid `.hg.conf` file in your home directory. This file contains the credentials and host information for the MySQL database where the browser data resides.

### Basic Syntax
The tool is typically invoked with the following positional arguments:

```bash
hgGoldGapGl [database] [chromosome] [agp_file] [gl_file]
```

*   **database**: The name of the target MySQL database (e.g., hg38, mm10, or a custom assembly name).
*   **chromosome**: The specific chromosome name being loaded (e.g., chr1).
*   **agp_file**: The path to the .agp file containing the assembly coordinates.
*   **gl_file**: The path to the .gl file containing the gap/clone list.

### Common Workflow Pattern
1.  **Prepare the Database**: Ensure the target database exists in your MySQL instance.
2.  **Set Permissions**: If you have just downloaded the binary, ensure it is executable:
    ```bash
    chmod +x hgGoldGapGl
    ```
3.  **Execute Loading**: Run the tool for each chromosome in your assembly.
    ```bash
    hgGoldGapGl myDb chr1 chr1.agp chr1.gl
    ```

## Expert Tips and Best Practices

*   **Database Connectivity**: If you encounter "permission denied" or connection errors, verify that your `.hg.conf` file is correctly formatted and that the user specified has `INSERT` and `CREATE` privileges on the target database.
*   **AGP Versioning**: Ensure your .agp files follow the standard format (v1.1 or v2.0). The tool expects specific column counts to correctly parse the "gold" (finished/draft sequences) and "gap" components.
*   **Verification**: After running the tool, use the `hgsql` utility to verify that the tables were populated:
    ```bash
    hgsql -e "select count(*) from gold where chrom='chr1'" myDb
    ```
*   **Batch Processing**: For large assemblies with many scaffolds or chromosomes, use a simple shell loop to process all files in a directory, provided they follow a consistent naming convention.
*   **Source Code Reference**: If you need to debug specific parsing logic, the source code for this utility is maintained in the UCSC Genome Browser GitHub repository under `kent/src/hg/hgGoldGapGl/`.

## Reference documentation
- [ucsc-hggoldgapgl bioconda overview](./references/anaconda_org_channels_bioconda_packages_ucsc-hggoldgapgl_overview.md)
- [UCSC Genome Browser Binary Instructions](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [UCSC Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)