---
name: gencube
description: Gencube provides a unified command-line interface for searching and retrieving multi-omics resources from NCBI, Ensembl, and UCSC. Use when user asks to find genome assemblies, download gene sets or sequences, retrieve comparative genomics data, or fetch sequencing metadata.
homepage: https://github.com/snu-cdrc/gencube
---


# gencube

## Overview
The `gencube` tool provides a unified command-line interface for retrieving multi-omics resources. It streamlines the process of finding and downloading genome assemblies, annotations, and sequencing metadata by aggregating data from disparate sources like NCBI, Ensembl, and UCSC. Use this skill to automate the acquisition of genomic assets while maintaining consistency in chromosome labeling and assembly versions.

## Setup and Configuration
Before first use, initialize your credentials to avoid rate limiting and enable access to NCBI services.
- **Initialization**: Run `gencube` or `gencube info` to prompt for your email and NCBI API key.
- **API Key Benefit**: Using an NCBI API key increases the request limit from 3 to 10 requests per second, significantly speeding up `seqmeta` operations.
- **Storage**: Credentials are saved in `~/.gencube_entrez_info`.

## Core CLI Patterns

### Searching for Genomes
Use the `genome` subcommand to locate assemblies. You can search by scientific name, common name, accession, or UCSC name.

```bash
# Search by scientific name (recommended for precision)
gencube genome homo_sapiens

# Search by assembly accession or UCSC name
gencube genome GCF_000001405.40 hg38

# Filter by assembly level and latest version
gencube genome "Canis lupus familiaris" --level complete,chromosome --latest
```

### Downloading Annotations and Sequences
The subcommands `geneset`, `annotation`, and `sequence` follow the same keyword logic as `genome`.

```bash
# Download gene sets for a specific assembly
gencube geneset GRCh38

# Retrieve specific sequence data
gencube sequence homo_sapiens
```

### Comparative Genomics
Use `crossgenome` for homology data, protein alignments, or codon alignments.

```bash
# Search for comparative data
gencube crossgenome homo_sapiens
```

### Metadata Retrieval
The `seqmeta` subcommand is used to fetch integrated metadata for experimental sequencing data (SRA/ENA/DDBJ).

```bash
# Retrieve metadata for a specific taxon or study
gencube seqmeta "Mus musculus"
```

## Expert Tips and Best Practices
- **Assembly Levels**: By default, `gencube` searches for `complete` and `chromosome` levels. If you need draft assemblies, explicitly set `--level complete,chromosome,scaffold,contig`.
- **Case Sensitivity**: Keywords are case-insensitive (e.g., `GRCh38` and `grch38` are equivalent).
- **Multiple Keywords**: You can pass multiple space-separated keywords to merge search results into a single output.
- **RefSeq vs. GenBank**: Use the `-r` or `--refseq` flag to filter specifically for RefSeq accessions (GCF_*) when high-quality curated data is required.
- **UCSC Compatibility**: Use the `-u` or `--ucsc` flag to ensure the assemblies found have corresponding UCSC names, which is helpful for browser compatibility.

## Reference documentation
- [Gencube GitHub Repository](./references/github_com_snu-cdrc_gencube.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_gencube_overview.md)