---
name: ucsc-ldhggene
description: The ucsc-ldhggene tool loads gene prediction data from GFF files into a MySQL database. Use when user asks to 'load gene prediction data', 'ingest GFF data', 'set up a UCSC Genome Browser mirror', or 'manage custom genomic databases'.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---


# ucsc-ldhggene

## Overview
The `ldHgGene` utility is a specialized tool from the UCSC Genome Browser "kent" source suite. It facilitates the ingestion of gene prediction data—typically formatted as GFF (General Feature Format)—into a structured MySQL database. This is a critical step for researchers and bioinformaticians setting up local mirrors of the UCSC Genome Browser or managing custom genomic databases where gene models need to be visualized or queried via the browser's backend.

## Usage Guidelines

### Prerequisites
Before running `ldHgGene`, ensure the following environment setup is complete:
*   **Database Configuration**: You must have an `.hg.conf` file in your home directory. This file contains the credentials (host, user, password) required to connect to your MySQL server.
*   **Permissions**: If using the standalone binary, ensure it is executable: `chmod +x ldHgGene`.
*   **Database Existence**: The target database (e.g., `hg38` or a custom assembly) must already exist on the MySQL server.

### Common Command Pattern
The basic syntax for the tool follows this structure:
```bash
ldHgGene [options] database table gffFile
```

### Best Practices
*   **Self-Documentation**: Run the command without any arguments to view the most up-to-date list of supported flags and specific GFF version requirements.
*   **Table Naming**: By convention, UCSC gene tables are often named `genePred`, `refGene`, or `ensGene`. Ensure your table name aligns with your downstream visualization needs.
*   **Data Validation**: Ensure your GFF file is properly formatted and matches the coordinate system of the target database assembly to prevent alignment errors in the browser.
*   **MySQL Connection**: If you encounter connection errors, verify that your `.hg.conf` file has the correct permissions (typically `600`) and that the MySQL server allows connections from your current host.

### Expert Tips
*   **Public MySQL Access**: While `ldHgGene` is typically used for local database loading, the UCSC Genome Browser suite can sometimes be configured to interact with the public MySQL server (`genome-mysql.soe.ucsc.edu`) for read-only operations, though loading data requires a local writeable instance.
*   **Integration with Kent Tools**: `ldHgGene` is often used in pipelines alongside `gtfToGenePred` or `gff3ToGenePred` if your source data requires conversion before being loaded into the database schema.

## Reference documentation
- [UCSC Admin Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-ldhggene Package](./references/anaconda_org_channels_bioconda_packages_ucsc-ldhggene_overview.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)