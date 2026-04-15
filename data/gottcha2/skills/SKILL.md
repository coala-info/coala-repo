---
name: gottcha2
description: GOTTCHA2 is a signature-based bioinformatics tool used for rapid and precise taxonomic profiling of metagenomic sequencing data. Use when user asks to perform taxonomic classification, identify species or strains in metagenomic samples, or generate abundance metrics using unique genomic signatures.
homepage: https://github.com/poeli/gottcha2
metadata:
  docker_image: "quay.io/biocontainers/gottcha2:2.2.0--pyhdfd78af_0"
---

# gottcha2

## Overview
GOTTCHA2 (Genomic Origin Through Taxonomic CHAllenge) is a bioinformatics tool designed for rapid and precise taxonomic profiling. Unlike k-mer based approaches that may suffer from high false-positive rates, GOTTCHA2 utilizes a database of unique genomic signatures to provide highly specific classifications. It is particularly effective for clinical or environmental metagenomics where accurate species or strain-level identification is required while minimizing noise from conserved sequences.

## Usage Guidelines

### Basic Command Structure
The primary execution pattern for GOTTCHA2 involves specifying the input reads, the reference database, and the output directory:

```bash
gottcha2.py -i <input_reads.fastq> -db <database_path> -o <output_dir>
```

### Key Parameters
- `-i / --input`: Path to input file (FASTQ, FASTA, or BAM). Supports gzipped files.
- `-db / --database`: Path to the GOTTCHA2 specific signature database.
- `-o / --outdir`: Directory where results and logs will be stored.
- `-t / --threads`: Number of CPU threads to use for alignment (default is usually 1).
- `-p / --prefix`: Custom prefix for output filenames.

### Input Handling
- **Single-end**: Provide the file directly to `-i`.
- **Paired-end**: While GOTTCHA2 can process paired files, it often treats them as independent reads unless pre-merged. For best results with paired-end data, ensure both files are passed or merged if the specific implementation version requires it.
- **Quality Control**: It is a best practice to trim adapters and low-quality bases using tools like Trimmomatic or Cutadapt before running GOTTCHA2 to improve signature matching accuracy.

### Output Interpretation
GOTTCHA2 generates several files, the most important being:
- `*.summary.tsv`: A tabular report containing taxonomic ranks, taxon names, and abundance metrics (linear coverage, relative abundance).
- `*.full.tsv`: Detailed breakdown of hits across all taxonomic levels.

### Best Practices
- **Database Selection**: Ensure the database matches your target organisms (e.g., RefSeq Speciate for general bacteria/viral screening).
- **Abundance Thresholds**: When interpreting results, pay close attention to the "Linear Coverage" metric. Low linear coverage (e.g., <1%) often indicates a potential false positive or low-confidence hit, even if the relative abundance seems high.
- **Memory Management**: GOTTCHA2 can be memory-intensive depending on the database size. Ensure the environment has sufficient RAM (typically 16GB-64GB for standard RefSeq databases).



## Subcommands

| Command | Description |
|---------|-------------|
| gottcha2 | GOTTCHA2 - Genomic Origin Through Taxonomic CHAllenge v2.2.0 |
| gottcha2.py | Genomic Origin Through Taxonomic CHAllenge (GOTTCHA) is an annotation-independent and signature-based metagenomic taxonomic profiling tool that has significantly smaller FDR than other profiling tools. This program is a wrapper to map input reads to pre-computed signature databases using minimap2 and/or to profile mapped reads in SAM format. |
| gottcha2.py | Genomic Origin Through Taxonomic CHAllenge (GOTTCHA) is an annotation-independent and signature-based metagenomic taxonomic profiling tool that has significantly smaller FDR than other profiling tools. This program is a wrapper to map input reads to pre-computed signature databases using minimap2 and/or to profile mapped reads in SAM format. |

## Reference documentation
- [GOTTCHA2 Overview](./references/anaconda_org_channels_bioconda_packages_gottcha2_overview.md)