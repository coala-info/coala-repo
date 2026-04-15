---
name: coidb
description: The coidb tool automates the retrieval, taxonomic reconciliation, and formatting of BOLD sequence data for metabarcoding workflows. Use when user asks to generate reference databases, retrieve COI sequences from GBIF, or format FASTA files for SINTAX and DADA2.
homepage: https://github.com/johnne/coidb
metadata:
  docker_image: "quay.io/biocontainers/coidb:0.4.8--pyhdfd78af_0"
---

# coidb

## Overview
The `coidb` tool is a specialized pipeline designed to bridge the gap between public sequence repositories and metabarcoding bioinformatics workflows. It automates the retrieval of sequence and taxonomic metadata from GBIF-hosted BOLD datasets, performs taxonomic reconciliation (resolving ambiguous assignments using consensus rules), and filters data based on specific marker genes or taxonomic groups. The tool's primary value lies in its ability to generate pre-formatted FASTA files that are immediately compatible with popular classification algorithms, saving researchers significant manual data-wrangling time.

## Installation and Setup
The most efficient way to deploy the tool is via the Bioconda channel:
`conda install -c bioconda coidb`

## Core Workflow Patterns

### Initial Testing
Before committing to a full download and processing run, always perform a dry run to validate the execution steps:
`coidb -n`

### Standard Execution
To run the full pipeline using default settings (COI-5P gene, 100% identity clustering, all phyla), use:
`coidb --cores 4`

### Managing Resources and Workspace
- **Parallelization**: Use the `-j` or `--cores` flag to specify the number of CPU cores. This is critical for the clustering step (vsearch).
- **Directory Management**: Use `--workdir <path>` to specify where the database should be built. If a run is interrupted and the directory is locked, use the `-u` or `--unlock` flag to resume.
- **Forcing Updates**: To re-run the pipeline even if files exist (e.g., to fetch newer data from GBIF), use the `-f` or `--force` flag.

## Output Formats and Downstream Compatibility
The tool produces four primary FASTA files in the working directory, each tailored for specific tools:

1. **Standard Cleaned**: `bold_clustered_cleaned.fasta`
   - General-purpose clustered sequences.
   - Header format: `>Representative_ID Taxonomy_String;BOLD_BIN`

2. **SINTAX Format**: `bold_clustered.sintax.fasta`
   - Optimized for `vsearch -sintax`.
   - Note: Taxonomic ranks are shifted (Kingdom becomes Domain, etc.) to accommodate SINTAX's 8-rank limit, with the BOLD BIN ID assigned to the species ('s') rank.

3. **DADA2 assignTaxonomy**: `bold_clustered.assigntaxonomy.fasta`
   - Formatted specifically for the DADA2 `assignTaxonomy` function.
   - Headers contain the full taxonomic path separated by semicolons.

4. **DADA2 addSpecies**: `bold_clustered.addSpecies.fasta`
   - Formatted for the DADA2 `addSpecies` function to provide species-level resolution.

## Expert Tips and Best Practices
- **Taxonomic Filling**: `coidb` automatically handles missing taxonomic ranks by propagating the last known higher-level rank and suffixing it with `_X`. This prevents gaps in the taxonomy string that can crash some classifiers.
- **Clustering Logic**: By default, clustering is performed at 100% identity on a per-species or per-BIN basis. If you require a broader reference set (e.g., 97% or 95%), this must be defined in the configuration file.
- **Gene Filtering**: While the default is `COI-5P`, the tool can be configured to include other markers like `COI-3P`.
- **Phyla Filtering**: To save time and disk space, you can restrict the database to specific groups (e.g., only Arthropoda) via the configuration settings.

## Reference documentation
- [coidb GitHub Repository](./references/github_com_biodiversitydata-se_coidb.md)
- [coidb Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_coidb_overview.md)