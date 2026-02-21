---
name: extract-sv-reads
description: `extract-sv-reads` is a high-performance tool designed to isolate reads that provide evidence for structural variations.
homepage: https://github.com/hall-lab/extract_sv_reads
---

# extract-sv-reads

## Overview
`extract-sv-reads` is a high-performance tool designed to isolate reads that provide evidence for structural variations. It implements logic identical to SAMBLASTER but is optimized to work on coordinate-sorted files. This tool is essential in SV discovery pipelines where efficiency is a priority, as it generates the necessary splitter and discordant BAM files directly from standard alignment formats.

## Usage Guidelines

### Basic Command Structure
The tool typically requires an input file and produces two output BAM files: one for discordant reads and one for split reads.

```bash
extract-sv-reads -i input.bam -s splitters.bam -d discordants.bam
```

### Handling CRAM Files
When working with CRAM files, it is highly recommended to use the `-T` option. This prevents `htslib` from attempting to download the reference sequence to the local `REF_CACHE` (usually the home directory), which can cause performance bottlenecks or disk space issues.

```bash
extract-sv-reads -T /path/to/reference.fa -i input.cram -s splitters.bam -d discordants.bam
```

### Performance Optimization
For versions 1.2.0 and later, threading significantly improves processing speed for both BAM and CRAM formats. Use multiple threads to reduce wall-clock time in high-throughput environments.

### Duplicate Management
By default, the tool includes reads marked as duplicates. If your downstream SV calling logic requires the exclusion of duplicates, use the `-e` flag.

```bash
extract-sv-reads -e -i input.bam -s splitters.bam -d discordants.bam
```

## Expert Tips and Best Practices

*   **Read Name Alterations**: Unlike SAMBLASTER, which appends `_1` and `_2` to read names, `extract-sv-reads` modifies the first character of the read name to 'A' for Read 1 and 'B' for Read 2. Ensure your downstream tools are compatible with this naming convention.
*   **Memory and Disk**: Since the tool avoids name-sorting, it is generally more memory-efficient than SAMBLASTER for this specific task. However, ensure you have sufficient disk space for the two resulting BAM files.
*   **Maintenance Note**: This tool is archived. While it remains functional for existing pipelines, the developers recommend transitioning to `lumpy_filter` (part of the `lumpy-sv` suite) or using `smoove` for modern SV discovery workflows.
*   **CRAM Compatibility**: If you encounter issues with specific CRAM versions, ensure you are using a version of the tool linked against `htslib` 1.9 or later, which includes better support for `libdeflate`.

## Reference documentation
- [extract-sv-reads Overview](./references/anaconda_org_channels_bioconda_packages_extract-sv-reads_overview.md)
- [hall-lab/extract_sv_reads Repository](./references/github_com_hall-lab_extract_sv_reads.md)