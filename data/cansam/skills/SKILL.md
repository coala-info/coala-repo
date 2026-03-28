---
name: cansam
description: cansam is a C++ library and utility suite designed for high-performance manipulation, sorting, and conversion of SAM and BAM alignment files. Use when user asks to convert between SAM and BAM formats, extract header information, sort alignment records, group records by name, or split files into smaller chunks.
homepage: https://github.com/jmarshall/cansam
---

# cansam

## Overview
cansam is a specialized C++ library and suite of utilities designed for high-performance manipulation of nucleotide sequence alignments. It provides a native C++ interface for SAM/BAM records and includes robust tools for common bioinformatics tasks like format conversion and data organization. It is particularly useful for developers building C++ bioinformatics pipelines or users needing lightweight alternatives for basic SAM/BAM manipulation.

## Command-Line Utilities
The cansam package provides several high-performance tools for file manipulation:

- **samcat**: Converts between SAM and BAM formats.
  - Usage: `samcat input.sam > output.bam`
- **samhead**: Extracts and displays the header information from a SAM or BAM file.
  - Usage: `samhead input.bam`
- **samsort**: Sorts alignment records.
  - Usage: `samsort unsorted.bam > sorted.bam`
- **samgroupbyname**: Sorts or merges files based on read names rather than genomic coordinates.
- **samsplit**: Partitions a large alignment file into smaller chunks for parallel processing.

## C++ Library Development
When writing custom C++ applications with cansam, utilize the following core components:

- **Namespace**: All library functionality is encapsulated within the `sam` namespace.
- **Core Classes**:
  - `sam::alignment`: Represents a single alignment record.
  - `sam::header`: Manages the SAM/BAM header metadata.
- **I/O Handling**: The library integrates with standard C++ streams. Use `sam::samstream` for reading and writing records.
- **CIGAR Operations**: Use `alignment::cigar_span()` for efficient calculation of alignment lengths.

## Best Practices and Expert Tips
- **Stream Redirection**: cansam utilities are designed to work with standard streams. Use pipes (`|`) to chain `samcat` or `samsort` with other tools to avoid unnecessary disk I/O.
- **Header Management**: When merging files, remember that headers must appear at the beginning of a SAM file. If you concatenate files, ensure only the first header is preserved to maintain file validity.
- **Memory Efficiency**: The library is optimized for the large volumes of short-to-middling length reads typical of next-generation sequencing. Prefer using the provided iterators over manual record management.
- **Platform Support**: The library includes specific support for ARM platforms and standard C++ levels (C++11 and newer).



## Subcommands

| Command | Description |
|---------|-------------|
| cansam_samgroupbyname | Group SAM/BAM records by read name. |
| samcat | Concatenate SAM/BAM files |
| samhead | (No description) |
| samsort | Sort SAM/BAM/CRAM files |
| samsplit | Split a SAM/BAM file into multiple files based on read group information. |

## Reference documentation
- [Cansam GitHub Repository](./references/github_com_jmarshall_cansam.md)