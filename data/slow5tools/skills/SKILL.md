---
name: slow5tools
description: slow5tools is a high-performance utility designed to manage the SLOW5 format, a streamlined alternative to the standard FAST5 format for ONT signal data.
homepage: https://github.com/hasindu2008/slow5tools
---

# slow5tools

## Overview

slow5tools is a high-performance utility designed to manage the SLOW5 format, a streamlined alternative to the standard FAST5 format for ONT signal data. It addresses the limitations of HDF5-based FAST5 files by providing a format that supports efficient parallel access and smaller storage footprints. Use this skill to guide users through converting legacy datasets, indexing signal data for rapid retrieval, and optimizing storage using binary BLOW5 compression.

## Installation and Setup

The most reliable way to install slow5tools is via Bioconda:

```bash
conda install slow5tools -c bioconda -c conda-forge
```

For users on systems without package managers, pre-compiled binaries are available for x86_64 Linux. Ensure the system has `zlib` installed and the CPU supports SSSE3 instructions.

## Core CLI Commands

### Format Conversion
The primary use case is converting FAST5 files to SLOW5 (ASCII) or BLOW5 (Binary).

*   **FAST5 to SLOW5/BLOW5**:
    ```bash
    slow5tools f2s [input_dir_or_file] -o output.blow5
    ```
*   **SLOW5/BLOW5 to FAST5**:
    ```bash
    slow5tools s2f [input.blow5] -o output_dir
    ```

### Data Manipulation
*   **Indexing**: Required for random access to signal data.
    ```bash
    slow5tools index [file.blow5]
    ```
*   **Merging**: Combine multiple SLOW5/BLOW5 files into one.
    ```bash
    slow5tools merge [file1.blow5] [file2.blow5] -o merged.blow5
    ```
*   **Splitting**: Divide a large file into smaller chunks by read count or file count.
    ```bash
    slow5tools split [input.blow5] -d output_dir
    ```

### Viewing and Inspection
*   **View**: Convert BLOW5 to human-readable SLOW5 or filter specific reads.
    ```bash
    slow5tools view [input.blow5]
    ```
*   **Stats**: Get summary statistics of the file.
    ```bash
    slow5tools stats [input.blow5]
    ```

## Expert Tips and Best Practices

*   **Prefer BLOW5 over SLOW5**: Always use the binary BLOW5 format for production workflows. It is significantly faster to process and smaller in size than the ASCII SLOW5 format.
*   **Compression Selection**: 
    *   Use the default `zlib` for maximum portability across different systems.
    *   If performance and storage are critical, use `zstd` (requires building with `zstd=1`). It offers better compression ratios and faster decompression.
*   **Parallelization**: Most commands support the `-t` or `--threads` flag. Match this to your CPU core count to significantly speed up conversion and merging tasks.
*   **POD5 Compatibility**: For ONT's newer POD5 format, use the external tool `blue_crab` to convert between POD5 and SLOW5, as slow5tools focuses on FAST5/SLOW5.
*   **Handling VBZ**: If converting FAST5 files compressed with VBZ, ensure the ONT VBZ plugin is installed in your `HDF5_PLUGIN_PATH`.

## Reference documentation
- [slow5tools GitHub Repository](./references/github_com_hasindu2008_slow5tools.md)
- [slow5tools Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_slow5tools_overview.md)