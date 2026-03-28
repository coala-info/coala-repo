---
name: wiggletools
description: WiggleTools is a high-performance framework for processing and performing mathematical operations on genome-wide data files as numerical functions. Use when user asks to scale genomic signals, calculate statistics across multiple files, aggregate data from various formats, or perform complex nesting of genomic operators.
homepage: https://github.com/Ensembl/WiggleTools
---

# wiggletools

## Overview
WiggleTools is a high-performance framework designed to treat genome-wide data as numerical functions. It uses lazy evaluation to process massive datasets efficiently without loading everything into memory. This skill provides the syntax for building complex command-level "programs" that can scale, filter, and aggregate genomic signals across different file formats.

## Core Command Patterns
The basic syntax follows a functional nesting pattern: `wiggletools <program>`.

### Input Formats
WiggleTools automatically detects formats by extension:
- **Signal**: `.bw` (BigWig), `.wig` (Wiggle), `.bg` (BedGraph)
- **Features/Intervals**: `.bed`, `.bb` (BigBed)
- **Reads/Variants**: `.bam`, `.cram`, `.vcf`, `.bcf` (Note: Index files like `.bai` or `.tbi` must be in the same directory).

### Unary Operators (Single Input)
Modify a single data stream:
- **Scaling**: `wiggletools scale 1.5 input.bw`
- **Log Transformation**: `wiggletools ln input.bw` or `wiggletools log 10 input.bw`
- **Thresholding**: `wiggletools gt 5 input.bw` (Returns boolean regions where value > 5)
- **Absolute Value**: `wiggletools abs input.bw`

### Binary and N-ary Operators (Multiple Inputs)
Combine multiple files:
- **Summation**: `wiggletools sum file1.bw file2.bw file3.bw`
- **Mean**: `wiggletools mean file1.bw file2.bw`
- **Product**: `wiggletools product file1.bw file2.bw`
- **Ratio**: `wiggletools ratio file1.bw file2.bw`

### Statistics and Comparisons
- **Variance/StdDev**: `wiggletools var file1.bw file2.bw file3.bw`
- **T-test**: `wiggletools ttest file1_groupA.bw file2_groupB.bw`
- **Coverage**: `wiggletools coverage reads.bed` (Generates a signal track from overlapping intervals)

## Advanced Workflows

### Complex Nesting
You can nest operators to create sophisticated pipelines.
Example: Calculate the mean of two scaled files:
`wiggletools mean [ scale 0.5 file1.bw ] [ scale 0.8 file2.bw ]`

### Genomic Filtering (Seek)
To restrict operations to a specific genomic region:
`wiggletools seek chr1 100 2000 sum file1.bw file2.bw`

### Handling Large Command Strings
If the command becomes too long for the shell, save the program to a text file and run:
`wiggletools run program.txt`

### Streaming Data
Pipe data from other tools using `-` for stdin:
`cat data.wig | wiggletools sum - other_data.bw`
For SAM format specifically:
`samtools view input.bam | wiggletools sam -`

## Expert Tips
- **Lazy Evaluation**: WiggleTools only computes values when requested by the output. This means you can chain many operators without a significant memory penalty.
- **Boolean Masks**: Use operators like `gt` (greater than) or `unit` in combination with `product` to effectively mask regions of the genome.
- **Integrity Checks**: Use `isZero` to verify if a subtraction or comparison results in an empty signal; it exits with an error code if any non-zero value is found.



## Subcommands

| Command | Description |
|---------|-------------|
| wiggletools_apply | Apply a function to wiggle files. |
| wiggletools_entropy | Calculate the entropy of a wiggle track. |
| wiggletools_mean | Calculates the mean of wiggle files. |
| wiggletools_median | Calculates the median of wiggle tracks. |
| wiggletools_min | Find the minimum value across wiggle files. |
| wiggletools_nearest | Find the nearest feature in a wiggle file. |
| wiggletools_ratio | Calculates the ratio of two wiggle files. |
| wiggletools_stddev | Calculates the standard deviation of wiggle tracks. |
| wiggletools_ttest | Performs a t-test on wiggle files. |
| wiggletools_wilcoxon | Performs a Wilcoxon rank-sum test on wiggle files. |

## Reference documentation
- [WiggleTools GitHub Repository](./references/github_com_Ensembl_WiggleTools.md)