---
name: merfishtools
description: "merfishtools uses a Bayesian model to analyze MERFISH data for accurate transcript expression estimation and differential expression analysis. Use when user asks to estimate transcript expression from spatial readout data, identify differentially expressed genes between two conditions, or perform multi-condition expression analysis."
homepage: https://merfishtools.github.io
---


# merfishtools

## Overview

This skill provides guidance for using `merfishtools`, a specialized tool for analyzing Multiplexed Error-Robust Fluorescence in situ Hybridization (MERFISH) data. It employs a Bayesian model to account for noise and misidentification probes, providing more accurate expression estimates than simple counting. Use this skill to process raw readout files, generate expression probability distributions, and identify differentially expressed genes with credible intervals and FDR control.

## Core Workflows

### 1. Estimating Transcript Expression
The primary entry point for raw data. This step converts spatial readout data into posterior probability mass functions (PMFs).

```bash
merfishtools exp --threads <N> <codebook.txt> <data.txt> --estimate <estimates.txt> > <expression.txt>
```

**Key Inputs:**
- **Codebook (`codebook.txt`)**: Tab-separated file with columns `feature`, `codeword`, and `expressed`. The `expressed` column must be `1` for target transcripts and `0` for noise/misidentification probes.
- **Data (`data.txt`)**: Tab-separated file (or v2 binary) containing columns: `cell`, `feature`, `hamming_dist`, `cell_position_x/y`, and `rna_position_x/y`.

**Key Outputs:**
- **STDOUT (`expression.txt`)**: The full PMF (cell, feature, expression, posterior probability). This file is required for subsequent differential expression steps.
- **Estimates (`--estimate`)**: A summary table containing MAP (Maximum A Posteriori) estimates, standard deviations, and 95% credible intervals.

### 2. Differential Expression (Two Conditions)
Compares two PMF files generated in Step 1 to identify changes in expression.

```bash
merfishtools diffexp --threads <N> <expression1.txt> <expression2.txt> > <diffexp.txt>
```

- **Output**: Provides Posterior Error Probability (PEP), Bayes Factors, and log2 fold change estimates with 95% credible intervals.
- **FDR Control**: The output includes an expected False Discovery Rate (FDR) column to help threshold significant results.

### 3. Multi-Condition Analysis
Used when comparing three or more groups. It uses the coefficient of variation (CV) across condition means as the metric for differential expression.

```bash
merfishtools multidiffexp --threads <N> <exp1.txt> <exp2.txt> <exp3.txt> ... > <multidiff.txt>
```

## Expert Tips & Best Practices

- **Noise Estimation**: Always include misidentification probes (marked as `0` in the codebook). `merfishtools` uses these to calculate background noise rates; omitting them will reduce the accuracy of the Bayesian model.
- **Resource Management**: Use the `--threads` flag to parallelize calculations, as Bayesian posterior estimation is computationally intensive.
- **Data Formats**: The tool automatically detects MERFISH protocol v2 binary formats for the data input, so no manual conversion is necessary if using newer protocol outputs.
- **Interpreting Results**: Prefer using the MAP log2 fold change and the 95% credible intervals for reporting, as these provide a more robust measure of uncertainty than frequentist p-values.



## Subcommands

| Command | Description |
|---------|-------------|
| diffexp | Test for differential expression between two groups of cells. |
| gen-mhd2 | Generate MERFISH MHD2 codebook with given parameters. |
| merfishtools est-error-rates | Estimate 0-1 and 1-0 error rates. |
| merfishtools exp | Estimate expressions for each feature (e.g. gene or transcript) in each cell. |
| merfishtools gen-mhd4 | Generate MERFISH MHD4 codebook with given parameters. |
| merfishtools multidiffexp | Test for differential expression between multiple groups of cells. |

## Reference documentation
- [MERFISHtools Home](./references/merfishtools_github_io_index.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_merfishtools_overview.md)