---
name: seqwin
description: Seqwin identifies signature sequences that distinguish target microbial genomes from non-target genomes using a minimizer-based pan-genome graph. Use when user asks to discover diagnostic markers, identify unique genomic signatures using taxonomy names, or find specific sequences from local assembly files.
homepage: https://github.com/treangenlab/seqwin
---


# seqwin

## Overview

Seqwin is a high-performance toolkit designed to discover signature sequences that distinguish target microbial genomes from non-target "neighbor" genomes. It constructs a minimizer-based pan-genome graph to identify sequences with high sensitivity (conservation within targets) and high specificity (divergence from non-targets). It is optimized for speed and memory efficiency, capable of handling thousands of bacterial genomes in minutes.

## Installation

The recommended installation method is via Bioconda:

```bash
conda create -n seqwin seqwin --channel conda-forge --channel bioconda --strict-channel-priority
conda activate seqwin
```

## Core Workflows

### 1. Taxonomy-Based Identification
Use this when you have specific NCBI Taxonomy names. Names must be exact matches.

```bash
seqwin \
  -t "Salmonella enterica subsp. diarizonae" \
  -n "Salmonella enterica subsp. salamae" \
  -n "Salmonella bongori" \
  --threads 8
```

### 2. Local File-Based Identification
Use this when working with custom assemblies or genomes not yet in NCBI. Provide text files containing absolute or relative paths to FASTA files (one per line).

```bash
seqwin --tar-paths targets.txt --neg-paths non-targets.txt --threads 8
```

## Parameter Optimization

### Sensitivity and Specificity
*   **Stringency (`-s` or `--stringency`)**: Adjusts the auto-estimated node penalty threshold. Range is 0-10 (default 5). Higher stringency results in a lower threshold, typically yielding fewer but more specific signatures.
*   **Manual Threshold (`--penalty-th`)**: Manually set the penalty. Higher values allow for longer or more signatures but may decrease specificity.

### Sequence Resolution
*   **K-mer Length (`-k` or `--kmerlen`)**: Default is 21. Use shorter k-mers (e.g., 17) for highly variable genomes like viruses.
*   **Window Size (`-w` or `--windowsize`)**: Default is 200. Smaller windows increase resolution to find shorter signatures but increase memory and runtime.

### Performance Tuning
For large datasets (e.g., >10,000 genomes), use these flags to reduce runtime:
*   `--no-mash`: Skips Mash-based threshold estimation in favor of faster minimizer sketches.
*   `--no-blast`: Skips the final BLAST validation step. Note that `signatures.csv` will not contain conservation/divergence metrics if this is used.

## Output Interpretation

Results are stored in `seqwin-out/` (or the directory specified by `-o`):

*   **signatures.fasta**: The actual marker sequences, ranked by quality.
*   **signatures.csv**: Tabulated metrics including conservation (sensitivity) and divergence (specificity) scores.
*   **assemblies.csv**: A mapping file linking internal IDs to the original genome paths.

## Reference documentation
- [Seqwin GitHub Repository](./references/github_com_treangenlab_Seqwin.md)