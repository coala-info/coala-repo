---
name: cazy_webscraper
description: cazy_webscraper scrapes CAZyme data from the CAZy database and organizes it into a local SQLite3 database for downstream analysis. Use when user asks to scrape CAZy data, build a local CAZyme database, retrieve protein sequences and structures, or enrich CAZy datasets with UniProt and GTDB metadata.
homepage: https://hobnobmancer.github.io/cazy_webscraper/
metadata:
  docker_image: "quay.io/biocontainers/cazy_webscraper:2.3.0.4--pyhdfd78af_0"
---

# cazy_webscraper

## Overview
cazy_webscraper is a specialized bioinformatics tool designed to bridge the gap between the CAZy web interface and local analytical pipelines. It allows for the systematic scraping of CAZyme data, which is then structured into a local SQLite3 database. This enables complex querying, taxonomic filtering, and data enrichment (sequences, EC numbers, structures) that are difficult to perform manually. The tool is particularly useful for researchers needing to build comprehensive, reproducible datasets of specific CAZy classes or families for comparative genomics or structural biology.

## Core Workflows and CLI Patterns

### 1. Building the Local Database
The primary function is to scrape CAZy and initialize a SQLite3 database.
- **Basic Scrape**: Define the CAZy classes or families to retrieve.
- **Taxonomic Filtering**: Use flags to limit the scrape to specific Kingdoms, genera, or species.
- **Optimization**: Use the `--skip_ncbi_tax` flag to significantly speed up the initial scrape if you plan to use GTDB or UniProt taxonomies later, as this reduces the burden on NCBI-Entrez servers.

### 2. Data Expansion (The `expand` Subcommand)
Once the core database is built, use the `expand` functionality to pull in external metadata:
- **UniProt**: Retrieve UniProt IDs, EC numbers, and PDB accessions. In version 2.3.0+, this is significantly faster.
- **GenBank**: Download protein sequences and genomic assembly data.
- **PDB**: Download protein structure files directly to disk.
- **GTDB**: Retrieve the latest archaeal and bacterial taxonomic classifications for more accurate lineage data.

### 3. Database Maintenance and Inspection
- **Schema Inspection**: Use `cw_get_db_schema` to print the SQLite schema to the terminal. This is essential for writing custom SQL queries against the database.
- **Cleaning Stale Data**: When updating UniProt data, use specific flags to maintain database integrity:
  - `--delete_old_ec_relationships`: Removes protein-EC links no longer present in UniProt.
  - `--delete_old_pdbs`: Removes PDB accessions that are no longer linked to any proteins in your local set.

### 4. Sequence Extraction
Extract data from the local database for use in other tools:
- **FASTA Generation**: Extract sequences into a single multisequence FASTA file or individual files per protein.
- **BLAST Integration**: Automatically build a local BLASTP database from the extracted sequences.

## Expert Tips
- **Email Requirement**: While newer subcommands like `cw_get_uniprot_data` have removed the email requirement, standard NCBI-interacting commands still require a valid email address for Entrez identification.
- **Memory Management**: If working on a standard laptop, ensure you are using version 2.3.0 or the `dev` branch, which features a significantly lighter RAM footprint and faster processing (capable of building a full CAZy database in minutes).
- **Taxonomy Strategy**: For the most up-to-date bacterial/archaeal taxonomy, prioritize the GTDB expansion over the default NCBI classifications.

## Reference documentation
- [cazy_webscraper Overview](./references/anaconda_org_channels_bioconda_packages_cazy_webscraper_overview.md)
- [cazy_webscraper Documentation](./references/hobnobmancer_github_io_cazy_webscraper.md)