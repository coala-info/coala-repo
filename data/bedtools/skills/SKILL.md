---
name: bedtools
description: "bedtools is a suite of tools for performing genomic arithmetic and set theory operations on interval files. Use when user asks to intersect genomic features, merge overlapping intervals, find the closest features, calculate coverage, or manipulate BED, VCF, and BAM files."
homepage: http://bedtools.readthedocs.org/
---


# bedtools

## Overview
The `bedtools` suite functions as a "Swiss-army knife" for genomic analysis, allowing for complex "genome arithmetic." It is designed to handle set theory operations on genomic intervals, enabling researchers to compare different sets of genomic features (e.g., overlapping ChIP-seq peaks with gene annotations). While individual sub-commands perform simple tasks, they are designed to be piped together on the UNIX command line to create sophisticated analysis pipelines.

## Core Concepts and Best Practices

### Input Requirements
- **Tab-Delimited**: With the exception of BAM files, all input files must be tab-delimited.
- **Line Endings**: Files must use UNIX line endings (`\n`). Windows-formatted files (`\r\n`) will cause errors.
- **Chromosome Naming**: Chromosome names must match exactly across files (e.g., "chr1" and "1" are not compatible).
- **Sorting**: Many operations (and performance optimizations) require files to be sorted by chromosome and then by start position. Use `sort -k1,1 -k2,2n` for BED files.

### Performance Optimization
- **The `-sorted` Option**: When working with very large datasets that are pre-sorted, always use the `-sorted` flag. This invokes a sweep-line algorithm that is significantly faster and uses much less memory than the default R-Tree algorithm.
- **Memory Constraints**: For unsorted data, `bedtools` may fail on extremely large files (e.g., 100M+ alignments) due to memory exhaustion. Sorting the data is the primary solution.

## Common CLI Patterns

### Intersecting Intervals
Find overlaps between two sets of features:
```bash
# Basic intersection
bedtools intersect -a features.bed -b database.bed

# Require 50% reciprocal overlap
bedtools intersect -a peaks1.bed -b peaks2.bed -f 0.50 -r

# Report only features in A that do NOT overlap B (like grep -v)
bedtools intersect -a calls.vcf -b repeats.bed -v

# Count the number of overlaps in B for each interval in A
bedtools intersect -a exons.bed -b reads.bam -c
```

### Proximity and Merging
```bash
# Find the closest non-overlapping gene for each peak
bedtools closest -a peaks.bed -b genes.bed -io

# Merge overlapping features into a single interval
bedtools merge -i input.sorted.bed

# Merge features within 1000bp of each other
bedtools merge -i input.sorted.bed -d 1000
```

### Coverage and Genome Arithmetic
```bash
# Calculate coverage of BAM alignments on exons
bedtools coverage -a exons.bed -b reads.bam

# Get the genomic complement (regions not covered by features)
bedtools complement -i features.bed -g hg38.chrom.sizes

# Randomly shuffle intervals while excluding specific regions (e.g., gaps)
bedtools shuffle -i peaks.bed -g hg38.chrom.sizes -excl gaps.bed
```

## Expert Tips
- **Genome Files**: Tools like `complement`, `slop`, and `shuffle` require a genome file (chromosome names and sizes). You can use a `.fai` (fasta index) file as a genome file; `bedtools` will automatically use the first two columns.
- **BAM to BED**: Use `bedtools bamtobed` to convert alignments for use with tools that don't natively support BAM, or to use specific BAM tags (like edit distance) as the BED score.
- **Streaming**: Use `stdin` and `-` to pipe multiple `bedtools` commands together without creating intermediate files, which saves disk I/O and space.
- **Strand Specificity**: Most tools support a `-s` option to force strandedness, ensuring overlaps only occur between features on the same strand.



## Subcommands

