---
name: bttoxin_scanner
description: The bttoxin_scanner tool automates the discovery and identification of insecticidal toxins within Bacillus thuringiensis genomic datasets. Use when user asks to identify toxin profiles in raw reads, assemble and mine Bt genomes, or scan protein sequences for insecticidal toxins.
homepage: https://github.com/liaochenlanruo/BtToxin_scanner/blob/master/README.md
---


# bttoxin_scanner

## Overview

The `bttoxin_scanner` skill enables the automated discovery of insecticidal toxins within *Bacillus thuringiensis* datasets. It is particularly useful for researchers performing bioprospecting or genomic characterization of Bt strains. The tool handles the entire workflow from raw data assembly to HMM-based toxin prediction. Use this skill when you need to process large batches of genomic data to find specific toxin profiles or when you need to integrate toxin mining into a larger comparative genomics workflow.

## Installation

The recommended way to install `bttoxin_scanner` is via Bioconda:

```bash
conda create -n toxin python=3
conda activate toxin
conda install bioconda::bttoxin_scanner
```

## Core CLI Usage

The tool requires two primary arguments: `--SeqPath` (the directory containing your files) and `--SequenceType` (the format of those files).

### 1. Processing Raw Reads (Automated Assembly + Mining)
When starting from raw reads, you must specify the sequencing platform.

**Illumina Paired-End:**
```bash
BtToxin_scanner --SeqPath ./reads/ --SequenceType reads --platform illumina --reads1 .R1.fastq.gz --reads2 .R2.fastq.gz --suffix_len 15 --threads 8
```

**PacBio or Oxford Nanopore:**
```bash
BtToxin_scanner --SeqPath ./long_reads/ --SequenceType reads --platform pacbio --reads1 .ccs.fastq --suffix_len 10 --genomeSize 6.0m
```

### 2. Processing Assembled Genomes or Proteins
If you already have assemblies or protein files, the process is significantly faster as it skips the assembly and ORF prediction steps.

**Assembled Genomes (Fasta):**
```bash
BtToxin_scanner --SeqPath ./assemblies/ --SequenceType nucl --Scaf_suffix .fasta --threads 4
```

**Protein Sequences (FAA):**
```bash
BtToxin_scanner --SeqPath ./proteins/ --SequenceType prot --prot_suffix .faa --threads 4
```

## Expert Tips and Best Practices

### Calculating `--suffix_len`
The `--suffix_len` parameter is critical for the tool to correctly identify strain names from filenames. 
*   **Formula**: `Length of full filename` - `Length of strain name`.
*   **Example**: If your file is `StrainA_L001_R1.fastq.gz` and the strain name is `StrainA`, the suffix is `_L001_R1.fastq.gz`. The length of that suffix (20 characters) is your `--suffix_len`.

### Input Directory Management
`bttoxin_scanner` processes files in bulk within the directory specified by `--SeqPath`. 
*   Ensure only the target files for a single run are in that directory.
*   Use specific suffixes (e.g., `--Scaf_suffix`, `--prot_suffix`) to filter files if the directory contains mixed content.

### Hybrid Assembly
For the highest quality toxin mining from novel strains, use the `hybrid` platform option if you have both short (Illumina) and long (PacBio/ONT) reads:
```bash
BtToxin_scanner --SeqPath ./data/ --SequenceType reads --platform hybrid --short1 R1.fq --short2 R2.fq --long long_reads.fq --hout ./hybrid_output
```

### Resource Allocation
*   **Threads**: Use `--threads` to scale HMMER and BLAST+ operations. For large datasets, 8-16 threads are recommended.
*   **Genome Size**: When using long reads, providing an accurate `--genomeSize` (e.g., `6.2m` for typical Bt) improves assembly performance.

## Reference documentation
- [BtToxin_scanner README](./references/github_com_liaochenlanruo_BtToxin_scanner_blob_master_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_bttoxin_scanner_overview.md)