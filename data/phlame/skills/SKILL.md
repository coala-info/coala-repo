---
name: phlame
description: PHLAME is a bioinformatics pipeline for high-resolution intraspecies profiling and estimating strain divergence from reference phylogenies. Use when user asks to identify specific clades within a species, quantify genomic novelty, or track strain dynamics in metagenomic samples.
homepage: https://github.com/quevan/phlame
---


# phlame

## Overview

PHLAME (Phylogenetic-based Metagenomic Evaluation) is a specialized bioinformatics pipeline for high-resolution intraspecies profiling. While standard taxonomic profilers often stop at the species level, PHLAME identifies specific clades within a species and estimates the degree to which strains in a sample have diverged from the reference phylogeny. This "novelty-aware" capability allows researchers to quantify the proportion of diversity that cannot be explained by existing reference genomes, making it a powerful tool for tracking pathogen evolution and strain dynamics in complex microbial communities.

## Installation and Setup

PHLAME has several heavy bioinformatics dependencies (samtools, bcftools, RaXML). Using Conda is the recommended method to ensure all environment requirements are met:

```bash
conda install -c bioconda phlame
```

Ensure you have an aligner like `bowtie2` installed if you are starting from raw FASTQ sequencing data.

## Core Workflow

### 1. Database Construction
To profile a specific species, you must first create a reference database. This requires:
- A high-quality assembled reference genome (.fasta).
- A collection of whole genome sequences (WGS) for that species to capture known diversity.

The process involves generating a candidate mutation table, creating a phylogeny (often using RaXML), and then compiling these into a PHLAME-formatted database.

### 2. Metagenomic Classification
Once a database is prepared, use the `phlame classify` command to analyze metagenomic samples.

**Input Requirements:**
- Metagenomic sequencing data in `.fastq` or aligned `.bam` format.
- A pre-built PHLAME reference database.

**Key Metric: Divergence (DVb)**
Pay close attention to the DVb metric in the output. It estimates the point on individual branches of a phylogeny where novel strains in your sample are inferred to diverge from known references. A high DVb suggests the presence of a strain significantly different from those in your reference database.

## Best Practices

- **Reference Selection**: The quality of your intraspecies profiling is directly tied to the diversity of the genomes used to build the reference database. Include as many representative strains as possible.
- **Read Alignment**: If starting from FASTQ files, ensure your alignment parameters are sensitive enough to capture intraspecies variations but stringent enough to avoid cross-species contamination.
- **Resource Management**: Building databases and running classifications on large metagenomes can be computationally intensive. Ensure `samtools` and `bcftools` are accessible in your PATH.
- **Visualization**: Use the built-in visualization tools to inspect the distribution of clades and the divergence estimates across the phylogeny to identify potential "novelty" hotspots.

## Reference documentation
- [PHLAME GitHub Repository](./references/github_com_quevan_phlame.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_phlame_overview.md)