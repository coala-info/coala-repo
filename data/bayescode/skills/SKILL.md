---
name: bayescode
description: BayesCode implements mutation-selection phylogenetic codon models to disentangle mutation bias from selective pressure. Use when user asks to estimate site-specific evolutionary rates, infer changes in effective population size along branches, detect variations in the omega ratio, or test for diversifying selection in quantitative traits.
homepage: https://github.com/ThibaultLatrille/bayescode
---


# bayescode

## Overview
BayesCode is a specialized toolset for researchers working with phylogenetic codon models. It implements mutation-selection frameworks that allow for the disentanglement of mutation bias and selective pressure. This skill provides guidance on selecting the appropriate sub-program for specific biological questions—such as estimating site-specific rates (omega) or tracking changes in population size across a phylogeny—and executing the MCMC-based analysis.

## Core Sub-programs
BayesCode is organized into specific binaries based on the desired evolutionary analysis:

- `mutselomega`: Used for gene and site-specific rates of evolution ($\omega$, $\omega_0$, $\omega_A^{phy}$, $\omega^*$) and selection coefficients ($S_0$).
- `nodemutsel`: Used to infer changes in effective population size ($N_e$) and mutation rate ($\mu$) along the branches of a phylogeny.
- `nodeomega`: Used to detect changes in the $\omega$ ratio along the phylogeny.
- `nodetraits`: Used to test for diversifying selection for a quantitative trait.

## Installation and Setup
The recommended way to install BayesCode is via Bioconda:
```bash
conda install -c conda-forge -c bioconda bayescode
```

## Common CLI Patterns
Most BayesCode programs follow a standard MCMC execution pattern.

### Running a Chain
To start an analysis, you typically provide a tree file and an alignment (or trait file):
```bash
mutselomega -t <tree_file> -d <alignment_file> <chain_name>
```
*Note: Replace `mutselomega` with the specific sub-program required for your analysis.*

### Resuming or Reading a Chain
BayesCode generates several output files based on the `<chain_name>`. To process the MCMC samples after a run:
```bash
readmutselomega <chain_name>
```
Use the `--output` flag to specify a custom path for the results:
```bash
readmutselomega --output <path/to/results> <chain_name>
```

## Best Practices
- **Chain Convergence**: As a Bayesian tool, always run multiple independent chains (e.g., `chain1`, `chain2`) and compare the posterior distributions to ensure convergence.
- **Data Formatting**: Ensure your phylogenetic tree is in Newick format and your alignments are in a compatible format (typically Phylip or Fasta, depending on the specific sub-program requirements).
- **Resource Management**: For large datasets or complex models (like `nodemutsel`), ensure sufficient computational time as MCMC convergence can be slow. Use `make tiny` during compilation if you only need a subset of the tools for specific environments.

## Reference documentation
- [BayesCode GitHub Repository](./references/github_com_ThibaultLatrille_bayescode.md)
- [BayesCode Wiki](./references/github_com_ThibaultLatrille_bayescode_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_bayescode_overview.md)