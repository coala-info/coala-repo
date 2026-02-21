---
name: mdmcleaner
description: mdmcleaner is a bioinformatics pipeline designed for the assessment, classification, and refinement of microbial genomes, particularly those belonging to "microbial dark matter." It addresses the challenge of fragmented assemblies in Metagenome Assembled Genomes (MAGs) and Single-cell Amplified Genomes (SAGs).
homepage: https://github.com/KIT-IBG-5/mdmcleaner
---

# mdmcleaner

## Overview

mdmcleaner is a bioinformatics pipeline designed for the assessment, classification, and refinement of microbial genomes, particularly those belonging to "microbial dark matter." It addresses the challenge of fragmented assemblies in Metagenome Assembled Genomes (MAGs) and Single-cell Amplified Genomes (SAGs). The tool uses a Least Common Ancestor (LCA) approach that is uniquely "reference-DB contamination aware," meaning it can identify sequences that might be mislabeled even within the reference databases themselves. It prevents overclassification by only assigning taxonomy to levels supported by actual alignment identity.

## Core Workflows

### 1. Database Initialization
Before running analysis, you must create or download the reference database. This process integrates GTDB, RefSeq, and Silva data.

*   **Build from scratch**: `mdmcleaner makedb` (Note: This can take >13 hours).
*   **Download publication data**: Use `mdmcleaner makedb --get_pub_data` to retrieve the pre-built database used in the original publication.
*   **Resume**: If a download or build is interrupted, simply run the same command again to resume from the last checkpoint.

### 2. Configuration Management
mdmcleaner relies on a configuration file for database paths and tool locations (BLAST, Diamond, etc.).

*   **View current settings**: `mdmcleaner show_configs`
*   **Set database path**: `mdmcleaner set_configs -s global --db_basedir /path/to/database`
*   **Local configuration**: Use `-s local` to create an `mdmcleaner.config` file in your current working directory. This is preferred for project-specific settings or when you lack admin privileges.

### 3. Cleaning and Refinement
The `clean` command is the primary entry point for genome processing.

*   **Basic usage**: `mdmcleaner clean -i input_genome.fasta -o output_dir`
*   **Custom config**: If your config is not in the default location, use `mdmcleaner clean -c /path/to/mdmcleaner.config ...`

### 4. Accessory Commands
*   **Completeness Check**: For a fast assessment of bin completeness based on universal markers or tRNAs: `mdmcleaner completeness -i genome.fasta`
*   **Extract Markers**: Extract specific marker gene sequences: `mdmcleaner get_markers -i genome.fasta`
*   **Taxonomy Lookup**: Get the full taxonomic path for a specific GTDB accession: `mdmcleaner acc2taxpath -a <ACCESSION>`

## Expert Tips and Best Practices

*   **Dependency Verification**: Always run `mdmcleaner check_dependencies` after installation to ensure all external binaries (blastn, blastp, diamond, hmmer, barrnap, aragorn, prodigal) are correctly mapped in your PATH or config.
*   **Avoid Overclassification**: mdmcleaner automatically scales the taxonomic depth based on alignment identity. If a contig only has a low-identity match, it will be classified at a higher rank (e.g., Family instead of Genus) to maintain accuracy.
*   **Reference Blacklisting**: Use the `refdb_contams` command (experimental) to evaluate reference database ambiguities and add identified contaminants to a blacklist, further improving the cleaning precision.
*   **Resource Allocation**: When running `makedb` or `clean`, ensure you specify threads via the config or command line to optimize performance, as the alignment steps are computationally intensive.

## Reference documentation
- [Main Documentation and CLI Usage](./references/github_com_KIT-IBG-5_mdmcleaner.md)
- [Wiki and Command Overviews](./references/github_com_KIT-IBG-5_mdmcleaner_wiki.md)
- [Bioconda Package Information](./references/anaconda_org_channels_bioconda_packages_mdmcleaner_overview.md)