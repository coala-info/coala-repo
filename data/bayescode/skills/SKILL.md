---
name: bayescode
description: BayesCode is a Bayesian MCMC framework for molecular evolution studies that implements mutation-selection models and phylogenetic comparative methods. Use when user asks to estimate selection coefficients, infer changes in effective population size, detect variations in dN/dS ratios across branches, or correlate phenotypic traits with molecular evolutionary rates.
homepage: https://github.com/ThibaultLatrille/bayescode
---

# bayescode

## Overview

BayesCode is a specialized suite of C++ tools designed for advanced molecular evolution studies. It implements mutation-selection models and phylogenetic comparative methods within a Bayesian MCMC framework. It is particularly effective for researchers needing to disentangle the effects of mutation, selection, and genetic drift across different lineages or specific sites within a gene. The toolset allows for the estimation of dN/dS ratios (omega), selection coefficients (S), and the correlation between phenotypic traits and molecular evolutionary rates.

## Data Preparation

Before running BayesCode, ensure your input files meet the following requirements:

- **Alignment File**: Must be in **Phylip** format. Sequences must be protein-coding DNA with a total length that is a multiple of 3 (codons).
- **Tree File**: Must be in **Newick** format. Leaf names must exactly match the sequence identifiers in the alignment file. Branch lengths are optional for some models but recommended for others.
- **Trait File**: For `nodetraits`, provide a tab-separated file (.tsv) mapping species names to quantitative trait values.

## Core Command Line Tools

### 1. mutselomega
Used for gene and site-specific rates of evolution and selection coefficients.
- **Primary Use**: Estimating $\omega$, $\omega_0$, and selection coefficients ($S_0$).
- **Execution**: `mutselomega -t <tree> -d <alignment> <chain_name>`

### 2. nodemutsel
Used for inferring changes in effective population size ($N_e$) and mutation rate ($\mu$) along the phylogeny.
- **Execution**: `nodemutsel -t <tree> -d <alignment> <chain_name>`

### 3. nodeomega
Used for detecting changes in $\omega$ across different branches of the tree.
- **Execution**: `nodeomega -t <tree> -d <alignment> <chain_name>`

### 4. nodetraits
Used to test for diversifying selection for a quantitative trait.
- **Execution**: `nodetraits -t <tree> -d <alignment> -x <trait_file> <chain_name>`

## Post-Analysis and MCMC Diagnostics

After running a chain, use the corresponding `read` tools (e.g., `readmutselomega`, `readnodemutsel`) to process the MCMC output:

- **Burn-in and Subsampling**: Always specify a burn-in period and a frequency for subsampling to ensure posterior estimates are based on a converged and non-autocorrelated sample.
  - Example: `readmutselomega -b 100 -f 10 <chain_name>`
- **Convergence**: It is best practice to run at least two independent chains and compare their outputs to ensure convergence.
- **Output Redirection**: Use the `--output` flag in read commands to specify a custom path for the resulting statistics and trace files.

## Expert Tips

- **Compilation**: For standard usage, `make tiny` is sufficient and compiles the core tools. If you require high-performance parallelization for large datasets, ensure an MPI environment is available and use `make release`.
- **Data Conversion**: If your data is in Fasta format, use the provided `fasta_to_ali.py` script to convert it to the required Phylip format.
- **Binary Location**: After compilation, all executables are located in the `bin/` directory. Add this to your PATH for easier access.



## Subcommands

| Command | Description |
|---------|-------------|
| mutselomega | A tool for analyzing codon models with multiple Omegas. |
| nodemutsel | DatedMutSel |
| nodeomega | DatedNodeOmega |
| nodetraits | Processes traits for nodes in a phylogenetic tree. |
| readmutselomega | Computes posterior probabilities of ω and ω₀, and related statistics. |

## Reference documentation

- [BayesCode Wiki Home](./references/github_com_ThibaultLatrille_bayescode_wiki.md)
- [Installation Guide](./references/github_com_ThibaultLatrille_bayescode_wiki_1.-installation.md)
- [Data Formatting](./references/github_com_ThibaultLatrille_bayescode_wiki_2.-format-your-data.md)
- [Running BayesCode](./references/github_com_ThibaultLatrille_bayescode_wiki_3.-run-bayescode.md)