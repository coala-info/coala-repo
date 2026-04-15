---
name: crabs
description: CRABS is a command-line toolkit designed to create curated, primer-specific reference databases for metagenomic and amplicon-based sequencing analysis. Use when user asks to download genomic sequences, perform in silico PCR to extract amplicons, filter sequences by quality or taxonomy, and export databases for taxonomic classifiers.
homepage: https://github.com/gjeunen/reference_database_creator
metadata:
  docker_image: "quay.io/biocontainers/crabs:1.14.0--pyhdfd78af_0"
---

# crabs

## Overview
CRABS (Creating Reference databases for Amplicon-Based Sequencing) is a command-line toolkit designed to transform raw genomic data into curated, primer-specific reference databases. It streamlines the workflow of metagenomic analysis by providing a unified pipeline to download sequences, simulate PCR amplification to isolate target regions, and apply rigorous filtering parameters. The tool uses a standardized internal format across all modules, allowing for a flexible, non-linear workflow where steps can be re-run or re-ordered to optimize the final database for specific taxonomic classifiers.

## Core Workflow and CLI Patterns

The CRABS workflow is organized into seven functional modules. Use the following patterns to build a reference database:

### 1. Data Acquisition and Import
CRABS separates the downloading of data from the importing process to allow for better error handling and flexibility.
- **Download**: Use specific download functions for different repositories (e.g., `--download-ncbi`, `--download-bold`, `--download-silva`).
- **Import**: Convert downloaded files into the internal CRABS format. This step can parse synonyms and unaccepted names to maximize the diversity of the database.

### 2. Sequence Extraction (In Silico PCR)
Extract specific amplicon regions from the imported sequences using your primer sets.
- Use the `insilico-pcr` function to simulate amplification.
- **Tip**: CRABS v1.0.0+ can extract amplicons in both directions simultaneously.
- **Tip**: If sequences lack primer-binding regions but contain the target barcode, use the alignment-based retrieval module to recover them.

### 3. Curation and Filtering
Refine the local database by applying multiple parameters:
- Filter by sequence length or quality.
- Subset the database based on specific taxonomic groups.
- Remove environmental or "unverified" sequences that may contaminate the reference.

### 4. Exporting for Classifiers
Once curated, export the database into the format required by your downstream analysis tool:
- **BLAST**: Generates files compatible with `blastn` and `megablast`.
- **IDTAXA**: Formats data for the IDTAXA taxonomic classifier.
- **General**: Supports standard FASTA and TSV formats.

## Expert Tips and Best Practices
- **Workflow Flexibility**: Because CRABS uses a consistent internal format, you can run modules in any order. If a filtering step produces unexpected results, you can return to the curation module without re-running the download or PCR steps.
- **Memory Management**: For large-scale downloads (like the full NCBI nt database), ensure you have sufficient disk space for intermediate files, though CRABS v1.0.0+ has been optimized to reduce storage requirements.
- **Concurrency**: The updated file handling in CRABS allows multiple commands to run concurrently, which is useful when building databases for multiple primer sets simultaneously.
- **Taxonomic Accuracy**: Always use the import functions that incorporate synonym mapping to ensure your database reflects current nomenclature and includes the widest possible range of relevant sequences.

## Reference documentation
- [CRABS Overview and Installation](./references/anaconda_org_channels_bioconda_packages_crabs_overview.md)
- [CRABS GitHub Repository and Workflow Guide](./references/github_com_gjeunen_reference_database_creator.md)