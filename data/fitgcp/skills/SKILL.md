---
name: fitgcp
description: `fitgcp` is a statistical tool designed to model the distribution of reads across a genome.
homepage: 
---

# fitgcp

## Overview
`fitgcp` is a statistical tool designed to model the distribution of reads across a genome. By converting SAM files into Genome Coverage Profiles (GCPs), it allows users to fit complex mixture models—such as Zero-Inflated Negative Binomials—to their data using an Expectation-Maximization (EM) algorithm. This process is essential for distinguishing between biological signals and technical noise in high-throughput sequencing experiments.

## Command Line Usage

### Basic Execution
The simplest command generates a GCP and fits the default zero-inflated negative binomial (MOM) model:
`fitgcp [options] input.sam`

### Distribution Selection (`-d`)
Specify the components of the mixture model using character codes:
- `z`: Zero-component (for zero-inflated data)
- `n`: Negative Binomial (Method of Moments)
- `N`: Negative Binomial (Maximum Likelihood Estimation)
- `p`: Poisson
- `t`: Tail component

Example for a Zero-inflated MLE Negative Binomial:
`fitgcp -d zN input.sam`

### Refining the Fit
- **Convergence Control**: Increase iterations with `-i` (default 50) or tighten the threshold with `-t` (default 0.01) for more precise fits.
- **Handling Outliers**: Use `-c` to set a coverage quantile cutoff (default 0.95). Lowering this can help if extreme coverage values are preventing convergence.
- **Initial Parameters**: If the model fails to converge, provide starting points for means (`-m`) and proportions (`-a`).
  `fitgcp -m 10.5 -m 50.0 -a 0.4 input.sam` (Sets means for two distributions and the proportion for the first).

### Visualization and Debugging
- **Pre-fit Inspection**: Use `--view` to inspect the GCP without running the fitting algorithm. This helps determine which distributions are appropriate.
- **Plotting**: Add `-p` to generate a visual representation of the GCP and the resulting fit.
- **Logging**: Use `-l` to track parameter changes at each iteration step, which is useful for diagnosing convergence issues.

## Expert Tips
- **GCP Persistence**: The tool caches the GCP after the first run. Subsequent runs on the same SAM file will be significantly faster as they skip the parsing step.
- **MLE vs MOM**: While `-n` (Method of Moments) is faster, `-N` (Maximum Likelihood Estimation) is generally more accurate for Negative Binomial distributions, especially in noisy datasets.
- **Zero-Inflation**: Always include `z` in your distribution string if your library has many uncovered regions, as this prevents the other distributions from being skewed toward zero.
- **Multi-modal Data**: If you suspect multiple enrichment levels (e.g., different copy number states), use multiple `-m` flags to guide the EM algorithm toward the expected peaks.