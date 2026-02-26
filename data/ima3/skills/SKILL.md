---
name: ima3
description: IMa3 models phylogenetic history and population genetic processes to estimate rooted trees while accounting for gene flow between populations. Use when user asks to estimate posterior distributions of phylogenies, infer population divergence with migration, or generate figures from IMa3 output files.
homepage: https://github.com/jodyhey/IMa3
---


# ima3

## Overview
IMa3 is a specialized tool for evolutionary genetics designed to solve the challenge of modeling phylogenetic history alongside population genetic processes. Unlike simpler models, it accounts for gene flow (migration) between populations while estimating rooted phylogenetic trees. It works by integrating over all possible Isolation-with-Migration models, making it suitable for complex demographic inference where population divergence and genetic exchange occur simultaneously.

## Installation and Compilation
The tool can be installed via Conda or compiled from source for specific environments:

*   **Conda**: `conda install bioconda::ima3`
*   **MPI Version (Parallel)**: Run `make` in the source directory to create the `IMa3` executable.
*   **Single Processor**: Run `make singlecpu` to create the `IMa3_singlecpu` executable.
*   **Testbed/Debug**: Use `make testbed` or `make debug` for development and troubleshooting.

## Command Line Usage and Best Practices
IMa3 is typically executed via the command line, with the MPI version being preferred for complex multi-population datasets to handle the computational load.

### Key Parameters and Flags
*   **Phylogeny Posterior (-j0)**: Use the `-j0` flag when the primary goal is to estimate the posterior distribution of the phylogeny.
*   **Chain Heating (-hb)**: This parameter controls the heating model for MCMC chains. 
    *   If you observe low swap rates between heated chains, use or increase the `-hb` value.
    *   Recent updates suggest that while higher `-hb` values might lower raw swap rates, they often improve overall mixing of the chains.
*   **Swap Intervals**: The program defaults to attempting chain swaps every 5th step to optimize mixing.

### Visualization
For post-analysis visualization, the package includes `IMfig.py`. This script is used to generate figures from IMa3 output files.
*   **Usage**: `python IMfig.py [args]`
*   **Note**: Ensure you are using the latest version of `IMfig.py` which supports argument passing for better integration into automated pipelines.

### Expert Tips
*   **Mixing Issues**: If the program hangs or shows poor convergence, check the genealogy probability assessments. Recent bug fixes addressed issues where the program could hang during these calculations.
*   **Migration Arrays**: In long runs with high migration rates, monitor for crashes related to filled migration arrays. If this occurs, consider thinning the sampling or adjusting priors.
*   **Prior Files**: Ensure prior files are formatted correctly; a common source of runtime errors is a bug in reading the prior file which was addressed in version 1.13.

## Reference documentation
- [bioconda / ima3](./references/anaconda_org_channels_bioconda_packages_ima3_overview.md)
- [jodyhey/IMa3 GitHub Repository](./references/github_com_jodyhey_IMa3.md)