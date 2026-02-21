---
name: tracer
description: Tracer is the standard diagnostic tool for assessing the quality of Bayesian phylogenetic inferences.
homepage: http://beast.community/tracer
---

# tracer

## Overview

Tracer is the standard diagnostic tool for assessing the quality of Bayesian phylogenetic inferences. It transforms raw MCMC sample logs into interpretable statistics and visualizations. Use this skill to determine if a chain has reached stationarity, decide if a run needs to be extended, or compare multiple independent runs to ensure they have converged on the same posterior distribution.

## Core Diagnostics and Workflows

### 1. Assessing Convergence and Mixing
The primary goal of using Tracer is to ensure the MCMC chain has sampled the target distribution effectively.
- **Effective Sample Size (ESS):** Aim for an ESS > 200 for all parameters. An ESS < 100 (often highlighted in red) indicates poor mixing and suggests the chain needs to run longer or the transition kernels need adjustment.
- **Trace Plot:** Inspect the "Trace" panel for "hairy caterpillar" behavior. A trend (upward or downward) suggests the chain has not reached stationarity and requires a larger burn-in.
- **Burn-in:** By default, Tracer often assumes a 10% burn-in. Adjust this value if the initial part of the chain shows a clear climb toward the posterior plateau.

### 2. Comparing Multiple Runs
Loading multiple independent `.log` files (replicates) is the most robust way to identify convergence issues.
- **Combined Trace:** Tracer automatically creates a "Combined" trace when multiple files with the same parameters are loaded.
- **Bimodality:** If the combined posterior distribution is bimodal, the replicates have likely converged to different local optima.
- **Visual Comparison:** Use the "Marginal Density" or "Estimates" panels (selecting multiple files) to overlay distributions. If the density plots do not overlap significantly, the runs have not converged to the same distribution.

### 3. Visualization Types
- **Estimates:** Provides mean, median, and Highest Posterior Density (HPD) intervals. Use "Violin plots" or "Box plots" for comparing parameter estimates across different models or runs.
- **Density:** Shows the frequency distribution of the sampled parameters. Useful for checking for normality or multi-modality.
- **Joint Probability:** Use the "Joint Marginal" tab to visualize correlations between two different parameters.

## Expert Tips
- **Topology Metrics:** While Tracer handles continuous parameters, use **TopologyTracer** to generate `.log` files for tree metrics (like tree length or clade frequencies), which can then be loaded into Tracer for topological convergence diagnostics.
- **Large Files:** For extremely large log files that slow down the GUI, consider sub-sampling the log file using a script before loading, ensuring you still have enough samples for a valid ESS.
- **Kernel Density Estimation (KDE):** Tracer uses KDE to smooth marginal density plots. If the distribution looks jagged, it usually indicates an insufficient number of samples.

## Reference documentation
- [Tracer Overview](./references/beast_community_tracer.md)
- [Identifying convergence problems using Tracer](./references/beast_community_tracer_convergence.md)