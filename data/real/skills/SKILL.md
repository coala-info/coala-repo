---
name: real
description: REAL is a specialized tool designed for the efficient alignment of short-read genomic sequencing data to reference sequences. Use when user asks to index a reference genome, align single-end or paired-end reads, or manage mapping parameters for bioinformatics workflows.
homepage: https://nms.kcl.ac.uk/informatics/projects/real/?id=man
---


# real

## Overview
REAL is a specialized tool designed for the efficient alignment of genomic reads. It is particularly effective for mapping short-read sequencing data to reference sequences. This skill provides the necessary command-line patterns to execute alignments, manage index files, and optimize mapping parameters for bioinformatics workflows.

## Installation
The tool is available via Bioconda. Ensure the environment is configured before execution:
```bash
conda install -c bioconda real
```

## Core Usage Patterns

### Indexing a Reference
Before alignment, the reference genome must be indexed.
```bash
real index <reference.fasta>
```

### Basic Alignment
Align single-end or paired-end reads to the indexed reference.
```bash
# Single-end alignment
real align -r <reference.fasta> -i <reads.fastq> -o <output.sam>

# Paired-end alignment
real align -r <reference.fasta> -1 <forward_reads.fastq> -2 <reverse_reads.fastq> -o <output.sam>
```

### Common Parameters
- `-t <int>`: Set the number of threads for parallel processing.
- `-m <int>`: Maximum number of mismatches allowed in the alignment.
- `-p`: Enable paired-end mode (when using separate fastq files).

## Best Practices
- **Memory Management**: Ensure sufficient RAM is available for the reference index, especially when working with large mammalian genomes.
- **Quality Control**: Pre-process reads with trimming tools (like fastp or Trimmomatic) before using REAL to improve alignment rates and reduce noise from adapter sequences.
- **Output Handling**: REAL typically outputs in SAM format. Use `samtools` to convert the output to BAM for downstream analysis to save disk space.

## Reference documentation
- [Bioconda real Overview](./references/anaconda_org_channels_bioconda_packages_real_overview.md)