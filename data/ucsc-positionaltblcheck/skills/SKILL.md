---
name: ucsc-positionaltblcheck
description: ucsc-positionaltblcheck validates that genomic data tables are correctly sorted by chromosome and start position. Use when user asks to check the sorting of genomic tables, verify BED file order, confirm integrity of exported genomic data, or validate sorting in bioinformatics pipelines.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-positionaltblcheck

## Overview
The `positionalTblCheck` utility is a specialized validation tool from the UCSC Genome Browser "kent" source suite. Its primary function is to ensure that genomic data tables are properly ordered. In the UCSC database schema, "positional" tables must be sorted primarily by chromosome (chrom) and secondarily by the starting coordinate (chromStart). This sorting is a prerequisite for efficient indexing and data retrieval within the browser.

## Usage Instructions

### Basic Validation
To check a table file for correct sorting, run the command against the target file. By default, the tool assumes the standard UCSC positional format where the chromosome is in the first column and the start position is in the second or third column (depending on the specific table type).

```bash
positionalTblCheck <filename>
```

### Common CLI Patterns
*   **Checking BED files**: Since BED files are the most common positional format, use this tool to verify a BED file before converting it to BigBed or uploading it as a custom track.
*   **Database Table Dumps**: If you have exported a table from a MySQL genomic database (e.g., `hg38`), use this tool to verify the integrity of the export before re-importing it into a different environment.
*   **Pipeline Integration**: Use this as a "gatekeeper" step in bioinformatics pipelines after a sorting operation (like `sort -k1,1 -k2,2n`) to confirm the sort was successful before proceeding to compute-intensive downstream analysis.

### Expert Tips
*   **Permission Errors**: If you have just downloaded the binary from the UCSC servers, you must grant execution permissions before use: `chmod +x positionalTblCheck`.
*   **Silent Success**: The tool typically follows the Unix philosophy—if the table is correctly sorted, it will exit without output. If it encounters an out-of-order record, it will report the specific line and coordinates where the sort order is violated.
*   **Database Connectivity**: While this specific utility is often used on flat files, many UCSC tools can interact with a local `.hg.conf` file to validate tables directly against a MySQL instance. Ensure your `.hg.conf` is in your home directory if you are working within a full UCSC mirror environment.
*   **Sorting Requirement**: If `positionalTblCheck` fails, the standard fix is to use `bedSort` (for BED files) or a standard Linux sort:
    ```bash
    sort -k1,1 -k2,2n input.txt > sorted_output.txt
    ```

## Reference documentation
- [UCSC Admin Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda Package Metadata](./references/anaconda_org_channels_bioconda_packages_ucsc-positionaltblcheck_overview.md)
- [Linux x86_64 Binary Directory](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)