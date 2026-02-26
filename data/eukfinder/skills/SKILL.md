---
name: eukfinder
description: "Eukfinder identifies eukaryotic sequences within metagenomic data. Use when user asks to find eukaryotic genomes in metagenomic datasets, process short reads or assembled contigs, or analyze microbial communities for eukaryotes."
homepage: https://github.com/RogerLab/Eukfinder
---


# eukfinder

A pipeline for detecting eukaryotic sequences in metagenomic data.
  Use when you need to identify and potentially recover eukaryotic genomes from WGS metagenomic datasets,
  supporting both Illumina short reads and assembled contigs or long-read data.
  This tool is particularly useful for analyzing complex microbial communities where eukaryotic
  organisms are of interest.
---
## Overview

Eukfinder is a bioinformatics pipeline designed to sift through metagenomic sequencing data to identify and isolate sequences belonging to eukaryotes. It can process raw Illumina short reads by classifying them and then assembling the eukaryotic candidates, or it can directly analyze pre-assembled contigs or long-read data. The pipeline aims to facilitate the recovery of microbial eukaryote genomes from diverse environments.

## Usage Instructions

Eukfinder can be run using its command-line interface. The tool supports two primary modes: `Eukfinder_short` for Illumina short reads and `Eukfinder_long` for assembled contigs or long-read data.

### Installation

Install Eukfinder via Conda:
```bash
conda install bioconda::eukfinder
```

### Running Eukfinder_short (Illumina Short Reads)

This mode processes raw paired-end FASTQ files.

**Basic command structure:**

```bash
eukfinder_short --input_dir <path_to_input_directory> --output_dir <path_to_output_directory> [options]
```

**Key arguments:**

*   `--input_dir`: Directory containing your raw paired-end FASTQ files (e.g., `sample1_R1.fastq.gz`, `sample1_R2.fastq.gz`).
*   `--output_dir`: Directory where all output files will be saved.
*   `--threads`: Number of CPU threads to use.
*   `--db`: Path to the Centrifuge database (if not using default).
*   `--plast_db`: Path to the PLAST database (if not using default).

**Example:**

```bash
eukfinder_short --input_dir ./raw_reads --output_dir ./eukfinder_output --threads 16
```

### Running Eukfinder_long (Metagenome Assembled Contigs or Long Reads)

This mode is for analyzing pre-assembled contigs (e.g., from metaSpades) or long-read sequencing data (e.g., Nanopore, PacBio).

**Basic command structure:**

```bash
eukfinder_long --input_contigs <path_to_contigs_fasta> --output_dir <path_to_output_directory> [options]
```

**Key arguments:**

*   `--input_contigs`: Path to the FASTA file containing your assembled contigs or long reads.
*   `--output_dir`: Directory where all output files will be saved.
*   `--threads`: Number of CPU threads to use.
*   `--db`: Path to the Centrifuge database (if not using default).
*   `--plast_db`: Path to the PLAST database (if not using default).

**Example:**

```bash
eukfinder_long --input_contigs ./assembled_contigs.fasta --output_dir ./eukfinder_long_output --threads 8
```

### Database Management

Eukfinder relies on classification databases (Centrifuge and PLAST). You can specify custom database paths using `--db` and `--plast_db`. For detailed information on database setup and configuration, refer to the Eukfinder Wiki.

### Output Interpretation

The output directory will contain various files, including classified reads/contigs, assembled contigs, and potentially binned genomes if the optional binning workflow is used. The primary output of interest for eukaryotic sequence detection will be files containing sequences classified as 'Eukaryotic' or 'Unknown' that are deemed potential eukaryotic candidates.

## Expert Tips

*   **Resource Allocation:** Ensure sufficient CPU threads (`--threads`) and memory are allocated, especially for `Eukfinder_short` which involves assembly.
*   **Database Choice:** For specific environments (e.g., gut, ocean, soil), consider using or building custom databases for improved classification accuracy. Refer to the Eukfinder Wiki for database building instructions.
*   **Input File Naming:** For `Eukfinder_short`, ensure your FASTQ files follow a consistent naming convention (e.g., `sample_name_R1.fastq.gz`, `sample_name_R2.fastq.gz`).
*   **Troubleshooting:** If you encounter issues, consult the Eukfinder Wiki's FAQ and troubleshooting sections. For persistent problems, consider opening an issue on the GitHub repository.

## Reference documentation

- [Eukfinder Wiki](https://github.com/RogerLab/Eukfinder/wiki)
- [Eukfinder README](https://github.com/RogerLab/Eukfinder.md)