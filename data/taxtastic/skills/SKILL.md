---
name: taxtastic
description: Taxtastic is a suite of tools designed to build, validate, and manage taxonomic reference packages for phylogenetic analysis. Use when user asks to create or validate reference packages, update NCBI TaxIDs, perform taxonomic lookups, or generate lineage tables from biological sequences.
homepage: https://github.com/fhcrc/taxtastic
---


# taxtastic

## Overview
Taxtastic is a specialized suite of tools designed to bridge the gap between raw phylogenetic data and standardized reference packages. It provides the `taxit` command-line interface to automate the construction of taxonomic databases, validate the structural integrity of reference bundles, and perform complex taxonomic lookups. Use this skill when you need to prepare data for phylogenetic placement, update obsolete NCBI TaxIDs, or generate tabular lineage reports from biological sequences.

## Core Workflows and CLI Patterns

### 1. Taxonomy Database Management
Before creating reference packages, you must have a local taxonomy database.
- **Create a new NCBI database**: `taxit new_database ncbi_taxonomy.db`
- **Note on Performance**: SQLite is significantly faster than PostgreSQL for initial database creation. Ensure your SQLite version is 3.8.3 or higher to support recursive common table expressions.

### 2. Reference Package (refpkg) Operations
Reference packages are the standard input for `pplacer` and `guppy`.
- **Create a package**: `taxit create -l <label> -p <prefix> --taxonomy <db_file> [files...]`
- **Validate a package**: `taxit check <my_package>.refpkg`
- **Update metadata/files**: `taxit update <my_package>.refpkg --metadata '{"key": "value"}'`
- **Rerooting**: Use `taxit reroot <my_package>.refpkg` to taxonomically reroot the reference tree.

### 3. Taxonomic Lookups and Lineages
- **Find TaxID by name**: `taxit namelookup <genus_species>`
- **Get full lineage**: `taxit get_lineage <taxid>`
- **Generate a lineage table**: `taxit lineage_table <seq_info_csv> --taxonomy <db_file>`
- **Update obsolete IDs**: If working with older datasets, run `taxit update_taxids <input_file>` to map old NCBI IDs to current ones.

### 4. Maintenance and Versioning
- **Rollback**: If a modification to a refpkg was erroneous, use `taxit rollback <my_package>.refpkg`.
- **Clean up**: Use `taxit strip <my_package>.refpkg` to remove the rollback/rollforward history and reduce file size.

## Expert Tips
- **Database Selection**: Use SQLite for local, single-user workflows. Use PostgreSQL only if you require concurrent access or integration with a larger institutional database.
- **Taxonomic Composition**: Use `taxit composition <my_package>.refpkg` to quickly audit the taxonomic diversity within a reference package.
- **Path Resolution**: Use `taxit rp <my_package>.refpkg <filename>` to get the absolute path to a specific file inside a reference package, which is useful for scripting multi-tool pipelines.

## Reference documentation
- [github_com_fhcrc_taxtastic.md](./references/github_com_fhcrc_taxtastic.md)
- [anaconda_org_channels_bioconda_packages_taxtastic_overview.md](./references/anaconda_org_channels_bioconda_packages_taxtastic_overview.md)