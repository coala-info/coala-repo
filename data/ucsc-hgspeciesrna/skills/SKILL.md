---
name: ucsc-hgspeciesrna
description: The `hgSpeciesRna` utility is a specialized tool from the UCSC Genome Browser "kent" source tree designed to generate FASTA files of RNA sequences for a single species.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---

# ucsc-hgspeciesrna

## Overview
The `hgSpeciesRna` utility is a specialized tool from the UCSC Genome Browser "kent" source tree designed to generate FASTA files of RNA sequences for a single species. It is particularly useful for researchers who need to isolate transcript data from the vast UCSC databases for downstream applications like BLAST searches, mapping, or RNA-seq reference generation.

## Usage Patterns

### Basic Command Structure
The tool is typically executed by specifying the target species and the output destination.
```bash
hgSpeciesRna [database] [output.fa]
```
*   **database**: The UCSC database name (e.g., `hg38` for human, `mm39` for mouse).
*   **output.fa**: The name of the resulting FASTA file.

### Common CLI Options
While specific flags can vary by version, the following are standard patterns for UCSC kent utilities:
*   `-verbose=N`: Set the verbosity level (default is 1).
*   `-noHeader`: Omit the header information in the output.

### Environment Setup
Many UCSC command-line tools require a connection to the public MySQL server.
1.  **Configuration**: Ensure an `.hg.conf` file exists in your home directory.
2.  **Permissions**: If running a manually downloaded binary, ensure it is executable:
    ```bash
    chmod +x hgSpeciesRna
    ```

## Best Practices
*   **Database Naming**: Always use the specific UCSC assembly ID (e.g., use `hg38` rather than just "human") to ensure the correct genomic version is accessed.
*   **MySQL Access**: If the tool fails to connect, verify that your network allows outgoing connections to `genome-mysql.soe.ucsc.edu` on port 3306.
*   **Binary Selection**: Ensure you are using the binary matching your architecture (e.g., `linux.x86_64` vs `macOSX.arm64`).

## Reference documentation
- [UCSC Admin Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-hgspeciesrna Package](./references/anaconda_org_channels_bioconda_packages_ucsc-hgspeciesrna_overview.md)