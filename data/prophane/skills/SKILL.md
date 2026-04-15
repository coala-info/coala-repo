---
name: prophane
description: Prophane is a metaproteomics pipeline that automates taxonomic assignment and functional annotation for protein groups identified via mass spectrometry. Use when user asks to initialize metaproteomics databases, execute protein sequence alignments, assign taxonomic lineages using Lowest Common Ancestor logic, or generate functional annotations from proteomics search results.
homepage: https://gitlab.com/s.fuchs/prophane/
metadata:
  docker_image: "quay.io/biocontainers/prophane:6.2.6--hdfd78af_0"
---

# prophane

## Overview

Prophane is a comprehensive metaproteomics pipeline designed to bridge the gap between protein identification and biological interpretation. It automates the assignment of taxonomic lineages and functional categories to protein groups identified via mass spectrometry. By leveraging a Snakemake-based workflow, it handles complex tasks such as database management, sequence alignment, and the generation of visualization-ready outputs like Krona plots and summary tables. It is particularly effective for analyzing microbial communities where proteins may map to multiple organisms, requiring sophisticated Lowest Common Ancestor (LCA) logic to ensure taxonomic accuracy.

## Core CLI Operations

Prophane uses a sub-command structure. Note that as of version 6.0, the primary executable is invoked as `prophane.py`.

### Initialization and Setup
Before running analyses, you must initialize the database directory.
- **Initialize environment**: `prophane.py init [DB_DIR]`
- **List available databases**: `prophane.py list-dbs`
- **Prepare/Download databases**: `prophane.py prepare-dbs` (This command accepts additional Snakemake options if needed).

### Running the Pipeline
The primary workflow is executed by pointing the tool to a configuration file.
- **Execute analysis**: `prophane.py run [path-to-job-config]`
- **Check version**: `prophane.py --version`

## Input and Format Support

Prophane is compatible with several standard proteomics outputs:
- **Search Results**: Supports Proteome Discoverer (XML/PSMs), mzTab, mzIdentML, Scaffold (CSV), and MPA (MetaProteomeAnalyzer) reports.
- **Sequences**: Supports standard FASTA files and gzipped FASTA files (`.fasta.gz`).
- **Quantification**: Handles protein abundance values, including cases with missing or zero values (v6.1+).

## Taxonomy and LCA Logic

Prophane offers two distinct methods for determining the Lowest Common Ancestor (LCA) of protein groups:

1.  **Per Protein Group (Default)**: Assigns an ancestor based on a support threshold (default: 1). If the ratio of proteins in a group assigned to a specific ancestor meets the threshold, that ancestor is assigned to the group.
2.  **Democratic**: Assigns the ancestor with the highest frequency of occurrence across all protein groups in the entire task.

**Expert Tip**: Use the `lca-support` column in the `summary.txt` output to evaluate the confidence of taxonomic assignments. This column indicates the number of proteins or spectra that contributed to the specific LCA determination.

## Functional Annotation Best Practices

- **eggNOG**: Prophane supports eggNOG database version 5.0.2. For large FASTA files (>10MB), the tool automatically adjusts the `block_size` parameter to optimize memory usage.
- **HMMER Tools**: When using dbCAN, PFAM, or TIGRFAM, Prophane utilizes `hmmscan` or `hmmsearch`. Ensure your database versions are current; Prophane will attempt to migrate outdated databases automatically upon execution.
- **Memory Management**: For large datasets with numerous protein groups and samples, Prophane utilizes a SQLite database (`pgs/protein_groups_db.sql`) to minimize RAM consumption during LCA calculations.

## Output Interpretation

- **summary.txt**: The primary result file containing functional and taxonomic assignments.
- **Krona Plots**: Interactive hierarchical visualizations of taxonomic or functional distributions.
- **Task Files**: Located in the `tasks/` directory, these follow the naming convention: `{annot_type}_annot_by_{tool}_on_{db_type}.v{db_version}.task{id}.{ext}`.



## Subcommands

| Command | Description |
|---------|-------------|
| prophane init | Write DB_DIR path for storing prophane databases to general config file. |
| prophane prepare-dbs | download the databases required to execute the tasks in the provided CONFIGFILE |
| prophane run | execute prophane workflow (using snakemake underneath) |
| prophane_info | This is prophane version v6.2.6 |
| prophane_list-styles | Styles available in "/usr/local/opt/prophane/styles" |

## Reference documentation
- [README](./references/gitlab_com_s.fuchs_prophane_-_blob_master_README.md)
- [Releases](./references/gitlab_com_s.fuchs_prophane_-_releases.md)
- [Changelog](./references/gitlab_com_s.fuchs_prophane_-_blob_master_changelog.md)