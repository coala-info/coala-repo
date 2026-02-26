---
name: bedtools-test
description: Bedtools-test performs genomic interval arithmetic to manipulate and analyze genomic features. Use when user asks to intersect genomic intervals, merge overlapping regions, find the closest feature, or calculate coverage.
homepage: http://bedtools.readthedocs.org/
---


# bedtools-test

## Overview
The bedtools-test skill provides a specialized workflow for handling genomic intervals. It treats genomic features as sets and allows for complex operations like finding overlaps, merging adjacent regions, and calculating coverage. This toolset is the "Swiss-army knife" for bioinformatics pipelines, enabling users to transition from raw interval data to sophisticated biological insights through the UNIX command line.

## Core Usage Patterns

### Intersecting Intervals
The most common task is finding overlaps between two sets of genomic features (File A and File B).
- **Basic overlap**: `bedtools intersect -a peaks.bed -b genes.bed`
- **Reciprocal overlap**: Use `-f` and `-r` to require a specific percentage of overlap from both features.
  `bedtools intersect -a exp1.bed -b exp2.bed -f 0.50 -r` (Requires 50% mutual overlap).
- **Counting overlaps**: Use `-c` to report the number of hits in B for each feature in A.

### Proximity and Merging
- **Finding the closest feature**: `bedtools closest -a query.bed -b reference.bed`
- **Ignoring overlaps**: Use `-io` with `closest` to find the nearest non-overlapping neighbor.
- **Merging overlapping regions**: `bedtools merge -i input.bed` (Combines overlapping or book-ended features into a single record).

### Working with Large Datasets
- **Sorted Data**: For massive files, always use the `-sorted` option. This significantly reduces memory usage and increases speed.
- **Genome Files**: When using `-sorted` with non-lexicographically sorted files, you must provide a genome file (`-g`) or a `.fai` index to define chromosome order.

## Expert Tips and Constraints

### Input Requirements
- **Delimiters**: All input files (except BAM/CRAM) must be TAB-delimited.
- **Line Endings**: Files must use UNIX line endings.
- **Chromosome Naming**: Chromosome names must match exactly between files (e.g., "chr1" will not match "1").
- **Size Limits**: Without the `-sorted` flag, bedtools may struggle with chromosomes larger than 512Mb.

### Format Support
- **BAM/CRAM**: Bedtools natively supports BAM. For CRAM, you must set the `CRAM_REFERENCE` environment variable to point to your reference genome.
- **GFF/GTF**: These are treated similarly to BED files but preserve their specific attribute columns.

### Performance Optimization
- Use pipes (`|`) to chain bedtools commands together to avoid writing intermediate files to disk.
- When calculating coverage for targeted capture or RNA-seq, use `bedtools coverage` to get per-interval or per-base statistics.

## Reference documentation
- [bedtools: a powerful toolset for genome arithmetic](./references/bedtools_readthedocs_io_en_latest.md)
- [bedtools - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_bedtools_overview.md)