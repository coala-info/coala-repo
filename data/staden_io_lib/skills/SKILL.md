---
name: staden_io_lib
description: Staden_io_lib is a library and toolset for reading, writing, and converting DNA sequence and alignment formats. Use when user asks to convert between SAM, BAM, and CRAM formats, manage CRAM versions, apply compression profiles, or handle DNA trace files.
homepage: https://github.com/jkbonfield/io_lib/
---


# staden_io_lib

## Overview

staden_io_lib (also known as libstaden-read) is a robust library and toolset designed for reading and writing a wide array of DNA sequence formats. While it provides a C API for programmatic access, its primary command-line interface is the `scramble` utility. This tool is essential for converting between alignment formats (SAM/BAM/CRAM) and handling legacy or specialized trace files. It is particularly powerful for users needing to balance compression ratios against CPU performance using specific CRAM profiles.

## Core CLI Patterns

### Format Conversion with Scramble
The `scramble` tool is the primary utility for converting between sequence formats.

```bash
# Convert BAM to CRAM (default version 3.0)
scramble input.bam output.cram

# Convert CRAM to BAM
scramble -O bam input.cram output.bam

# Convert to SAM
scramble -O sam input.bam output.sam
```

### Managing CRAM Versions
Select specific CRAM versions based on your compatibility and compression needs:

*   **-V3.0**: The default version; provides maximum compatibility with other bioinformatics tools.
*   **-V3.1**: The current GA4GH standard; enables advanced codecs like rANS++, tok3, and fqzcomp for better compression.
*   **-V4.0**: Experimental version; includes 64-bit sizes and read-name deduplication. Use for evaluation only.

```bash
# Create a CRAM 3.1 file
scramble -V3.1 input.bam output.cram
```

### Compression Profiles
Use the `-X` flag to set a profile that automatically adjusts codecs and random-access granularity:

*   **-X fast**: Prioritizes speed over file size.
*   **-X small**: Uses advanced codecs (like fqzcomp for quality scores) to significantly reduce size.
*   **-X archive**: Maximum compression, typically slower for both encoding and decoding.

```bash
# Optimize for storage (Archive profile)
scramble -X archive input.bam output.cram
```

## Supported Formats

The library supports a broad range of sequence and trace formats:
*   **Alignments**: SAM, BAM, CRAM
*   **Traces**: SCF, ABI, ALF, ZTR
*   **Archives**: SFF (Standard Flowgram Format), SRF (Sequence Read Format)
*   **Other**: Experiment files, Plain text

## Expert Tips and Best Practices

*   **NovaSeq Optimization**: When working with Illumina NovaSeq data, using the `-V3.1 -X small` profile can result in significantly faster encoding (up to 27% faster) and better compression ratios compared to standard CRAM 3.0.
*   **Random Access**: Note that compression profiles affect random access granularity. `fast` uses 1k blocks, while `archive` uses 100k blocks. Choose `fast` or `normal` if the downstream application requires frequent random seeking.
*   **Validation**: Use `scram_flagstat -b` to check the integrity and statistics of a generated BAM or CRAM file.
*   **Library Linking**: If developing software, the library is often referred to as `libstaden-read`. Use `io_lib-config --libs` to determine the necessary linker flags.



## Subcommands

| Command | Description |
|---------|-------------|
| scram_flagstat | Calculates flag statistics for BAM, SAM, or CRAM files. |
| scramble | Convert between SAM, BAM, and CRAM formats with compression and indexing options. |

## Reference documentation
- [Io_lib README](./references/github_com_jkbonfield_io_lib_blob_master_README.md)
- [Staden io_lib Overview](./references/github_com_jkbonfield_io_lib.md)
- [Changes and Version History](./references/github_com_jkbonfield_io_lib_blob_master_CHANGES.md)