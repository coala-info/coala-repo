---
name: migraine
description: The `migraine` tool provides a framework for likelihood-based inference in population genetics.
homepage: http://kimura.univ-montp2.fr/~rousset/Migraine.htm
---

# migraine

## Overview
The `migraine` tool provides a framework for likelihood-based inference in population genetics. It excels at fitting complex demographic models—such as those involving fluctuating population sizes or spatial structure—to genetic data. By leveraging importance sampling and the `blackbox` R package for smoothing the likelihood surface, it allows for the estimation of parameters like $2N\mu$, $2N\sigma^2$, and migration rates. This skill provides guidance on configuring the analysis, selecting appropriate models, and managing the computational workflow.

## Core Workflow and Models
The analysis typically involves preparing an input file (often in Genepop or Nexus format), running the `migraine` executable to generate point estimates of likelihood, and using the `blackbox` R package to find the maximum likelihood estimates (MLEs) and confidence intervals.

### Supported Demographic Models
- **OnePop**: The simplest model with $2N\mu$ as the unique parameter.
- **OnePopVarSize**: For populations with changing sizes; supports Generalized Stepwise Mutation (GSM) and Infinite Site Mutation (ISM) models.
- **OnePopFounderFlush**: Specifically for populations that underwent a bottleneck followed by rapid expansion.
- **Isolation by Distance (IBD)**: Fits 1D or 2D spatial models, including the island model as a subcase.
- **Two-Populations**: Analyzes divergence and migration between two distinct groups.

## Command Line Usage
`migraine` is primarily controlled via a settings file (usually named `settings.txt`) or direct CLI arguments.

### Basic Execution
To run an analysis with a settings file:
```bash
migraine -s settings.txt
```

### Key Parameters in Settings
- **DataFile**: Path to the input genetic data.
- **Model**: Specify the demographic model (e.g., `OnePopVarSize`, `IBD`).
- **MutationModel**: Set to `GSM` for microsatellites or `ISM` for sequences.
- **Nsim**: Number of simulations per point (increase for higher precision).
- **Npts**: Number of points in the parameter space to explore.

## Expert Tips
- **Iterative Refinement**: Start with a "short" run (lower `Nsim` and `Npts`) to ensure the settings are correct before committing to an "overnight" run for final publication-quality results.
- **Parallelization**: For complex three-parameter models, split the analysis across multiple CPU cores or computers by running independent instances with different random seeds and merging the resulting points for the `blackbox` analysis.
- **R Integration**: Ensure the `blackbox` R package is installed in your environment, as `migraine` relies on it for the final likelihood surface estimation.
- **Data Conversion**: Use the `Nexus2GP` helper program if your data is in Nexus format and needs conversion for specific `migraine` workflows.

## Reference documentation
- [Migraine Distribution Page](./references/kimura_univ-montp2_fr__rousset_Migraine.htm.md)
- [Bioconda Migraine Overview](./references/anaconda_org_channels_bioconda_packages_migraine_overview.md)