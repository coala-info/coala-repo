---
name: ucsc-bedremoveoverlap
description: `bedRemoveOverlap` is a high-performance utility from the UCSC Kent toolset designed to resolve interval conflicts in BED files.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-bedremoveoverlap

## Overview
`bedRemoveOverlap` is a high-performance utility from the UCSC Kent toolset designed to resolve interval conflicts in BED files. It processes genomic intervals sequentially and filters out any record that overlaps with a previously accepted interval. This tool is particularly valuable for cleaning up redundant datasets, preparing data for visualization where overlapping features cause clutter, or ensuring that downstream analysis tools receive a set of unique, non-overlapping genomic coordinates.

## Command Line Usage

The tool follows a simple positional argument structure:

```bash
bedRemoveOverlap input.bed output.bed
```

### Mandatory Sorting
The most critical requirement for `bedRemoveOverlap` is that the input BED file must be sorted by chromosome and then by start position. If the file is not sorted, the tool may fail to identify overlaps or produce incorrect results.

**Recommended Workflow:**
Always pipe or sequence the input through `bedSort` (another UCSC utility) if the sorting status is unknown:

```bash
bedSort input.bed sorted.bed
bedRemoveOverlap sorted.bed output.bed
```

## Expert Tips and Best Practices

### Greedy Selection Logic
`bedRemoveOverlap` typically employs a "first-come, first-served" logic. It keeps the first record it encounters in the sorted file and discards subsequent records that overlap with it. If you have a preference for which overlapping record to keep (e.g., keeping the one with the highest score), you should sort your file by score *within* the coordinate sorting before running this tool.

### Data Integrity
*   **BED Format:** The tool works with standard BED formats (BED3 through BED12). It preserves the columns of the records it keeps.
*   **Large Datasets:** Because it processes the file linearly after sorting, it is extremely memory-efficient and suitable for whole-genome datasets.

### Permission Errors
If you are using the standalone binary downloaded directly from UCSC (rather than via Conda), you may need to set execution permissions:

```bash
chmod +x bedRemoveOverlap
./bedRemoveOverlap input.bed output.bed
```

## Reference documentation
- [ucsc-bedremoveoverlap overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bedremoveoverlap_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)