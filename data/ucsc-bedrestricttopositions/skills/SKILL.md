---
name: ucsc-bedrestricttopositions
description: This tool filters a BED file to retain only records that exactly match genomic intervals specified in a restriction BED file. Use when user asks to filter a BED file by exact genomic coordinates, extract specific features based on precise locations, or retrieve full feature information for known exact coordinates.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-bedrestricttopositions

## Overview
`bedRestrictToPositions` is a specialized filtering utility from the UCSC Genome Browser "kent" toolset. It is used to extract specific records from a BED file by comparing them against a "restriction" BED file. Unlike standard intersection tools that identify any degree of overlap, this tool requires an exact match of the genomic interval (Chromosome, Start, and End). It is particularly useful for isolating specific features from large datasets when the exact coordinates of interest are already known.

## Usage Instructions

### Basic Command Line Syntax
The tool follows a straightforward positional argument pattern:

```bash
bedRestrictToPositions input.bed restrict.bed output.bed
```

If you wish to stream the output to other tools, you can often use `stdout` as the output destination (depending on the specific build) or use standard redirection:

```bash
bedRestrictToPositions input.bed restrict.bed stdout
```

### Key Requirements
*   **Exact Coordinate Matching**: The tool only retains records where `chrom`, `chromStart`, and `chromEnd` are identical in both the input and the restriction file.
*   **BED Format**: Ensure both files are valid tab-separated BED files. While the tool primarily looks at the first three columns for matching, it preserves the additional columns (name, score, strand, etc.) from the `input.bed` in the output.
*   **Sorting**: For optimal performance and compatibility with other UCSC utilities, it is a best practice to sort your BED files using `bedSort` before processing.

### Common Workflow Pattern
A typical expert workflow involves sorting the input data before performing the restriction to ensure downstream compatibility:

```bash
# Sort the files first
bedSort raw_data.bed sorted_data.bed
bedSort regions_of_interest.bed sorted_restrict.bed

# Perform the restriction
bedRestrictToPositions sorted_data.bed sorted_restrict.bed filtered_output.bed
```

## Expert Tips
*   **Strict Filtering**: Use this tool instead of `bedtools intersect` or `overlapSelect` when you want to avoid partial overlaps. If a record in your input file overlaps a restriction region by 99% but the start/end coordinates differ by even one base, it will be excluded.
*   **Preserving Metadata**: Because the tool retains the full line from the `input.bed`, it is an excellent way to "lookup" and extract full feature information (like gene names or scores) for a specific list of coordinates.
*   **Permission Errors**: If running the binary directly from a download, ensure it has execution permissions: `chmod +x bedRestrictToPositions`.

## Reference documentation
- [ucsc-bedrestricttopositions overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bedrestricttopositions_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)