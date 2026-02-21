---
name: ucsc-bedweedoverlapping
description: The `bedWeedOverlapping` utility is a high-performance filtering tool from the UCSC Genome Browser "Kent" source tree.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-bedweedoverlapping

## Overview
The `bedWeedOverlapping` utility is a high-performance filtering tool from the UCSC Genome Browser "Kent" source tree. It performs a negative spatial join, effectively "weeding out" any genomic features from an input file that touch or overlap regions defined in a filter file. This tool is a lightweight alternative to more complex interval algebra suites when the primary goal is simple exclusion based on overlap.

## Command Line Usage

The basic syntax for the tool follows the standard UCSC positional argument pattern:

```bash
bedWeedOverlapping input.bed weed.bed output.bed
```

### Positional Arguments
1.  **input.bed**: The source BED file containing the features you want to keep.
2.  **weed.bed**: The reference BED file containing the "weeds" (regions to be excluded).
3.  **output.bed**: The resulting file containing only the records from `input.bed` that had zero overlap with `weed.bed`.

## Expert Tips and Best Practices

### 1. Pre-sorting for Performance
While `bedWeedOverlapping` is efficient, processing very large datasets (e.g., whole-genome sequencing results) is faster and more reliable if the files are pre-sorted by chromosome and start position. Use the companion tool `bedSort`:
```bash
bedSort input.bed input.sorted.bed
bedSort weed.bed weed.sorted.bed
bedWeedOverlapping input.sorted.bed weed.sorted.bed output.bed
```

### 2. Handling Permissions
If you are using the standalone binaries downloaded directly from the UCSC server rather than via Conda, you must ensure the binary has execution permissions:
```bash
chmod +x ./bedWeedOverlapping
./bedWeedOverlapping input.bed weed.bed output.bed
```

### 3. Use Cases for "Weeding"
*   **Blacklist Filtering**: Remove ENCODE/UCSC blacklisted regions known to have artificially high signals.
*   **Repeat Masking**: Filter out elements that fall within RepeatMasker-identified regions.
*   **Coding Region Isolation**: Remove any intervals that overlap with known exons to focus on intronic or intergenic space.

### 4. Comparison with Other Tools
`bedWeedOverlapping` is functionally equivalent to `bedtools intersect -v -a input.bed -b weed.bed`. Use the UCSC version when working within a pipeline primarily composed of Kent utilities (like `bigBedToBed` or `liftOver`) to ensure consistent handling of BED format nuances and chromosome naming.

## Reference documentation
- [ucsc-bedweedoverlapping - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-bedweedoverlapping_overview.md)
- [Index of /admin/exe/linux.x86_64](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [Index of /admin/exe](./references/hgdownload_cse_ucsc_edu_admin_exe.md)