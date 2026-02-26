---
name: mentalist
description: "MentaLiST is a high-performance MLST caller that uses a k-mer counting algorithm for rapid bacterial genotyping. Use when user asks to download MLST schemas, build custom k-mer databases, or call alleles from sequencing reads."
homepage: https://github.com/WGS-TB/MentaLiST
---


# mentalist

## Overview
MentaLiST is a high-performance MLST caller designed to handle the computational challenges of large-scale bacterial genotyping. While traditional MLST uses a small number of housekeeping genes, modern surveillance often uses hundreds (cgMLST) or thousands (wgMLST) of genes. MentaLiST utilizes a k-mer counting algorithm implemented in Julia to provide rapid allele calling with low memory requirements, making it significantly faster than alignment-based callers for large schemes.

## Installation and Setup
The tool is primarily distributed via Docker or manual Julia installation. Note that Conda packages for MentaLiST are frequently outdated and may be broken.

- **Docker (Recommended):**
  ```bash
  docker pull matnguyen/mentalist:latest
  docker run -v ${PWD}:/data matnguyen/mentalist mentalist -h
  ```
- **Manual Julia Setup:** Requires Julia >= 1.0 and specific packages (BioSequences, ArgParse, JSON, etc.).

## Core Workflows

### 1. Preparing the MLST Schema
Before calling alleles, you must download or build a k-mer database for the target organism.

- **Download from PubMLST:**
  ```bash
  mentalist download_pubmlst -s "Streptococcus pyogenes" -o spyo_db
  ```
- **Download from Enterobase:**
  ```bash
  mentalist download_enterobase -s "Salmonella" -o salm_db
  ```
- **Build from Custom FASTA:**
  If you have a custom set of alleles in FASTA format:
  ```bash
  mentalist build_db --fasta alleles.fasta -k 31 -o custom_db
  ```

### 2. Allele Calling
Once the database is ready, run the calling algorithm on your sequencing reads (FASTQ).

- **Standard Call:**
  ```bash
  mentalist call -o output_prefix -db spyo_db/spyo.jld --paired read1.fastq.gz read2.fastq.gz
  ```

## Expert Tips and Best Practices

- **K-mer Size Constraints:** Do not exceed a k-mer size of 31. Using $k > 31$ is known to cause errors in the current implementation.
- **Large Scheme Compression:** When building databases for massive wgMLST schemes, use the `-c` (allele coverage) option to compress the scheme. This requires the Gurobi ILP solver to be installed.
- **Novel Alleles:** MentaLiST is optimized for known schemes. If a sample contains a novel allele not present in the database, the tool will identify the closest known match.
- **Resource Management:** While MentaLiST is memory-efficient, the `build_db` step for wgMLST (thousands of genes) is the most RAM-intensive phase. Ensure the environment has sufficient memory for the initial indexing.
- **Input Formats:** The tool supports both single-end and paired-end FASTQ files. Use the `--paired` flag specifically for paired-end data to ensure proper processing.

## Reference documentation
- [MentaLiST GitHub Repository](./references/github_com_WGS-TB_MentaLiST.md)
- [MentaLiST Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mentalist_overview.md)