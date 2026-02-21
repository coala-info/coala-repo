---
name: fastspar
description: FastSpar provides a scalable and efficient way to infer correlations in compositional datasets, overcoming the limitations of traditional correlation measures like Pearson or Spearman which can produce spurious results on relative abundance data.
homepage: https://github.com/scwatts/fastspar
---

# fastspar

## Overview
FastSpar provides a scalable and efficient way to infer correlations in compositional datasets, overcoming the limitations of traditional correlation measures like Pearson or Spearman which can produce spurious results on relative abundance data. It implements the SparCC algorithm in C++, offering a massive speedup and reduced memory footprint compared to the original Python implementation. The toolset includes utilities for the full analytical pipeline: initial correlation estimation, bootstrap generation for significance testing, and p-value calculation.

## Usage Patterns

### 1. Correlation Inference
The primary command estimates the median correlation and covariance from an OTU table.
```bash
fastspar --otu_table input_data.tsv --correlation correlation.tsv --covariance covariance.tsv --threads 8
```
*   **Input**: BIOM-formatted TSV (counts only, no metadata).
*   **Optimization**: Increase `--iterations` (default 20) and `--exclude_iterations` (default 10) for higher precision.
*   **Thresholding**: Use `--threshold` (default 0.1) to define the correlation strength required to exclude OTU pairs during the iterative estimation process.

### 2. P-value Estimation Workflow
To determine the statistical significance of correlations, follow this three-step process:

**Step A: Generate Bootstrap Samples**
Create 1000 (or more) random permutations of the original data.
```bash
mkdir -p bootstrap_counts
fastspar_bootstrap --otu_table input_data.tsv --number 1000 --prefix bootstrap_counts/sample
```

**Step B: Process Bootstraps**
Run correlation inference on every bootstrap file. Using GNU `parallel` is the standard method to maximize CPU usage.
```bash
mkdir -p bootstrap_correlations
parallel fastspar --otu_table {} --correlation bootstrap_correlations/cor_{/} --covariance bootstrap_correlations/cov_{/} --iterations 5 --threads 1 ::: bootstrap_counts/*
```

**Step C: Calculate P-values**
Compare the original correlations against the bootstrap distribution to generate p-values.
```bash
fastspar_pvalues --otu_table input_data.tsv --correlation correlation.tsv --prefix bootstrap_correlations/cor_sample_ --permutations 1000 --outfile pvalues.tsv
```

## Best Practices
- **Data Preparation**: Ensure the input TSV contains only numeric counts. Metadata columns or non-numeric headers will cause parsing errors.
- **Threading Strategy**: Use the `--threads` flag for single large runs. However, when processing bootstraps with `parallel`, it is more efficient to set `fastspar --threads 1` and let `parallel` manage the concurrent execution of multiple files.
- **Memory Management**: FastSpar is memory-efficient, but when running many parallel instances on very large OTU tables, monitor system RAM to avoid OOM (Out Of Memory) errors.

## Reference documentation
- [FastSpar GitHub Repository](./references/github_com_scwatts_fastspar.md)
- [FastSpar Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fastspar_overview.md)