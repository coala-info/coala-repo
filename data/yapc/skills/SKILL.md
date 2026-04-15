---
name: yapc
description: yapc identifies consistent genomic peaks across multiple experimental conditions. Use when user asks to call genomic peaks or assess reproducibility between replicates.
homepage: https://github.com/jurgjn/yapc
metadata:
  docker_image: "quay.io/biocontainers/yapc:0.1--py_0"
---

# yapc

## Overview
The `yapc` (Yet Another Peak Caller) tool is designed to identify consistent genomic peaks across multiple experimental conditions. Unlike traditional peak callers that often focus on single samples, `yapc` excels at finding representative peaks by averaging signals across all samples to define candidate regions (using the second derivative of the signal) and then applying IDR to assess statistical significance and reproducibility between replicates. It is specifically optimized for datasets with two biological replicates per condition.

## CLI Usage and Best Practices

### Basic Command Structure
The tool requires an output prefix followed by sets of condition names and their corresponding BigWig replicate files.

```bash
yapc [OUTPUT_PREFIX] [CONDITION_NAME] [REP1.bw] [REP2.bw] ...
```

### Common Workflow Example
To call peaks across a time-series (e.g., Embryo and L1 stages):

```bash
yapc study_results \
  embryo embryo_rep1.bw embryo_rep2.bw \
  l1 l1_rep1.bw l1_rep2.bw
```

### Input Preparation
*   **Normalization**: Ensure BigWig tracks are normalized by library size (e.g., using `MACS2 --SPMR`) before running `yapc` to ensure all samples are weighed equally.
*   **Signal Quality**: Use processed signal tracks that show clear peaks upon visual inspection in a genome browser.
*   **ChIP-seq**: For treatment/control assays, pre-process them into a single signal track (e.g., using BEADS) before inputting into `yapc`.

### Parameter Tuning
*   **Peak Shape**: If the default calls do not capture the peak shape well, adjust `--smoothing-window-width`. Values between 75 and 200 are recommended (default is 150).
*   **Peak Width**: Use `--fixed-peak-halfwidth [bp]` if you require peaks of a specific uniform size centered on the concave region mode.
*   **Efficiency**: Use the `--recycle` flag to skip recomputing intermediate files if a run was previously interrupted or if you are re-running with different IDR thresholds.
*   **Reproducibility**: For modENCODE-style analysis, use `--pseudoreplicates` to assess reproducibility within and between replicates.

### Interpreting Outputs
The tool generates several files based on the `OUTPUT_PREFIX`:
*   **BED files**: `_0.001.bed`, `_0.005.bed`, etc., contain peaks passing specific IDR cutoffs.
*   **Signal tracks**: `_coverage.bw` (mean signal) and `_d2smooth.bw` (smoothed second derivative used for peak detection).
*   **Master Table**: `OUTPUT_PREFIX.tsv` contains comprehensive data, including condition-specific globalIDR values (reported as -log10, where 2.0 equals an IDR of 0.01).

## Reference documentation
- [GitHub Repository for yapc](./references/github_com_jurgjn_yapc.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_yapc_overview.md)