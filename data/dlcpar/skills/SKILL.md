---
name: dlcpar
description: DLCpar is a specialized phylogenetic toolset used to infer the most parsimonious reconciliation between a gene tree and a species tree.
homepage: https://github.com/wutron/dlcpar
---

# dlcpar

## Overview
DLCpar is a specialized phylogenetic toolset used to infer the most parsimonious reconciliation between a gene tree and a species tree. Unlike standard duplication-loss models, DLCpar incorporates the Labeled Coalescent Tree (LCT) framework to account for deep coalescence (incomplete lineage sorting). This skill assists in navigating the various reconciliation methods provided by the package, including Integer Linear Programming (ILP) solvers and cost landscape analysis.

## Core Commands and Workflows

The `dlcpar` package consists of several primary executables. Always use the `-h` or `--help` flag with any command to see specific argument requirements.

### 1. Standard Reconciliation (`dlcpar`)
Use this for basic parsimony reconciliation. It maps gene tree nodes to species tree nodes and identifies specific evolutionary events.
- **Primary Use**: Finding the Most Parsimonious Reconciliation (MPR).
- **Key Feature**: Uses LCTs to distinguish between duplications and coalescence events.

### 2. ILP-Based Reconciliation (`dlcilp`)
Use this when you require an Integer Linear Programming approach to solve the reconciliation problem.
- **Optimization**: Useful for complex constraints or when seeking exact solutions via solvers like CPLEX or GLPK.
- **Performance Tuning**: You can specify the number of threads and memory limits for the ILP solver to handle larger datasets.

### 3. Cost Landscape Analysis (`dlcpar landscape`)
Use this to explore how sensitive a reconciliation is to the relative costs assigned to duplication, loss, and coalescence events.
- **Pareto-Optimality**: Identifies reconciliations that are optimal across a range of event costs.
- **Output**: Partitions the "landscape" of event costs into regions where different reconciliations are optimal.

### 4. Multiple Optimal Reconciliations
When a single MPR is insufficient, DLCpar supports:
- **Counting**: Determining the total number of optimal reconciliations.
- **Uniform Random Sampling**: Generating a representative set of optimal reconciliations to assess uncertainty.

## Expert Tips and Best Practices

- **Event Counting**: You can configure the tool to count coalescence events separately from other events to better understand the impact of incomplete lineage sorting on your data.
- **Search Functionality**: Use `dlcpar_search` for tasks involving tree searching or exploring reconciliation space, though note that LCT conversion may be limited for non-dated trees.
- **Solver Selection**: If using `dlcilp`, ensure your environment has a compatible ILP solver installed (e.g., CPLEX) and use the rounding options if the solver exhibits integrality relaxation issues.
- **Memory Management**: For large-scale genomic reconciliations, explicitly set memory limits in the ILP solver to prevent process termination.

## Reference documentation
- [Main Repository Overview](./references/github_com_wutron_dlcpar.md)
- [Commit History and Feature Updates](./references/github_com_wutron_dlcpar_commits_master.md)