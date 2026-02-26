---
name: salty
description: SaLTy assigns lineages to *Staphylococcus aureus* genomic data by screening for specific markers and alleles. Use when user asks to assign lineages to *S. aureus* assemblies or raw reads, track genomic epidemiology, or perform MLST-based lineage inference.
homepage: https://github.com/LanLab/salty
---


# salty

## Overview
SaLTy (Staphylococcus aureus Lineage Typer) is a specialized bioinformatic tool designed to accurately assign lineages to *S. aureus* genomic data. It works by screening for specific markers and alleles across three key loci (SACOL0451, SACOL1908, and SACOL2725). It is particularly useful for researchers needing to describe the population structure of *S. aureus* collections or track genomic epidemiology at scale.

## Installation and Setup
The tool is primarily distributed via Bioconda.
```bash
conda install -c conda-forge -c bioconda salty
```
*Note: For Mac M1 users, the environment should be configured for `osx-64` and use Python 3.9.0 to ensure compatibility with dependencies like Numpy and Pandas.*

## Core CLI Usage

### Basic Command
To run SaLTy on a directory containing genomic files:
```bash
salty --input_folder /path/to/input/ --output_folder /path/to/output/
```

### Input Requirements
- **Assemblies**: Files must end in `.fasta` or `.fna`.
- **Raw Reads**: Must be paired-end Illumina reads following the naming convention `*_1.fastq.gz` and `*_2.fastq.gz`.

### Common Options
- `-t, --threads`: Increase the number of threads to speed up the parsing of raw reads.
- `-c, --csv_format`: Generates the output in a comma-separated format instead of the default tab-separated format.
- `-s, --summary`: Concatenates all individual sample assignments into a single master file, which is highly recommended for large batches.
- `-f, --force`: Overwrites the output folder if it already exists.

## Expert Tips and Best Practices

### Dependency Verification
Before starting a large run, always verify that the environment is correctly set up:
```bash
salty --check
```
This ensures that `kma`, `mlst`, and `pandas` are accessible in the current path.

### Handling Low-Confidence Assignments
If SaLTy cannot assign a lineage using its primary three-gene markers, you can enable MLST-based inference:
```bash
salty -i <input> -o <output> --mlstPrediction
```
- **Interpreting Output**: Lineages marked with an asterisk (`*`) indicate they were predicted via MLST because the standard markers were insufficient.
- **No Lin**: If the output shows `*No lin.`, both the marker screening and the MLST backup failed to identify a known lineage.

### Post-Processing and Reporting
If you have already run the analysis but need to regenerate the summary report (e.g., after adding new samples or changing output preferences), use the report flag to save time:
```bash
salty --input_folder /path/to/input/ --output_folder /path/to/output/ --report
```

## Reference documentation
- [SaLTy GitHub Repository](./references/github_com_LanLab_salty.md)
- [Bioconda SaLTy Package Overview](./references/anaconda_org_channels_bioconda_packages_salty_overview.md)