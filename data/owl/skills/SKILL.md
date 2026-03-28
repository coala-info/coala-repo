---
name: owl
description: Owl detects and quantifies microsatellite instability using high-fidelity long-read sequencing data. Use when user asks to profile microsatellite repeats, score microsatellite instability, or analyze MSI from HiFi reads.
homepage: https://github.com/PacificBiosciences/owl
---

# owl

## Overview

Owl is a specialized bioinformatics tool designed to detect and quantify Microsatellite Instability (MSI) specifically using high-fidelity (HiFi) long-read sequencing data. It leverages the accuracy of HiFi reads and phasing information to distinguish between true biological instability and sequencing noise. The tool operates in a two-step workflow: first profiling individual repeat loci to generate raw results, and then aggregating those results into a final sample-level MSI score.

## Usage Guidelines

### Prerequisites
* **Phased Data**: For accurate results, HiFi reads should be phased (haplotagged) using tools like `HiPhase` or `WhatsHap`. While Owl will run on un-phased data, it will issue a warning and may produce falsely elevated MSI scores.
* **Marker Bed**: A BED file containing the target microsatellite regions (e.g., `GRCh38_owl_markers.bed.gz`) is required for the profiling step.

### Step 1: Profiling Repeats
The `profile` command analyzes the BAM file at specific regions to determine the length distribution of microsatellites.

```bash
owl profile \
  --bam sample.haplotagged.bam \
  --regions GRCh38_owl_markers.bed.gz \
  --sample SampleName > sample.results.txt
```

### Step 2: Scoring and Summarization
The `score` command processes the output from the profiling step to generate the final MSI metrics.

```bash
owl score --file sample.results.txt --prefix SampleName
```

## Output Interpretation

The scoring step produces two primary files:

1.  **`{prefix}.owl-scores.txt`**: Contains the summary MSI metrics.
    *   **%high**: The primary MSI metric, representing the proportion of loci with a high coefficient of variation (CV).
    *   **#passing / %passing**: Indicates data completeness.
    *   **qc**: A "pass" or "fail" label based on the percentage of sites with reliable measurements.
2.  **`{prefix}.owl-motif-counts.txt`**: Breaks down the instability metrics by specific repeat motifs (e.g., mono-nucleotide vs. di-nucleotide repeats).

## Best Practices
* **Haplotype Awareness**: Owl uses the `HP` (haplotype) and `PS` (phase set) tags in the BAM file. Ensure your alignment pipeline preserves these tags.
* **Batch Processing**: You can score multiple samples together by providing multiple result files to the `score` command to compare MSI levels across a cohort.
* **QC Monitoring**: Always check the `qc` column in the scores file. A "fail" typically indicates insufficient coverage or poor phasing at the marker sites, which compromises the MSI call.



## Subcommands

| Command | Description |
|---------|-------------|
| owl score | Score profiles |
| owl_merge | Merge multiple profiles |
| owl_profile | Profile a BAM file |

## Reference documentation
- [Owl README](./references/github_com_PacificBiosciences_owl_blob_main_README.md)