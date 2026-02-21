---
name: karect
description: Karect (KAUST Assembly Read Error Correction Tool) is a high-performance utility for identifying and fixing sequencing errors in DNA reads.
homepage: https://github.com/aminallam/karect
---

# karect

## Overview

Karect (KAUST Assembly Read Error Correction Tool) is a high-performance utility for identifying and fixing sequencing errors in DNA reads. Unlike many tools that focus solely on substitutions, Karect is proficient at correcting indels (insertions and deletions) as well. It works by performing multiple alignments of reads to find a consensus, making it a critical preprocessing step for improving the contiguity and accuracy of genome assemblies.

## Installation and Setup

Karect can be installed via Bioconda or compiled from source:

- **Conda**: `conda install bioconda::karect`
- **Source**: Download the repository, then run `make` in the root directory to produce the `karect` executable.

## Common CLI Patterns

### 1. Correcting Reads
The primary function of Karect is the `-correct` mode. It accepts multiple input files (e.g., for paired-end data).

```bash
./karect -correct \
    -threads=12 \
    -matchtype=hamming \
    -celltype=haploid \
    -inputfile=reads_1.fastq \
    -inputfile=reads_2.fastq
```

**Key Parameters:**
- `-matchtype`: Specifies the alignment algorithm (e.g., `hamming`).
- `-celltype`: Defines the ploidy of the sample (e.g., `haploid`).
- `-threads`: Number of CPU cores to utilize.

### 2. Evaluating Correction Accuracy
If a reference genome is available, you can evaluate how well Karect performed. This is a two-step process.

**Step A: Align original reads to the reference**
```bash
./karect -align \
    -threads=12 \
    -inputfile=reads_1.fastq \
    -inputfile=reads_2.fastq \
    -refgenomefile=genome.fasta \
    -alignfile=align.txt
```

**Step B: Run the evaluation**
```bash
./karect -eval \
    -threads=12 \
    -inputfile=reads_1.fastq \
    -inputfile=reads_2.fastq \
    -resultfile=karect_reads_1.fastq \
    -resultfile=karect_reads_2.fastq \
    -refgenomefile=genome.fasta \
    -alignfile=align.txt \
    -evalfile=eval.txt
```

## Expert Tips and Best Practices

- **File Preparation**: While Karect handles FASTA and FASTQ formats, ensure files are decompressed (`gunzip`) before processing, as the tool typically expects raw text inputs for the `-inputfile` flag.
- **Output Naming**: By default, Karect produces output files prefixed with `karect_` followed by the original filename (e.g., `karect_frag_1.fastq`).
- **Memory Management**: For large datasets, ensure the system has sufficient RAM for the multiple alignment phase. Adjusting the `-threads` parameter can help manage the trade-off between speed and resource consumption.
- **Paired-End Handling**: Always provide both paired-end files using separate `-inputfile` flags in the same command to ensure the tool processes the library context correctly.

## Reference documentation
- [Karect GitHub Repository](./references/github_com_aminallam_karect.md)
- [Bioconda Karect Package](./references/anaconda_org_channels_bioconda_packages_karect_overview.md)