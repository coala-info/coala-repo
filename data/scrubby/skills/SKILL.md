---
name: scrubby
description: Scrubby filters non-target background sequences from metagenomic data using alignment or classification methods to improve diagnostic yield. Use when user asks to deplete host DNA, extract specific target reads, manage reference indices, or filter reads from existing alignment and classification outputs.
homepage: https://github.com/esteinig/scrubby
---

# scrubby

## Overview

Scrubby is a specialized tool designed for clinical metagenomics to improve diagnostic yield by filtering out non-target "background" sequences—typically host DNA like Human. It provides a unified interface for read depletion or extraction using either alignment-based or classification-based methods. It is optimized for both short-read (Illumina) and long-read (Oxford Nanopore) sequencing protocols and handles paired-end data as synchronized pairs.

## Core Workflows

### 1. Reference Management
Before processing reads, you must download or prepare reference indices.
- **List available indices**: `scrubby download --list`
- **Download specific index**: `scrubby download --name chm13v2 --aligner bowtie2 minimap2`

### 2. Read Depletion (Standard Pipeline)
The `reads` command is the primary entry point for filtering raw FASTQ files.
- **Short-read paired-end (Bowtie2)**:
  `scrubby reads -i r1.fq r2.fq -o clean1.fq clean2.fq -I chm13v2`
- **Long-reads (Minimap2)**:
  `scrubby reads -i reads.fq -o clean.fq -I chm13v2.fa.gz --preset map-ont`
- **Using Classifiers (Kraken2)**:
  `scrubby reads -i r1.fq r2.fq -o clean1.fq clean2.fq -I kraken_db/ -c kraken2 -T Chordata`

### 3. Read Extraction
To keep only the reads matching the reference (e.g., for targeted pathogen isolation), add the `-e` or `--extract` flag to any `reads`, `alignment`, or `classifier` command.
- **Example**: `scrubby reads -i sample.fq -o target.fq -I virus_ref.fa -e`

### 4. Filtering from Existing Outputs
If you have already run an aligner or classifier, use these subcommands to avoid re-running the compute-intensive steps.
- **From Alignment (PAF/SAM/BAM)**:
  `scrubby alignment --input r1.fq r2.fq --output clean1.fq clean2.fq --alignment map.paf --min-cov 0.5`
- **From Kraken2 Output**:
  `scrubby classifier --input r1.fq r2.fq --output clean1.fq clean2.fq --report k2.report --reads k2.reads --taxa Chordata`

## Expert Tips and Best Practices

- **Pre-processing**: Always perform quality and adapter trimming before using Scrubby to ensure optimal alignment/classification sensitivity.
- **Paired-End Handling**: Scrubby always depletes/extracts reads as a pair. If one read in a pair matches the background, both are removed to maintain file synchronization.
- **Presets**: 
  - Use `sr` for short reads.
  - Use `map-ont` or `lr-hq` for Nanopore reads.
- **Performance**: Use the `-t` flag to specify threads and `-w` to set a high-speed temporary working directory (like an SSD or RAM disk) for intermediate files.
- **Verification**: Use `scrubby diff` to generate a report comparing input and output files to verify the depletion efficiency:
  `scrubby diff -i in.fq -o out.fq -j report.json`



## Subcommands

| Command | Description |
|---------|-------------|
| scrubby | Scrubby command-line application |
| scrubby scrub-reads | Clean sequence reads by removing background taxa (Kraken2) or aligning reads (Minimap2) |

## Reference documentation
- [Scrubby README](./references/github_com_esteinig_scrubby_blob_main_README.md)
- [Scrubby Repository Overview](./references/github_com_esteinig_scrubby.md)