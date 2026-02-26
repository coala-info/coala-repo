---
name: emirge
description: EMIRGE reconstructs full-length ribosomal RNA genes from metagenomic or amplicon sequencing data using an iterative expectation-maximization algorithm. Use when user asks to reconstruct 16S or 18S sequences, estimate taxonomic abundances from environmental samples, or assemble conserved genes from short-read datasets.
homepage: https://github.com/csmiller/EMIRGE
---


# emirge

## Overview

EMIRGE (Expectation-Maximization Iterative Reconstruction of Genes from the Environment) is a specialized assembly tool designed to overcome the challenges of assembling highly conserved but divergent ribosomal genes from metagenomic or amplicon datasets. Instead of traditional de novo assembly, it uses a candidate database and an iterative Expectation-Maximization algorithm to map reads, estimate abundances, and refine consensus sequences. It is particularly effective for generating full-length 16S/18S sequences that provide better taxonomic resolution than short reads alone.

## Core Workflow and CLI Patterns

### 1. Database Preparation
Before running the reconstruction, you must prepare a candidate SSU database. SILVA is the recommended source.

```bash
# Download and cluster the default SILVA SSU database
python emirge_makedb.py

# If using a custom database, ensure non-standard characters are removed
python utils/fix_nonstandard_chars.py custom_db.fasta > custom_db_clean.fasta

# Build the required Bowtie index
bowtie-build SSU_candidate_db.fasta SSU_candidate_db
```

### 2. Running the Reconstruction
Choose the script based on your data type:
- `emirge.py`: For shotgun metagenomic data.
- `emirge_amplicon.py`: For PCR amplicon data or RNASeq data where rRNA is highly enriched.

**Common Parameters:**
- `-1`, `-2`: Forward and reverse FASTQ files (Illumina pipeline >= 1.3).
- `-f`: Path to the candidate SSU database FASTA.
- `-b`: Path to the Bowtie index.
- `-l`: Maximum read length.
- `-i`: Insert size mean.
- `-s`: Insert size standard deviation.
- `-n`: Number of iterations (default is often sufficient, but 40-80 is standard).

### 3. Post-Processing and Results
The output of EMIRGE is organized into iteration directories (e.g., `iter.01`, `iter.02`). You must run the rename script on the final iteration to generate a usable FASTA file.

```bash
# Generate the final fasta from the last iteration (e.g., iteration 40)
emirge_rename_fasta.py iter.40 > reconstructed_ssu.fasta
```

## Expert Tips and Best Practices

- **Convergence**: Iterations should ideally stop when reference sequences no longer change. In practice, 40 to 80 iterations are sufficient for most complex environmental samples.
- **Resuming**: If a run stops prematurely, `emirge.py` supports resuming from a specific iteration.
- **Abundance Estimates**: The final FASTA headers contain two types of abundance estimates:
    - `Prior`: The raw abundance estimate.
    - `NormPrior`: The length-normalized abundance estimate. Use `NormPrior` for more accurate community composition analysis if your reconstructed sequences vary significantly in length.
- **Strain Splitting**: If a header contains a suffix like `_m01`, it indicates EMIRGE identified multiple "strains" or closely related sequences originating from the same initial candidate sequence.
- **Memory and Performance**: EMIRGE relies on Bowtie (v1) for mapping. Ensure `bowtie`, `samtools`, and `usearch` (v6.0.203+) are in your executable PATH.

## Reference documentation
- [EMIRGE Main Documentation](./references/github_com_csmiller_EMIRGE.md)
- [EMIRGE Wiki and FAQ](./references/github_com_csmiller_EMIRGE_wiki.md)