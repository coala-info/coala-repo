---
name: bioconductor-ternarynet
description: This tool estimates ternary network models from steady-state perturbation data using a Bayesian approach and a replica exchange algorithm. Use when user asks to fit Boolean-like networks with three-state nodes, estimate network structures from perturbation experiments, or model gene regulatory networks using ternary logic.
homepage: https://bioconductor.org/packages/release/bioc/html/ternarynet.html
---

# bioconductor-ternarynet

name: bioconductor-ternarynet
description: Estimate ternary network models from steady-state perturbation data using a computational Bayesian approach and replica exchange algorithm. Use this skill when you need to fit Boolean-like networks where nodes have three states (-1, 0, 1) and you have experimental data involving specific node perturbations.

# bioconductor-ternarynet

## Overview

The `ternarynet` package implements a Bayesian algorithm to estimate ternary networks (where nodes exist in states -1, 0, or +1) from perturbation data. It uses a parallelized replica exchange Monte Carlo algorithm to find the best-fitting network structure and transition rules based on a provided cost function (typically Hamming distance).

## Core Workflow

### 1. Data Preparation
The primary input is an `experiment_set` data frame. It must contain exactly five columns:
- `i_exp`: Integer experiment index (0 to $N_{exp}-1$).
- `i_node`: Integer node index (0 to $N_{node}-1$).
- `outcome`: The observed state (-1, 0, or +1).
- `value`: The cost associated with that outcome (e.g., if using Hamming distance and the observed state is +1, the costs for outcomes -1, 0, and +1 would be 2, 1, and 0 respectively).
- `is_perturbation`: Boolean/Integer (0/1) indicating if the node was specifically perturbed in that experiment.

### 2. Model Fitting
Use the `parallelFit` function to execute the replica exchange algorithm.

```r
library(ternarynet)

# Example call
results <- parallelFit(
  experiment_set = indata,
  max_parents = 1,          # Max parents per node
  n_cycles = 100000,        # MC cycles
  n_write = 10,             # Output frequency
  T_lo = 0.001,             # Low temp for replica
  T_hi = 2.0,               # High temp for replica
  target_score = 0,         # Termination threshold
  n_proc = 1,               # Number of replicas
  logfile = 'fit.log'
)
```

### 3. Interpreting Results
`parallelFit` returns a list of results for each replica. Usually, you want the first element (lowest temperature).

- `unnormalized_score`: Total cost of the fit.
- `normalized_score`: Score divided by (nodes * experiments).
- `parents`: A matrix where each row contains the parent indices for the corresponding node.
- `outcomes`: An array describing the transition rules (the outcome of a node for every possible configuration of its parents).

### 4. Seeding and Refinement
- **Seeding**: You can provide a `callback` function (e.g., `function(replicate) set.seed(replicate)`) to ensure different seeds for different replicas.
- **Refining**: You can restart a fit using previous results by passing `init_parents` and `init_outcomes` to `parallelFit`.

## Key Parameters for Tuning
- `max_parents`: Increasing this exponentially increases the state space of transition rules.
- `exchange_interval`: Steps between attempting to swap replicas (default 1000).
- `max_states`: Maximum states to propagate to find a steady-state repetition (default 10).

## Reference documentation
- [A Computational Bayesian Approach to Ternary Network Estimation](./references/ternarynet.md)