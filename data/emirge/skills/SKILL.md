---
name: emirge
description: EMIRGE reconstructs full-length ribosomal RNA sequences and estimates their abundance from fragmented metagenomic or amplicon sequencing data. Use when user asks to reconstruct SSU genes from environmental DNA, identify microbial strains within a sample, or generate length-normalized abundance estimates for rRNA sequences.
homepage: https://github.com/csmiller/EMIRGE
metadata:
  docker_image: "quay.io/biocontainers/emirge:0.61.1--py27_1"
---

# emirge

## Overview
EMIRGE (Expectation-Maximization Iterative Reconstruction of Genes from the Environment) is a specialized assembly tool designed to recover full-length ribosomal RNA sequences from fragmented environmental DNA. It addresses the challenges of assembling highly conserved genes by using an iterative mapping and consensus-calling approach. It is particularly effective for identifying "strains" within a sample and providing length-normalized abundance estimates for the reconstructed sequences.

## Core Workflows

### 1. Database Preparation
Before running reconstructions, generate a candidate SSU database. By default, this downloads and processes the SILVA database.

```bash
# Download and cluster the default SILVA SSU database
python emirge_makedb.py
```

**Expert Tips:**
- If using a custom database, run `utils/fix_nonstandard_chars.py` to ensure compatibility with Bowtie.
- Always build a Bowtie index for your candidate database using `bowtie-build`.

### 2. Metagenomic Reconstruction
Use `emirge.py` for standard metagenomic data where rRNA reads represent a small fraction of the total library.

```bash
# Standard paired-end run
emirge.py <output_dir> -1 <forward_reads.fastq> -2 <reverse_reads.fastq> -f <candidate_db.fasta> -b <bowtie_index> -l <max_read_length>
```

**Key Parameters:**
- `-i`: Number of iterations. 40-80 is usually sufficient for convergence.
- `-m`: Insert size mean.
- `-s`: Insert size standard deviation.
- `--resume`: Use this flag to continue a run from the last completed iteration.

### 3. Amplicon or High-Depth rRNA Reconstruction
Use `emirge_amplicon.py` for PCR amplicons, total RNA-Seq, or any dataset where the majority of reads are ribosomal.

```bash
# Amplicon-specific run
emirge_amplicon.py <output_dir> -1 <reads_1.fastq> -2 <reads_2.fastq> -f <db.fasta> -b <index> -l <length>
```

**Note:** This version loads all reads into memory to accelerate processing. Ensure the system has several GB of RAM available depending on the input size.

### 4. Post-Processing and Results
After the iterations complete, extract the final sequences into a usable FASTA format.

```bash
# Rename and format the final iteration results
emirge_rename_fasta.py <output_dir>/iter.<N> > reconstructed_genes.fasta
```

## Output Interpretation
The FASTA headers produced by `emirge_rename_fasta.py` contain critical metadata:
- **Prior**: The raw abundance estimate.
- **NormPrior**: The length-normalized abundance estimate (recommended for comparative analysis).
- **Length**: The total length of the reconstructed sequence.

## Troubleshooting and Best Practices
- **Read Format**: EMIRGE expects Illumina FASTQ format (pipeline version >= 1.3).
- **Mapper Compatibility**: EMIRGE specifically uses Bowtie 1. It is generally incompatible with Bowtie 2 due to how it handles alignments and indels.
- **Single-End Data**: While designed for paired-end, you can process single-end data by omitting the `-2` parameter.
- **Convergence**: If sequences are still changing significantly at iteration 40, increase the iteration count to 80 or 100.



## Subcommands

| Command | Description |
|---------|-------------|
| bowtie | Alignments for short DNA sequences |
| bowtie-build | Builds a Bowtie index from a reference sequence. |
| emirge_emirge_makedb.py | emirge_makedb.py creates a reference database and the necessay indices for use by EMIRGE from an rRNA reference database. Without extra parameters, emirge_makedb.py will 1) download the most recent SILVA SSU database, 2) filter it by sequence length, 3) cluster at 97% sequence identity, 4) replace ambiguous bases with random characters and 5) create a bowtie index. |
| emirge_rename_fasta.py | Rewrites an emirge fasta file to include proper sequence names and prior probabilities (abundance estimates) in the record headers, and sorts the sequences from most to least abundant |
| samtools | Tools for alignments in the SAM format |

## Reference documentation
- [EMIRGE Main Documentation](./references/github_com_csmiller_EMIRGE.md)
- [Frequently Asked Questions](./references/github_com_csmiller_EMIRGE_wiki_Frequently-Asked-Questions-_FAQ_.md)