---
name: ucsc-bedcommonregions
description: `bedCommonRegions` is a specialized utility from the UCSC Genome Browser "Kent" toolset designed to identify genomic intervals that overlap across every input file provided.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-bedcommonregions

## Overview
`bedCommonRegions` is a specialized utility from the UCSC Genome Browser "Kent" toolset designed to identify genomic intervals that overlap across every input file provided. While many tools perform pairwise intersections, this utility is optimized for finding the "consensus" or "common core" regions among a set of BED files. It simplifies the output to a standard 3-column BED format (chrom, start, end), making it ideal for generating reference sets of shared genomic features.

## Command Line Usage

The basic syntax for the tool requires two or more input BED files:

```bash
bedCommonRegions input1.bed input2.bed input3.bed > common_regions.bed
```

### Common Patterns

**Finding consensus across a directory of samples:**
If you have multiple peak calls or feature sets and want to find regions present in every single sample:
```bash
bedCommonRegions path/to/samples/*.bed > consensus_peaks.bed
```

**Integrating with other UCSC tools:**
Since the tool outputs to `stdout`, it is often used in pipes. It is a best practice to sort the output if it will be used for further UCSC processing:
```bash
bedCommonRegions in1.bed in2.bed in3.bed | bedSort stdin common_sorted.bed
```

## Expert Tips and Best Practices

*   **Strict Intersection**: A region is only included in the output if it is represented in **all** input files. If a region is missing from even one file, it will be excluded.
*   **BED3 Output**: Regardless of the complexity of your input files (e.g., BED6 or BED12), the output will always be a simple BED3 file. This tool is intended for coordinate discovery, not for preserving metadata like scores or strand information.
*   **Input Requirements**: Ensure all input files use the same coordinate system (e.g., all hg38 or all mm10). The tool does not perform liftover or check for assembly consistency.
*   **Permission Errors**: If running the binary directly after download from UCSC, you may need to grant execution permissions: `chmod +x bedCommonRegions`.
*   **Memory Efficiency**: Like most Kent utilities, `bedCommonRegions` is designed to be fast and efficient, but when working with dozens of very large BED files, ensure your environment has sufficient memory to hold the intersection structures.

## Reference documentation
- [ucsc-bedcommonregions overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bedcommonregions_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)