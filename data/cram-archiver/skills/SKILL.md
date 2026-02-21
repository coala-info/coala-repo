---
name: cram-archiver
description: The `cram-archiver` tool is a specialized wrapper for `samtools` designed to simplify large-scale genomic data archival.
homepage: https://github.com/lumc/cram-archiver
---

# cram-archiver

## Overview

The `cram-archiver` tool is a specialized wrapper for `samtools` designed to simplify large-scale genomic data archival. It automates the recursive discovery of BAM files and converts them to CRAM format, which significantly reduces disk footprint. Unlike manual conversion, it automatically validates that the BAM header contigs match the provided reference genomes and performs functional integrity checks using `samtools checksum --all` to ensure the CRAM file is a reliable replacement for the original BAM.

## Core Workflows

### Single File Conversion
To convert a specific BAM file, you must provide at least one reference genome.
```bash
cram-archiver -r reference.fasta input.bam
```
This generates:
- `input.cram` (The compressed data)
- `input.cram.crai` (The index)
- `input.bam.checksum` and `input.cram.checksum` (For verification)

### Batch Archiving with Age Filtering
For production environments, use the `--minimum-age-days` flag to only target files that have finished their active processing phase.
```bash
cram-archiver -r hg38.fasta --minimum-age-days 30 --delete /path/to/data/
```
*Note: The `--delete` flag only removes the source BAM if the checksum verification passes successfully.*

### Handling Multiple References
If a directory contains BAMs aligned to different references (e.g., hg19 and hg38), provide both. The tool will automatically match each BAM to the correct reference based on header information.
```bash
cram-archiver -r hg19.fasta -r hg38.fasta /path/to/mixed_data/
```

## Best Practices and Tips

- **Safety First**: Always use `--dry-run` before executing a command on a large directory to see which files will be targeted for conversion.
- **Performance**: Use the `-t` flag to specify threads. Conversion and checksumming are CPU-intensive; matching the thread count to your available cores will significantly speed up batch processing.
- **Exclusions**: Use `--exclude` or `--exclude-list` to skip specific subdirectories or known problematic files within a large data tree.
- **CRAM Versions**: By default, the tool uses CRAM 3.0 for maximum compatibility. While 3.1 offers better compression, 3.0 is generally preferred for long-term archival stability across various bioinformatics tools.
- **Integrity**: Do not use `--dont-write-checksums` unless disk space for small text files is an extreme concern. These files are vital for manual audits of the archival process later.

## Reference documentation
- [LUMC cram-archiver GitHub](./references/github_com_LUMC_cram-archiver.md)