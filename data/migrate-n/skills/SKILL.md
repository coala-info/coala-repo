---
name: migrate-n
description: Migrate-n estimates population genetic parameters such as effective population size and migration rates using coalescent-based MCMC or importance sampling. Use when user asks to estimate gene flow, calculate effective population sizes, perform Bayesian inference on population models, or compare migration scenarios using Bayes Factors.
homepage: http://popgen.sc.fsu.edu/Migrate/Migrate-n.html
---


# migrate-n

## Overview
Migrate-n is a specialized tool for evolutionary biologists and population geneticists. It uses Markov Chain Monte Carlo (MCMC) or Importance Sampling to estimate parameters of a population model. Unlike simpler methods, it accounts for the history of the samples through the coalescent process, allowing for more robust estimates of gene flow and population size even with complex migration patterns.

## Core Usage Patterns

### Basic Execution
The tool typically looks for a parameter file named `parmfile` in the current directory.
```bash
# Run with default parmfile
migrate-n

# Run with a specific parameter file
migrate-n my_params
```

### Input Requirements
- **Infile**: Contains the actual sequence or microsatellite data.
- **Parmfile**: A text file containing all runtime options, model specifications, and search strategies.

### Common CLI Options
While most settings are in the `parmfile`, some flags are useful for environment setup:
- `-nomenu`: Bypasses the interactive menu (essential for cluster/batch jobs).
- `-p`: Specifies a custom parameter file name.

## Expert Tips and Best Practices

### Model Selection
- Use **Bayesian inference** (set in parmfile) over Maximum Likelihood for more reliable confidence intervals (Highest Posterior Density).
- When comparing models (e.g., "Is there migration between Pop A and Pop B?"), use the **Thermodynamic Integration** (Bezier approximation) to calculate Marginal Likelihoods for Bayes Factor comparison.

### MCMC Convergence
- **Burn-in**: Always discard the initial portion of the chain (e.g., 10,000 steps) to ensure the sampler has reached the stationary distribution.
- **Long Chains**: For publication-quality results, increase the number of recorded steps and the sampling increment to reduce autocorrelation.
- **Heating**: Use static or adaptive heating (multiple chains at different "temperatures") to prevent the MCMC from getting stuck in local optima.

### Parameter Constraints
- If you assume symmetric migration, you can constrain the migration matrix in the `parmfile` to reduce the number of parameters and improve convergence.
- For large datasets, start with a "short run" to estimate the range of Theta and M, then use those as starting values for a "long run."

## Reference documentation
- [Migrate-n Home Page](./references/popgen_sc_fsu_edu_Migrate_Migrate-n.html.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_migrate-n_overview.md)