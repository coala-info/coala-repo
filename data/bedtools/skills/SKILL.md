---
name: bedtools
description: "bedtools performs set theory operations and genome arithmetic on genomic intervals to analyze overlaps, proximity, and coverage. Use when user asks to intersect genomic features, merge overlapping intervals, find the closest gene to a peak, or calculate genome-wide coverage."
homepage: http://bedtools.readthedocs.org/
---


# bedtools

## Overview
`bedtools` is a "Swiss-army knife" for genomics, providing a suite of utilities to perform set theory operations on the genome. It allows you to treat genomic features as mathematical intervals to find where they overlap, how far apart they are, or how they are distributed. By combining simple, modular tools through UNIX pipes, you can execute complex bioinformatics pipelines for peak analysis, coverage calculation, and feature annotation.

## Core CLI Patterns

### Intersecting Features
The most common operation is finding overlaps between two files (`-a` and `-b`).
```bash
# Find overlaps between peaks and exons
bedtools intersect -a peaks.bed -b exons.bed

# Count how many B features overlap each A feature
bedtools intersect -a peaks.bed -b repeats.bed -c

# Require a minimum fraction of overlap (e.g., 50%)
bedtools intersect -a A.bed -b B.bed -f 0.50

# Reciprocal overlap: both features must overlap by 50%
bedtools intersect -a A.bed -b B.bed -f 0.50 -r
```

### Merging and Proximity
```bash
# Merge overlapping or adjacent intervals into a single feature
bedtools merge -i sorted_peaks.bed

# Find the closest gene to each peak (ignoring overlaps)
bedtools closest -a peaks.bed -b genes.bed -io
```

### Coverage Analysis
```bash
# Calculate coverage of BAM alignments over BED intervals
bedtools coverage -a regions.bed -b alignments.bam

# Create a bedgraph of genome-wide coverage
bedtools genomecov -ibam alignments.bam -bg > coverage.bg
```

## Expert Tips and Best Practices

### Performance and Memory
*   **Use Sorted Data**: For large datasets, always sort your files (`sort -k1,1 -k2,2n`) and use the `-sorted` flag. This allows `bedtools` to process data using a "sweep-line" algorithm, drastically reducing memory usage.
*   **Genome Files**: When using tools like `complement`, `slop`, or `flank`, provide a genome file (`-g`) defining chromosome sizes. You can use a FASTA index (`.fai`) as a genome file.

### Data Integrity
*   **Naming Consistency**: `bedtools` requires identical chromosome naming. Comparing `chr1` to `1` will result in no overlaps or errors.
*   **Tab Delimitation**: Ensure all input files (except BAM/CRAM) are TAB delimited with UNIX line endings.
*   **Large Chromosomes**: Without the `-sorted` option, `bedtools` may struggle with chromosomes larger than 512Mb.

### Advanced Formatting
*   **CRAM Support**: As of v2.28.0, `bedtools` supports CRAM. Set the `CRAM_REFERENCE` environment variable to point to your reference genome.
*   **Header Preservation**: Use the `-header` flag to ensure the header lines of your input files are passed through to the output.

## Reference documentation
- [bedtools: a powerful toolset for genome arithmetic](./references/bedtools_readthedocs_io_en_latest.md)