---
name: ucsc-bedintersect
description: This tool identifies genomic regions in a primary BED file that overlap with regions in a secondary BED file. Use when user asks to find intersections between genomic intervals, filter SNPs by functional regions, or identify overlaps between ChIP-seq peaks and promoters.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-bedintersect

## Overview
The `bedIntersect` utility is a specialized tool from the UCSC Genome Browser "Kent" suite designed for rapid interval intersection. It identifies genomic regions in a primary BED file that share coordinates with regions in a secondary BED file. This is a fundamental operation in bioinformatics for tasks such as filtering SNPs by functional regions, finding overlaps between ChIP-seq peaks and promoters, or subsetting genomic annotations based on specific regions of interest.

## Usage Patterns

### Basic Intersection
The tool requires two BED files as input. By default, it outputs the entries from the first file that overlap with the second.

```bash
bedIntersect fileA.bed fileB.bed output.bed
```

### Common CLI Options
While specific flags can vary by version, the standard UCSC utility pattern for `bedIntersect` includes:

*   **-a**: Use the first file as the reference (default behavior).
*   **-b**: Use the second file as the reference.
*   **-u**: Write the original A entry once if any overlap is found (unique).
*   **-v**: Write the original A entry only if there is NO overlap with B (subtraction/exclusion).

### Expert Tips
1.  **Sorting Requirement**: Like most UCSC BED tools, performance is significantly improved, and errors are avoided, if input files are sorted by chromosome and then by start position. Use `bedSort` before intersecting.
    ```bash
    bedSort input.bed sorted.bed
    ```
2.  **Standard Streams**: The tool typically supports standard input/output, allowing it to be piped with other Kent utilities like `featureBits` or `bedClip`.
3.  **Chromosome Naming**: Ensure that both BED files use the same chromosome naming convention (e.g., both using "chr1" or both using "1"). The tool will not find overlaps if the naming schemes differ.
4.  **BED Format Strictness**: Ensure your files are tab-separated. UCSC tools are sensitive to whitespace and expect the first three columns to be `chrom`, `chromStart`, and `chromEnd`.

## Reference documentation
- [ucsc-bedintersect - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-bedintersect_overview.md)
- [Index of /admin/exe/linux.x86_64](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [GitHub - ucscGenomeBrowser/kent: UCSC Genome Browser source](./references/github_com_ucscGenomeBrowser_kent.md)