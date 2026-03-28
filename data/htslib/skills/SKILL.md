---
name: htslib
description: HTSlib provides essential utilities for compressing, indexing, and identifying high-throughput sequencing data formats. Use when user asks to compress files with bgzip, index genomic files with tabix, query specific genomic intervals, or identify and check the integrity of bioinformatics file formats.
homepage: https://github.com/samtools/htslib
---

# htslib

## Overview
HTSlib is the foundational engine powering major bioinformatics tools like Samtools and Bcftools. While primarily a developer library, it provides essential standalone utilities for managing large-scale genomic datasets. This skill focuses on the practical application of its core binaries: `bgzip` for blocked-gzip compression (allowing random access), `tabix` for indexing TAB-delimited files, and `htsfile` for identifying and checking the integrity of sequencing files.

## Core Utilities and Best Practices

### bgzip: Blocked GNU Zip
Unlike standard gzip, `bgzip` compresses data in blocks, enabling tools to jump to specific locations without decompressing the entire file.

- **Compress a file**: `bgzip file.vcf` (creates `file.vcf.gz`)
- **Decompress to stdout**: `bgzip -dc file.vcf.gz`
- **Recompress/Refresh**: Use `bgzip -@ [threads]` to utilize multiple CPU cores for faster compression.
- **Offset extraction**: `bgzip -b [offset] -s [size] file.gz` allows for extracting specific chunks if the virtual offsets are known.

### tabix: Generic Indexer for TAB-delimited Files
Tabix is used to index position-sorted files (VCF, BED, GFF, SAM) for fast retrieval of genomic intervals.

- **Index a VCF**: `tabix -p vcf file.vcf.gz`
- **Index a BED**: `tabix -p bed file.bed.gz`
- **Query a region**: `tabix file.vcf.gz chr1:10,000-20,000`
- **CSI Indexing**: For very long chromosomes (e.g., exceeding 512Mbp), use the Coordinate Sorted Index format: `tabix --csi file.vcf.gz`.
- **Skip Headers**: Use `-c` to specify a comment character (default is `#`) to ensure headers are ignored during indexing but preserved in the file.

### htsfile: File Identification
Use `htsfile` to diagnose file format issues or verify if a file is truncated.

- **Identify format**: `htsfile data.bin` (returns e.g., "CRAM sequence data version 3.1")
- **Check integrity**: `htsfile -c data.bam` will check for a valid EOF (End Of File) marker, which is critical for verifying that a BAM file was not cut short during a transfer or crash.

## Expert Tips
- **Always BGZIP before Tabix**: Tabix requires the input file to be compressed with `bgzip`, not standard `gzip`. If you receive a "file is not bgzipped" error, decompress and re-compress using `bgzip`.
- **Sorting is Mandatory**: Files must be sorted by chromosome and then by start position before indexing. Tabix will fail or produce incorrect results on unsorted data.
- **Thread Management**: When working with large CRAM or BAM files, always leverage the `-@` flag in supported utilities to reduce wall-clock time significantly.
- **Remote Access**: HTSlib supports transparent access to S3, GCS, and HTTP/HTTPS. You can often pass a URL directly to these utilities if your environment is configured with the necessary credentials (e.g., `AWS_ACCESS_KEY_ID`).



## Subcommands

| Command | Description |
|---------|-------------|
| bgzip | Block compression/decompression utility |
| htsfile | Identify file formats and check hashes of genomic data files. |
| tabix | Generic indexer for TAB-delimited genome position files |

## Reference documentation
- [HTSlib GitHub Repository](./references/github_com_samtools_htslib.md)
- [HTSlib Release Tags and Version History](./references/github_com_samtools_htslib_tags.md)