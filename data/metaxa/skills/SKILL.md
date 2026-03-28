---
name: metaxa
description: Metaxa2 detects and classifies ribosomal RNA sequences from metagenomic or genomic datasets into taxonomic groups using Hidden Markov Models. Use when user asks to identify rRNA sequences, perform taxonomic classification, filter host rRNA, or calculate diversity indices from sequence data.
homepage: http://microbiology.se/software/metaxa2/
---

# metaxa

## Overview

Metaxa2 is a specialized bioinformatics pipeline that automates the detection and classification of rRNA sequences (12S, 16S, 18S, 23S, 28S). It utilizes Hidden Markov Models (HMMs) for high-sensitivity extraction and a dedicated classifier to assign sequences to Archaea, Bacteria, Eukaryota, Chloroplasts, or Mitochondria. Beyond simple identification, it provides a suite of diversity tools for downstream ecological analysis and supports the creation of custom marker databases.

## Core Command Line Usage

### Basic Analysis
To run a standard taxonomic classification on a metagenomic dataset using BLAST+:
```bash
metaxa2 -i input.fastq -o output_prefix --plus T --cpu 8
```

### Handling Paired-End Data
Metaxa2 attempts to auto-detect paired-end files (e.g., `_1.fastq` and `_2.fastq`). To prevent misidentification or to force specific behavior:
- **Force single-end:** Use `-f fastq` to explicitly define the format and prevent auto-pairing.
- **Concatenation:** Avoid concatenating R1 and R2 into a single file as it biases detection counts; process them as pairs instead.

### Genome and Assembly Mode
When working with assembled genomes or seeking to determine rRNA copy numbers, change the operational mode:
```bash
metaxa2 -i assembly.fasta -o out --mode genome
```
*Note: Copy number detection in assemblies can be limited by how the assembler handles repetitive rRNA regions.*

### Host rRNA Filtering
To remove rRNA sequences belonging to a specific host organism (e.g., human, plant, or lab animal) while keeping all other microbial hits:
```bash
metaxa2 -i sample.fastq -o filtered --reference host_rrna.fasta
```

## Diversity and Post-Processing Tools

Metaxa2 includes auxiliary scripts for handling multiple samples:

- **metaxa2_dc**: Merges output from multiple Metaxa2 runs into a single taxonomic abundance table.
- **metaxa2_rf**: Performs rarefaction on taxonomic tables to normalize sampling depth.
- **metaxa2_si**: Calculates diversity indices (e.g., Shannon, Simpson).
- **metaxa2_uc**: Summarizes taxonomic classifications into OTU-like clusters.

## Expert Tips and Troubleshooting

- **CPU Management**: The `--cpu` flag controls the main process, but HMMER may spawn additional threads. If system resources are constrained, use `--multi_thread F` to force sequential HMMER searches within the specified CPU limit.
- **BLAST+ Requirement**: Always use `--plus T` unless you are specifically required to use legacy BLAST, as BLAST+ is significantly faster and more robust.
- **Input Validation**: If Metaxa2 appears to hang at "Checking and handling input sequence data," verify that the input file path is correct and that the file is not empty.
- **Custom Markers**: If the target is not rRNA (e.g., *rpoB* or *COI*), use the `metaxa2_dbb` (Database Builder) to generate a compatible database before running the main pipeline.



## Subcommands

| Command | Description |
|---------|-------------|
| metaxa2 | Metaxa2 is a tool for identification and taxonomic classification of small and large subunit rRNA sequences in metagenomes and other sequence data sets. |
| metaxa2_dbb | Metaxa2 Database Builder - builds a classification database for Metaxa2 from reference sequences and taxonomic information. |
| metaxa2_dc | Metaxa2 tool for combining multiple Metaxa2 results into a single data matrix. |

## Reference documentation

- [Metaxa2 Overview](./references/microbiology_se_software_metaxa2.md)
- [Metaxa2 FAQ](./references/microbiology_se_software_metaxa2_metaxa2-faq.md)