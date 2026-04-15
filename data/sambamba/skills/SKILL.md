---
name: sambamba
description: Sambamba is a high-performance tool for parallelized processing, filtering, and manipulation of BAM and SAM files. Use when user asks to view, sort, mark duplicates, index, or calculate coverage depth for genomic sequencing data.
homepage: https://github.com/biod/sambamba
metadata:
  docker_image: "quay.io/biocontainers/sambamba:1.0.1--he614052_4"
---

# sambamba

## Overview

Sambamba is a high-performance alternative to samtools, written in the D programming language. It is specifically designed to exploit multi-core architectures for parallelized BAM reading, writing, and processing. This skill provides guidance on using its core subcommands to accelerate NGS (Next-Generation Sequencing) workflows, particularly for large-scale datasets where processing speed and efficient memory management are critical.

## Core Subcommands and Usage

### 1. Viewing and Filtering (view)
The `view` command is used for format conversion and complex filtering.
- **Convert BAM to SAM**: `sambamba view -h input.bam > output.sam`
- **Multithreaded Filtering**: Use `-t` to specify threads and `-F` for filter expressions.
  - Example: `sambamba view -t 8 -f bam -F "mapping_quality >= 30 and not duplicate" input.bam -o filtered.bam`
- **JSON Output**: Useful for downstream scripting.
  - Example: `sambamba view -S input.sam --format=json`

### 2. Sorting (sort)
Sambamba sort is highly efficient on machines with large RAM.
- **Standard Sort**: `sambamba sort -t 8 -m 4G input.bam`
- **Custom Temporary Directory**: Use `-l` or `--tmpdir` to avoid filling up `/tmp`.
- **Automatic Indexing**: Sambamba can automatically create an index (`.bai`) while sorting.

### 3. Marking Duplicates (markdup)
A fast implementation of the Picard duplicate marking algorithm.
- **Basic Usage**: `sambamba markdup -t 8 input.sorted.bam output.marked.bam`
- **Remove Duplicates**: Add the `-r` flag to remove instead of just marking.

### 4. Coverage Depth (depth)
Calculates base, sliding window, or region coverages.
- **Base-level depth**: `sambamba depth base input.bam`
- **Region-specific**: `sambamba depth region -L regions.bed input.bam`

### 5. Indexing and Slicing
- **Index**: `sambamba index -t 8 input.sorted.bam`
- **Slice**: Quickly extract a specific genomic region without re-reading the whole file.
  - Example: `sambamba slice input.bam chr1:100-200 > region.bam`

## Expert Tips and Best Practices

- **Thread Allocation**: For most commands, `-t` (threads) significantly impacts performance. Match this to your available CPU cores.
- **Filter Expressions**: Sambamba's `-F` filter syntax is more powerful than samtools. You can use field names like `read_name`, `sequence`, `cigar`, `mapping_quality`, and flag names like `unmapped`, `duplicate`, or `mate_is_unmapped`.
- **Piping**: Most tools support piping using `/dev/stdin` and `/dev/stdout`.
- **Memory Management**: When using `sort`, the `-m` flag sets the maximum memory per thread. Ensure `threads * memory_per_thread` does not exceed system limits.
- **Index Utilization**: When using `-L <bed_file>` with `view`, sambamba utilizes the BAM index to skip unrelated chunks, making it significantly faster for targeted analysis.



## Subcommands

| Command | Description |
|---------|-------------|
| sambamba-depth | Calculate depth of coverage for BAM files. |
| sambamba-flagstat | Outputs SAM/BAM/CRAM alignment statistics. |
| sambamba-index | Creates index for a BAM, or FASTA file |
| sambamba-markdup | Marks the duplicates without removing them |
| sambamba-merge | Merge multiple BAM files into a single BAM file. |
| sambamba-pileup | This subcommand relies on external tools and acts as a multi-core implementation of samtools and bcftools. |
| sambamba-slice | Fast copy of a region from indexed BAM or FASTA file to a new file |
| sambamba-sort | Sort BAM files. |
| sambamba-view | View and convert SAM/BAM/CRAM files |
| sambamba_subsample | Subsample BAM files |

## Reference documentation

- [Comparison with samtools](./references/github_com_biod_sambamba_wiki_Comparison-with-samtools.md)
- [[sambamba view] Filter expression syntax](./references/github_com_biod_sambamba_wiki__5Bsambamba-view_5D-Filter-expression-syntax.md)
- [Command line tools overview](./references/github_com_biod_sambamba_wiki_Command-line-tools.md)