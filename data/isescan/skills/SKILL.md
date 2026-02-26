---
name: isescan
description: "ISEScan is a computational pipeline that automates the identification and annotation of Insertion Sequence elements in prokaryotic genomes and metagenomes. Use when user asks to identify insertion sequences, find terminal inverted repeats, or annotate transposable elements in DNA sequences."
homepage: https://github.com/xiezhq/ISEScan
---


# isescan

## Overview
ISEScan is a Python-based computational pipeline designed to automate the identification of Insertion Sequence (IS) elements within DNA sequences. It is specifically optimized for prokaryotic genomes and metagenomes. The tool stands out by providing Terminal Inverted Repeat (TIR) sequences and handling both complete and fragmented IS elements. It operates by predicting proteomes from input DNA, searching against profile Hidden Markov Models (pHMMs) of transposases, and extending these hits into full IS elements based on known structural characteristics.

## Installation
The recommended method for installation is via Bioconda:
```bash
conda install bioconda::isescan
```

## Core Usage
The primary entry point is `isescan.py`. The input must be a DNA sequence file in FASTA format.

### Basic Command
```bash
isescan.py --seqfile genome.fasta --output results_dir
```

### Key Parameters and Options
- `--seqfile`: Path to the input FASTA file (supports multiple sequences/contigs).
- `--output`: Directory where results and intermediate files will be stored.
- `--nthread`: Number of threads to use for HMMER and FragGeneScan.
- `--is_only`: Report only complete IS elements (by default, ISEScan reports both complete and partial elements).

## Expert Tips and Best Practices

### Metagenomic Analysis
When processing metagenomic assemblies or highly fragmented draft genomes, always use the default mode (reporting both complete and partial elements). Partial elements are common in fragmented data where an IS element might be split across contig boundaries.

### Efficiency and Re-runs
If you need to re-run an analysis on the same genome with different parameters, you can skip the computationally expensive gene prediction and HMMER searching steps if the `results/proteome` directory already exists.
- Ensure the output directory remains the same to reuse the predicted `.faa` and `.hmm` hits.

### Handling Missing Elements
If a known IS element is not detected, it is often because the specific transposase family is not represented in the default pHMM models.
- **Custom Models**: You can manually add new transposase models to the `pHMMs` directory (`clusters.faa.hmm` and `clusters.single.fa`).
- **Manual Refinement**: You can manually replace or add gene boundaries and protein sequences in the `.faa` file located in `results/proteome` and re-run the pipeline to force the extension step on specific coordinates.

### Output Interpretation
ISEScan produces several high-utility files in the output directory:
- **.gff3**: Standard annotation format for integration with genome browsers (e.g., IGV, JBrowse).
- **.csv / .tsv**: Tabular summaries of identified IS elements, including coordinates and TIR sequences.
- **.fna**: FASTA file containing the nucleotide sequences of the identified IS elements.

### Sequence Requirements
- **Format**: Strictly FASTA.
- **Ambiguity**: Unknown bases (N) are permitted and handled by the pipeline.
- **Length**: No hard limit on sequence length, making it suitable for large bacterial chromosomes or complex metagenomic pools.

## Reference documentation
- [ISEScan GitHub Repository](./references/github_com_xiezhq_ISEScan.md)
- [ISEScan Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_isescan_overview.md)