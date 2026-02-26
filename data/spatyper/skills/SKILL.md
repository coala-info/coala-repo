---
name: spatyper
description: spatyper identifies the *spa* type of *Staphylococcus aureus* strains by analyzing repeat sequences within the *spa* gene. Use when user asks to identify *spa* types from FASTA files, perform genomic surveillance of *S. aureus*, or process PCR products for strain typing.
homepage: https://github.com/HCGB-IGTP/spaTyper
---


# spatyper

## Overview

spatyper is a specialized bioinformatics tool used to identify the *spa* type of *Staphylococcus aureus* strains. It functions by identifying specific repeat sequences within the *spa* gene and determining their arrangement. The tool automatically synchronizes with the Ridom Spa Server to ensure the latest repeat and type definitions are used. This skill should be used during genomic surveillance, clinical diagnostics, or epidemiological studies involving *S. aureus* to provide standardized strain typing.

## Installation and Setup

The tool is available via Bioconda or PyPI.

```bash
# Using Conda
conda install bioconda::spatyper

# Using Pip
pip install spaTyper
```

## Common CLI Patterns

### Basic Identification
To identify the *spa* type from one or more FASTA files:

```bash
spaTyper -f sample1.fasta sample2.fasta
```

### Batch Processing
Use the globbing flag to process all FASTA files in a directory:

```bash
spaTyper -g "*.fasta" --output all_results.txt
```

### PCR Product Enrichment
If the input sequences are raw PCR products or if standard detection fails, use the enrichment flag. This triggers a search for sequences produced by specific primer sets (e.g., TAAAGACGATCCTTCGGTGAG):

```bash
spaTyper -f pcr_product.fasta -e
```

### Offline Usage and Local Databases
By default, the tool attempts to download `sparepeats.fasta` and `spatypes.txt` from the Ridom server. For offline environments or to ensure reproducibility with specific database versions, provide local files:

```bash
spaTyper -f genome.fasta -r /path/to/sparepeats.fasta -o /path/to/spatypes.txt
```

## Expert Tips and Best Practices

- **Database Caching**: Use the `-d` flag to specify a persistent folder for downloaded Ridom files. This prevents the tool from re-downloading the database on every execution, which is critical for large-scale batch jobs.
- **Primer Specificity**: The enrichment mode (`-e`) uses four specific primer sets. If your lab uses custom primers not included in the default list (see `github_com_HCGB-IGTP_spaTyper.md`), you may need to extract the *spa* locus manually before running the tool.
- **Multiple Products**: If a single FASTA file contains multiple PCR products, `spaTyper` will identify and print the *spa* types for each detected product to stdout.
- **Output Interpretation**: The output provides both the eGenomics letter combination and the numerical Ridom *spa* type (e.g., t008).

## Reference documentation

- [spaTyper GitHub Repository](./references/github_com_HCGB-IGTP_spaTyper.md)
- [spaTyper Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_spatyper_overview.md)