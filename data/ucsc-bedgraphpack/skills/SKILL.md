---
name: ucsc-bedgraphpack
description: The `ucsc-bedgraphpack` tool is a utility from the UCSC Genome Browser "kent" source tree designed to compress bedGraph data.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-bedgraphpack

## Overview
The `ucsc-bedgraphpack` tool is a utility from the UCSC Genome Browser "kent" source tree designed to compress bedGraph data. In many genomic datasets, consecutive genomic windows often carry identical scores. Instead of representing these as separate lines, this tool "packs" them into a single record spanning the entire contiguous range. This reduces redundancy without losing any information, making the files more efficient for storage and faster for tools like `bedGraphToBigWig` to process.

## Command Line Usage
The tool follows the standard UCSC utility pattern of taking an input file and an output file as positional arguments.

### Basic Syntax
```bash
bedGraphPack input.bedGraph output.bedGraph
```

### Expert Tips and Best Practices
*   **Pre-sorting Requirement**: Like most UCSC bed-based utilities, the input bedGraph file must be sorted by chromosome and then by start position. Use `bedSort` if the file is not already ordered.
*   **Data Integrity**: This tool only merges records where the values (column 4) are exactly identical. It does not perform averaging or smoothing; it is a lossless compression step for adjacent identical values.
*   **Workflow Integration**: Use this tool as a cleanup step after generating bedGraph files from raw signal data (e.g., from BAM or wiggle files) but before converting them to the binary bigWig format.
*   **Handling Overlaps**: Ensure your input bedGraph does not have overlapping regions. If overlaps exist, the packing logic may produce unexpected results or errors. Use `bedItemOverlapCount` or similar tools to check for overlaps if the source of the data is unknown.
*   **Permission Errors**: If running the binary directly from a download, ensure it has execution permissions:
    ```bash
    chmod +x bedGraphPack
    ./bedGraphPack input.bedGraph output.bedGraph
    ```

## Reference documentation
- [UCSC Genome Browser Admin Executables](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-bedgraphpack Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bedgraphpack_overview.md)