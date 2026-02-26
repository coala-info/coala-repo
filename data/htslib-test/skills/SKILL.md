---
name: htslib-test
description: HTSlib-test provides standalone utilities for identifying, compressing, and indexing genomic data files. Use when user asks to identify file formats, compress files with bgzip, or index and query tab-delimited genomic files using tabix.
homepage: https://github.com/samtools/htslib
---


# htslib-test

## Overview
HTSlib is the foundational C library for processing genomic data formats. While it is primarily used as a programming library for tools like Samtools and Bcftools, it includes several essential standalone utilities for managing large-scale sequencing files. This skill provides guidance on using these native utilities to identify, compress, and index genomic data efficiently.

## Core Utilities and CLI Patterns

### htsfile: Format Identification
Use `htsfile` to identify the specific format and compression of a sequencing file. This is useful for debugging file extensions that may not match their contents.

```bash
# Identify a file's format
htsfile input_file.bam

# Identify multiple files
htsfile sample1.vcf.gz sample2.bcf
```

### bgzip: Block Compression
`bgzip` is a variant of gzip that allows for random access to compressed files. Most genomic indexers (like tabix) require files to be compressed with `bgzip`.

- **Compress a file**: `bgzip file.vcf` (creates `file.vcf.gz`)
- **Decompress a file**: `bgzip -d file.vcf.gz`
- **Recompress for optimal indexing**: `bgzip -c input.vcf > output.vcf.gz`
- **Multi-threaded compression**: Use `-@` to specify threads for faster processing.
  ```bash
  bgzip -@ 4 data.sam
  ```

### tabix: Indexing Tab-Delimited Files
`tabix` creates indexes for generic TAB-delimited files (like VCF, GFF, or BED) that have been compressed with `bgzip`.

- **Index a VCF file**: `tabix -p vcf file.vcf.gz`
- **Index a BED file**: `tabix -p bed file.bed.gz`
- **Query a specific region**:
  ```bash
  tabix file.vcf.gz chr1:10,000-20,000
  ```
- **List chromosomes/contigs in the index**: `tabix -l file.vcf.gz`

### CSI Indexing
For very long chromosomes (exceeding the 512Mbp limit of the older `.tbi` format), use the Coordinate Sorted Index (`.csi`) format.

```bash
# Create a CSI index with a specific min_shift (default is 14)
tabix --csi -p vcf file.vcf.gz
```

## Expert Tips
- **Always use bgzip**: Standard `gzip` files cannot be indexed by `tabix`. If you receive an error about a missing "magic string," the file was likely compressed with standard gzip.
- **Coordinate Systems**: Remember that `tabix` defaults to 1-based coordinates. If working with 0-based formats like BED, ensure you use the `-p bed` preset or manually specify the columns with `-s` (sequence), `-b` (begin), and `-e` (end).
- **Remote Access**: HTSlib utilities support remote URLs (HTTP/S3/GCS) if the library was built with libcurl/S3 support. You can run `htsfile https://example.com/data.bam` directly.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_samtools_htslib.md)
- [HTSlib Release 1.23 Details](./references/github_com_samtools_htslib_tags.md)