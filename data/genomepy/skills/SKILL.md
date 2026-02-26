---
name: genomepy
description: genomepy streamlines the acquisition and preprocessing of genomic sequences and gene annotations from multiple providers through a unified interface. Use when user asks to search for assemblies, install genomes and annotations, preview annotation files, or manage local genomic data and aligner indexes.
homepage: https://github.com/vanheeringen-lab/genomepy
---


# genomepy

## Overview
genomepy is a specialized tool designed to streamline the acquisition and preprocessing of genomic sequences and gene annotations. It eliminates the manual effort of navigating various FTP sites by providing a unified interface to search and install data from Ensembl, UCSC, NCBI, and GENCODE. Beyond simple downloads, it handles file decompression, chromosome name matching, and can automatically trigger plugins to generate indexes for popular aligners like Bowtie2 or BWA.

## Core CLI Workflows

### Searching for Genomes
Before downloading, use the search command to identify the correct assembly name and provider.
- **Basic search**: `genomepy search <species_name_or_tax_id>`
- **Filter by provider**: `genomepy search zebrafish -p Ensembl`
- **Include genome size**: `genomepy search "Danio rerio" --size` (Note: This is slower but provides assembly scale).

### Inspecting Annotations
Different providers offer different annotation styles (e.g., UCSC provides ncbiRefSeq, refGene, ensGene). Use the `annotation` command to preview the first few lines of the GTF/BED file to ensure it matches your naming convention (e.g., "chr1" vs "1").
- **Preview UCSC annotations**: `genomepy annotation xenTro9 -p UCSC`

### Installing Genomes and Annotations
The `install` command is the primary way to fetch data.
- **Standard install**: `genomepy install <assembly_name> <provider>`
- **Install with gene annotations**: `genomepy install GRCz11 --annotation`
- **UCSC specific annotation**: `genomepy install xenTro9 --UCSC-annotation refGene`
- **Custom local name**: `genomepy install hg38 UCSC --localname human_hg38`

### Managing Local Genomes
- **List installed genomes**: `genomepy genomes`
- **Show genome directory**: `genomepy config generate` (to see the `genome_dir` path, usually `~/.local/share/genomes/`).

## Expert Tips and Best Practices
- **Provider Reliability**: If a download fails due to a provider being offline, try an alternative provider for the same assembly (e.g., switching from Ensembl to NCBI).
- **Plugin Management**: Use `genomepy plugin list` to see active post-processing steps. If you frequently use Bowtie2 or BWA, ensure those plugins are enabled so indexes are built automatically upon installation.
- **WSL2 Performance**: When running on Windows Subsystem for Linux (WSL2), high thread counts for indexing (like Bowtie2) can sometimes hang. If a process appears stuck, try running with fewer threads.
- **Disk Space**: Genomic data is large. Always check your available storage in the directory specified in your `genomepy.yaml` config before starting a multi-genome installation.

## Reference documentation
- [genomepy GitHub README](./references/github_com_vanheeringen-lab_genomepy.md)
- [genomepy Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_genomepy_overview.md)