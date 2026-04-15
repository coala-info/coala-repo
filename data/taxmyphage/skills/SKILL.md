---
name: taxmyphage
description: taxmyphage is a bioinformatics tool for the taxonomic classification of complete dsDNA bacteriophage genomes against the ICTV database. Use when user asks to classify phage genomes, determine genus and species assignments, or identify novel phage taxa.
homepage: https://github.com/amillard/tax_myPHAGE
metadata:
  docker_image: "quay.io/biocontainers/taxmyphage:0.3.6--pyhdfd78af_0"
---

# taxmyphage

## Overview
`taxmyphage` is a specialized bioinformatics tool designed for the taxonomic classification of complete dsDNA bacteriophage genomes. It streamlines the process of comparing a query sequence against the official ICTV database, providing genus and species-level assignments based on current taxonomic cutoffs. Use this skill when you have a newly sequenced phage and need to determine its place in the ICTV hierarchy or verify if it constitutes a novel genus.

## Core Workflows

### 1. Database Initialization
Before running classification, the required databases (MASH index, FASTA sequences, and VMR metadata) must be installed.
```bash
taxmyphage install
```

### 2. Running Classification
The primary command for classification requires an input FASTA file.
```bash
# Basic run
taxmyphage run -i query_genome.fna

# Run with multiple threads for faster BLAST/MASH processing
taxmyphage run -i query_genome.fna -t 8

# Processing multiple genomes simultaneously
taxmyphage run -i folder_of_phages/ -t 4
```

## Expert Tips and Best Practices
- **Genome Completeness**: This tool is optimized for complete or near-complete genomes. Using fragmented metagenomic assemblies may lead to inaccurate results.
- **Taxonomic Scope**: The tool is specifically designed for dsDNA phages. While it may provide results for RNA or ssDNA phages, these are not the intended targets and results should be treated with extreme caution.
- **Database Updates**: Taxonomy is updated frequently by the ICTV. If a new VMR is released (e.g., MSL40), you may need to update the database files. If the automated `install` command does not fetch the latest version, manually replace `VMR.xlsx`, `ICTV.msh`, and `Bacteriophage_genomes.fasta.gz` in the tool's database directory.
- **Output Interpretation**: The tool uses a VIRIDIC-like formula for similarity. If the similarity to the closest relative is below the ICTV genus cutoff (typically <70%), the phage likely represents a new genus.
- **Hardware Requirements**: The tool can be run on a standard laptop, but increasing the thread count (`-t`) significantly improves performance during the BLAST and MASH stages.



## Subcommands

| Command | Description |
|---------|-------------|
| taxmyphage install | Install taxmyphage databases and dependencies. |
| taxmyphage mash | Performs MASH comparison for phage classification. |
| taxmyphage run | Run taxmyphage analysis |
| taxmyphage similarity | Compares phage genomes and generates similarity reports. |

## Reference documentation
- [taxmyPHAGE GitHub README](./references/github_com_amillard_tax_myPHAGE_blob_main_README.md)
- [Bioconda taxmyphage Overview](./references/anaconda_org_channels_bioconda_packages_taxmyphage_overview.md)