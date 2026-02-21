---
name: biasaway
description: BiasAway is a specialized bioinformatics tool used to generate control sequence sets that match the composition of a target set of genomic sequences.
homepage: https://github.com/asntech/biasaway
---

# biasaway

## Overview
BiasAway is a specialized bioinformatics tool used to generate control sequence sets that match the composition of a target set of genomic sequences. In enrichment analysis, using a random background can lead to false positives if the target sequences have specific properties (e.g., high GC content). BiasAway mitigates this by providing four distinct models to create backgrounds through either k-mer shuffling or selection from a genomic pool based on GC distribution.

## Command Line Usage

The tool follows a subcommand-based structure: `biasaway <subcommand> [options]`.

### Core Subcommands
- **k**: Performs global k-mer shuffling of the input sequences.
- **w**: Performs k-mer shuffling within a sliding window to preserve local composition.
- **g**: Selects background sequences from a provided genomic pool based on the overall %GC distribution of the target set.
- **c**: Selects background sequences from a genomic pool based on both %GC distribution and local %GC composition within a sliding window.

### Common Patterns

**1. Generating a Shuffled Background (Global)**
To generate a background by shuffling the input sequences while preserving dinucleotide frequency (k=2):
```bash
biasaway k -f target_sequences.fa -k 2 > background.fa
```

**2. Generating a Shuffled Background (Sliding Window)**
To preserve local sequence context during shuffling:
```bash
biasaway w -f target_sequences.fa -k 2 -w 100 -s 50 > background.fa
```
*Note: `-w` defines the window size and `-s` defines the step size.*

**3. Selecting GC-Matched Genomic Backgrounds**
To pick sequences from a large genomic pool that match the GC profile of your target:
```bash
biasaway g -f target_sequences.fa -g genome_pool.fa > background.fa
```

### Expert Tips
- **Seed for Reproducibility**: Use the `--seed` argument (if available in your version) or ensure your environment is consistent, as shuffling is a stochastic process.
- **Input Handling**: BiasAway supports reading from `stdin`. You can pipe sequences directly from other tools:
  ```bash
  cat sequences.fa | biasaway k -k 2 > shuffled.fa
  ```
- **Quality Control**: After generating a background, it is best practice to verify the GC distribution matches your target using a simple script or the built-in QC plotting features if the environment supports graphical output.
- **K-mer Selection**: For most transcription factor motif analyses, `k=2` (dinucleotide shuffling) is the standard to account for CpG island biases.

## Reference documentation
- [BiasAway Overview](./references/anaconda_org_channels_bioconda_packages_biasaway_overview.md)
- [BiasAway GitHub Repository](./references/github_com_asntech_biasaway.md)