---
name: get_fasta_info
description: This tool extracts structural statistics, metadata, and missing data proportions from FASTA and FASTQ files. Use when user asks to summarize sequence lengths, quantify gaps, validate file integrity, or list per-sequence details.
homepage: https://github.com/nylander/get_fasta_info
---


# get_fasta_info

## Overview
The `get_fasta_info` suite consists of high-performance C programs and flexible Perl scripts designed for rapid assessment of sequence data. Unlike heavy bioinformatics packages, these tools provide a lightweight way to extract metadata and structural statistics from genomic files. They are particularly effective for validating file integrity, checking alignment status (by comparing min and max lengths), and quantifying missing data across thousands of sequences.

## Core Tool Usage

### get_fasta_info (C Program)
The primary tool for FASTA files. It outputs tab-delimited statistics: `Nseqs`, `Min.len`, `Max.len`, `Avg.len`, and `File`.

*   **Basic Summary**: `get_fasta_info sequences.fasta`
*   **Gap/Missing Data Analysis**: Use `-g` to report the proportion of missing data (default symbols: `Nn?Xx-`).
    *   `get_fasta_info -g sequences.fasta`
*   **Custom Missing Symbols**: Use `-C` followed by specific characters to define what constitutes a "gap".
    *   `get_fasta_info -C N sequences.fasta` (Only count 'N' as missing)
*   **Clean Output**: Use `-n` to suppress the header, which is useful for piping into downstream tools like `awk` or `sort`.

### get_fastq_info (C Program)
Specifically for FASTQ files.
*   **Quality Metrics**: Use `-q` to include the average read quality in the output.
    *   `get_fastq_info -q reads.fastq`
*   **Compressed Input**: Both C tools natively handle `.gz` files.

### get_fasta_details.pl (Perl Script)
Use this when you need per-sequence information rather than a file-wide summary. It lists the length, sequence number, and header for every entry.
*   **Sort by Length**: 
    *   Shortest first: `get_fasta_details.pl -s input.fasta`
    *   Longest first: `get_fasta_details.pl -r input.fasta`

## Expert CLI Patterns

### Identifying Unaligned Files
A file is likely unaligned if the minimum length does not equal the maximum length.
```bash
get_fasta_info -n *.fasta | awk '$2 != $3 {print $NF}'
```

### Finding Empty Sequences
To identify files containing sequences with zero length:
```bash
get_fasta_info -n *.fasta | awk '!$2 {print $NF}'
```

### High-Performance Decompression
For very large compressed files, use `pigz` (parallel gzip) with process substitution to significantly reduce wall-clock time:
```bash
get_fasta_info <(pigz -d -c large_file.fasta.gz)
```
*Note: This will report the file name as a file descriptor (e.g., /dev/fd/63).*

### Filtering by Missing Data
To find files where at least one sequence consists entirely of missing data:
```bash
get_fasta_info -g -n *.fasta | awk '$6 == 1.00 {print $NF}'
```

## Best Practices
*   **Standardization**: Use the `-p` flag to print the absolute path of the input file, ensuring your logs are reproducible even if the working directory changes.
*   **Error Handling**: The tools print to both STDOUT and STDERR. When parsing in scripts, redirect STDERR to `/dev/null` to keep your data tables clean.
*   **Empty Sequences**: Be aware that `get_fasta_info` includes 0-length sequences in its average length calculations.

## Reference documentation
- [get_fasta_info GitHub Repository](./references/github_com_nylander_get_fasta_info.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_get_fasta_info_overview.md)