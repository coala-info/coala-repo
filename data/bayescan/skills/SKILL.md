---
name: bayescan
description: BayeScan identifies candidate loci under natural selection by analyzing differences in allele frequencies between populations using a Bayesian model. Use when user asks to detect outliers under selection, identify loci with significant FST coefficients, or perform genome scans for diversifying and balancing selection.
homepage: https://github.com/mfoll/BayeScan
---


# bayescan

## Overview
BayeScan is a command-line tool designed to identify candidate loci under natural selection by analyzing differences in allele frequencies between populations. It utilizes a multinomial-Dirichlet model that accounts for varying effective population sizes and immigration rates by decomposing $F_{ST}$ coefficients into population-specific ($\beta$) and locus-specific ($\alpha$) components. A locus is considered under selection when the $\alpha$ component is significantly different from zero.

## CLI Usage and Best Practices

### Basic Command Structure
The standard execution requires an input file in the specific BayeScan format:
```bash
bayescan [input_file] [options]
```

### Common Options
- `-od <path>`: Specify the output directory (default is the current directory).
- `-threads <n>`: Enable multithreading to speed up the MCMC algorithm.
- `-n <n>`: Number of iterations (default: 5000).
- `-thin <n>`: Thinning interval (default: 10).
- `-nbp <n>`: Number of pilot runs (default: 20).
- `-pilot <n>`: Length of pilot runs (default: 500).
- `-burn <n>`: Burn-in length (default: 50000).
- `-pr_odds <n>`: Prior odds for the neutral model (default: 10).

### Expert Configuration Tips
1. **Controlling False Discovery Rate (FDR)**: Use the `-pr_odds` parameter to reflect your skepticism about selection. For large datasets (e.g., tens of thousands of SNPs), increasing prior odds to 100 or 1000 is recommended to reduce false positives.
2. **Interpreting Alpha ($\alpha$)**:
   - **Positive $\alpha$**: Suggests diversifying (positive) selection.
   - **Negative $\alpha$**: Suggests balancing or purifying selection.
3. **Decision Making with q-values**: Since version 2.1, BayeScan outputs q-values. A q-value threshold of 0.05 or 0.10 is standard, meaning 5% or 10% of identified outliers are expected to be false positives.
4. **Jeffreys' Scale for Bayes Factors (BF)**:
   - **Log10(BF) 0.5 to 1**: Substantial evidence.
   - **Log10(BF) 1 to 1.5**: Strong evidence.
   - **Log10(BF) 1.5 to 2**: Very strong evidence.
   - **Log10(BF) > 2**: Decisive evidence.

### Troubleshooting
- **Compilation Errors**: If encountering an "Ambiguous reference 'beta'" error during compilation with modern GCC, it is often due to namespace conflicts with the `beta` function in `<cmath>`.
- **Input Format**: Ensure the input file correctly specifies the number of loci and populations at the top. BayeScan supports codominant (SNPs), dominant binary (AFLPs), and AFLP band intensity data.

## Reference documentation
- [BayeScan GitHub README](./references/github_com_mfoll_BayeScan.md)
- [BayeScan Issues and Troubleshooting](./references/github_com_mfoll_BayeScan_issues.md)