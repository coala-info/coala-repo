---
name: terrace
description: TERRACE reconstructs full-length circular RNA transcripts from paired-end RNA-seq data using a machine-learning framework. Use when user asks to assemble circular RNA sequences, assign confidence scores to circRNA transcripts, or identify back-splice junctions from sorted BAM files.
homepage: https://github.com/Shao-Group/TERRACE
---


# terrace

## Overview
TERRACE is a specialized bioinformatic assembler designed to reconstruct circular RNA (circRNA) transcripts from paired-end RNA-seq data. Unlike simple detection tools that only identify back-splice junctions, TERRACE attempts to assemble the full circular sequence. It is most effective when used with high-quality alignments and provides a machine-learning framework (Random Forest) to assign confidence scores to the reconstructed transcripts.

## Installation and Setup
The most reliable way to install TERRACE is via Bioconda:
```bash
conda install bioconda::terrace
```

## Core Command Line Usage
The basic syntax for running TERRACE requires a sorted BAM file, a reference genome, and the read length used in the sequencing run.

### Basic Assembly
```bash
terrace -i input.sort.bam -o output.gtf -fa reference_genome.fa --read_length 150
```

### Parameters
- `-i`: Input alignment file in BAM format. **Must be sorted.**
- `-o`: Output file path for the reconstructed transcripts (GTF format).
- `-fa`: Reference genome file in FASTA format (e.g., GRCh38).
- `--read_length`: The exact length of the paired-end reads.
- `-r`: (Optional) Reference annotation file in GTF format to improve assembly accuracy.
- `-fe`: (Optional) Path to output a feature file used for subsequent Random Forest scoring.

## Expert Tips and Best Practices

### 1. Mandatory BAM Sorting
TERRACE requires the input BAM to be coordinate-sorted. If your aligner (STAR/HISAT2) did not produce a sorted file, use samtools before running TERRACE:
```bash
samtools sort input.bam > input.sort.bam
```

### 2. Library Type Specification
While TERRACE can attempt to infer the library type, it is highly recommended to specify it explicitly to avoid errors, especially if the BAM file lacks `XS` tags.
- `unstranded`: Standard unstranded library.
- `first`: Corresponds to `fr-firststrand` (e.g., dUTP, NSR, NNSR).
- `second`: Corresponds to `fr-secondstrand` (e.g., Ligation, Standard SOLiD).

Use the `--preview` flag to check what TERRACE infers before running the full assembly:
```bash
terrace -i input.sort.bam --preview
```

### 3. Generating Confidence Scores
By default, the "score" field in the output GTF contains abundance values. To generate more reliable confidence scores (0 to 1):
1. Run TERRACE with the `-fe` flag to generate a feature file.
2. Use the provided Random Forest scripts (found in the `RF-scoring` directory of the source) to process the feature file.
3. This allows you to filter the `precise.gtf` for high-confidence candidates.

### 4. Reference Genome Selection
For human data, the developers recommend using Gencode GRCh37 or GRCh38 for the `-fa` parameter to ensure compatibility with standard annotation features.

## Reference documentation
- [TERRACE GitHub Repository](./references/github_com_Shao-Group_TERRACE.md)
- [Bioconda TERRACE Overview](./references/anaconda_org_channels_bioconda_packages_terrace_overview.md)