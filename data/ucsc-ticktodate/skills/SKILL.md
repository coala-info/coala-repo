---
name: ucsc-ticktodate
description: This tool converts Unix epoch timestamps into standard calendar dates and clock times. Use when user asks to convert Unix epoch timestamps to dates, transform ticks to dates, interpret time-based metadata, or audit file timestamps.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-ticktodate:482--h0b57e2e_0"
---

# ucsc-ticktodate

## Overview
The `ucsc-ticktodate` utility is a specialized command-line tool from the UCSC Genome Browser "kent" source tree. It performs a singular, deterministic task: transforming Unix epoch timestamps—often referred to as "ticks"—into standard calendar dates and clock times. This is particularly useful when auditing file timestamps in UCSC data repositories or interpreting time-based metadata in bioinformatics pipelines.

## Usage Instructions

### Basic Command Pattern
The tool is typically invoked by passing a single integer representing the number of seconds since the Unix epoch (January 1, 1970).

```bash
tickToDate <timestamp>
```

### Common CLI Patterns
*   **Single Conversion**: To convert a specific timestamp, provide it as a direct argument.
    ```bash
    tickToDate 1719694260
    ```
*   **Batch Processing**: While the tool is designed for single arguments, you can process a list of timestamps from a file using a loop or `xargs`.
    ```bash
    cat timestamps.txt | xargs -I {} tickToDate {}
    ```

### Expert Tips
*   **Permission Handling**: If you have downloaded the binary directly from the UCSC servers rather than installing via Conda, ensure the execution bit is set: `chmod +x tickToDate`.
*   **Standard Output**: The tool outputs the date string directly to `stdout`, making it easy to redirect into log files or pipe into other text-processing utilities like `awk` or `sed`.
*   **Verification**: If you are unsure if a value is a valid "tick," remember that Unix timestamps for current genomic data are typically 10-digit integers (e.g., starting with 16 or 17).

## Reference documentation
- [ucsc-ticktodate - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-ticktodate_overview.md)
- [Index of /admin/exe](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Index of /admin/exe/linux.x86_64.v369](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.v369.md)