---
name: samtools
description: Create a sequence dictionary file from a fasta file
homepage: https://github.com/samtools/samtools
---

# samtools

## Overview
Samtools is a fundamental suite of programs for manipulating next-generation sequencing (NGS) data. It operates on the Sequence Alignment/Map (SAM) format and its binary (BAM) and compressed (CRAM) representations. Use this skill to perform essential bioinformatics tasks such as filtering reads by mapping quality or flags, converting between formats, calculating genome coverage, and generating consensus sequences.

## Core CLI Patterns

### File Conversion and Viewing
The `view` command is the most versatile tool for format conversion and data filtering.
*   **Convert SAM to BAM:** `samtools view -bS input.sam > output.bam`
*   **Convert BAM to CRAM:** `samtools view -C -T reference.fa input.bam > output.cram`
*   **Filter by Mapping Quality:** `samtools view -b -q 30 input.bam > filtered.bam` (keeps reads with MAPQ ≥ 30)
*   **Filter by Flags:** `samtools view -b -f 2 input.bam` (keeps only properly paired reads)
*   **Fast Access:** Use `-@ [threads]` to speed up compression/decompression.

### Sorting and Indexing
Most downstream tools require BAM files to be coordinate-sorted and indexed.
*   **Sort:** `samtools sort -@ 4 -o sorted.bam input.bam`
*   **Index:** `samtools index sorted.bam` (creates a `.bai` file)
*   **Mark Duplicates:** Use `samtools markdup` on name-sorted, mate-fixed files to identify PCR or optical duplicates.

### Quality Control and Statistics
*   **General Stats:** `samtools stats input.bam > output.stats` (provides comprehensive metrics for `plot-bamstats`)
*   **Flag Statistics:** `samtools flagstat input.bam` (quick summary of alignment percentages)
*   **Coverage:** `samtools coverage input.bam` (calculates depth and percent coverage per contig)
*   **Bedcov:** `samtools bedcov regions.bed input.bam` (calculates total read base count per region in a BED file)

### Data Extraction and Manipulation
*   **BAM to FastQ:** `samtools fastq -1 read1.fq -2 read2.fq input.bam`
*   **Fast Access to Regions:** `samtools view input.bam chr1:1000-2000` (requires index)
*   **Header Editing:** `samtools reheader new_header.sam input.bam` (faster than re-sorting if only metadata changes)
*   **Splitting:** `samtools split -d tag_name input.bam` (splits a file into multiple files based on a specific tag, such as Read Group)

## Expert Tips
*   **CRAM Versioning:** As of version 1.22, CRAM 3.1 is the default output. If compatibility with older tools is required, specify the version: `samtools view -O cram,version=3.0`.
*   **Memory Management:** When running `samtools sort`, use the `-m` flag to specify memory per thread (e.g., `-m 2G`). Ensure the total memory (`threads * memory-per-thread`) does not exceed system limits.
*   **Piping:** Samtools is designed for Unix pipes. Use `-` as a filename to represent stdin/stdout to avoid unnecessary disk I/O.
*   **Data Integrity:** Use `samtools checksum` to generate orientation-agnostic hashes of sequence and quality data to verify that no information was lost during processing.
*   **Consensus Generation:** `samtools consensus -f FASTA input.bam -o consensus.fa` can be used to generate a consensus sequence directly from alignments, with support for multi-threading in newer versions.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_samtools_samtools.md)
- [Samtools Tags and Release Notes](./references/github_com_samtools_samtools_tags.md)
- [Bioconda Package Summary](./references/anaconda_org_channels_bioconda_packages_samtools_overview.md)