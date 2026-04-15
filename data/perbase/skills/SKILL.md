---
name: perbase
description: Perbase is a high-performance bioinformatics utility designed to calculate per-position depth and nucleotide-specific pileup statistics from BAM or CRAM files. Use when user asks to calculate sequencing depth, count nucleotide frequencies at specific positions, or generate pileup statistics with hardware-accelerated parallelization.
homepage: https://github.com/sstadick/perbase
metadata:
  docker_image: "quay.io/biocontainers/perbase:1.2.0--h15397dd_0"
---

# perbase

## Overview
Perbase is a specialized bioinformatics utility written in Rust, designed to overcome the performance bottlenecks of traditional depth-calculation tools. It leverages hardware concurrency to parallelize analysis over input regions, making it significantly faster than tools like `samtools depth` or `bam-readcount` when compute resources are available. It is particularly useful for generating detailed pileup statistics, including base-specific counts (A, C, T, G, N), insertion/deletion frequencies, and handling mate-pair overlaps with customizable resolution strategies.

## CLI Usage and Patterns

### Basic Depth and Nucleotide Counting
The primary command is `base-depth`, which provides a comprehensive breakdown of every base at each position.

```bash
# Analyze a BAM file and output to stdout
perbase base-depth input.bam

# Analyze specific regions using a BED file
perbase base-depth input.bam --bed regions.bed

# Provide a reference FASTA to include the REF_BASE column in output
perbase base-depth input.bam --ref reference.fasta
```

### Performance and Output Optimization
*   **Compression**: Use the `-Z` or `--bgzip` flag to output BGZF compressed data directly. This is highly recommended for genome-wide analyses to save disk space.
*   **Parallelization**: Perbase automatically scales to available cores. Ensure your environment has sufficient threads allocated.
*   **Zero-Depth Positions**: By default, perbase may truncate regions with 0 depth at the start/end. Use `--keep-zeros` to ensure every position in your target interval is reported.

### Quality Filtering and Accuracy
*   **Base Quality**: Use `-Q` or `--min-base-quality` to ignore low-quality bases. Bases below this threshold are counted as `N` rather than being discarded, maintaining accurate depth counts while flagging low-confidence sites.
*   **Mate Resolution**: When read pairs overlap, perbase can resolve conflicts. Use `--mate-fix` to choose a strategy (e.g., preferring the base with higher quality or higher mapping quality).
*   **Filtering**: Reads failing standard filters (mapping quality, flags) are tracked in the `FAIL` column rather than simply ignored, providing better visibility into data quality.

### Common Tool Flags
| Flag | Description |
| --- | --- |
| `-Z, --bgzip` | Output in BGZF compressed format. |
| `--keep-zeros` | Report positions even if depth is zero. |
| `-Q, --min-base-quality` | Minimum base quality to count a nucleotide (else counts as N). |
| `--skip-merging-intervals` | Prevent merging of overlapping BED regions (useful for maintaining 1:1 mapping with input). |
| `--bed-format` | (For `only-depth`) Outputs a 5-column BED-like file without headers. |

## Expert Tips
*   **CRAM Support**: When working with CRAM files, always provide the reference genome using `--ref` to ensure proper decoding and to enable the `REF_BASE` output column.
*   **Memory Management**: While perbase is fast, analyzing extremely high-depth regions (e.g., amplicon sequencing) with many threads can consume significant memory. Monitor usage when depth exceeds 10,000x.
*   **Downstream Analysis**: The output is TSV-formatted. For rapid filtering of the results, pipe the output to `awk` or use `tabix` on the bgzipped output (after indexing).



## Subcommands

| Command | Description |
|---------|-------------|
| perbase base-depth | Calculate the depth at each base, per-nucleotide |
| perbase only-depth | Calculate the only the depth at each base |

## Reference documentation
- [Perbase GitHub Repository](./references/github_com_sstadick_perbase.md)
- [Perbase README](./references/github_com_sstadick_perbase_blob_master_README.md)
- [Changelog and Version History](./references/github_com_sstadick_perbase_blob_master_CHANGELOG.md)