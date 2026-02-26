---
name: merfishtools
description: "merfishtools processes raw MERFISH readouts into expression estimates and performs Bayesian differential expression analysis. Use when user asks to estimate gene expression probabilities from spatial transcriptomics data, calculate differential expression between two conditions, or analyze expression variation across multiple experimental groups."
homepage: https://merfishtools.github.io
---


# merfishtools

## Overview
This skill enables the processing of raw MERFISH readouts into accurate expression estimates. It is particularly useful when you need to account for noise rates and misidentification probes in spatial transcriptomics data. The workflow typically involves two stages: first, estimating the posterior probability mass functions (PMF) for gene expression in individual cells, and second, using those PMFs to calculate differential expression statistics (fold changes or coefficients of variation) between experimental groups.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::merfishtools
```

## Core Workflows

### 1. Expression Estimation
Use the `exp` command to convert raw readouts into expression probabilities.

```bash
merfishtools exp --threads 8 codebook.txt data.txt --estimate estimates.txt > expression_pmf.txt
```

**Input Requirements:**
- **Codebook (`codebook.txt`):** Tab-separated file with columns `feature`, `codeword`, and `expressed`. The `expressed` column must be `1` for real targets and `0` for misidentification probes (used for noise estimation).
- **Data (`data.txt`):** Tab-separated file (or binary v2 format) containing columns: `cell`, `feature`, `hamming_dist`, `cell_position_x`, `cell_position_y`, `rna_position_x`, `rna_position_y`.

**Output Files:**
- **STDOUT:** The full probability mass function (PMF) required for downstream differential expression.
- **`--estimate`:** A summary table containing Maximum A Posteriori (MAP) estimates, standard deviations, and 95% credible intervals.

### 2. Differential Expression (Two Conditions)
Compare two groups using the PMFs generated in the previous step.

```bash
merfishtools diffexp --threads 8 cond1_pmf.txt cond2_pmf.txt > diffexp_results.txt
```

**Key Output Metrics:**
- **PEP:** Posterior Error Probability.
- **Expected FDR:** False Discovery Rate control for the selected feature set.
- **Log2 Fold Change:** MAP estimate with 95% credible intervals.

### 3. Multi-Condition Analysis
For three or more conditions, use `multidiffexp` to calculate the Coefficient of Variation (CV) across groups.

```bash
merfishtools multidiffexp --threads 8 cond1.txt cond2.txt cond3.txt > multi_diffexp.txt
```

## Expert Tips and Best Practices
- **Noise Estimation:** Always include misidentification probes (marked as `0` in the codebook). The Bayesian model relies on these to accurately distinguish true signal from background noise.
- **Resource Management:** Use the `--threads` flag to parallelize the computation, as Bayesian estimation via PMFs can be computationally intensive for large datasets.
- **Pipeline Continuity:** Ensure you capture the STDOUT of the `exp` command. While the `--estimate` file is easier for humans to read, the STDOUT (PMF) is the mandatory input for `diffexp` and `multidiffexp` to maintain the full uncertainty of the estimates.
- **Binary Format:** If using MERFISH protocol v2, provide the binary readout file directly; the tool detects the format automatically.

## Reference documentation
- [MERFISHtools Homepage and Usage Guide](./references/merfishtools_github_io_index.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_merfishtools_overview.md)