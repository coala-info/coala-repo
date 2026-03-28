---
name: slow5tools
description: slow5tools is a high-performance toolkit for converting, compressing, and managing Oxford Nanopore Technologies raw signal data. Use when user asks to convert FAST5 to BLOW5, index signal data for random access, merge or split datasets, and perform signal compression.
homepage: https://github.com/hasindu2008/slow5tools
---


# slow5tools

## Overview
slow5tools is a high-performance toolkit designed to handle Oxford Nanopore Technologies (ONT) raw signal data. While the industry-standard FAST5 format (based on HDF5) suffers from performance bottlenecks and complex parallel access issues, SLOW5 provides a streamlined, scalable alternative. This skill enables the conversion between these formats, data compression (BLOW5), and efficient data management for downstream genomic analysis.

## Core CLI Patterns

### Format Conversion
The most common entry point is converting existing FAST5 directories to the more efficient BLOW5 (binary SLOW5) format.

*   **FAST5 to BLOW5 (Recommended)**:
    `slow5tools f2s path/to/fast5_dir -d path/to/blow5_dir`
    *Use `-p` to specify the number of parallel threads for faster conversion.*
*   **SLOW5 to FAST5**:
    `slow5tools s2f path/to/slow5_file -o path/to/output.fast5`

### Data Compression
BLOW5 supports different compression layers. Use `zlib` for maximum compatibility or `zstd` for better performance/compression ratios if the build supports it.

*   **Compressing to BLOW5 with zlib**:
    `slow5tools view input.slow5 -c zlib -o output.blow5`
*   **Lossy Compression (Signal Quantization)**:
    To significantly reduce size by rounding signal values (check downstream compatibility first):
    `slow5tools view input.blow5 --lossy ex-out -o lossy_output.blow5`

### Indexing and Retrieval
To perform random access on large BLOW5 files, you must first create an index.

*   **Create Index**:
    `slow5tools index file.blow5`
*   **Fetch Specific Reads**:
    `slow5tools get file.blow5 read_id_1 read_id_2 -o output.blow5`

### Dataset Manipulation
*   **Merging**: Combine multiple SLOW5/BLOW5 files into one.
    `slow5tools merge dir_with_files -o merged.blow5`
*   **Splitting**: Divide a large file into smaller chunks (by read count or file count).
    `slow5tools split input.blow5 -n 4000 -d output_dir`
*   **Quick Check**: Verify if a SLOW5/BLOW5 file is intact and valid.
    `slow5tools quickcheck file.blow5`

## Expert Tips
*   **Parallelism**: Always use the `-t` (threads) option during `f2s`, `s2f`, and `merge` operations on high-core systems to drastically reduce processing time.
*   **BLOW5 vs SLOW5**: Always prefer BLOW5 (binary) for storage and analysis. Use SLOW5 (ASCII) only for debugging or manual inspection of headers and signal records.
*   **I/O Performance**: When converting large datasets, ensure the output directory is on a filesystem with high IOPS (like NVMe or high-performance parallel filesystems) as slow5tools can easily saturate standard HDD write speeds.
*   **POD5 Compatibility**: For ONT's newer POD5 format, use the external `blue_crab` tool to bridge to SLOW5, as slow5tools focuses on the FAST5/SLOW5 ecosystem.



## Subcommands

| Command | Description |
|---------|-------------|
| cat | Quickly concatenate SLOW5/BLOW5 files of same type (same header, extension, compression) |
| degrade | Irreversibly degrade and convert slow5/blow5 FILEs. |
| f2s | Convert FAST5 files to SLOW5/BLOW5 format. |
| get | Display the read entry for each specified read id from a slow5 file. With no READ_ID, read from standard input newline separated read ids. |
| index | Create a slow5 or blow5 index file. |
| merge | Merge multiple SLOW5/BLOW5 files to a single file |
| quickcheck | Performs a quick check if a SLOW5/BLOW5 file is intact. That is, quickcheck checks if the file begins with a valid header (SLOW5 or BLOW5), attempt to decode the first SLOW5 record and then seeks to the end of the file and checks if proper EOF exists (BLOW5 only).If the file is intact, the commands exists with 0. Otherwise exists with a non-zero error code. |
| s2f | Convert SLOW5/BLOW5 files to FAST5 format. |
| skim | Skims through requested components in a SLOW5/BLOW5 file. If no options are provided, all the SLOW5 records except the raw signal will be printed. |
| slow5tools split | Split a single a SLOW5/BLOW5 file into multiple separate files. |
| slow5tools_view | View a slow5 as blow5 FILE and vice versa. |
| stats | Prints statistics of a SLOW5/BLOW5 file to the stdout. If no argument is given details about slow5tools is printed. |

## Reference documentation
- [slow5tools GitHub README](./references/github_com_hasindu2008_slow5tools_blob_master_README.md)
- [slow5tools Commands Reference](./references/hasindu2008_github_io_slow5tools_commands.html.md)
- [slow5tools Workflows and One-liners](./references/hasindu2008_github_io_slow5tools_oneliners.html.md)