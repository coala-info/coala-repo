---
name: evofold2
description: evofold2 identifies conserved functional elements like RNA secondary structures by combining phylogenetic models with stochastic context-free grammars. Use when user asks to train directed factor graphs using expectation-maximization, evaluate posterior distributions of hidden variables, or perform evolutionary analysis on genomic sequences.
homepage: https://github.com/jakob-skou-pedersen/phy
metadata:
  docker_image: "quay.io/biocontainers/evofold2:0.1--0"
---

# evofold2

## Overview
The evofold2 toolset, built upon the `phy` C++ library, is designed for the evolutionary analysis of genomic sequences. It specializes in identifying conserved functional elements, such as RNA secondary structures, by combining phylogenetic models with Stochastic Context-Free Grammars (SCFGs). Use this skill to configure Directed Factor Graphs (DFGs), train models using Expectation-Maximization (EM), and evaluate posterior distributions of hidden variables across comparative genomic data.

## Core Workflows

### Model Training with dfgTrain
Use `dfgTrain` to estimate model parameters from observed data.

*   **Perform EM Training**: Execute training on a dataset to recover distribution parameters (e.g., Alpha and Beta values for Beta distributions).
    `dfgTrain --emTrain input_data.tab --writeInfo`
*   **Verify Parameter Recovery**: Check the output for the `ALPHAS` and `BETAS` blocks to ensure the model has converged on expected evolutionary rates or state distributions.

### Model Evaluation with dfgEval
Use `dfgEval` to perform inference and calculate likelihoods or posterior probabilities.

*   **Basic Evaluation**: Run evaluation against a specific model specification directory.
    `dfgEval input_data.tab -s model_spec_dir/`
*   **Handle Sample-Specific Observations**: Use subscription factors when variables like trial counts (N) and successes (X) vary by sample.
    `dfgEval input_data.tab -m - --subVarFile supplemental_data.tab -s model_spec_dir/`

## Configuration Patterns

### Defining Factor Potentials
Define the statistical distributions in a `factorPotentials.txt` file.

*   **Beta Distribution**: Specify `DIST: BETA` with `MIN: 0` and `MAX: 1`.
*   **Subscription Mapping**: Map internal model variables to columns in your data file using the `N:` and `X:` keys within the potential definition.

### Defining the Factor Graph
Map the relationship between hidden variables and potentials in `factorGraph.txt`.

*   **Node Assignment**: Use `NB1`, `NB2`, etc., to define the neighbors (variables) of a specific potential.
*   **Potential Linking**: Reference the `NAME` defined in your potentials file using the `POT:` key.

## Expert Tips
*   **Subscription Factors**: When modeling uncertainty in observed fractions, use subscription factors to allow the model to "subscribe" to specific variable names in a separate data file.
*   **Memory Efficiency**: For large-scale genomic scans, ensure your state maps are optimized; use `BINS` for continuous data to discretize the search space effectively.
*   **Windows Compatibility**: If working on Windows, manually resolve any symlinks in the `test/data` directories, as the `phy` library relies on specific directory structures for integration tests.



## Subcommands

| Command | Description |
|---------|-------------|
| dfgEval | dfgEval allows implementation of discrete factor graphs and evaluates the probability of data sets under these models. |
| dfgTrain | dfgTrain allows implementation of discrete factor graphs and evaluates the probability of data sets under these models. |

## Reference documentation
- [Phy Library Overview](./references/github_com_jakob-skou-pedersen_phy.md)
- [Beta Distribution Training](./references/github_com_jakob-skou-pedersen_phy_wiki_Beta-distribution.md)
- [Posterior Binomial Specification](./references/github_com_jakob-skou-pedersen_phy_wiki_Posterior-p-in-binomial.md)