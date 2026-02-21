---
name: ucsc-crtreeindexbed
description: The `crTreeIndexBed` utility is part of the UCSC Genome Browser "Kent" toolset.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-crtreeindexbed

## Overview
The `crTreeIndexBed` utility is part of the UCSC Genome Browser "Kent" toolset. It transforms a standard BED file into a specialized CR-Tree index format. This indexing strategy is optimized for genomic coordinates, allowing for extremely fast retrieval of features overlapping specific chromosomal ranges. Use this tool when working with large BED files where linear searching is computationally prohibitive.

## Common CLI Patterns

### Basic Indexing
To create an index from a BED file:
```bash
crTreeIndexBed input.bed output.cr
```

### Preparing Input Data
UCSC indexing tools generally require input files to be sorted by chromosome and then by start position. Use `bedSort` (another UCSC utility) to prepare your file:
```bash
bedSort input.bed sorted_input.bed
crTreeIndexBed sorted_input.bed output.cr
```

### Searching the Index
Once the `.cr` index is created, use `crTreeSearchBed` to perform queries:
```bash
crTreeSearchBed output.cr chrom start end out.bed
```

## Expert Tips and Best Practices

*   **File Permissions**: If you have downloaded the binary directly from the UCSC server instead of using a package manager, ensure it is executable:
    ```bash
    chmod +x crTreeIndexBed
    ```
*   **Sorting Requirement**: Always ensure your BED file is properly sorted. Providing an unsorted BED file to `crTreeIndexBed` may result in an incomplete or corrupted index that fails during search operations.
*   **Large Datasets**: This tool is specifically designed for local, high-performance access. If you intend to share the data for use in the UCSC Genome Browser web interface, consider using `bedToBigBed` instead, as BigBed is the standard format for remote track hubs.
*   **Database Connectivity**: While some UCSC tools require an `.hg.conf` file to connect to public MySQL servers, `crTreeIndexBed` is a standalone file-processing utility and does not require database configuration.

## Reference documentation
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-crtreeindexbed Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-crtreeindexbed_overview.md)
- [UCSC Linux x86_64 Tool List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)