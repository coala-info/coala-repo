---
name: genomepy
description: "genomepy streamlines the acquisition, management, and preprocessing of genomic data from multiple providers. Use when user asks to search for assemblies, download genome sequences and annotations, or manage local genome installations and aligner indexes."
homepage: https://github.com/vanheeringen-lab/genomepy
---


# genomepy

## Overview

genomepy is a specialized tool designed to streamline the acquisition and preprocessing of genomic data. It provides a unified interface to interact with multiple genomic data providers, abstracting away the complexities of different FTP structures and API formats. This skill enables the automated discovery of assemblies, the downloading of sequences and annotations, and the management of local genome installations for downstream bioinformatics workflows.

## Common CLI Patterns

### Searching for Genomes
To find available assemblies, use the `search` command with a species name or taxonomy ID.
```bash
# Search by species name
genomepy search zebrafish

# Search for a specific assembly with exact matching
genomepy search GRCz11 --exact

# Search by taxonomy ID
genomepy search 7955
```

### Installing Genomes and Annotations
When installing, specify the provider to ensure you get the desired version and metadata.
```bash
# Install a genome with gene annotations
genomepy install GRCz11 ensembl --annotation

# Install and compress with bgzip
genomepy install hg38 UCSC --annotation --bgzip

# Install with specific aligner indexes (e.g., bowtie2, star)
genomepy install mm10 UCSC --bgzip --recalculate
```

### Managing Local Genomes
```bash
# List all locally installed genomes
genomepy genomes

# Show the first few lines of installed annotations
genomepy annotation <genome_name>

# Generate or edit the configuration file
genomepy config generate
genomepy config edit
```

## Expert Tips and Best Practices

- **Provider Selection**: 
  - Use **GENCODE** for high-quality human and mouse annotations.
  - Use **Ensembl** or **NCBI** for broad taxonomic coverage.
  - Use **UCSC** when specific UCSC-style chromosome naming (e.g., "chr1") is required for compatibility with other tools.
- **Annotation Formats**: genomepy can handle GTF, GFF3, and BED. If you need to convert between them, ensure the UCSC utilities (like `genePredToBed`) are in your PATH.
- **Blacklists**: genomepy supports automatic downloading of genome blacklists (e.g., from the Boyle lab) to filter out problematic regions in NGS data.
- **Local Provider**: You can use the `Local` provider to manage your own FASTA/GTF files within the genomepy framework by providing the path to the file during installation.
- **Thread Safety**: genomepy uses `filelock` and `diskcache`, making it safe to use in multi-threaded environments or parallel workflow executions.

## Python API Usage

For scripts requiring programmatic access:
```python
import genomepy

# Access an installed genome
g = genomepy.Genome("GRCh38.p13")
seq = g.get_seq("chr1", 100, 200)

# Programmatic installation
genomepy.install_genome("GRCz11", "Ensembl", annotation=True)
```



## Subcommands

| Command | Description |
|---------|-------------|
| genomepy config | Manage configuration |
| genomepy install | Install a genome & run active plugins. |
| genomepy_annotation | Quickly inspect the metadata of each GTF annotation available for the given genome. |
| genomepy_genomes | List all available genomes. |
| genomepy_plugin | Enable or disable plugins. |
| genomepy_search | Search for genomes that contain TERM in their name, description, accession (must start with GCA_ or GCF_) or taxonomy (start). |

## Reference documentation
- [genomepy: genes and genomes at your fingertips](./references/github_com_vanheeringen-lab_genomepy_blob_master_README.md)
- [Changelog](./references/github_com_vanheeringen-lab_genomepy_blob_master_CHANGELOG.md)