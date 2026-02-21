---
name: ucsc-subcolumn
description: The `subColumn` utility is a high-performance command-line tool from the UCSC Genome Browser suite designed for efficient column substitution in tab-separated files.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-subcolumn

## Overview
The `subColumn` utility is a high-performance command-line tool from the UCSC Genome Browser suite designed for efficient column substitution in tab-separated files. It is particularly useful in bioinformatics workflows for mapping internal IDs to public accessions, updating chromosome names, or replacing specific data fields based on a lookup table. It operates by reading a mapping file into memory and then streaming the target file, making it suitable for very large datasets.

## Usage Patterns

### Basic Syntax
The tool requires three positional arguments:
```bash
subColumn <column_index> <input_file> <mapping_file> <output_file>
```
*   **column_index**: The 1-based index of the column to be replaced.
*   **input_file**: The TSV file containing the data to be modified.
*   **mapping_file**: A two-column TSV file where the first column is the "old" value and the second column is the "new" value.
*   **output_file**: The destination for the modified data.

### Common CLI Examples

**Replacing Chromosome Names (Column 1) in a BED file:**
If you have a BED file using "1, 2, 3" and need "chr1, chr2, chr3":
```bash
subColumn 1 input.bed chrom_map.tsv output.bed
```
*Note: `chrom_map.tsv` should look like:*
```text
1   chr1
2   chr2
```

**Updating Gene IDs in a results table:**
To replace internal IDs in the 4th column of a results file:
```bash
subColumn 4 results.tsv id_mapping.tsv updated_results.tsv
```

## Expert Tips and Best Practices

1.  **Tab-Separated Only**: The tool is strictly designed for tab-separated files. If your file uses spaces or commas, use `sed` or `awk` to convert them to tabs before running `subColumn`.
2.  **1-Based Indexing**: Unlike many programming languages (like Python or C) that use 0-based indexing, `subColumn` uses 1-based indexing for columns.
3.  **Mapping File Structure**: The mapping file must be a two-column TSV. The tool performs a literal string match on the first column to find the replacement value in the second column.
4.  **Handling Missing Values**: If a value in the input file's target column does not exist in the mapping file, the tool typically leaves the original value unchanged. Always verify a subset of your output to ensure the mapping coverage is as expected.
5.  **Permissions**: If you downloaded the binary directly from the UCSC server, ensure it is executable:
    ```bash
    chmod +x subColumn
    ```
6.  **Streaming and Pipes**: While the standard usage involves an output file, you can often use `/dev/stdout` or standard Unix redirection if you need to pipe the results into another UCSC tool like `bedSort`.

## Reference documentation
- [UCSC Genome Browser Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-subcolumn Package Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-subcolumn_overview.md)
- [UCSC Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.v369.md)