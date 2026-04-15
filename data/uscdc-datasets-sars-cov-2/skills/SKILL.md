---
name: uscdc-datasets-sars-cov-2
description: The uscdc-datasets-sars-cov-2 tool downloads and organizes SARS-CoV-2 genomic benchmark datasets from NCBI. Use when user asks to retrieve SARS-CoV-2 genomic datasets, organize downloaded data, validate lineages, test QC thresholds, compare sequencing platforms, benchmark metagenomic approaches, or generate a Makefile for data download.
homepage: https://github.com/CDCgov/datasets-sars-cov-2
metadata:
  docker_image: "quay.io/biocontainers/uscdc-datasets-sars-cov-2:0.7.2--hdfd78af_0"
---

# uscdc-datasets-sars-cov-2

## Overview

The `uscdc-datasets-sars-cov-2` tool provides a standardized way to retrieve and organize genomic benchmark datasets developed by the CDC's Technical Outreach and Assistance for States Team (TOAST). These datasets represent diverse real-world scenarios, including outbreak cohorts, platform comparisons (Illumina vs. MinION), and specific Variant of Interest/Concern (VOI/VOC) lineages. The core functionality is delivered via the `GenFSGopher.pl` script, which processes TSV manifests to download sequence data from NCBI and organize it into specific directory structures suitable for various bioinformatics workflows.

## Environment Setup

Before running the tool, ensure the following environment variables are set to avoid rate-limiting or errors during NCBI E-Direct requests:

```bash
export NCBI_API_KEY=your_hexadecimal_key
export EMAIL=your_email@address.com
```

## Core CLI Usage

The primary command for downloading datasets is `GenFSGopher.pl`.

### Basic Command Pattern
```bash
GenFSGopher.pl -o <output_directory> <dataset_file.tsv>
```

### Key Arguments and Options
- `-o, --outdir`: (Required) The directory where data will be stored.
- `--numcpus <int>`: Set the number of simultaneous download jobs. High values may cause Disk I/O bottlenecks.
- `--compressed`: Automatically compress files after hashsum verification is complete.
- `--shuffled`: Output reads as interleaved files instead of separate forward and reverse files.

### Directory Layouts (`--layout`)
The tool supports several organization patterns to match different pipeline requirements:
- `onedir`: (Default) All files are placed in a single directory.
- `byrun`: Each genomic run is placed in its own separate directory.
- `byformat`: Organizes files by type (e.g., Fastq in one dir, assemblies in another).
- `cfsan`: Reference and samples are separated, with each sample in its own subdirectory.

## Expert Tips and Workflows

### Dry Run for Pipeline Integration
Use the `--norun` flag to generate a `Makefile` without actually downloading the data. This is useful for inspecting the planned actions or integrating the download step into a larger automated build process.
```bash
GenFSGopher.pl -o ./data --norun sars-cov-2-voivoc.tsv
```

### Selecting the Right Dataset
Choose the dataset based on your specific validation goal:
- **Lineage Validation**: Use `sars-cov-2-voivoc.tsv` or `sars-cov-2-nonvoivoc.tsv`.
- **QC Threshold Testing**: Use `sars-cov-2-failedQC.tsv`, which contains 24 samples representing 8 specific failure scenarios.
- **Platform Consistency**: Use `sars-cov-2-coronahit-rapid.tsv` or `sars-cov-2-coronahit-routine.tsv` to compare Illumina and MinION results.
- **Outbreak Modeling**: Use `sars-cov-2-SNF-A.tsv` (Boston Outbreak) for metagenomic approach benchmarking.

### Verification
The tool automatically performs hashsum verification. If a download fails or a file is corrupted, the script will report the mismatch. Ensure `sha256sum` is available in your path (on macOS, you may need to alias `shasum -a 256`).

## Reference documentation
- [CDC SARS-CoV-2 Datasets README](./references/github_com_CDCgov_datasets-sars-cov-2.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_uscdc-datasets-sars-cov-2_overview.md)