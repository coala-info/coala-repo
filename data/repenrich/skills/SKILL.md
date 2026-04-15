---
name: repenrich
description: RepEnrich is a computational pipeline that quantifies repetitive element expression by assigning multi-mapping genomic reads to specific repeat families using a fractional strategy. Use when user asks to quantify transposon activation, analyze repetitive element expression, or assign multi-mapping reads to repeat families like LINEs, SINEs, and LTRs.
homepage: https://github.com/nskvir/RepEnrich
metadata:
  docker_image: "quay.io/biocontainers/repenrich:1.2--py27_1"
---

# repenrich

## Overview

RepEnrich is a computational pipeline designed to address the challenge of multi-mapping reads in repetitive regions of the genome. While standard genomic pipelines often discard reads that map to multiple locations, RepEnrich utilizes a fractional assignment strategy to attribute these reads to specific repeat families, such as LINEs, SINEs, LTRs, and satellite DNA. It is an essential tool for researchers studying transposon activation, heterochromatin stability, or repetitive element expression where standard unique-mapping approaches would result in a significant loss of data.

## Implementation Guide

### 1. Environment and Dependencies
RepEnrich has strict version requirements. Ensure the following environment is available:
- **Python**: Version 2.7.3 (requires `BioPython`).
- **Bowtie 1**: Version 0.12.9 (RepEnrich is built specifically for Bowtie 1).
- **Bedtools**: Version < 2.24.0 (Functionality of `coverageBed` changed in later versions).
- **Samtools**: Version 0.1.19.

### 2. Annotation Setup
Before processing samples, you must build the RepEnrich-compatible annotation for your genome.

**Using RepeatMasker (Default):**
```bash
python RepEnrich_setup.py /path/to/mm9_repeatmasker.txt /path/to/mm9.fa /path/to/setup_folder_mm9
```

**Using a Custom BED file:**
If using a custom set of elements (e.g., only LTRs), ensure the BED file is tab-delimited with 6 columns: Chromosome, Start, End, Repeat_name, Class, Family.
```bash
python RepEnrich_setup.py /path/to/custom_repeats.bed /path/to/genome.fa /path/to/setup_folder --is_bed TRUE
```

### 3. Alignment Strategy
RepEnrich requires a specific Bowtie 1 alignment to separate uniquely mapping reads from multi-mapping reads.

**Single-End Reads:**
```bash
bowtie /path/to/index -p 16 -t -m 1 -S --max sample_multimap.fastq sample.fastq sample_unique.sam
```

**Paired-End Reads:**
```bash
bowtie /path/to/index -p 16 -t -m 1 -S --max sample_multimap.fastq -1 sample_1.fastq -2 sample_2.fastq sample_unique.sam
```

**Post-Alignment Processing:**
Convert the unique SAM to a sorted, indexed BAM:
```bash
samtools view -bS sample_unique.sam > sample_unique.bam
samtools sort sample_unique.bam sample_unique_sorted
samtools index sample_unique_sorted.bam
```

### 4. Quantifying Repeat Enrichment
Run the main RepEnrich script using the outputs from the previous steps.

```bash
python RepEnrich.py /path/to/setup_folder sample_name /path/to/sample_unique_sorted.bam /path/to/sample_multimap.fastq /path/to/output_folder --cpus 16
```

## Expert Tips and Best Practices

- **Total Mapping Reads**: Always record the total number of mapping reads (unique + multi-mapping) from the Bowtie stdout. This value is required for downstream normalization (e.g., CPM or DESeq2 analysis).
- **Memory Management**: The setup step creates many small files. Ensure your filesystem can handle high inode counts if working with very large genomes or complex repeat sets.
- **Simple Repeats**: For most biological contexts, it is recommended to use "clean" RepeatMasker files where simple and low-complexity repeats are removed, focusing instead on transposons and satellites.
- **Version Warning**: If you are using a modern environment (Python 3+), consider using **RepEnrich2**, which is the updated version of this tool.



## Subcommands

| Command | Description |
|---------|-------------|
| bowtie | Alignments for short DNA sequences |
| getargs_genome_maker.py | Part I: Prepartion of repetive element psuedogenomes and repetive element bamfiles. This script prepares the annotation used by downstream applications to analyze for repetitive element enrichment. For this script to run properly bowtie must be loaded. The repeat element psuedogenomes are prepared in order to analyze reads that map to multiple locations of the genome. The repeat element bamfiles are prepared in order to use a region sorter to analyze reads that map to a single location of the genome.You will 1) annotation_file: The repetitive element annotation file downloaded from RepeatMasker.org database for your organism of interest. 2) genomefasta: Your genome of interest in fasta format, 3)setup_folder: a folder to contain repeat element setup files command-line usage EXAMPLE: python master_setup.py /users/nneretti/data/annotation/mm9/mm9_repeatmasker.txt /users/nneretti/data/annotation/mm9/mm9.fa /users/nneretti/data/annotation/mm9/setup_folder |
| samtools | Tools for alignments in the SAM format |

## Reference documentation
- [RepEnrich GitHub README](./references/github_com_nskvir_RepEnrich_blob_master_README.md)
- [RepEnrich Overview](./references/github_com_nskvir_RepEnrich.md)