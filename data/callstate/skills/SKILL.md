---
name: callstate
description: "callstate classifies genomic regions into specific callability states based on sequencing depth and alignment quality. Use when user asks to determine if genomic regions are callable, identify regions with low coverage or poor mapping quality, or calculate mean depth statistics for specific intervals."
homepage: https://github.com/LuobinY/Callstate
---


# callstate

## Overview
`callstate` is a high-performance bioinformatics tool used to classify genomic regions into specific "callable" states based on sequencing depth and alignment quality. It serves as a modern, faster alternative to the GATK3 `CallableLoci` tool. By analyzing BAM files against a target BED file, it determines whether a region is truly callable, lacks coverage, or suffers from poor mapping quality, while also providing mean depth statistics for each interval.

## Command Line Usage

The basic syntax requires a BED file of target regions and a BAM file of alignments:

```bash
callstate [options] <TARGETS.bed> <INPUT.bam>
```

### Common Patterns

**Standard Execution**
To run with default thresholds (Min QC depth 20, Min MAPQ 10) and save to a file:
```bash
callstate -o output_callable_status.bed targets.bed sample.bam
```

**High-Sensitivity/Low-Depth Calling**
If working with low-input data or specific panels where a lower depth is acceptable:
```bash
callstate -mdp 5 -o output.bed targets.bed sample.bam
```

**Performance Optimization**
Increase decompression threads for faster processing of large BAM files:
```bash
callstate -t 8 -o output.bed targets.bed sample.bam
```

## Parameter Tuning and Best Practices

### Defining Callability
*   **QC Depth (`-mdp`)**: This is the most critical threshold. A site is marked `CALLABLE` only if the QC depth meets this value. The default is 20.
*   **Mapping Quality (`-mmq`)**: Reads with MAPQ below this value (default 10) do not count toward the QC depth used to determine if a site is `CALLABLE`.
*   **Base Quality (`-mbq`)**: Individual bases with quality scores below this (default 10) are ignored when calculating QC depth.

### Identifying Problematic Regions
*   **Poor Mapping Quality**: A region is flagged as `POOR_MAPPING_QUALITY` if the fraction of "low mapping quality" reads exceeds the threshold set by `-frlmq` (default 0.5).
*   **Low MAPQ Definition (`-mlmq`)**: Defines the ceiling for what is considered a "problematic" read (default 1).
*   **Excessive Coverage (`-mxdp`)**: Use this to flag regions with suspiciously high depth (e.g., collapsed repeats). By default, this is disabled (-1).

### Filtering Reads
The tool uses a bitwise flag filter (`-F`) to exclude specific reads. The default is `1796`, which excludes:
*   Read unmapped
*   Not passing quality controls
*   PCR or optical duplicate
*   Secondary alignment

## Output Interpretation
The output is a BED-like file with additional columns:
1.  **chrom**: Chromosome
2.  **start**: Start position
3.  **end**: End position
4.  **call_state**: One of `REF_N`, `NO_COVERAGE`, `LOW_COVERAGE`, `POOR_MAPPING_QUALITY`, `EXCESSIVE_COVERAGE`, or `CALLABLE`.
5.  **raw_depth**: Mean raw depth across the region.
6.  **qc_depth**: Mean depth of reads passing quality filters.
7.  **low_mapq_depth**: Mean depth of reads with low mapping quality.

## Reference documentation
- [Callstate GitHub Repository](./references/github_com_Luobiny_Callstate.md)