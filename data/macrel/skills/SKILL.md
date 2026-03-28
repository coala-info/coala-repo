---
name: macrel
description: Macrel identifies and classifies antimicrobial peptides within genomic and metagenomic datasets. Use when user asks to predict antimicrobial peptides from sequences, mine contigs for small open reading frames, process raw metagenomic reads, or perform abundance profiling.
homepage: https://github.com/BigDataBiology/macrel
---

# macrel

## Overview

Macrel is a specialized pipeline designed for the identification and classification of antimicrobial peptides (AMPs) within genomic and metagenomic datasets. It excels at processing raw sequencing reads, assembled contigs, or pre-extracted peptide sequences to predict both antimicrobial potential and hemolytic activity. By leveraging machine learning models, Macrel provides a high-throughput solution for discovering novel bioactive molecules in complex biological samples.

## Core Workflows

### 1. Peptide Prediction and Classification
Use this mode when you already have a set of amino acid sequences and want to identify which ones are likely to be AMPs.

```bash
macrel peptides \
    --fasta input_peptides.faa \
    --output out_folder \
    --threads 4
```

### 2. Mining Contigs
Use this mode to predict small Open Reading Frames (smORFs) from nucleotide assemblies and classify them.

```bash
macrel contigs \
    --fasta assembly.fna \
    --output out_contigs
```
*   **Note**: This generates a prediction table, a FASTA file of predicted smORFs (≤ 100aa), and gene coordinates.

### 3. Metagenomic Read Processing
Use this mode to perform an end-to-end analysis starting from raw FASTQ reads. Macrel will handle assembly and gene prediction internally.

```bash
# Paired-end reads
macrel reads \
    -1 R1.fq.gz \
    -2 R2.fq.gz \
    --output out_metagenomics \
    --outtag sample_name

# Single-end reads
macrel reads \
    -1 reads.fq.gz \
    --output out_single_end
```

### 4. Abundance Profiling
Use this mode to map metagenomic reads against a reference database of AMPs to determine their relative abundance.

```bash
macrel abundance \
    -1 reads.fq.gz \
    --fasta reference_amps.faa \
    --output out_abundance
```

## Expert Tips and Best Practices

*   **Probability Thresholds**: Macrel considers any peptide with a probability ($p$) > 0.5 as an AMP. However, for high-confidence candidates, prioritize sequences with probabilities closer to 1.0.
*   **Resource Management**: Use the `--threads` flag to speed up processing, especially during the `reads` and `contigs` subcommands which involve assembly and gene prediction.
*   **Output Interpretation**: The main output table includes:
    *   `sequence`: The peptide sequence.
    *   `classification`: Structural/compositional class.
    *   `amp_prob`: Probability of being an AMP.
    *   `hemolytic`: Prediction of hemolytic activity.
    *   `hemo_prob`: Probability of being hemolytic.
*   **AMPSphere Integration**: Recent versions support querying AMPSphere. Use `--verbose` to track the progress of online or local database matching.
*   **Input Formats**: Macrel supports compressed FASTA/FASTQ files (`.gz`, `.bz2`, `.xz`).



## Subcommands

| Command | Description |
|---------|-------------|
| macrel | Macrel v1.6.0 |
| macrel | macrel v1.6.0 |
| macrel | macrel v1.6.0 |
| macrel | macrel v1.6.0 |
| macrel | Macrel command to execute (see documentation) |

## Reference documentation

- [Macrel GitHub README](./references/github_com_BigDataBiology_macrel_blob_main_README.md)
- [Macrel ChangeLog](./references/github_com_BigDataBiology_macrel_blob_main_ChangeLog.md)