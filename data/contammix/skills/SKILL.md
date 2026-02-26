---
name: contammix
description: The contammix tool uses a Bayesian mixture model to estimate the proportion of modern DNA contamination in ancient DNA samples. Use when user asks to estimate contamination levels in ancient DNA, run a Gibbs sampler for MCMC estimation, or assess the authenticity of sequencing reads.
homepage: https://github.com/plfjohnson/contamMix
---


# contammix

## Overview

The `contammix` tool is a specialized R-based package designed for ancient DNA (aDNA) bioinformatics. It addresses the critical challenge of modern DNA contamination by using a Bayesian mixture model to estimate the proportion of reads originating from an authentic ancient source versus a pool of potential contaminants. It utilizes a Gibbs sampler (written in C++) to perform Markov Chain Monte Carlo (MCMC) estimation, providing both a point estimate and a measure of uncertainty for the contamination level.

## Installation and Setup

The most efficient way to install `contammix` is via Bioconda:

```bash
conda install bioconda::contammix
```

Note that while the core logic is in C++ and Perl, the tool is wrapped as an R package. The primary execution script, `estimate.R`, is located within the R library directory where the package is installed.

## Core Workflow

To use `contammix` effectively, follow this sequence:

1.  **Generate Consensus**: Create a consensus sequence for your ancient sample.
2.  **Align Reads**: Align your sequencing reads (BAM format) to this consensus sequence (e.g., using `bwa`).
3.  **Prepare Contaminant Alignment**: Create a FASTA-formatted multiple alignment containing:
    *   The inferred consensus sequence of your sample.
    *   A set of potential contaminant genomes (e.g., a global panel of human mtDNA sequences).
    *   Tools like `mafft` or `muscle` are recommended for this step.
4.  **Run Estimation**: Execute the `estimate.R` script.

## Command Line Usage

The standard execution pattern uses the `estimate.R` script:

```bash
# Example command
estimate.R --samFn sample_reads.bam --malnFn contaminants_plus_consensus.fa --figure output_plots_prefix
```

### Key Arguments:
*   `--samFn`: Path to the BAM file containing reads aligned to the consensus.
*   `--malnFn`: Path to the FASTA multiple alignment of contaminants and the consensus.
*   `--figure`: Prefix for the output PDF containing diagnostic and results plots.
*   `--alpha`: (Optional) A hyperparameter for the prior. Tweak this if you encounter convergence issues.

## Expert Tips and Best Practices

*   **The 50% Assumption**: The underlying model assumes that contamination is less than 50%. If contamination exceeds this, the consensus sequence will likely represent the contaminant rather than the authentic sequence, violating the model's assumptions.
*   **Ambiguity Characters**: Ensure the consensus sequence does not contain ambiguity characters (e.g., N, R, Y) at variable sites. `contammix` ignores these positions, which can lead to the loss of the most informative sites for contamination estimation.
*   **MCMC Convergence**: Always inspect the generated figures. Look for:
    *   **Trace Plots**: Ensure the chains have mixed well and reached a stationary distribution.
    *   **Gelman-Rubin Diagnostic**: Check this statistic (provided in the output) to confirm convergence across multiple chains.
*   **Informative Sites**: The power of the tool depends on the number of sites where the authentic sequence differs from the potential contaminants. If the sample and contaminants are very similar, the credible intervals will be wider.

## Reference documentation
- [Bioconda contammix Overview](./references/anaconda_org_channels_bioconda_packages_contammix_overview.md)
- [contamMix GitHub README](./references/github_com_plfjohnson_contamMix.md)