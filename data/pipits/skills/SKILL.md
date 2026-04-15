---
name: pipits
description: pipits is a bioinformatics workflow designed for the analysis of fungal ITS sequences from raw FASTQ files. Use when user asks to process fungal ITS data, extract ITS subregions, or generate OTU abundance tables and BIOM files.
homepage: https://github.com/hsgweon/pipits
metadata:
  docker_image: "quay.io/biocontainers/pipits:4.0--pyhdfd78af_0"
---

# pipits

## Overview

pipits is a specialized bioinformatics workflow designed to address the specific requirements of fungal ITS analysis. Because ITS regions vary significantly in length, standard microbiome pipelines often struggle with them; pipits overcomes this by integrating tools like ITSx for subregion extraction and VSEARCH/SINTAX for rapid taxonomic assignment. It transforms raw demultiplexed FASTQ files into OTU abundance tables and BIOM files through a streamlined four-step command-line process.

## Core Workflow

The pipeline follows a sequential execution order. Ensure all raw data files (.fastq, .fastq.gz, or .fastq.bz2) are in a single input directory.

### 1. Generate Read Pairs List
Create the required mapping file that identifies forward and reverse reads for each sample.
```bash
pipits_createreadpairslist -i rawdata/ -o readpairslist.txt
```
*   **Tip**: Sample IDs are automatically parsed from filenames (characters preceding the first underscore). Verify `readpairslist.txt` for accuracy before proceeding.

### 2. Sequence Preparation
Join paired-end reads, perform quality filtering, and merge samples into a single FASTA file.
```bash
pipits_prep -i rawdata/ -o out_prep -l readpairslist.txt
```
*   **Output**: The primary file for the next step is `out_prep/prepped.fasta`.

### 3. Fungal ITS Extraction (Optional but Recommended)
Extract specific ITS subregions (ITS1 or ITS2) and remove conserved flanking regions to improve taxonomic resolution.
```bash
pipits_funits -i out_prep/prepped.fasta -o out_funits -x ITS2
```
*   **Note**: Use `-x ITS1` or `-x ITS2` depending on your primer set. This step can be time-consuming as it uses HMMER3 via ITSx.

### 4. Downstream Processing
Perform OTU clustering, chimera removal, and taxonomic assignment.
```bash
pipits_process -i out_funits/ITS.fasta -o out_process
```
*   **Default**: As of version 4.0, SINTAX is the default classifier and UNITE 10.0 is the default database.
*   **Memory**: Ensure the system has at least 16GB RAM (32GB+ recommended) to load the large UNITE database.

## Expert Tips and Best Practices

*   **Environment Setup**: Always run pipits within a dedicated Conda environment to manage dependencies like Python 3.10 and VSEARCH.
    ```bash
    conda create -n pipits_env -c bioconda -c conda-forge python=3.10 pipits
    ```
*   **BIOM Conversion Errors**: If `pipits_process` fails during the BIOM conversion stage on older server distributions, run `conda update pipits` within your environment to resolve library conflicts.
*   **Performance**: SINTAX is significantly faster than the RDP Classifier while providing comparable results. If you require the RDP Classifier specifically, check the version-specific documentation for the `-c` flag.
*   **Subregion Selection**: Since 300bp PE Illumina reads often cannot span the full ITS region with sufficient overlap, always specify a single subregion (`ITS1` or `ITS2`) in the `pipits_funits` step.



## Subcommands

| Command | Description |
|---------|-------------|
| PIPITS_PROCESS | Sequences to OTU Table |
| pipits_funits | PIPITS_FUNITS v4.0: Extract ITS1 or ITS2 regions. |
| pipits_pipits_createreadpairslist | Creates a read pairs list file for PIPITS from a directory of FASTQ files. |
| pipits_prep | Reindex, join (VSEARCH), quality filter, convert and merge Illumina FASTQ data. |

## Reference documentation
- [hsgweon/pipits: Automated pipeline for analyses of fungal ITS](./references/github_com_hsgweon_pipits.md)
- [pipits Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pipits_overview.md)