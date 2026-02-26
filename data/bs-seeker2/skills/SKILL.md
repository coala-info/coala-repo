---
name: bs-seeker2
description: BS Seeker 2 is a bioinformatics pipeline for aligning bisulfite-converted DNA sequences and calling methylation levels at single-base resolution. Use when user asks to index a reference genome, map bisulfite-treated reads, or extract methylation information.
homepage: http://pellegrini.mcdb.ucla.edu/BS_Seeker2/
---


# bs-seeker2

## Overview
BS Seeker 2 is a specialized bioinformatics pipeline designed for the efficient alignment of bisulfite-converted DNA sequences. It addresses the reduced complexity of the "three-letter" genome resulting from C-to-T conversions by utilizing a three-step process: preprocessing reads and reference genomes, performing alignments using established short-read mappers (like Bowtie, Bowtie2, or SOAP), and post-processing to identify methylation levels at single-base resolution.

## Core Workflow

### 1. Genome Indexing
Before mapping, the reference genome must be converted and indexed.
```bash
python bs_seeker2-build.py -f reference.fa -g hg19 -p /path/to/bowtie2/ --aligner=bowtie2
```
- `-f`: Path to the fasta file.
- `-g`: Genome assembly name.
- `--aligner`: Choose between bowtie, bowtie2, or soap.

### 2. Read Mapping
Map bisulfite-treated reads to the indexed reference.
```bash
python bs_seeker2-align.py -i reads.fastq -g hg19 -o output.bam -p /path/to/bowtie2/ --aligner=bowtie2
```
- `-i`: Input fastq file (use `-1` and `-2` for paired-end).
- `-m`: Mismatches allowed (default is 4% of read length).
- `-X`: Maximum insert size for paired-end reads.

### 3. Methylation Calling
Extract methylation information from the alignment file.
```bash
python bs_seeker2-call_methylation.py -i output.bam -o methylation_results -g hg19
```
- `--wig`: Generate a wiggle file for visualization.
- `--CGmap`: Generate a CGmap file (detailed site-specific info).
- `--ATCGmap`: Generate an ATCGmap file (full sequence context).

## Best Practices
- **Aligner Selection**: Use `bowtie2` for better sensitivity with longer reads or reads containing indels. Use `bowtie` for very short reads where speed is the priority.
- **Memory Management**: Genome indexing is memory-intensive. Ensure the environment has sufficient RAM relative to the genome size (e.g., ~3GB for human genome using Bowtie2).
- **Library Type**: If using a non-directional library, specify `--un-directional` during the alignment step to ensure all four possible bisulfite strands are considered.
- **Filtering**: Use the `-r` flag in the alignment step to remove PCR duplicates, which is critical for accurate quantification of methylation levels.

## Reference documentation
- [BS Seeker 2 Overview](./references/anaconda_org_channels_bioconda_packages_bs-seeker2_overview.md)