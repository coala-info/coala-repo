---
name: mmpdb
description: mmpdb is a high-performance cheminformatics tool designed to identify and analyze Matched Molecular Pairs (MMPs) within large chemical libraries.
homepage: https://github.com/rdkit/mmpdb
---

# mmpdb

## Overview
mmpdb is a high-performance cheminformatics tool designed to identify and analyze Matched Molecular Pairs (MMPs) within large chemical libraries. It automates the "constant vs. variable" fragmentation of molecules to discover how specific chemical substitutions (transforms) influence biological activity or physical properties. Use this skill to build searchable MMP databases, execute medicinal chemistry design strategies, and perform data-driven property predictions or structure generation.

## Core Workflow and CLI Patterns

The standard mmpdb workflow follows a sequential pipeline: fragmentation, indexing, property loading, and analysis.

### 1. Fragmentation
Break molecules into constant (core) and variable (R-group) parts.
```bash
# Fragment a SMILES file into a fragment file
mmpdb fragment molecules.smi --output fragments.mmpdbf
```
*   **Tip**: By default, it cuts 1, 2, or 3 non-ring bonds. Use `--max-cuts` to limit this for faster processing on very large sets.

### 2. Indexing
Find pairs with the same constant part to define transformations.
```bash
# Create the MMP database from fragments
mmpdb index fragments.mmpdbf --output project.mmpdb
```
*   **Performance**: Use the `--memory` flag to speed up indexing if the `psutil` module is installed.

### 3. Loading Properties
Associate experimental data (e.g., IC50, LogP) with the molecular pairs.
```bash
# Load property data from a CSV/TSV file
mmpdb loadprops --properties data.csv project.mmpdb
```
*   **Format**: The CSV should typically contain a column matching the molecule identifiers used in the SMILES file.

### 4. Analysis and Generation
Apply the database to new structures.
```bash
# Find possible transforms for a new structure
mmpdb transform --smiles "c1ccccc1C" --db project.mmpdb

# Predict property changes for a structure
mmpdb predict --smiles "c1ccccc1C" --db project.mmpdb

# Generate new structures using 1-cut rules
mmpdb generate --smiles "c1ccccc1C" --db project.mmpdb
```

## Expert Tips and Best Practices

*   **Rule Environments**: mmpdb uses circular fingerprints (Morgan-style) to describe the local environment of attachment points. Use the `help-analysis` command to understand how SMARTS and "pseudo-SMILES" represent these environments.
*   **Database Backends**: While SQLite is the default for local projects, use the `help-postgres` command for instructions on scaling to multi-user, high-volume datasets using PostgreSQL.
*   **Memory Management**: For large datasets, fragmentation and indexing can be resource-intensive. Ensure your environment has sufficient RAM or use the distributed processing options described in `mmpdb help-distributed`.
*   **Validation**: Always verify your input SMILES are sanitized. While mmpdb handles many RDKit-compatible structures, pre-cleaning your dataset prevents indexing errors.

## Reference documentation
- [mmpdb GitHub README](./references/github_com_rdkit_mmpdb.md)
- [mmpdb Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mmpdb_overview.md)