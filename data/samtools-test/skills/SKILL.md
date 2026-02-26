---
name: samtools-test
description: Samtools provides a comprehensive suite of utilities for manipulating, filtering, and summarizing high-throughput sequencing alignment files. Use when user asks to convert between SAM, BAM, and CRAM formats, sort and index alignments, calculate depth of coverage, or generate alignment statistics.
homepage: https://github.com/samtools/samtools
---


# samtools-test

## Overview
Samtools is the foundational C-library and toolset for handling Next-Generation Sequencing (NGS) alignments. This skill enables efficient management of large-scale genomic data by providing optimized patterns for viewing, filtering, and summarizing alignment files. It covers essential tasks such as converting between compressed and uncompressed formats, generating depth-of-coverage reports, and performing quality control through detailed alignment statistics.

## Core CLI Patterns and Best Practices

### File Conversion and Filtering
*   **Format Conversion**: Use `samtools view` to convert between formats.
    *   BAM to SAM: `samtools view -h input.bam > output.sam`
    *   SAM to BAM: `samtools view -bS input.sam > output.bam`
    *   CRAM Versioning: As of version 1.22, CRAM 3.1 is the default. To force compatibility with older tools, specify the version: `samtools view -O cram,version=3.0 input.bam -o output.cram`.
*   **Filtering by Region**: Use a BED file to extract specific genomic coordinates: `samtools view -L regions.bed input.bam`.
*   **Filtering by Read Group**: Use `-r` (read group ID) or `-R` (file of IDs). In version 1.23+, use `--exclude-no-read-group` to ignore reads lacking an RG tag when filtering.

### Sorting and Indexing
*   **Memory Management**: Always specify memory per thread with `sort -m` to avoid crashing on high-depth samples. Example: `samtools sort -@ 4 -m 2G input.bam -o sorted.bam`.
*   **Multi-threaded Indexing**: Speed up index creation using the `-@` flag: `samtools index -@ 4 sorted.bam`.
*   **Tag-based Splitting**: When using `samtools split` on data sorted by tag, the tool processes outputs sequentially to minimize the number of simultaneously open file handles.

### Statistics and Quality Control
*   **Comprehensive Stats**: Run `samtools stats` to generate a full report. In version 1.23, the RFS (Reference Stats) section provides total sequence counts, GC content, and region lengths.
*   **Coverage Analysis**: Use `samtools coverage` for a summary table of depth and breadth. Use `--min-depth` to filter out low-coverage bases from the calculation.
*   **Data Integrity**: Use `samtools checksum` to verify that sequence data, names, and qualities remain unchanged after processing (e.g., after sorting or marking duplicates). This command is order and orientation agnostic.

### Advanced Manipulations
*   **Consensus Calling**: Use `samtools consensus` for generating consensus sequences. It supports multi-threading and can report reference bases in low-coverage areas using the `-T ref.fa` option.
*   **Duplicate Marking**: Use `samtools markdup` for identifying PCR or optical duplicates. Note that this requires the input to be name-colated or coordinate-sorted with specific tags added by `samtools fixmate`.
*   **Fastq/Fasta Export**: When exporting with `samtools fastq`, you can trim soft clips using the `--trim-soft-clips` option and generate an index on-the-fly with `--write-index`.

## Expert Tips
*   **Ref Cache**: For CRAM files, use the `seq_cache_populate.py` script (included in `misc/`) to create a local `REF_CACHE`. This prevents the tool from attempting to download reference sequences from EBI servers repeatedly.
*   **Piping**: To save disk I/O, pipe commands together using `-` as the filename. Example: `samtools view -u input.bam | samtools sort - -o sorted.bam`. The `-u` flag in `view` outputs uncompressed BAM, which is faster for piping.
*   **Global Options**: Most samtools commands support global HTSlib options like `--reference` for CRAM decoding and `--threads` for parallel compression/decompression.

## Reference documentation
- [Samtools Tags and Release Notes](./references/github_com_samtools_samtools_tags.md)
- [Samtools GitHub Overview](./references/github_com_samtools_samtools.md)
- [Bioconda Samtools Installation](./references/anaconda_org_channels_bioconda_packages_samtools_overview.md)