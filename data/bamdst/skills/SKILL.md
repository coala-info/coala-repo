---
name: bamdst
description: bamdst is a specialized utility for analyzing sequencing depth and coverage statistics within defined genomic regions. Use when user asks to calculate target enrichment efficiency, evaluate mapping quality, or identify poorly covered genomic regions from BAM files.
homepage: https://github.com/shiquan/bamdst
metadata:
  docker_image: "biocontainers/bamdst:1.0.9_cv1"
---

# bamdst

## Overview

`bamdst` is a specialized utility for analyzing sequencing depth within defined genomic regions. It processes alignment data to provide comprehensive metrics on mapping quality, target enrichment efficiency, and coverage uniformity. It is particularly useful for quality control in clinical sequencing and research pipelines where target capture performance must be validated.

## Usage Patterns

### Basic Command
The tool requires a target BED file (probes), an output directory, and at least one sorted BAM file.
```bash
bamdst -p targets.bed -o ./output_dir/ input.bam
```

### Pipeline Integration
To avoid intermediate disk I/O, use the pipeline mode by passing `-` as the input file and streaming from `samtools`.
```bash
samtools view -u input.bam | bamdst -p targets.bed -o ./output_dir/ -
```

### Custom Depth Thresholds
By default, the tool reports coverage at 0x, 4x, 10x, 30x, and 100x. Use `--cutoffdepth` to add a specific threshold relevant to your project (e.g., 500x for high-depth panels).
```bash
bamdst -p targets.bed -o ./output_dir/ --cutoffdepth 500 input.bam
```

## Parameters and Optimization

- **Flank Analysis**: Use `-f` or `--flank` (default 200bp) to calculate coverage in the regions immediately adjacent to your targets. This is useful for assessing capture "spill-over."
- **Handling High Depth**: For extremely high-depth data, use `--maxdepth` to set a cutoff for the cumulative distribution file to prevent unnormally high values from skewing plots.
- **Identifying Gaps**: Use `--uncover` to define the threshold for "badly covered" regions (default <5x). These regions are exported to `uncover.bed`.
- **Insert Size**: The `--isize` parameter (default 2000) filters out reads with unrealistic inferred insert sizes from the statistics.

## Key Output Files

- **coverage.report**: The primary summary containing mapping stats, target data (Mb), average depth, and percentage of targets covered at various depths.
- **uncover.bed**: A BED file containing regions that failed to meet the `--uncover` depth threshold.
- **depth.tsv.gz**: A per-base depth file for all target regions.
- **cumu.plot / insert.plot**: Data files for generating cumulative depth and insert size distribution plots.
- **chromosome.report**: Coverage statistics broken down by individual chromosomes.

## Best Practices

1. **Input Preparation**: Always ensure the BAM file is coordinate-sorted. While an index is not strictly required for the basic operation, it is standard practice in workflows.
2. **Target Merging**: Note that `bamdst` automatically merges overlapping regions in the provided BED file before calculating statistics.
3. **Map Quality**: The tool defaults to a Map Quality (MapQ) cutoff of 20. Reads below this value are excluded from target depth calculations to ensure statistical reliability.

## Reference documentation
- [bamdst -- a BAM Depth Stat Tool](./references/github_com_shiquan_bamdst.md)