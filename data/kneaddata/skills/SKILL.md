---
name: kneaddata
description: KneadData is a pipeline designed to clean metagenomic datasets by performing quality trimming and removing host contaminant reads. Use when user asks to perform quality control on metagenomic sequences, filter out host DNA, or remove low-complexity sequences from sequencing reads.
homepage: https://huttenhower.sph.harvard.edu/kneaddata
---


# kneaddata

## Overview
KneadData is a specialized pipeline for cleaning metagenomic datasets. Its primary function is to separate microbial reads from host "contaminant" reads (such as human DNA) through in silico subtraction. It integrates quality trimming (via Trimmomatic) and alignment-based filtering (via Bowtie2) into a single workflow, ensuring that downstream analysis is performed on high-quality, microbial-enriched sequences.

## Core Usage Patterns

### Basic Quality Control and Host Removal
To run the standard pipeline on paired-end reads against a host database:
```bash
kneaddata --input1 read1.fastq --input2 read2.fastq \
  --reference-db /path/to/host_db \
  --output kneaddata_output
```

### Common CLI Options
- `--input <file>`: Use for single-end reads.
- `--reference-db <path>`: Path to the Bowtie2 index of the host genome. Multiple databases can be specified by repeating this flag.
- `--threads <int>`: Number of CPU cores to use (default is 1).
- `--run-trim-repetitive`: Removes low-complexity sequences.
- `--fastqc <path_to_fastqc>`: Runs FastQC on the reads before and after processing.

### Advanced Filtering Logic
- **Bypass Trimming**: If reads are already quality-trimmed, use `--bypass-trim`.
- **Bypass Host Removal**: To perform only quality trimming without alignment, use `--bypass-bowtie2`.
- **Output Handling**: By default, KneadData outputs several files. Use `--unmatched-output <filename>` to consolidate reads that did not match the reference database into a single file.

## Expert Tips
- **Database Preparation**: Ensure your reference database is indexed specifically for Bowtie2. Common databases include human (HG37/38), mouse, and ribosomal RNA (SILVA).
- **Memory Management**: Bowtie2 alignment can be memory-intensive. Ensure the available RAM exceeds the size of the index files.
- **Contaminant Identification**: If you suspect multiple sources of contamination (e.g., human host and a specific reagent contaminant), provide both as separate `--reference-db` arguments; KneadData will filter against them sequentially.
- **Paired-end Consistency**: KneadData is excellent at maintaining the pairing of reads. The files labeled `*paired_1.fastq` and `*paired_2.fastq` in the output folder are the cleaned reads ready for assemblers or taxonomic profilers like MetaPhlAn.

## Reference documentation
- [KneadData Overview](./references/anaconda_org_channels_bioconda_packages_kneaddata_overview.md)