---
name: ucsc-fasomerecords
description: This tool extracts specific sequences from a FASTA file. Use when user asks to extract specific sequences from a FASTA file, subset a FASTA file by sequence names, or exclude sequences from a FASTA file.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-fasomerecords

## Overview
The `faSomeRecords` utility is a specialized tool from the UCSC Genome Browser "kent" source tree designed for efficient sequence extraction. It allows you to provide a source FASTA file and a simple text list of sequence names to generate a new FASTA file containing only those specific records. This is significantly more reliable and faster than using generic text-processing tools like `grep` for subsetting genomic data.

## Usage Instructions

### Basic Command Pattern
The tool requires three positional arguments:
```bash
faSomeRecords input.fa list.txt output.fa
```
*   **input.fa**: The source multi-FASTA file containing all sequences.
*   **list.txt**: A plain text file containing the names of the sequences you want to extract (one name per line).
*   **output.fa**: The destination file where the extracted records will be saved.

### Identifier Matching
*   **Exact Match**: The tool matches the identifiers in your list against the FASTA header. It typically looks at the first word of the header (everything before the first whitespace).
*   **Case Sensitivity**: Ensure the IDs in your list match the case used in the FASTA file exactly.

### Common Workflow Patterns
1.  **Preparation**: If you have a list of IDs with extra columns (like a BED file or metadata table), extract just the ID column first:
    ```bash
    cut -f1 my_data.tsv > list.txt
    ```
2.  **Execution**: Run the extraction:
    ```bash
    faSomeRecords genome.fa list.txt subset.fa
    ```
3.  **Verification**: Use `grep` to count the headers in the output to ensure it matches the number of lines in your list:
    ```bash
    grep -c ">" subset.fa
    wc -l list.txt
    ```

## Expert Tips
*   **Permissions**: If you downloaded the binary directly from the UCSC server, you must make it executable before use: `chmod +x faSomeRecords`.
*   **Excluding Records**: While the primary use is extraction, some versions of the tool support an `-exclude` flag to perform the inverse operation (saving everything *except* the records in the list). Run the tool with no arguments to check if your specific version supports this.
*   **Large Files**: `faSomeRecords` is optimized for memory efficiency, making it suitable for large chromosome-level FASTA files where other scripts might fail.
*   **Database Connectivity**: Note that while some UCSC tools require an `.hg.conf` file for MySQL connectivity, `faSomeRecords` is a standalone file-processing utility and does not require database access.

## Reference documentation
- [UCSC Administrative Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-fasomerecords Package Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-fasomerecords_overview.md)