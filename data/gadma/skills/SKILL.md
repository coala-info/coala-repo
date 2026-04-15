---
name: gadma
description: GADMA automatically infers the joint demographic history of multiple populations from genetic data using global and local search algorithms. Use when user asks to infer demographic models from allele frequency spectrum data, automate the discovery of population histories, or perform demographic inference using engines like dadi, moments, or momi2.
homepage: https://github.com/ctlab/GADMA
metadata:
  docker_image: "quay.io/biocontainers/gadma:2.0.3--pyhdfd78af_0"
---

# gadma

## Overview

GADMA (Genetic Algorithm for Demographic Model Analysis) is a command-line tool designed to infer the joint demographic history of multiple populations from genetic data, specifically Allele Frequency Spectrum (AFS) data. It addresses the limitations of manual model specification by using a global search (Genetic Algorithm or Bayesian Optimization) followed by local search refinement. This allows for the automatic discovery of complex demographic histories, including population splits, size changes, and migration events, across various simulation engines.

## Core Workflow

1.  **Data Preparation**: Convert genetic data into the format required by your chosen engine (e.g., a `.fs` file for dadi or moments).
2.  **Engine Selection**:
    *   **moments**: Recommended for most tasks due to its speed and support for up to 5 populations.
    *   **dadi**: Highly accurate, supports up to 5 populations, but can be slower than moments.
    *   **momi2**: Best for a large number of populations (supports ∞ populations).
    *   **momentsLD**: Use when working with Linkage Disequilibrium data rather than AFS.
3.  **Optimization Strategy**:
    *   For 1-3 populations: Use the default Genetic Algorithm (GA).
    *   For 4-5 populations: Use Bayesian Optimization (BO) to handle the increased computational cost.
4.  **Refinement**: GADMA typically performs a global search to find the general model structure, followed by a local search to fine-tune parameter values.

## CLI Usage and Best Practices

### Installation
The preferred method for installation is via Bioconda:
```bash
conda install -c bioconda gadma
```

### Common Execution Patterns
While GADMA relies on parameter files for detailed configuration, the primary interaction is through the CLI:

*   **Initial Run**: Execute GADMA with a specified parameter file to begin the inference process.
*   **Resuming**: If a run is interrupted, GADMA supports resuming from the last saved state. Ensure the output directory remains consistent.
*   **Model Specification**:
    *   **Automatic Inference**: Let GADMA find the structure for up to 3 populations.
    *   **Custom Models**: Provide a template for more than 3 populations or specific known histories.

### Expert Tips
*   **Engine Switching**: Start with the `moments` engine to rapidly explore the model space, then use the resulting parameters as a starting point for a `dadi` run if higher precision is required.
*   **Performance Tuning**: When using Bayesian Optimization for complex models (4+ populations), ensure you have sufficient computational resources as evaluations become significantly more time-consuming.
*   **Parameter Constraints**: When defining custom models, set realistic bounds for population sizes and times to prevent the algorithm from exploring biologically impossible regions of the parameter space.
*   **Result Validation**: Always run GADMA multiple times with different random seeds to ensure the genetic algorithm has converged on a global maximum rather than a local one.

## Reference documentation
- [GADMA GitHub Repository](./references/github_com_ctlab_GADMA.md)
- [Bioconda GADMA Overview](./references/anaconda_org_channels_bioconda_packages_gadma_overview.md)