| Command | Description |
|---------|-------------|
| annotate | Annotates the depth & breadth of coverage of features from multiple files on the intervals in -i. |
| bamtobed | Converts BAM alignments to BED6 or BEDPE format. |
| bamtofastq | Convert BAM alignments to FASTQ files. |
| bed12tobed6 | Splits BED12 features into discrete BED6 features. |
| bedpetobam | Converts feature records to BAM format. |
| bedtobam | Converts feature records to BAM format. |
| closest | For each feature in A, finds the closest feature (upstream or downstream) in B. |
| cluster | Clusters overlapping/nearby BED/GFF/VCF intervals. |
| complement | Returns the base pair complement of a feature file. |
| coverage | Returns the depth and breadth of coverage of features from B on the intervals in A. |
| expand | Replicate lines in a file based on columns of comma-separated values. |
| fisher | Calculate Fisher statistic b/w two feature files. |
| flank | Creates flanking interval(s) for each BED/GFF/VCF feature. |
| genomecov | Compute the coverage of a feature file among a genome. |
| getfasta | Extract DNA sequences from a fasta file based on feature coordinates. |
| groupby | Summarizes a dataset column based upon common column groupings. Akin to the SQL "group by" command. |
| igv | Creates a batch script to create IGV images at each interval defined in a BED/GFF/VCF file. |
| intersect | Report overlaps between two feature files. |
| jaccard | Calculate Jaccard statistic b/w two feature files. Jaccard is the length of the intersection over the union. Values range from 0 (no intersection) to 1 (self intersection). |
| links | Creates HTML links to an UCSC Genome Browser from a feature file. |
| makewindows | Makes adjacent or sliding windows across a genome or BED file. |
| map | Apply a function to a column from B intervals that overlap A. |
| maskfasta | Mask a fasta file based on feature coordinates. |
| merge | Merges overlapping BED/GFF/VCF entries into a single interval. |
| multicov | Counts sequence coverage for multiple bams at specific loci. |
| multiinter | Identifies common intervals among multiple BED/GFF/VCF files. Requires that each interval file is sorted by chrom/start. |
| nuc | Profiles the nucleotide content of intervals in a fasta file. |
| overlap | Computes the amount of overlap (positive values) or distance (negative values) between genome features and reports the result at the end of the same line. |
| pairtobed | Report overlaps between a BEDPE file and a BED/GFF/VCF file. |
| pairtopair | Report overlaps between two paired-end BED files (BEDPE). |
| random | Generate random intervals among a genome. |
| reldist | Calculate the relative distance distribution b/w two feature files. |
| sample | Take sample of input file(s) using reservoir sampling algorithm. |
| shift | Shift each feature by requested number of base pairs. |
| shuffle | Randomly permute the locations of a feature file among a genome. |
| slop | Add requested base pairs of "slop" to each feature. |
| sort | Sorts a feature file in various and useful ways. |
| spacing | Report (last col.) the gap lengths between intervals in a file. |
| split | Split a Bed file. |
| subtract | Removes the portion(s) of an interval that is overlapped by another feature(s). |
| summary | Report summary statistics of the intervals in a file |
| tag | Annotates a BAM file based on overlaps with multiple BED/GFF/VCF files on the intervals in -i. |
| unionbedg | Combines multiple BedGraph files into a single file, allowing coverage comparisons between them. |
| window | Examines a "window" around each feature in A and reports all features in B that overlap the window. For each overlap the entire entry in A and B are reported. |

## Reference documentation
- [bedtools Overview](./references/bedtools_readthedocs_io_en_latest_content_overview.html.md)
- [General Usage and Formats](./references/bedtools_readthedocs_io_en_latest_content_general-usage.html.md)
- [Example Usage Guide](./references/bedtools_readthedocs_io_en_latest_content_example-usage.html.md)
- [Advanced Usage Patterns](./references/bedtools_readthedocs_io_en_latest_content_advanced-usage.html.md)
- [Tips and Tricks](./references/bedtools_readthedocs_io_en_latest_content_tips-and-tricks.html.md)