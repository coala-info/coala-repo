---
name: pysamstats
description: pysamstats is a specialized utility for summarizing sequence alignment data into actionable statistics.
homepage: https://github.com/alimanfoo/pysamstats
---

# pysamstats

## Overview

pysamstats is a specialized utility for summarizing sequence alignment data into actionable statistics. While tools like samtools provide raw pileups, pysamstats automates the calculation of specific metrics—such as strand-specific coverage, GC-content-aware depth, and base quality distributions—across genomic positions. It is particularly useful for identifying genomic regions with anomalous mapping patterns, calculating depth of coverage for CNV analysis, or quantifying allele frequencies at specific loci.

## Command Line Usage

The basic syntax for pysamstats is:
`pysamstats [options] <alignment_file>`

### Common Statistics Types (`-t` or `--type`)

*   **coverage**: Total and properly paired read counts per position.
*   **variation**: Counts of matches, mismatches, deletions, and insertions. Required for SNP/Indel frequency analysis.
*   **tlen**: Statistics on insert sizes (template length).
*   **mapq / baseq**: Mapping and base quality distributions.
*   **_binned**: Append `_binned` to types (e.g., `coverage_binned`) to calculate statistics over a sliding window rather than per-base.

### Essential CLI Patterns

**1. Calculate per-base coverage for a specific region:**
```bash
pysamstats --type coverage --chromosome chr1 --start 100000 --end 200000 input.bam > coverage.tsv
```

**2. Extract variation statistics using a reference FASTA:**
Using a reference allows the tool to distinguish between matches and mismatches.
```bash
pysamstats --type variation --fasta reference.fasta input.bam > variation.tsv
```

**3. Generate binned coverage with a custom window size:**
Useful for visualizing large-scale depth fluctuations.
```bash
pysamstats --type coverage_binned --window-size 500 input.bam > binned_coverage.tsv
```

**4. Filter by quality scores:**
Exclude low-quality alignments or bases from the statistics.
```bash
pysamstats --type variation --min-mapq 30 --min-baseq 20 input.bam
```

## Expert Tips and Best Practices

*   **Coordinate Systems**: By default, pysamstats uses **1-based** coordinates. Use the `-z` or `--zero-based` flag if your downstream analysis (like BED format processing) requires 0-based coordinates.
*   **Handling High Depth**: The default maximum read depth is 8,000. For ultra-high depth sequencing (e.g., amplicon or viral sequencing), increase this limit using `--max-depth <int>` to avoid truncated statistics.
*   **Output Formats**: While TSV is the default, you can use `--format hdf5` for extremely large datasets to enable faster random access and compression (requires PyTables).
*   **Memory Efficiency**: When using the Python API, `pysamstats.stat_variation(...)` returns an iterator. To load data into memory efficiently for plotting, use `pysamstats.load_variation(...)` which returns a specialized structure (like a numpy record array).
*   **Duplicate Reads**: Use the `--no-dup` flag to exclude reads marked as PCR or optical duplicates, which is standard practice for variant calling and depth-of-coverage workflows.

## Reference documentation
- [pysamstats GitHub Repository](./references/github_com_alimanfoo_pysamstats.md)
- [Bioconda pysamstats Overview](./references/anaconda_org_channels_bioconda_packages_pysamstats_overview.md)