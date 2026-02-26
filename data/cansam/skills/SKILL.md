---
name: cansam
description: Cansam is a C++ library and utility suite for manipulating SAM and BAM alignment files. Use when user asks to convert between SAM and BAM formats, view alignment headers, sort or merge records, partition files, or develop C++ applications for processing sequence alignments.
homepage: https://github.com/jmarshall/cansam
---


# cansam

## Overview

Cansam is a C++ binding and utility suite designed for efficient manipulation of SAM and BAM files, which are standard formats for storing nucleotide sequence alignments. It provides a modular C++ API for programmatic access to alignment records and headers, as well as a set of high-performance command-line tools for common file operations. Use this skill to implement C++ alignment processing logic or to perform file-level manipulations using the native cansam toolset.

## Command-Line Utilities

The cansam suite includes several specialized tools for handling alignment data:

- **samcat**: Converts between SAM and BAM formats. Use this for lightweight streaming or conversion tasks.
- **samhead**: Displays the header information of a SAM or BAM file. Essential for verifying @SQ (sequence) or @RG (read group) metadata.
- **samsort**: Sorts and merges alignment files. Typically used for coordinate-based ordering.
- **samgroupbyname**: Sorts and merges files specifically by read name, which is often required for paired-end processing.
- **samsplit**: Partitions alignment files into smaller chunks.

## C++ Library Usage

When writing C++ applications with cansam, follow these patterns:

### Core Classes and Namespace
- All library components are encapsulated in the `sam` namespace.
- **sam::alignment**: Represents a single alignment record.
- **sam::header**: Represents the file header metadata.

### I/O Operations
- Use `samstream` for reading and writing records.
- When merging files programmatically, ensure you handle headers from multiple sources correctly. Simply copying headers from subsequent files into a single stream will result in an invalid SAM file.

### Alignment Manipulation
- **CIGAR Access**: Use `alignment::cigar_span()` to determine the length of the alignment on the reference sequence.
- **Flags**: The library supports standard SAM flags, including the `SUPPLEMENTARY` alignment bit.

## Expert Tips

- **Memory Management**: When processing large BAM files, reuse `sam::alignment` objects where possible to minimize allocation overhead during high-throughput loops.
- **Exception Handling**: Be aware that cansam may throw `std::ios_base::failure` during I/O operations. Ensure your C++ implementation accounts for potential write failures or malformed input files.
- **Stream State**: `samstream` objects are designed to be closeable and reopenable, allowing for flexible file handling in long-running processes.

## Reference documentation
- [C++ binding for SAM/BAM files](./references/github_com_jmarshall_cansam.md)
- [Cansam Commit History](./references/github_com_jmarshall_cansam_commits_master.md)