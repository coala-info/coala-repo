---
name: super-focus
description: SUPER-FOCUS performs rapid functional profiling of shotgun metagenomic datasets using a reduced database of protein families. Use when user asks to annotate metagenomic reads, perform functional profiling of subsystems, or download the required protein database.
homepage: https://edwards.sdsu.edu/SUPERFOCUS
metadata:
  docker_image: "quay.io/biocontainers/super-focus:1.6--pyhdfd78af_1"
---

# super-focus

## Overview
SUPER-FOCUS (Subsystems Profile by Electronic Resource Focused On Chemotaxis, Unknowns, and Secretion) is a tool designed for the rapid functional profiling of shotgun metagenomic datasets. It utilizes a reduced database of protein families (Subsystems) to provide high-speed annotation while maintaining accuracy. This skill provides the necessary CLI patterns to execute the tool, manage database dependencies, and interpret the functional output.

## Installation and Setup
Before running analysis, ensure the environment is configured via Conda:
```bash
conda install -c bioconda super-focus
```

## Common CLI Patterns

### Basic Functional Annotation
To run a standard analysis on a fasta/fastq file:
```bash
superfocus -q input_file.fasta -dir output_directory
```

### Specifying Search Tools
SUPER-FOCUS supports different alignment tools. Use `-t` to specify the aligner based on your speed/sensitivity requirements (e.g., diamond, blastx, rapsearch):
```bash
superfocus -q input.fastq -t diamond -dir output_results
```

### Database Management
If the database is not present or needs updating, use the following to download the required subsystem data:
```bash
superfocus -download
```

### Key Parameters
- `-q`: Input file (FASTA/FASTQ, can be gzipped).
- `-dir`: Output directory for results.
- `-t`: Number of threads to use for the alignment step.
- `-n`: Minimum identity threshold (default is usually 60% for protein).
- `-e`: E-value cutoff for alignments.

## Expert Tips
- **Memory Management**: When using `diamond` as the aligner, ensure the system has sufficient RAM for the database index; otherwise, use the `--block-size` parameter if the tool allows passing arguments to the underlying aligner.
- **Output Interpretation**: The tool generates `.output` files containing the distribution of subsystems across different levels (Level 1 to Level 3). Level 1 provides broad categories (e.g., Carbohydrates), while Level 3 provides specific functional roles.
- **Data Pre-processing**: For best results, trim adapters and filter low-quality reads before running SUPER-FOCUS to reduce computational overhead and false positives.

## Reference documentation
- [SUPER-FOCUS Overview](./references/anaconda_org_channels_bioconda_packages_super-focus_overview.md)