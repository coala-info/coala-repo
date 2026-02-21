---
name: mptp
description: mPTP (multi-rate Poisson Tree Processes) is a specialized tool for delimiting species based on a rooted phylogenetic tree.
homepage: https://github.com/Pas-Kapli/mptp
---

# mptp

## Overview

mPTP (multi-rate Poisson Tree Processes) is a specialized tool for delimiting species based on a rooted phylogenetic tree. It extends the original PTP model by allowing each delimited species to have its own distinct branching rate, which better fits empirical datasets where population sizes and mutation rates vary. The tool provides a fast dynamic programming implementation for Maximum Likelihood estimates and an MCMC approach to assess the confidence of the delimitation through support values.

## Core Workflows

### Maximum Likelihood (ML) Delimitation
Use ML to find the point-estimate of species boundaries.

*   **Multi-rate model (Recommended)**: Accounts for different branching rates across species.
    `mptp --ml --multi --tree_file <input_tree> --output_file <output_prefix>`
*   **Single-rate model**: Assumes a single exponential distribution for all within-species processes.
    `mptp --ml --single --tree_file <input_tree> --output_file <output_prefix>`

### Bayesian Delimitation (MCMC)
Use MCMC to generate support values and assess delimitation confidence.

*   **Standard MCMC run**:
    `mptp --mcmc 50000000 --multi --mcmc_sample 1000000 --mcmc_burnin 1000000 --tree_file <input_tree> --output_file <output_prefix>`
*   **Parameters**:
    *   `--mcmc`: Total number of generations.
    *   `--mcmc_sample`: Sampling frequency.
    *   `--mcmc_burnin`: Number of initial samples to discard.
    *   `--mcmc_runs`: Run multiple independent chains (default is 2) to check for convergence.

## Input and Pre-processing

*   **Tree Rooting**: mPTP requires a rooted tree. If the tree is unrooted, specify outgroups to root it during execution.
    `--outgroup TAXA1,TAXA2`
*   **Outgroup Management**: Use `--outgroup_crop` to remove the outgroup from the delimitation results after rooting.
*   **Minimum Branch Length**: Very short or zero-length branches can interfere with likelihood calculations.
    *   Set manually: `--minbr 0.0001`
    *   Auto-detect: `--minbr_auto <alignment_file>` (uses the alignment to estimate the smallest significant branch length).

## Visualization and Output

*   **Tree Visualization**: Generate an SVG representation of the delimitation.
    `mptp --ml --multi --tree_file <input> --tree_show`
*   **SVG Customization**:
    *   `--svg_width <int>`: Adjust image width.
    *   `--svg_fontsize <int>`: Adjust label size.
    *   `--svg_legend_ratio <0..1>`: Control the space allocated for the legend.

## Expert Tips

*   **Convergence Check**: When running MCMC, compare the results of independent runs. If the Average Standard Deviation of Delimitation Support Values (ASDDSV) is high, increase the number of generations.
*   **Likelihood Ratio Test (LRT)**: If the GNU Scientific Library (GSL) is linked, mPTP can perform an LRT to determine if the multi-rate model fits significantly better than the single-rate model.
*   **Large Datasets**: mPTP is optimized for 64-bit multi-threaded systems; for very large trees, ensure the system has sufficient memory for the dynamic programming matrix.

## Reference documentation

- [mPTP Main Documentation](./references/github_com_Pas-Kapli_mptp.md)
- [mPTP Wiki Overview](./references/github_com_Pas-Kapli_mptp_wiki.md)