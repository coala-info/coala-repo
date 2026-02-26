---
name: ucsc-bigwigtobedgraph
description: This tool converts binary bigWig files into the ASCII-based bedGraph format. Use when user asks to convert bigWig to bedGraph, extract raw signal values, or extract signal for a specific genomic region.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-bigwigtobedgraph

## Overview
The `ucsc-bigwigtobedgraph` skill provides a specialized workflow for decompressing and converting binary bigWig files into the ASCII-based bedGraph format. While bigWig files are optimized for rapid access and visualization in genome browsers, bedGraph files are preferred for custom bioinformatics pipelines, text-based filtering, and signal calculations. This tool is part of the UCSC Genome Browser "Kent" utilities and is the standard method for extracting raw signal values from indexed binary tracks.

## Command Line Usage

### Basic Syntax
The tool follows a simple input-output pattern:
```bash
bigWigToBedGraph input.bw output.bedGraph
```

### Common CLI Patterns
*   **Regional Extraction**: To avoid creating massive text files, you can extract signal for a specific genomic region:
    ```bash
    bigWigToBedGraph -chrom=chr1 -start=100000 -end=200000 input.bw output.bedGraph
    ```
*   **Remote Access**: If the input is a URL, you can specify a local cache directory to speed up repeated access:
    ```bash
    bigWigToBedGraph -udcDir=/tmp/udc http://example.com/data.bw output.bedGraph
    ```

### Expert Tips and Best Practices
*   **Storage Management**: BedGraph files are significantly larger than their bigWig counterparts because they are uncompressed text. Always check available disk space before converting whole-genome bigWig files.
*   **Permissions**: If using the standalone binaries downloaded from UCSC, ensure the file is executable:
    ```bash
    chmod +x bigWigToBedGraph
    ```
*   **Pipe to Compression**: To save space while keeping the data readable, pipe the output directly to `gzip`:
    ```bash
    bigWigToBedGraph input.bw /dev/stdout | gzip > output.bedGraph.gz
    ```
*   **Data Integrity**: The tool converts the binary signal exactly as stored. If the bigWig contains "zoom levels," `bigWigToBedGraph` will still extract the highest resolution data (base-pair level) by default.

## Reference documentation
- [ucsc-bigwigtobedgraph overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bigwigtobedgraph_overview.md)
- [UCSC Admin Executables](./references/hgdownload_cse_ucsc_edu_admin_exe.md)