---
name: contigtax
description: contigtax is a bioinformatics tool designed to assign taxonomic labels to metagenomic contigs.
homepage: https://github.com/NBISweden/contigtax
---

# contigtax

## Overview

contigtax is a bioinformatics tool designed to assign taxonomic labels to metagenomic contigs. It operates by querying nucleotide sequences against a protein database using `diamond blastx` (or blastp for ORFs). Unlike simple LCA (Lowest Common Ancestor) approaches, contigtax utilizes rank-specific thresholds to improve assignment accuracy. It is particularly effective for metatranscriptomics and metagenomics projects where protein-level homology provides deeper or more reliable taxonomic insights than nucleotide-level searches.

## Installation and Setup

The tool is primarily distributed via Bioconda.

```bash
# Install via Conda
conda install -c bioconda contigtax

# Alternative: Use Docker
docker pull nbisweden/contigtax
```

## Core Workflow

The contigtax pipeline consists of database preparation followed by the search and assignment phases.

### 1. Database Preparation
You must first acquire the reference data and build a Diamond-compatible database.

```bash
# Download reference protein data (e.g., uniref100, uniref90, or uniref50)
contigtax download uniref100

# Download NCBI taxonomy files
contigtax download taxonomy

# Reformat the fasta file and create a taxon map
contigtax format uniref100/uniref100.fasta.gz uniref100/uniref100.reformat.fasta.gz

# Build the Diamond database
# Requires the reformatted fasta, the accession2taxid mapping, and the taxonomy nodes
contigtax build uniref100/uniref100.reformat.fasta.gz uniref100/prot.accession2taxid.gz taxonomy/nodes.dmp
```

### 2. Taxonomic Assignment
Once the database is built, run the search and assignment on your assembled contigs.

```bash
# Step A: Search
# -p specifies threads. Input is your assembly (FASTA) and the built .dmnd file.
contigtax search -p 8 assembly.fa uniref100/diamond.dmnd assembly.tsv.gz

# Step B: Assign
# Converts search hits into final taxonomic assignments using rank-specific thresholds.
contigtax assign -p 8 assembly.tsv.gz assembly.taxonomy.tsv
```

## Expert Tips and Best Practices

- **Thread Optimization**: Always use the `-p` flag in both `search` and `assign` steps to utilize multi-core processing, as Diamond search is computationally intensive.
- **Memory Management**: When building databases (especially NR or UniRef100), ensure the system has sufficient RAM. UniRef90 or UniRef50 are faster alternatives if computational resources are limited or if high-sequence identity isn't strictly required.
- **Docker Usage**: If running via Docker, use the following volume mounting pattern to ensure the tool can access your local files:
  `docker run --rm -v $(pwd):/work nbisweden/contigtax <command>`
- **Input Types**: While typically used for contigs (nucleotide), the tool can also handle ORFs. The underlying mechanism uses `diamond blastx` for nucleotide inputs to translate them on-the-fly against the protein database.
- **Threshold Logic**: The tool's accuracy stems from rank-specific thresholds (e.g., different identity requirements for Genus vs. Phylum). If assignments seem too conservative, verify that your reference database is comprehensive.

## Reference documentation
- [contigtax GitHub README](./references/github_com_NBISweden_contigtax.md)
- [contigtax Wiki Home](./references/github_com_NBISweden_contigtax_wiki.md)
- [Bioconda contigtax Overview](./references/anaconda_org_channels_bioconda_packages_contigtax_overview.md)