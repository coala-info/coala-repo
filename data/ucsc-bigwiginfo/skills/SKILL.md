---
name: ucsc-bigwiginfo
description: The ucsc-bigwiginfo tool inspects bigWig files to extract header and summary information. Use when user asks to view bigWig file metadata, get detailed statistics for individual chromosomes, inspect remote bigWig files, validate bigWig file contents, or check bigWig file zoom levels.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-bigwiginfo:482--h0b57e2e_0"
---

# ucsc-bigwiginfo

## Overview
The `bigWigInfo` utility is a specialized tool from the UCSC Genome Browser "kent" source tree designed to provide a snapshot of the contents of a bigWig file. BigWig files are indexed binary formats for dense, continuous data (like sequencing coverage or conservation scores). This tool allows you to inspect the file header and summary information quickly, which is a critical first step in bioinformatics pipelines to ensure that the data matches the expected reference genome and contains valid signal values.

## Usage Patterns

### Basic Metadata Extraction
To view the general information about a bigWig file, run the command with the file path as the only argument:
```bash
bigWigInfo input.bw
```
This outputs key attributes including:
*   **version**: The bigWig format version.
*   **isCompressed**: Whether the data blocks are compressed.
*   **isSwapped**: Byte order status.
*   **primaryDataSize**: Size of the main data section.
*   **zoomLevels**: The number of lower-resolution summary levels available.
*   **chromCount**: Number of chromosomes/sequences defined in the file.
*   **summary data**: Global min, max, mean, and standard deviation.

### Detailed Statistics
To get a more comprehensive statistical breakdown, use the `-chroms` flag to see information about individual sequences:
```bash
bigWigInfo -chroms input.bw
```

### Expert Tips
*   **Remote Access**: `bigWigInfo` supports URLs. You can inspect files hosted on the UCSC server or other web servers without downloading them:
    ```bash
    bigWigInfo http://hgdownload.soe.ucsc.edu/gbdb/hg38/bbi/gc5Base.bw
    ```
*   **Validation**: If a pipeline is failing, use `bigWigInfo` to check if the `chromCount` and chromosome names match your reference genome (e.g., checking for "chr" prefix consistency).
*   **Zoom Level Optimization**: Use the output to see if the file contains enough zoom levels for smooth visualization in genome browsers. If `zoomLevels` is 0, the file may perform poorly when zoomed out.
*   **Permission Errors**: If running a freshly downloaded binary, ensure it has execution permissions: `chmod +x bigWigInfo`.

## Reference documentation
- [ucsc-bigwiginfo Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bigwiginfo_overview.md)
- [UCSC Binary Downloads and Usage](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Tool Documentation](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)