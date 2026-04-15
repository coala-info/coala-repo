---
name: flextaxd
description: Flextaxd is a modular utility for managing and merging taxonomic information into optimized SQLite databases. Use when user asks to create a custom taxonomy database, merge disparate taxonomy sources, purge inactive nodes, or export taxonomic data to standard formats.
homepage: https://github.com/FOI-Bioinformatics/flextaxd
metadata:
  docker_image: "quay.io/biocontainers/flextaxd:0.4.4--pyhdfd78af_0"
---

# flextaxd

## Overview

Flextaxd (Flexible Taxonomy Databases) is a modular Python utility that simplifies the management of taxonomic information. It allows bioinformaticians to integrate disparate taxonomy sources into a single, efficient SQLite-backed database. By focusing on minimalism and the removal of inactive nodes, it optimizes downstream classification performance. The tool is essential for researchers who need to customize taxonomic trees, annotate specific nodes, or bridge the gap between different classification standards (e.g., merging NCBI and GTDB).

## Installation and Setup

The most reliable way to install flextaxd is via Bioconda using Mamba to ensure all dependencies (like SQLite and specific Python libraries) are resolved correctly.

```bash
# Create a dedicated environment
mamba create -c conda-forge -c bioconda -n flextaxd flextaxd
conda activate flextaxd
```

## Core CLI Usage Patterns

### Creating a Database
To initialize a new FlexTaxD database from a taxonomy file (TSV or MP-style):

```bash
flextaxd --taxonomy_file taxonomy.tsv --database my_custom_db.ftd
```

### Database Maintenance and Statistics
Check the health and composition of your database:

```bash
# View database statistics
flextaxd --stats

# Purge genomes that are missing from the database (including tree nodes)
flextaxd --purge_database
```

### Exporting Data
To use the database with external tools, export it back to standard formats:

```bash
# Export to NCBI formatted files
flextaxd --dump

# Export to a custom TSV
flextaxd --dump --format tsv
```

## Expert Tips and Best Practices

- **Source Compatibility**: Flextaxd supports multiple formats including NCBI, TSV, and MP-style (used by GTDB, QIIME, SILVA, and CanSNPer). Ensure your input file matches one of these standards.
- **Visualization**: If you need to visualize the taxonomic tree, ensure `biopython` and `matplotlib` are installed. These are required for Newick and tree visualizations.
- **Genome Downloads**: For workflows involving genome acquisition, flextaxd relies on `ncbi-genome-download`. It now uses the dehydrate/rehydrate method for large downloads, which is more stable for high-volume data.
- **Interactive Conflict Resolution**: When merging databases where multiple parents might exist for a node, flextaxd uses the `inquirer` library to provide interactive prompts. Run the tool in a TTY-enabled terminal for these operations.
- **Log Management**: The tool expects a `logs/` directory for certain operations (like `flextaxd-create`). While newer versions attempt to create this automatically, it is a best practice to ensure the directory exists in your working path.

## Reference documentation

- [FlexTaxD GitHub Repository](./references/github_com_FOI-Bioinformatics_flextaxd.md)
- [FlexTaxD Wiki Home](./references/github_com_FOI-Bioinformatics_flextaxd_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_flextaxd_overview.md)