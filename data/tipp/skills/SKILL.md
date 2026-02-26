---
name: tipp
description: TIPP assembles organellar genomes and telomeric regions from HiFi long-read data. Use when user asks to assemble organellar genomes, assemble chloroplast genomes, assemble mitochondrial genomes, assemble plastid genomes, or assemble telomeric regions.
homepage: https://github.com/Wenfei-Xian/TIPP
---



# tipp

## Overview

TIPP (Telomere local assembly, Improved whole genome polish, and Plastid assembly) is a specialized bioinformatics suite designed to streamline the assembly of organellar genomes. Its core component, TIPPo, provides a user-friendly workflow for the de novo assembly of chloroplast and mitochondrial genomes specifically optimized for high-fidelity (HiFi) long-read data. The tool integrates several third-party utilities (like Flye, KMC3, and TIARA) to handle k-mer counting, assembly, and sequence classification in a single pipeline.

## Installation and Environment

TIPP has specific dependency requirements, most notably a strict requirement for Python 3.8.

### Conda Setup
The most reliable way to manage the environment is via Conda:
```bash
conda create -n TIPP python=3.8
conda activate TIPP
conda install bioconda::tipp
```

### Containerized Execution
For systems where dependency conflicts occur, use the official Docker or Apptainer images:
*   **Docker**: `docker pull weigelworld/tipp:latest`
*   **Apptainer**: `apptainer pull docker://weigelworld/tipp:latest`

## Command Line Usage

### Organellar Assembly (TIPPo)
The primary script for organellar assembly is `TIPPo.v2.3.pl` (or the version-specific equivalent in your path).

**Basic Command:**
```bash
TIPPo.v2.3.pl -f input_hifi_reads.fastq.gz
```

### Telomere and Plastid Modules
*   **TIPP_telomere**: Used for localized assembly of telomeric regions.
*   **TIPP_plastid**: Specifically for plastid assembly (note: version 1 requires a specific chloroplast/mitochondrial database).

### Database Preparation
For TIPP_plastid (v1) tasks, you must download the reference database:
```bash
wget https://figshare.com/ndownloader/files/44102183 -O Plant_chlo_mito.fa.gz
```

## Expert Tips and Best Practices

*   **Input Data**: TIPP is optimized for PacBio HiFi data. Using standard CLR or low-accuracy Nanopore data may result in fragmented assemblies or failure during the TIARA classification step.
*   **Resource Management**: The pipeline uses KMC3 for k-mer counting. Ensure your working directory has sufficient disk space for temporary k-mer database files, especially when processing large whole-genome sequencing (WGS) datasets to extract organellar reads.
*   **Windows Compatibility**: TIPP is not natively supported on Windows. Use Windows Subsystem for Linux (WSL2) with an Ubuntu distribution for the best experience.
*   **Classification**: The tool uses TIARA to distinguish between nuclear, mitochondrial, and chloroplast sequences. If your organism is highly divergent from standard plant models, verify the classification results in the intermediate output files.

## Reference documentation
- [TIPPo: A User-Friendly Tool for De Novo Assembly of Organellar Genomes with HiFi Data](./references/anaconda_org_channels_bioconda_packages_tipp_overview.md)
- [TIPP GitHub Repository and Usage Guide](./references/github_com_Wenfei-Xian_TIPP.md)