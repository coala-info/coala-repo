---
name: sts-smctc
description: The sts-smctc library provides a high-performance C++ template framework for implementing Sequential Monte Carlo algorithms with support for parallelization and advanced resampling. Use when user asks to install the library, compile SMC models with OpenMP, or configure resampling strategies and MCMC moves for statistical modeling.
homepage: https://github.com/matsengrp/smctc
metadata:
  docker_image: "quay.io/biocontainers/sts-smctc:1.0--h0704011_13"
---

# sts-smctc

## Overview
The `sts-smctc` library is a high-performance C++ template class framework designed for Sequential Monte Carlo (SMC) algorithms. It is a specialized fork of Adam M. Johansen's SMC Template Class, optimized for modern computational needs with features like OpenMP support and advanced resampling techniques. This skill enables the efficient setup and utilization of the library for complex statistical modeling, providing the necessary patterns for installation, compilation, and core algorithmic configuration.

## Installation and Environment Setup
The library is primarily distributed via the Bioconda channel. Ensure your environment is configured to access Bioconda before installation.

```bash
# Install the library using conda
conda install bioconda::sts-smctc
```

## Compilation and Build Patterns
Since `sts-smctc` is a C++ template library, usage involves including the headers in your source code and linking against necessary dependencies (like OpenMP).

### Using CMake
The library includes `CMakeLists.txt` support. A typical build pattern involves:

```bash
mkdir build && cd build
cmake ..
make
```

### Manual Compilation with OpenMP
To leverage the parallelization features added in the `sts-smctc` fork, ensure you enable OpenMP during compilation:

```bash
g++ -O3 -fopenmp my_smc_model.cpp -o smc_sim -lsmctc
```

## Core Algorithmic Components
When implementing models, focus on these primary functional areas provided by the library:

*   **Resampling Strategies**: The library supports multiple resampling methods to prevent particle degeneracy:
    *   Stratified Resampling (preferred for variance reduction)
    *   Systematic Resampling
    *   Fribblebits Resampling
*   **MCMC Moves**: Use MCMC moves within the SMC framework to maintain particle diversity. The library supports multiple MCMC moves and move selectors.
*   **ESS Management**: Monitor the Effective Sample Size (ESS) to trigger resampling. Note that setting the ESS threshold to 1.0 may require specific handling to avoid stability issues.
*   **Parallelization**: The library supports simple parallelization of MCMC and SMC steps over particles using OpenMP.

## Expert Tips
*   **Weight Scaling**: Use the global weight scaling features to prevent underflow/overflow issues when exponentiating weights in high-dimensional spaces.
*   **Particle History**: Utilize the auxiliary structs for tracking particle history if you need to reconstruct ancestral paths or trajectories.
*   **Variable Population**: The library allows for varying the population size; use this to balance computational cost and approximation accuracy dynamically.

## Reference documentation
- [sts-smctc - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_sts-smctc_overview.md)
- [matsengrp/smctc: Our fork of Adam M. Johansen's Sequential Monte Carlo Template Class](./references/github_com_matsengrp_smctc.md)
- [Commits · matsengrp/smctc](./references/github_com_matsengrp_smctc_commits_master.md)