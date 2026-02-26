---
name: ucsc-rmfadups
description: ucsc-rmfadups deduplicates FASTA files by identifying and removing redundant records to produce a cleaned version with unique entries. Use when user asks to deduplicate FASTA files, remove duplicate sequences from a FASTA file, or get unique entries from a FASTA file.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-rmfadups

## Overview

The `rmFaDups` utility is a specialized tool from the UCSC Genome Browser "Kent" suite designed to deduplicate FASTA files. It identifies redundant records within a file and produces a cleaned version containing only unique entries. This is a critical preprocessing step in genomics to prevent inflated counts or redundant computations during mapping, assembly, or motif searching.

## Usage Instructions

### Basic Command Line Pattern

The standard usage for `rmFaDups` follows the typical UCSC binary pattern:

```bash
rmFaDups <input.fa> <output.fa>
```

### Execution Requirements

1.  **Permissions**: If you have downloaded the binary directly from the UCSC server, you must ensure it has execution permissions:
    ```bash
    chmod +x rmFaDups
    ```
2.  **Help Menu**: To view specific version information or additional flags (if available in your specific build), run the tool with no arguments:
    ```bash
    rmFaDups
    ```

## Expert Tips and Best Practices

*   **Input Validation**: Ensure your input file is in standard FASTA format. While UCSC tools are robust, malformed headers or unexpected characters can lead to incomplete deduplication.
*   **Pipeline Integration**: Use `rmFaDups` immediately after sequence extraction or pooling from multiple sources to minimize the data volume handled by more computationally expensive tools like `blat` or `lastz`.
*   **Memory Management**: UCSC tools are generally optimized for performance. However, when working with exceptionally large datasets (e.g., whole-genome shotgun reads), monitor system memory as the tool must track seen sequences or IDs to identify duplicates.
*   **Standard Streams**: If you need to integrate this into a shell pipe, check if your version supports `stdin` or `stdout` (often denoted by using `-` as a filename), though explicit file paths are preferred for reliability with this specific tool.

## Reference documentation

- [ucsc-rmfadups Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-rmfadups_overview.md)
- [UCSC Admin Executables Guide](./references/hgdownload_cse_ucsc_edu_admin_exe.md)