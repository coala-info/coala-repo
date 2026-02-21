---
name: prosampler
description: ProSampler is a high-performance motif-finding tool designed to handle the massive sequence sets typical of modern ChIP-seq experiments.
homepage: https://github.com/zhengchangsulab/ProSampler
---

# prosampler

## Overview

ProSampler is a high-performance motif-finding tool designed to handle the massive sequence sets typical of modern ChIP-seq experiments. It identifies overrepresented DNA sequences (motifs) by comparing input sequences against a background model. The tool utilizes a combination of Gibbs sampling and significance testing to produce accurate binding site predictions and position-specific weight matrices (PWMs) with significantly higher speed than traditional motif finders.

## Installation and Setup

The most efficient way to install ProSampler is via Bioconda:

```bash
conda install bioconda::prosampler
```

If compiling from source, ensure `ProSampler.cc` and `Markov3.cc` are in the same directory:

```bash
g++ -O2 -o ProSampler ProSampler.cc
chmod +x ProSampler
```

## Common CLI Patterns

### Basic Motif Discovery
Run ProSampler with default settings (3rd order Markov background, 9bp seed length, searching both strands):

```bash
prosampler -i input_sequences.fa -o output_prefix
```

### Using a Specific Background
If you have a pre-defined background set (e.g., non-peak regions or genomic averages), provide it with the `-b` flag:

```bash
prosampler -i input_sequences.fa -b background_sequences.fa -o output_prefix
```

### Adjusting Motif Specificity
To find longer motifs or adjust the sensitivity of the initial seed:

```bash
# Search for 12bp seeds instead of the default 9bp
prosampler -i input_sequences.fa -k 12 -o output_prefix

# Increase the significance threshold (z-value) for k-mers
prosampler -i input_sequences.fa -t 10.0 -o output_prefix
```

## Parameter Reference and Best Practices

### Input/Output
- `-i`: Input file must be in FASTA format.
- `-o`: Prefix for output files. ProSampler generates three files:
    - `.meme`: Position specific weight matrices (compatible with MEME suite).
    - `.site`: Specific binding site locations.
    - `.spic`: Input format for the SPIC program.

### Background Modeling
- `-b`: If a file is not provided, you can specify the Markov model order (0, 1, 2, or 3). 
- **Tip**: Use `-b 3` (default) for the highest consistency between input and output nucleotide frequencies when a background file is unavailable.

### Search Constraints
- `-p`: Set to `1` for single-strand search (e.g., RNA-seq or specific assays) or `2` (default) for both strands.
- `-m`: Limit the number of reported motifs if you only need the top candidates.
- `-d`: Hamming distance cutoff (default 1). Increase this if you expect highly degenerate motifs.

### Significance Tuning
- `-t`: The primary z-value cutoff for significant k-mers (default 8.0).
- `-w`: The lower z-value cutoff for subsignificant k-mers (default 4.5).
- `-z`: Cutoff for extending motif lengths (default 1.96).

## Reference documentation
- [ProSampler README](./references/github_com_zhengchangsulab_ProSampler_blob_master_README.md)
- [Bioconda ProSampler Overview](./references/anaconda_org_channels_bioconda_packages_prosampler_overview.md)