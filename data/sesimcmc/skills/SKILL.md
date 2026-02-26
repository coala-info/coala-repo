---
name: sesimcmc
description: The sesimcmc tool uses a modified MCMC algorithm to identify recurring motifs within biological sequences. Use when user asks to find unknown patterns in DNA or protein sequences, perform blind motif searching, or identify regulatory elements using Gibbs sampling.
homepage: http://favorov.bioinfolab.net/SeSiMCMC/
---


# sesimcmc

## Overview
The sesimcmc tool implements a modified MCMC algorithm designed to find motifs (short, recurring patterns) within biological sequences. It is particularly effective for "blind" motif searching where the exact pattern is unknown. It balances the sensitivity of Gibbs sampling with modifications that improve convergence and help avoid local optima during the search process.

## Usage Guidelines

### Installation
The tool is primarily distributed via Bioconda. Ensure the environment is configured with the necessary channels:
```bash
conda install -c bioconda sesimcmc
```

### Basic Command Structure
The tool typically requires an input FASTA file containing the sequences to be searched. While specific parameter flags can vary by version, the core execution follows this pattern:
```bash
sesimcmc [options] -i input_sequences.fasta
```

### Key Parameters and Best Practices
*   **Motif Length**: If the expected length of the regulatory element is known, specify it to narrow the search space.
*   **Background Model**: Use a background Markov model that matches the GC content of the organism being studied to reduce false positives.
*   **Strand Orientation**: For DNA sequences, ensure the search considers both the forward and reverse-complement strands unless the motif is known to be strand-specific.
*   **Multiple Runs**: Because MCMC is a stochastic process, run the tool multiple times with different random seeds to ensure the discovered motifs are consistent and not artifacts of a single run.

### Interpreting Results
*   **Information Content**: Look for motifs with high information content (measured in bits), as these represent stronger biological signals.
*   **P-values/E-values**: Prioritize motifs with low statistical significance scores, which indicate the pattern is unlikely to have occurred by chance.

## Reference documentation
- [sesimcmc Overview](./references/anaconda_org_channels_bioconda_packages_sesimcmc_overview.md)