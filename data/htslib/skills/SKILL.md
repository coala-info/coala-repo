---
name: htslib
description: HTSlib is the foundational C library used by Samtools and Bcftools for processing high-throughput sequencing data.
homepage: https://github.com/samtools/htslib
---

# htslib

## Overview
HTSlib is the foundational C library used by Samtools and Bcftools for processing high-throughput sequencing data. While it is primarily a developer library, it provides several critical command-line utilities that are essential for genomic data management. This skill focuses on the practical application of these utilities to compress, index, and identify genomic files efficiently.

## Core Utilities and CLI Patterns

### bgzip: Block Compression
Unlike standard gzip, `bgzip` compresses data in blocks, allowing for random access when used with an index.
- **Compress a file**: `bgzip file.vcf` (creates `file.vcf.gz`)
- **Decompress a file**: `bgzip -d file.vcf.gz`
- **Write to stdout**: `bgzip -c file.vcf > file.vcf.gz`
- **Recompress with specific threads**: `bgzip -@ 4 file.vcf`

### tabix: Generic Indexer
Tabix is used to index TAB-delimited genomic files (VCF, GFF, BED, etc.) that have been compressed with `bgzip`.
- **Index a VCF file**: `tabix -p vcf file.vcf.gz`
- **Index a BED file**: `tabix -p bed file.bed.gz`
- **Query a specific region**: `tabix file.vcf.gz chr1:10,000-20,000`
- **List sequence names**: `tabix -l file.vcf.gz`

### htsfile: File Identification
Use `htsfile` to identify the format and compression of a sequencing file.
- **Identify file type**: `htsfile sample.bam`
- **Check if a file is a specific format**: `htsfile -c bam sample.bam` (returns exit code 0 if true)

## Expert Tips and Best Practices

### Indexing Large Chromosomes
Standard `.tbi` indexes (Tabix) cannot handle coordinates larger than 512Mbp (2^29). For large genomes (e.g., some plants or specific human assemblies):
- Use the Coordinate-Sorted Index (CSI) format: `tabix --csi file.vcf.gz`
- Adjust the min_shift if necessary (default is 14): `tabix --csi --min-shift 14 file.vcf.gz`

### Stream Processing
HTSlib utilities are designed to work in pipes. Always use `bgzip -c` when piping output to ensure the stream remains compatible with downstream indexing tools.

### Threading Performance
For large-scale compression tasks, always utilize the `-@` or `--threads` flag. HTSlib scales well with multiple cores, significantly reducing the time required for `bgzip` operations.

### Handling Comments
When using `tabix`, you can skip comment lines using the `-c` flag. By default, many tools expect comments at the start of the file, but `tabix` can be configured to skip them wherever they occur.

## Reference documentation
- [HTSlib GitHub Repository](./references/github_com_samtools_htslib.md)
- [HTSlib Release Tags and NEWS](./references/github_com_samtools_htslib_tags.md)
- [Bioconda HTSlib Package](./references/anaconda_org_channels_bioconda_packages_htslib_overview.md)