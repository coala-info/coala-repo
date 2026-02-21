---
name: pgcgap
description: The Prokaryotic Genomics and Comparative Genomics Analysis Pipeline (pgcgap) is designed to streamline complex bioinformatics workflows into a unified execution.
homepage: https://github.com/liaochenlanruo/pgcgap/blob/master/README.md
---

# pgcgap

## Overview
The Prokaryotic Genomics and Comparative Genomics Analysis Pipeline (pgcgap) is designed to streamline complex bioinformatics workflows into a unified execution. It is particularly useful for researchers working with Illumina pair-end reads, Oxford Nanopore (ONT), or PacBio sequencing data. By automating the transition between assembly, gene prediction, and comparative metrics like ANI (Average Nucleotide Identity) and core-SNP phylogeny, it reduces the manual overhead of managing multiple independent tools.

## Installation and Setup
The most reliable way to deploy pgcgap and its dependencies is via Bioconda:

```bash
conda install bioconda::pgcgap
```

## Core Capabilities
The pipeline automates the following tasks in a single run:
- **Genome Assembly:** Processes raw reads (PE, ONT, or PacBio).
- **Functional Analysis:** Gene prediction, annotation, and COG assignments.
- **Comparative Genomics:** Calculates whole-genome ANI, identifies orthogroups/orthologs, and performs pan-genome analysis.
- **Phylogenetics:** Constructs phylogenetic trees based on single-core proteins and core SNPs.
- **Variant Calling:** Detects substitutions (SNPs) and insertions/deletions (indels).
- **Specialized Mining:** Searches for antimicrobial resistance (AMR) and virulence genes.

## Usage Best Practices
- **Input Preparation:** Ensure your input reads are properly formatted. The pipeline is optimized for pair-end reads but supports long-read technologies (ONT/PacBio) for hybrid or long-read-only assemblies.
- **Computational Resources:** Because the pipeline performs intensive tasks like pan-genome construction and phylogenetic tree building, ensure the execution environment has sufficient CPU cores and RAM, especially for large datasets.
- **One-Line Execution:** The primary advantage of pgcgap is its "one line of commands" philosophy. Users should aim to provide all necessary input paths and parameters in the initial call to allow the pipeline to handle the intermediate file transitions.

## Reference documentation
- [pgcgap Overview](./references/anaconda_org_channels_bioconda_packages_pgcgap_overview.md)
- [pgcgap Wiki Home](./references/github_com_liaochenlanruo_pgcgap_wiki.md)