---
name: kalamari
description: Kalamari is a specialized tool for managing a curated database of completed genomic assemblies and their associated taxonomies.
homepage: https://github.com/lskatz/kalamari
---

# kalamari

## Overview
Kalamari is a specialized tool for managing a curated database of completed genomic assemblies and their associated taxonomies. Unlike general-purpose databases that may contain "rogue" contigs or contaminated sequences, Kalamari focuses on high-quality, expert-verified assemblies primarily from the CDC's Enteric Diseases Laboratory Branch. It provides a streamlined workflow to download these genomes and generate a filtered, modified NCBI taxonomy that is optimized for downstream classification tools.

## Environment Setup
Before running Kalamari scripts, you must configure your environment to ensure stable communication with NCBI via `edirect`.

```bash
# Set your NCBI API key and email to avoid rate limiting and errors
export NCBI_API_KEY=your_hexadecimal_key
export EMAIL=your_email@address.com
```

## Core Workflow
The standard workflow involves downloading the sequence data and then preparing the taxonomy files.

### 1. Database Download
Download the reference genome FASTA files for chromosomes and plasmids.
```bash
# Default download to the package data directory
downloadKalamari.sh
```
*Note: This process is time-intensive as it fetches numerous high-quality assemblies.*

### 2. Taxonomy Preparation
Generate and filter the taxonomy files to match the specific genomes in the Kalamari database.
```bash
# Build the modified NCBI taxonomy dump
buildTaxonomy.sh

# Filter nodes.dmp and names.dmp to include only relevant TaxIDs
filterTaxonomy.sh
```

## CLI Patterns and Best Practices

### Locating Installed Data
When installed via Conda, Kalamari stores its data within the environment path. Use the following pattern to find your database files for use in other tools:
```bash
# Find the base directory for the current environment
echo "$CONDA_PREFIX/share/kalamari-$(kalamari_version_here)/kalamari/"
```

### Custom Taxonomy Logic
Be aware that Kalamari applies specific taxonomic overrides backed by Subject Matter Experts (SMEs):
- **Shigella**: Defined as a subspecies of *Escherichia coli*.
- **Listeria monocytogenes**: Includes definitions for the four major lineages.
These modifications are automatically included in the output of `buildTaxonomy.sh`.

### Integration with Downstream Tools
The primary output of Kalamari (FASTA files and filtered `.dmp` files) is designed to be used as input for:
- **Kraken/Kraken2**: Use the filtered taxonomy directory as the library taxonomy.
- **BLAST**: Use the downloaded FASTAs to build local BLAST databases.
- **ANI**: Use the completed assemblies for high-accuracy Average Nucleotide Identity calculations.

## Expert Tips
- **API Reliability**: Always use an `NCBI_API_KEY`. Without it, `edirect` requests often fail or hang during the large-scale downloads required by Kalamari.
- **Storage**: Ensure you have several gigabytes of free space before running `downloadKalamari.sh`, as it pulls down full, completed assemblies.
- **Verification**: After running `filterTaxonomy.sh`, the resulting `nodes.dmp` and `names.dmp` are significantly smaller than the full NCBI set, which drastically speeds up the database building process for tools like Kraken.

## Reference documentation
- [Kalamari GitHub README](./references/github_com_lskatz_Kalamari.md)
- [Kalamari Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_kalamari_overview.md)