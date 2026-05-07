---
name: ncbi-datasets-cli
description: The ncbi-datasets-cli tool provides a command-line interface for programmatically searching and downloading genome assemblies, sequences, and metadata from NCBI databases. Use when user asks to download reference genomes, search for metadata by taxon or accession, filter assemblies by quality level, or fetch specific genomic files like GFF3 and protein sequences.
homepage: https://github.com/metagenlab/assembly_finder
metadata:
  docker_image: "quay.io/biocontainers/ncbi-datasets-cli:14.26.0"
---


# ncbi-datasets-cli

## Overview
The `ncbi-datasets-cli` skill provides a streamlined interface for programmatically accessing the vast biological data repositories at NCBI. It replaces older, more complex tools like E-utilities for many common tasks, offering a modern, JSON-based approach to data retrieval. This skill enables the efficient gathering of genome assemblies, transcript sequences, and associated metadata using simple command-line patterns, making it essential for reproducible bioinformatics research and large-scale genomic analysis.

## Core Command Patterns

The tool is structured around three primary subcommands: `summary` (for metadata), `download` (for data packages), and `rehydrate` (for fetching large files from a metadata-only package).

### 1. Metadata Retrieval (Summary)
Always start with `summary` to validate your query and estimate data size before downloading.

*   **Search by Taxon:**
    `datasets summary genome taxon "Staphylococcus aureus" --reference`
*   **Search by Accession:**
    `datasets summary genome accession GCF_000013425.1`
*   **Filter by Assembly Level:**
    `datasets summary genome taxon human --assembly-level complete`

### 2. Downloading Data Packages
Downloads are provided as a zip archive containing the requested sequences and a data report.

*   **Download Reference Genome:**
    `datasets download genome taxon "staphylococcus aureus" --reference`
*   **Include Specific Files (CDS, Protein, GFF3):**
    `datasets download genome taxon 1280 --include rna,protein,cds,gff3`
*   **Download by Accession List:**
    `datasets download genome accession GCF_003812505.1,GCF_001618865.1`

### 3. Advanced Filtering and Bulk Operations
*   **Limit Results:** Use `--limit` to test queries or fetch a subset.
    `datasets summary genome taxon eubacteria --limit 5`
*   **RefSeq Only:** Use `--source refseq` to exclude GenBank assemblies.
    `datasets download genome taxon "Escherichia coli" --source refseq`
*   **Exclude MAGs:** For high-quality isolates, exclude Metagenome Assembled Genomes.
    `datasets download genome taxon bacteria --mag exclude`

## Expert Tips & Best Practices

*   **API Keys:** For large-scale downloads or high-frequency queries, always use an NCBI API key to avoid rate limiting. Pass it via `--api-key <key>`.
*   **JSON Processing:** The `summary` command outputs JSON. Pipe the output to `jq` for easy parsing of specific fields like accessions or FTP paths.
    `datasets summary genome taxon "Chlamydia" | jq '.reports[].accession'`
*   **Decompression:** NCBI data packages are zipped. Use `unzip` to access the `ncbi_dataset/data/` directory where sequences are stored.
*   **Assembly Finder Logic:** When searching for the "best" available genome, follow the hierarchy: **Complete Genome > Chromosome > Scaffold > Contig**.



## Subcommands

| Command | Description |
|---------|-------------|
| dataformat excel | Convert data into an Excel workbook. |
| dataformat tsv | Convert data to TSV format. |
| datasets completion | This sub-command generates files needed to enable auto-complete for several popular command-line interpreters. |
| datasets download | Download genome, gene and virus data packages, including sequence, annotation, and metadata, as a zip file. |
| datasets rehydrate | Download data files for an unzipped, dehydrated genome data package. Data files specified in fetch.txt will be downloaded from NCBI. |
| datasets summary | Print a data report containing gene, genome or virus metadata in JSON format. |

## Reference Documentation
- [NCBI Datasets CLI Overview](./references/anaconda_org_channels_conda-forge_packages_ncbi-datasets-cli_overview.md)
- [Assembly Finder Examples](./references/github_com_metagenlab_assembly_finder_blob_main_docs_examples.md)
- [Input Patterns and Tables](./references/github_com_metagenlab_assembly_finder_blob_main_docs_inputs.md)
- [NCBI Datasets How-To Guides](./references/www_ncbi_nlm_nih_gov_datasets_docs_v2_how-tos.md)