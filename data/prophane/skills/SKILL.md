---
name: prophane
description: Prophane automates the functional and taxonomic characterization of metaproteomes by mapping protein groups and quantification data against biological databases. Use when user asks to perform Lowest Common Ancestor determination, conduct functional enrichment analysis, or characterize the taxonomic composition of a microbial community.
homepage: https://gitlab.com/s.fuchs/prophane/
---


# prophane

## Overview

Prophane is a specialized bioinformatics pipeline designed to automate the functional and taxonomic characterization of metaproteomes. It takes protein groups and quantification data as input and maps them against various biological databases to provide a comprehensive summary of "who is doing what" in a microbial community. It is particularly useful for researchers who have completed their initial database searches and need to perform Lowest Common Ancestor (LCA) determination and functional enrichment analysis.

## Installation and Setup

Prophane is primarily distributed via Bioconda.

```bash
# Install via conda
conda install -c bioconda prophane

# For faster dependency resolution, use mamba
mamba install -c bioconda prophane
```

### Database Initialization
Before running analyses, you must initialize a directory for the required databases. Prophane can automatically download the databases specified in your configuration.

```bash
# Initialize the database directory
prophane.py init /path/to/database_directory
```

## Common CLI Patterns

As of version 6.0, the primary command-line interface uses `prophane.py`.

### Running an Analysis
The core workflow is executed by passing a configuration file to the `run` command.

```bash
prophane.py run path/to/job_config.yaml
```

### Database Management
Use these commands to inspect the state of your local Prophane environment:

```bash
# List all available and configured databases
prophane.py list-dbs

# List available output styles/templates
prophane.py list-styles

# Check the installed version
prophane.py --version
```

### Preparing Databases
If you need to prepare or migrate databases without running a full analysis:

```bash
prophane.py prepare-dbs
```

## Expert Tips and Best Practices

### Input Format Support
Prophane supports a wide variety of search engine outputs. Ensure your input files match these supported types:
- **Proteome Discoverer**: Supports XML and PSM exports.
- **mzIdentML**: Supports large .mzid files (v6.0.5+).
- **mzTab**: Standardized proteomics exchange format.
- **Scaffold**: Supports spectrum count columns.
- **Fasta**: Supports gzipped (.gz) protein database files.

### LCA Determination Methods
Prophane offers two distinct methods for taxonomic assignment. Choosing the right one depends on your specific research goals:
1. **Per Protein Group (Default)**: Uses a support threshold (default: 1). If the ratio of proteins assigned to an ancestor meets the threshold, that ancestor is assigned to the group.
2. **Democratic**: Assigns the taxon with the highest occurrence among all protein groups in the task.

### Memory Management
For large-scale metaproteomics (large numbers of protein groups and samples), Prophane uses a SQLite database (`pgs/protein_groups_db.sql`) to store intermediate information, significantly reducing RAM consumption compared to earlier versions.

### Troubleshooting Database Migrations
If you encounter crashes when running `list-dbs` on an environment with older data, Prophane will attempt to automatically migrate the database schema to the current version (Schema v5 as of Prophane 6.0).

## Reference documentation
- [prophane - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_prophane_overview.md)
- [Releases · Stephan Fuchs / prophane · GitLab](./references/gitlab_com_s.fuchs_prophane_-_releases.md)
- [README.md · master · Stephan Fuchs / prophane · GitLab](./references/gitlab_com_s.fuchs_prophane_-_blob_master_README.md)