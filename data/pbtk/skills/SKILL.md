---
name: pbtk
description: pbtk is a suite of command-line utilities designed to process, convert, and manage Pacific Biosciences BAM files and their associated metadata. Use when user asks to convert BAM files to FASTA or FASTQ, merge multiple PacBio datasets, generate .pbi index files, or extract HiFi reads.
homepage: https://github.com/PacificBiosciences/pbbioconda
---


# pbtk

## Overview
pbtk (PacBio BAM toolkit) is a specialized suite of command-line utilities designed to handle the unique requirements of Pacific Biosciences (PacBio) BAM formats. Unlike standard genomic BAM files, PacBio BAMs contain per-record and per-ZMW (Zero-Mode Waveguide) metadata essential for secondary analysis. This toolkit provides the necessary bridge between raw instrument output and downstream bioinformatics pipelines by enabling efficient data conversion, merging, and indexing while preserving PacBio-specific information.

## Installation and Setup
pbtk is primarily distributed via the Bioconda channel. It is recommended to install it within a dedicated Conda environment.

```bash
# Install pbtk via bioconda
conda install -c bioconda pbtk

# Update pbtk
conda update pbtk
```

## Core Utilities and Usage Patterns

### Data Conversion
Use these tools to convert PacBio BAM files into standard sequence formats for use in non-PacBio aware tools.
- **bam2fasta**: Convert BAM records to FASTA format.
- **bam2fastq**: Convert BAM records to FASTQ format (includes quality scores).

```bash
# Basic conversion to FASTQ
bam2fastq -o output_prefix input.subreads.bam
```

### Data Management
- **pbmerge**: Merges multiple PacBio BAM files into a single output file. This tool is preferred over `samtools merge` because it correctly handles PacBio-specific headers and metadata.
- **pbindex**: Generates a `.pbi` index file. This index is required by many PacBio tools for random access and contains pre-computed metadata for faster processing.
- **pbindexdump**: Dumps the contents of a `.pbi` index file into a human-readable format (JSON or TSV) for inspection.

```bash
# Merging multiple datasets
pbmerge -o merged.bam input1.subreads.bam input2.subreads.bam input3.subreads.bam

# Indexing a BAM file
pbindex input.bam
```

### Filtering and Extraction
- **extracthifi**: Specifically designed to extract High Fidelity (HiFi) reads from a dataset.
- **zmwfilter**: Filters BAM files based on specific ZMW criteria or lists.
- **ccs-kinetics-bystrandify**: Processes kinetics information for Circular Consensus Sequencing (CCS) data, organizing it by strand.

## Expert Tips and Best Practices
- **Always Index**: Run `pbindex` on any new or merged BAM file immediately. Most PacBio-specific downstream tools (like `lima` or `pbmm2`) will fail or run significantly slower without the `.pbi` file.
- **Preserve Metadata**: Use `pbmerge` instead of standard SAMtools for merging. Standard tools may strip the `PULSE` or `ZMW` tags required for kinetics analysis or demultiplexing.
- **HiFi Workflow**: When working with Sequel II or newer data, use `extracthifi` to isolate the high-quality reads before proceeding to assembly or variant calling.
- **Environment Isolation**: PacBio tools on Bioconda often have specific dependency requirements (historically favoring Python 2.7 for certain libraries). Always install `pbtk` in a clean environment to avoid version conflicts with Python 3-only bioinformatics tools.



## Subcommands

| Command | Description |
|---------|-------------|
| bam2fasta | Converts multiple BAM and/or DataSet files into into gzipped FASTA file(s). |
| bam2fastq | Converts multiple BAM and/or DataSet files into into gzipped FASTQ file(s). |
| ccs-kinetics-bystrandify | ccs-kinetics-bystrandify converts a BAM containing CCS-Kinetics tags to a pseudo-bystrand CCS BAM with pw/ip tags that can be used as a substitute for subreads in applications expecting such kinetic information. |
| extracthifi | extract HiFi reads (>= Q20) from full CCS reads.bam output |
| pbindex | pbindex creates a index file that enables random-access to PacBio-specific data in BAM files. Generated index filename will be the same as input BAM plus .pbi suffix. |
| pbindexdump | pbindexdump prints a human-readable view of PBI data to stdout. |
| pbmerge | pbmerge merges PacBio BAM files. If the input is DataSetXML, any filters will be applied. |
| zmwfilter | Filter ZMWs from BAM data |

## Reference documentation
- [PacBio Bioconda README](./references/github_com_PacificBiosciences_pbbioconda_blob_master_README.md)
- [pbtk Package Overview](./references/anaconda_org_channels_bioconda_packages_pbtk_overview.md)