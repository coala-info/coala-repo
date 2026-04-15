---
name: pepr
description: PePr is a bioinformatics pipeline that performs peak-calling and differential binding analysis for ChIP-Seq data while accounting for biological replicates. Use when user asks to identify binding sites in a single condition, find differential binding regions between two groups, or analyze sharp and broad peaks using a negative binomial distribution.
homepage: https://github.com/shawnzhangyx/PePr/
metadata:
  docker_image: "quay.io/biocontainers/pepr:1.1.24--py35_0"
---

# pepr

## Overview
PePr (Peak-calling and Prioritization) is a specialized bioinformatics pipeline designed for ChIP-Seq data with biological replicates. It uses a sliding window approach modeled with a negative binomial distribution to identify enriched regions. Unlike many other peak callers, PePr specifically accounts for variability across replicates, ranking regions with consistent enrichment more favorably. It is particularly effective for both sharp peaks (transcription factors) and broad peaks (histone modifications).

## Core Workflows

### Peak-Calling (Single Group)
Use this to identify binding sites for a single condition using ChIP samples and corresponding input (control) samples.
```bash
PePr -c chip_rep1.bam,chip_rep2.bam -i input_rep1.bam,input_rep2.bam -f bam -n MyExperiment
```

### Differential Binding Analysis
Use this to find regions where binding intensity significantly differs between two groups.
```bash
PePr -c g1_chip1.bam,g1_chip2.bam -i g1_in1.bam,g1_in2.bam --chip2 g2_chip1.bam,g2_chip2.bam --input2 g2_in1.bam,g2_in2.bam -f bam --diff -n DiffAnalysis
```

## Key Parameters and Optimization

### Peak Type Selection
*   **Broad Peaks**: Default setting. Suitable for histone marks like H3K27me3 or H3K36me3.
*   **Sharp Peaks**: Use `--peaktype sharp` for transcription factors or narrow marks like H3K4me3.

### Normalization Strategies
*   **Peak-calling**: Defaults to `intra-group`.
*   **Differential Analysis**: Defaults to `inter-group`.
*   **Manual Override**: Use `--normalization scale` if library sizes differ drastically but IP efficiency is similar, or `no` if data is already pre-normalized.

### Performance and Memory
*   **Parallelization**: Use `--num-processors` to specify CPU cores.
*   **Duplicate Reads**: By default, PePr keeps all reads. Use `--keep-max-dup [N]` to remove PCR artifacts if high duplication is suspected.
*   **Post-processing**: Run `PePr-postprocess` after the main command to filter false positives based on peak shape. Note that this step is memory-intensive as it loads all reads.

## File Format Requirements
*   **Single-end**: Supports BED, BAM, SAM. BED files must have at least 6 columns (including strand for shift size estimation).
*   **Paired-end**: Supports BAM, SAM. Files **must** be sorted by read name (`samtools sort -n`). Use `-f bampe` or `-f sampe`.

## Expert Tips
1.  **Parameter Estimation**: If the empirical estimation of shift size or window size fails, run `PePr-preprocess` first. This generates a parameter file you can inspect and modify before running the full pipeline with `-p parameter_file.txt`.
2.  **Window Size**: PePr estimates this between 100bp and 1000bp. For very broad domains, manually increasing `-w` may improve recovery.
3.  **Input Directory**: Always use absolute paths with `--input-directory` and `--output-directory` to avoid file resolution errors during multi-step processing.



## Subcommands

| Command | Description |
|---------|-------------|
| PePr-postprocess | Post-process PePr peak calling results, including artifact removal and peak boundary refinement. |
| PePr-preprocess | Pre-processing and parameter estimation for PePr (Peak-calling and Prioritization pipeline for ChIP-seq) |

## Reference documentation
- [PePr GitHub Repository](./references/github_com_shawnzhangyx_PePr.md)