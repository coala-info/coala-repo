---
name: dinf
description: dinf performs population genetics parameter inference by training neural networks to distinguish between real and simulated datasets. Use when user asks to infer demographic parameters, train a discriminator, run adversarial Monte Carlo simulations, or visualize posterior distributions.
homepage: https://github.com/RacimoLab/dinf
metadata:
  docker_image: "quay.io/biocontainers/dinf:0.5.0--pyhdfd78af_0"
---

# dinf

## Overview

dinf is a specialized tool for population genetics that performs parameter inference by leveraging neural networks as discriminators. Instead of using traditional summary statistics, it trains a discriminator to distinguish between a target (real) dataset and a simulated dataset. Inference is achieved by identifying the simulation parameters that produce data most similar to the target, effectively making the simulated data indistinguishable to the neural network. This approach is particularly useful for complex demographic models where likelihood functions are difficult to compute.

## CLI Usage and Patterns

The `dinf` toolset consists of three primary executables: `dinf` (core logic), `dinf-plot` (visualization), and `dinf-tabulate` (data processing).

### Core Inference Workflow

Always specify the simulation model and the discriminator architecture using the `-m` and `-d` flags.

*   **Training a Discriminator**:
    `dinf --model model.py --discriminator disc.py train --output-file discriminator.flax`
*   **Monte Carlo Inference (formerly SMC)**:
    `dinf --model model.py --discriminator disc.py mc --iterations 10 --output-prefix my_inference`
*   **MCMC Inference**:
    `dinf --model model.py --discriminator disc.py mcmc --epochs 100`

### Data Tabulation and Plotting

*   **Tabulate Results**: Use `dinf-tabulate` to convert raw inference output into a readable format.
    `dinf-tabulate my_inference.h5 > results.csv`
*   **Visualize Posterior Distributions**:
    `dinf-plot hist my_inference.h5`
*   **Check Convergence/Entropy**:
    `dinf-plot entropy my_inference.h5`

## Best Practices and Expert Tips

*   **Feature Matrix Selection**: Choose the appropriate matrix type for your genomic data. Use `BinnedHaplotypeMatrix` for standard `dinf` workflows or `HaplotypeMatrix` for workflows mimicking the PG-GAN style.
*   **Neural Network Architectures**: For population genetic data, use permutation-invariant architectures. `ExchangeableCNN` is the default for single populations, while multi-population versions are available for complex demographic scenarios.
*   **Performance Optimization**: `dinf` uses JAX and Flax. Ensure your environment is configured for GPU acceleration if available, as training discriminators on millions of simulations is computationally intensive.
*   **KDE Reflection**: When plotting results with `dinf-plot`, the tool uses Kernel Density Estimation (KDE) with reflection to prevent density drops at the edges of the parameter support.
*   **Lazy Imports**: The CLI is designed to be responsive by lazily importing heavy libraries like SciPy; however, the first execution of a complex model may still have a slight lag.



## Subcommands

| Command | Description |
|---------|-------------|
| dinf mc | Adversarial Monte Carlo. |
| dinf mcmc | Adversarial MCMC. |
| dinf pg-gan | PG-GAN style simulated annealing. |
| dinf predict | Make predictions using a trained discriminator. |
| dinf train | Train a discriminator. |
| dinf_check | Basic dinf_model health checks. |

## Reference documentation

- [README](./references/github_com_RacimoLab_dinf_blob_main_README.md)
- [Changelog](./references/github_com_RacimoLab_dinf_blob_main_CHANGELOG.md)
- [Setup Configuration](./references/github_com_RacimoLab_dinf_blob_main_setup.cfg.md)