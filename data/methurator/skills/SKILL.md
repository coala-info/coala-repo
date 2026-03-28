---
name: methurator
description: Methurator estimates DNA methylation sequencing saturation and predicts the discovery of additional CpG sites using Chao's estimator. Use when user asks to assess methylome coverage comprehensiveness, predict future CpG discovery from BAM files, or generate interactive saturation plots for WGBS and RRBS data.
homepage: https://github.com/VIBTOBIlab/methurator
---

# methurator

## Overview
Methurator is a specialized bioinformatics tool designed to assess whether a DNA methylation sequencing experiment has reached sufficient depth. It uses Chao's estimator to predict how many additional CpG sites would be discovered if sequencing depth were increased. This is essential for determining the cost-effectiveness of further sequencing and for validating the comprehensiveness of methylome coverage in both Whole Genome Bisulfite Sequencing (WGBS) and Reduced Representation Bisulfite Sequencing (RRBS) workflows.

## Core Workflows

### 1. Estimating Saturation (Chao's Estimator)
The primary command `gt-estimator` processes BAM files to calculate the current saturation and predict future discovery.

```bash
# Basic estimation for a single sample
methurator gt-estimator --genome hg19 input_sample.bam

# Estimation with bootstrap confidence intervals (recommended for publication)
methurator gt-estimator --genome mm10 --compute_ci sample.bam

# Processing multiple samples simultaneously
methurator gt-estimator --genome hg38 sample1.bam sample2.bam sample3.bam
```

### 2. Visualizing Results
After running the estimator, use the generated summary file to create interactive HTML plots.

```bash
# Generate plots from the summary YAML
methurator plot --summary output/methurator_summary.yml
```

## CLI Reference and Best Practices

### Command: `gt-estimator`
*   **`--genome`**: Required. Specify the reference genome (e.g., hg19, hg38, mm10).
*   **`--compute_ci`**: Optional. Enables bootstrap resampling to provide confidence intervals for the extrapolation. Note: This increases computation time.
*   **`--rrbs`**: Use this flag for RRBS data. It ensures `MethylDackel` (the underlying engine) keeps duplicates, which is standard practice for RRBS to avoid losing signal in high-density regions.
*   **`--threads`**: Adjust based on your environment. The tool uses a dynamic progress bar and supports multi-threading for BAM processing.

### Command: `plot`
*   **Input**: Requires the `methurator_summary.yml` file produced by `gt-estimator`.
*   **Output**: Produces interactive HTML files showing the sequencing saturation curve, distinguishing between interpolated data (observed) and extrapolated data (predicted).
*   **Asymptote**: The tool automatically calculates the theoretical maximum number of CpGs (asymptote) at an extrapolation factor of $t = 1000$.

### Legacy Support
*   The `downsample` command is maintained for backward compatibility with older workflows but has been superseded by `gt-estimator` for more accurate saturation modeling.

## Expert Tips
*   **Saturation Metrics**: Check the summary YAML for the "saturation" value. This is calculated relative to the theoretical asymptote; a value near 1.0 indicates that further sequencing will yield negligible new CpG discovery.
*   **HPC Usage**: When running in High-Performance Computing environments, ensure the `--threads` parameter matches your allocated cores to optimize the `MethylDackel` extraction phase.
*   **Multi-Sample Summaries**: If you provide multiple BAM files to a single `gt-estimator` run, the tool generates a consolidated `methurator_summary.yml`. The `plot` command will then generate a comparison plot containing all samples.



## Subcommands

| Command | Description |
|---------|-------------|
| methurator downsample | Downsample BAM files and estimate sequencing saturation. |
| methurator gt-estimator | Fit the Chao estimator. |
| methurator plot | Plot the sequencing saturation curve from downsampling results. |

## Reference documentation
- [Main README](./references/github_com_VIBTOBIlab_methurator_blob_main_README.md)
- [Changelog and Version History](./references/github_com_VIBTOBIlab_methurator_blob_main_CHANGELOG.md)