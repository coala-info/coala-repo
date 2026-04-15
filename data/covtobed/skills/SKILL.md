---
name: covtobed
description: covtobed converts sorted BAM files into BED files by collapsing adjacent bases with identical coverage into single genomic intervals. Use when user asks to transform BAM files to BED format, identify zero-coverage gaps, filter regions by depth and length, or calculate physical coverage for paired-end reads.
homepage: https://github.com/telatin/covtobed/
metadata:
  docker_image: "quay.io/biocontainers/covtobed:1.4.0--h077b44d_0"
---

# covtobed

## Overview
`covtobed` is a high-performance tool designed to transform sorted BAM files into BED files where each record represents a genomic interval with a constant coverage value. Unlike tools that report coverage per-base, `covtobed` collapses adjacent bases with identical coverage into single BED features, significantly reducing file size and making it highly efficient for downstream analysis of depth-defined regions. It is particularly useful for identifying "dark regions" (zero coverage) or regions of interest that meet specific depth and length criteria.

## Usage Guidelines

### Basic CLI Patterns
The tool reads sorted BAM files and outputs BED format to standard output.

*   **Standard usage**:
    `covtobed input.bam > coverage.bed`
*   **Identify gaps (zero coverage)**:
    `covtobed --max-cov 1 input.bam > gaps.bed`
*   **Identify regions with specific depth (e.g., 10x to 50x)**:
    `covtobed --min-cov 10 --max-cov 51 input.bam > target_depth.bed`
*   **Filter by interval length**:
    Use `-l` to ignore small "flickers" in coverage and only report significant regions.
    `covtobed --min-cov 20 --min-len 100 input.bam`

### Advanced Features
*   **Physical Coverage**: For paired-end or mate-paired libraries, use `--physical-coverage` to count the entire insert as covered, rather than just the aligned segments of the reads.
*   **Strand-Specific Tracks**: Use `--output-strands` to generate separate coverage statistics for the forward and reverse strands, which is essential for identifying strand imbalance in RNA-seq or specialized sequencing protocols.
*   **Streaming**: `covtobed` is designed to work in pipes.
    `samtools view -b sample.bam | samtools sort - | covtobed - > coverage.bed`

### Version 1.4.0+ Best Practices
*   **Default Filtering**: Starting with v1.4.0, the tool automatically discards "invalid" alignments (duplicates, failed QC, non-primary). This is equivalent to the `--discard-invalid-alignments` flag.
*   **Legacy Behavior**: If you need to include all reads (including duplicates and low-quality alignments), you must explicitly use the `--keep-invalid-alignments` flag.
*   **Quiet Mode**: When using `covtobed` in automated scripts or pipes where it waits for STDIN, it may print a status message. Suppress this by setting the environment variable `COVTOBED_QUIET=1`.

### Performance Tips
*   **Input Sorting**: Input BAM files **must** be sorted by coordinate.
*   **Mapping Quality**: Use `-q` (e.g., `-q 30`) to ensure coverage is only calculated from uniquely or high-confidence mapped reads, which prevents false coverage signals in repetitive regions.
*   **Reference Filtering**: Use `-z` to skip very short reference sequences (contigs/scaffolds) that might clutter the output.

## Reference documentation
- [Main README and CLI Reference](./references/github_com_telatin_covtobed.md)
- [Wiki Documentation Index](./references/github_com_telatin_covtobed_wiki.md)