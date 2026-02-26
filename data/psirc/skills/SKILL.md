---
name: psirc
description: psirc is a bioinformatics pipeline for the discovery, reconstruction, and quantification of full-length circular RNA isoforms using pseudo-alignment. Use when user asks to identify back-splice junctions, reconstruct circular RNA sequences, or quantify the abundance of circular and linear transcripts.
homepage: https://github.com/nictru/psirc
---


# psirc

## Overview
psirc (Pseudo-alignment identification of circular RNAs) is a specialized bioinformatics pipeline for the discovery and quantification of circular RNA isoforms. Unlike tools that only detect back-splice junctions, psirc reconstructs full-length circular sequences and provides a unified framework to quantify both linear and circular transcripts simultaneously. It relies on a specific forked version of kallisto for pseudo-alignment and a dedicated C++ tool, `psirc-quant`, for EM-based abundance estimation.

## Installation and Requirements
- **Input Data**: Requires paired-end FASTQ files (R1/R2). Single-end reads are not supported due to high false-positive rates in circRNA detection.
- **Library Prep**: Data must come from rRNA-depleted or exome-capture protocols; poly-A selection will remove most circular RNAs.
- **Dependencies**: Requires Perl, a forked version of kallisto (v0.43.1 modified), and the `psirc-quant` executable.

## Common CLI Patterns

### 1. Reference Preparation
Before running the pipeline, you must index your custom transcriptome FASTA.
```bash
perl psirc_v1.0.pl -i <custom_transcriptome.fa> <path_to_forked_kallisto>
```

### 2. BSJ Detection and FLI Inference
The recommended approach is to perform both back-splicing junction (BSJ) detection and full-length isoform (FLI) inference in a single command using the `-f` flag.
```bash
perl psirc_v1.0.pl -f -o <output_dir> <custom_transcriptome.fa> <path_to_forked_kallisto> <R1.fastq.gz> <R2.fastq.gz>
```

### 3. Quantification Workflow
Quantification is a two-step process using the `psirc-quant` tool.

**Step A: Index the inferred isoforms**
Note: Circular transcripts in the FASTA must have headers ending with `\tC`.
```bash
psirc-quant index -i <index_filename> <inferred_FLI_sequences.fa>
```

**Step B: Quantify abundances**
```bash
psirc-quant quant -i <index_filename> -o <output_dir> -t <threads> <R1.fastq.gz> <R2.fastq.gz>
```

## Expert Tips and Best Practices
- **Header Formatting**: If using FLI sequences from other tools, ensure circular transcript headers end with exactly `\tC`. The `psirc_v1.0.pl` script handles this automatically for its own outputs.
- **Forked Kallisto**: Do not use the standard upstream kallisto. psirc requires a specific fork of v0.43.1 that supports multi-threaded SAM output to stdout.
- **Memory Management**: For large human transcriptomes, ensure at least 32GB of RAM is available during the indexing and quantification phases.
- **Bias Correction**: When running `psirc-quant`, use the `--bias` flag to perform sequence-based bias correction, which often improves quantification accuracy for circular transcripts.
- **Bootstrap Sampling**: For downstream differential expression analysis, include `-b 100` (or more) in the `psirc-quant` command to generate bootstrap samples for uncertainty estimation.

## Reference documentation
- [psirc Overview](./references/anaconda_org_channels_bioconda_packages_psirc_overview.md)
- [psirc GitHub Repository](./references/github_com_nictru_psirc.md)