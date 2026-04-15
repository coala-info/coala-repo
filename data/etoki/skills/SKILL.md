---
name: etoki
description: EToKi is a modular suite of tools designed for the end-to-end processing, assembly, and comparative analysis of microbial genomic data. Use when user asks to preprocess raw reads, assemble genomes, perform MLST genotyping, conduct in silico serotyping, or generate multiple genome alignments and phylogenetic trees.
homepage: https://github.com/zheminzhou/EToKi
metadata:
  docker_image: "quay.io/biocontainers/etoki:1.2.3--hdfd78af_0"
---

# etoki

## Overview
EToKi (Enterobase Tool Kit) is a modular suite of tools designed to handle the end-to-end processing of microbial genomic data. It provides standardized pipelines that mirror the logic used by Enterobase, allowing users to move from raw FASTQ reads to assembled genomes, specific genotypes (MLST), and comparative genomic analyses. It is particularly effective for researchers working with enteric pathogens who require consistent, reproducible bioinformatic workflows.

## Installation and Setup
Before running analysis modules, ensure the environment is configured and third-party dependencies are linked.

- **Conda Installation**: `conda install bioconda::etoki`
- **Initial Configuration**: Run the following to install required third-party binaries (RAxML, SPAdes, etc.):
  `python EToKi.py configure --install --download_krakenDB`
- **Usearch Integration**: Since `usearch` is commercial, download it manually and link it:
  `python EToKi.py configure --usearch /path/to/usearch`

## Common CLI Patterns

### 1. Read Preprocessing (prepare)
Trims adapters, filters by quality, and renames reads for downstream compatibility.
- **Paired-end trimming**:
  `python EToKi.py prepare --pe R1.fastq.gz,R2.fastq.gz -p output_prefix`
- **Metagenomic merging**:
  `python EToKi.py prepare --pe R1.fastq.gz,R2.fastq.gz -p meta_out --merge --noRename`

### 2. Genome Assembly (assemble)
Supports multiple assemblers and can perform read mapping against references.
- **Standard SPAdes assembly**:
  `python EToKi.py assemble --pe R1_prep.fastq.gz,R2_prep.fastq.gz -p asm_out`
- **MEGAHIT for metagenomes**:
  `python EToKi.py assemble --pe R1.fq,R2.fq -p asm_out --assembler megahit`

### 3. MLST Genotyping (MLSType)
Identifies genotypes based on established schemes.
- **Calculate MLST genotype**:
  `python EToKi.py MLSType -i genome.fna -r references.fasta -k SchemeName -d convert.tab -o stdout`

### 4. Serotyping (EBEis)
Specific to *Escherichia* in silico serotyping.
- **Run EBEis**:
  `python EToKi.py EBEis -t Escherichia -q genome.fna -p output_prefix`

### 5. Comparative Genomics and Phylogeny
- **Multiple Genome Alignment**:
  `python EToKi.py align -r RefID:ref.fna.gz -p output_prefix ID1:genome1.fna.gz ID2:genome2.fna.gz`
- **Phylogenetic Tree Construction**:
  `python EToKi.py phylo -t snp2mut -p phylo_out -s matrix.gz --ng`

## Expert Tips
- **Memory Management**: For large datasets or complex assemblies, use the `-m` flag in the `prepare` and `assemble` modules to cap memory usage (e.g., `-m 32` for 32GB).
- **Kraken2 Database**: The `--download_krakenDB` flag downloads the 8GB minikraken2 database. If you already have a full Kraken2 database, use `--link_krakenDB /path/to/db` during configuration to save space and improve taxonomic filtering.
- **Hybrid BLAST**: Use the `uberBlast` module when high sensitivity is required; it combines BLASTn, uSearch, Minimap, and mmseqs in a single joint search.
- **Input Formatting**: When using the `align` module, ensure the input genomes are formatted as `Label:Path/to/File` to ensure the resulting tree and matrix use the correct identifiers.

## Reference documentation
- [EToKi GitHub Repository](./references/github_com_zheminzhou_EToKi.md)
- [EToKi Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_etoki_overview.md)