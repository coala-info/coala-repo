---
name: bppsuite
description: bppsuite is a modular collection of command-line tools for phylogenetics and molecular evolution research. Use when user asks to estimate model parameters, simulate molecular sequences, reconstruct ancestral states, or compute population genetics statistics.
homepage: https://github.com/BioPP/bppsuite
---


# bppsuite

## Overview

The bppsuite is a modular collection of command-line tools designed for phylogenetics and molecular evolution research. Built upon the Bio++ libraries, it allows for sophisticated modeling of sequence evolution, including non-stationary and non-homogeneous models. Use this skill to navigate the various executables within the suite, manage environment configurations, and execute core bioinformatics workflows such as model fitting, sequence simulation, and ancestral state reconstruction.

## Core Executables

The suite consists of several specialized programs. Choose the appropriate tool based on the task:

- **bppml**: The primary tool for Maximum Likelihood estimation of model parameters and tree branch lengths.
- **bppseqgen**: Used for simulating molecular sequences along a given phylogenetic tree under specific evolutionary models.
- **bppancestor**: Performs ancestral sequence reconstruction based on a fitted model and a phylogenetic tree.
- **bppbranchlik**: Calculates likelihoods for specific branches, often used for detailed model testing.
- **bppPopStats**: Computes various population genetics statistics from sequence data.
- **SeqMan**: A utility for sequence data management, indexing, and format conversion.

## Command Line Usage

### Environment Setup
Before running bppsuite tools, ensure the Bio++ dynamic libraries are accessible to the system.
- Set the library path: `export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/path/to/bpp/lib`
- Verify dependencies for an executable: `ldd $(which bppml)`

### Execution Pattern
Most bppsuite tools follow a standard execution pattern using parameter files or direct key-value arguments.
- Execute using a parameter file: `bppml param=my_analysis.bpp`
- Override or provide parameters directly: `bppseqgen input.sequence.file=data.fasta model=JC69`

## Best Practices and Tips

- **Parameter Files**: Always prefer using `.bpp` or `.prm` parameter files for complex analyses to ensure reproducibility.
- **Node Identification**: When using `bppancestor`, ensure the output trees include node IDs for correct mapping of reconstructed states.
- **Sequence Indexing**: For large-scale sequence management in `SeqMan`, utilize the `output.index.file` option to maintain efficient access to data subsets.
- **Precision**: For likelihood calculations in `bppbranchlik`, be aware that the tool defaults to high precision (often 12 decimal places) for log-likelihood outputs.
- **Library Dependencies**: The suite requires `bpp-core`, `bpp-seq`, `bpp-phyl`, and `bpp-popgen` libraries. If compiling from source, install these in a common prefix.



## Subcommands

| Command | Description |
|---------|-------------|
| bppancestor | Bio++ Ancestral Sequence Reconstruction |
| bppml | Bio++ Maximum Likelihood Computation |
| bppseqgen | Bio++ Sequence Generator |

## Reference documentation

- [Bio++ Program Suite Overview](./references/github_com_BioPP_bppsuite.md)
- [Recent Updates and Feature Changes](./references/github_com_BioPP_bppsuite_commits_master.md)