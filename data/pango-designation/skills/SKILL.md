---
name: pango-designation
description: The pango-designation skill provides a framework for working with the community-led SARS-CoV-2 lineage nomenclature system.
homepage: https://github.com/cov-lineages/pango-designation
---

# pango-designation

## Overview
The pango-designation skill provides a framework for working with the community-led SARS-CoV-2 lineage nomenclature system. It enables agents to efficiently handle the large-scale genomic data associated with Pango lineages, navigate the repository's data structures (such as the Sequence Designation List), and utilize built-in Python and Shell utilities for data maintenance and validation.

## Installation and Setup
The package is available via Bioconda.
```bash
conda install bioconda::pango-designation
```

### Efficient Repository Management
Because the `lineages.csv` file is extremely large and updated frequently, the repository history is massive. Always use a blobless clone to save disk space and time:
```bash
git clone --filter=blob:none https://github.com/cov-lineages/pango-designation.git
```

## Core Data Resources
The repository serves as the source of truth for three primary files:
- **lineages.csv**: The Sequence Designation List (SDL). Maps specific sequence names (from GISAID/Public databases) to Pango lineages.
- **lineage_notes.txt**: The Lineage Description List (LDL). Contains the human-readable descriptions and defining characteristics of each lineage.
- **alias_key.json**: The record of lineage aliases used to shorten long hierarchical strings (e.g., B.1.1.529.1 -> BA.1).

## Utility Scripts and Patterns
The repository includes several scripts for maintaining the integrity of the designation lists.

### Data Validation and Analysis
- **analyze_lineage_notes.py**: Use this to parse and validate the descriptions in `lineage_notes.txt`.
- **checkDups.sh / findDups.sh**: Shell utilities to identify duplicate sequence entries within the designation files.

### Deduplication Workflows
When merging new proposals or updating the SDL, use the following scripts to maintain file cleanliness:
- **deduplicate_keeping_first.py**: Removes duplicates while retaining the earliest entry.
- **deduplicate_keeping_last.py**: Removes duplicates while retaining the most recent entry.
- **drop_duplicate_rows.py**: A general utility for cleaning CSV data.

## Lineage Constellations
For AY (Delta) lineages, refer to the `lineage_constellations/` directory. These files contain mutations acquired along the phylogenetic path leading to the common ancestor of a lineage, conserved in >70% of designated sequences. These are distinct from "defining mutations" and provide a broader phylogenetic context.

## Best Practices
- **Proposing Lineages**: New lineages should be suggested by filing an issue on the GitHub repository. Proposals must include sequence names (as found on GISAID) and supporting phylogenetic evidence (e.g., a UShER tree).
- **Data Integrity**: Always run `checkDups.sh` after manually editing `lineages.csv` to ensure no sequence has been assigned to multiple conflicting lineages.
- **Version Tracking**: Use the tags and releases to ensure you are working with a stable version of the designations for reproducible research.

## Reference documentation
- [pango-designation Overview](./references/anaconda_org_channels_bioconda_packages_pango-designation_overview.md)
- [GitHub Repository README](./references/github_com_cov-lineages_pango-designation.md)
- [Repository Issues and Proposals](./references/github_com_cov-lineages_pango-designation_issues.md)