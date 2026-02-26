---
name: fastv
description: fastv is a high-performance tool for the rapid detection and identification of microorganisms from raw sequencing data using k-mer based scanning and genome mapping. Use when user asks to detect SARS-CoV-2, identify custom pathogens, screen for viruses in sequencing data, or perform quality control on reads while searching for target microbes.
homepage: https://github.com/OpenGene/fastv
---


# fastv

## Overview
fastv is a high-performance tool designed for the rapid detection and identification of microorganisms, specifically viruses like SARS-CoV-2, from raw sequencing data. It combines data quality control (QC) with k-mer based scanning and genome mapping to provide a comprehensive report on the presence of target pathogens. It is particularly useful in clinical and public health settings where speed and accuracy in infectious disease detection are critical.

## Core Workflows

### SARS-CoV-2 Detection
By default, fastv looks for SARS-CoV-2 if no specific k-mer or genome files are provided, provided the default data files are in the `./data` directory.

```bash
# Basic detection for single-end data
fastv -i input.fq.gz -o clean_on_target.fq.gz -h report.html -j report.json

# Basic detection for paired-end data
fastv -i R1.fq.gz -I R2.fq.gz -o out.R1.fq.gz -O out.R2.fq.gz
```

### Custom Pathogen Identification
To detect specific microbes other than SARS-CoV-2, you must provide custom k-mer or genome references.

```bash
# Using a specific k-mer file and genome reference
fastv -i input.fq.gz -k pathogen.kmer.fa -g pathogen.genomes.fa

# Using a k-mer collection for multi-pathogen screening
fastv -i input.fq.gz -c microbial.kc.fasta.gz
```

### Long-Read Processing (ONT/PacBio)
fastv supports long reads by scanning them for unique k-mers. Use the HTML report to visualize the distribution of hits across long fragments.

```bash
fastv -i ont_data.fq.gz --mode long_read
```

## Command Line Options

### Input/Output
- `-i, --in1`: Primary input FASTQ (required).
- `-I, --in2`: Secondary input FASTQ for paired-end data.
- `-o, --out1`: Output FASTQ containing clean, on-target reads.
- `-O, --out2`: Output FASTQ for paired-end on-target reads.
- `-j, --json`: JSON format report file (default: fastv.json).
- `-h, --html`: HTML format report file (default: fastv.html).

### Detection Parameters
- `-c, --kmer_collection`: Path to a FASTA file containing unique k-mers for multiple organisms.
- `-k, --kmer`: Path to unique k-mers for a specific target.
- `-g, --genomes`: Path to the reference genome(s) for the target.
- `-p, --positive_threshold`: The threshold for calling a sample "POSITIVE" based on mean k-mer coverage (default is 0.001).

### Quality Control (fastp-based)
fastv performs QC automatically. You can tune these parameters:
- `-w, --thread`: Number of worker threads to use.
- `-q, --qualified_quality_phred`: Phred score threshold for quality filtering (default: 15).
- `-l, --length_required`: Minimum read length required (default: 15).

## Expert Tips
- **Resource Files**: Pre-built k-mer collections for all viral RefSeq sequences and common human microorganisms are available from the OpenGene project. Using these collections (`-c`) is more efficient than providing full genomes for broad screening.
- **On-Target Reads**: The reads output via `-o` and `-O` are "clean" (QC-passed) and contain at least one hit to the target k-mers or genomes. These should be used for downstream assembly or specific alignment to confirm variants.
- **Positive Calls**: If a k-mer file is specified, fastv provides a POSITIVE/NEGATIVE result. Adjust `--positive_threshold` if you encounter false positives in high-background metagenomic samples.
- **Performance**: fastv is multi-threaded. Always specify `-w` to match your available CPU cores for maximum throughput.

## Reference documentation
- [fastv GitHub Repository](./references/github_com_OpenGene_fastv.md)
- [fastv Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fastv_overview.md)