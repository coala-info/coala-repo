---
name: ucsc-getrna
description: The `ucsc-getrna` utility (commonly executed as the binary `getRna`) is a specialized tool within the UCSC Kent command-line suite.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-getrna

## Overview
The `ucsc-getrna` utility (commonly executed as the binary `getRna`) is a specialized tool within the UCSC Kent command-line suite. It facilitates the retrieval of mRNA sequences specifically for GenBank or RefSeq entries stored within genomic databases. It is most effective when you need to programmatically extract transcript sequences associated with a particular genome assembly (e.g., hg38, mm10) without manually navigating the UCSC Genome Browser.

## Usage Instructions

### Database Connection Requirements
Many UCSC utilities, including `getRna`, connect directly to the UCSC public MySQL server.
- **Configuration File**: You must have an `.hg.conf` file in your home directory to provide connection parameters.
- **Public MySQL Settings**: To use the UCSC public server, your `.hg.conf` should typically include:
  ```text
  db.host=genome-mysql.soe.ucsc.edu
  db.user=genomep
  db.password=password
  central.db=hgcentral
  ```
- **Permissions**: Ensure the binary has execution permissions using `chmod +x getRna`.

### Common CLI Patterns
The tool generally follows the standard Kent utility syntax:
`getRna [database] [outputFile] [options]`

- **Database**: Specify the assembly name (e.g., `hg38`).
- **Output**: The resulting file is typically in FASTA format.

### Best Practices and Expert Tips
- **Environment Setup**: If you are using the Bioconda version, the tool is already in your PATH. If downloading directly from the UCSC directory, ensure you select the correct architecture (e.g., `linux.x86_64` or `macOSX.arm64`).
- **Batch Processing**: `getRna` is optimized for database-wide or large-scale retrievals. For single sequences, standard web APIs might be faster, but for pipeline integration, this tool is superior.
- **MySQL Errors**: If you encounter "Access denied" or "Can't connect" errors, verify your `.hg.conf` settings and ensure your network allows outgoing connections on port 3306.
- **Binary Discovery**: If `getRna` is not found, check the UCSC binary directory for your specific OS version (e.g., `v482_base`) as naming conventions can occasionally vary between the source and the compiled binary.

## Reference documentation
- [UCSC Genome Browser Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-getrna Package Details](./references/anaconda_org_channels_bioconda_packages_ucsc-getrna_overview.md)
- [UCSC MySQL Connection Guide](./references/hgdownload_cse_ucsc_edu_admin_exe.md) (referenced via the MySQL help link in the documentation)