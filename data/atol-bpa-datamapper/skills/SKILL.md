---
name: atol-bpa-datamapper
description: This tool normalizes and transforms metadata from the BPA data portal into a standardized format for the AToL Genome Engine. Use when user asks to filter raw data packages, map metadata fields using NCBI taxonomy, or extract unique biological entities like samples and organisms.
homepage: https://github.com/TomHarrop/atol-bpa-datamapper
---


# atol-bpa-datamapper

## Overview

The `atol-bpa-datamapper` is a specialized utility designed to normalize and transform metadata exported from the BPA data portal into a format compatible with AToL's Genome Engine. It operates as a three-stage pipeline: filtering raw packages based on controlled vocabularies, mapping fields to a standardized schema using taxonomic lookups, and extracting distinct biological entities (samples and organisms). The tool primarily handles compressed jsonlines (`.jsonl.gz`) and requires external reference data like the NCBI taxonomy dump for accurate metadata resolution.

## Core Workflow

The pipeline consists of three sequential commands. Data is typically piped or passed as compressed jsonlines.

### 1. Filtering Packages
Use `filter-packages` to remove irrelevant data based on package and resource-level field mappings.

```bash
filter-packages \
    -i raw_data.jsonl.gz \
    -o filtered.jsonl.gz \
    -f package_field_mapping.json \
    -r resource_field_mapping.json \
    -v value_mapping.json \
    --decision_log filtering_decisions.csv.gz
```

### 2. Mapping Metadata
Use `map-metadata` to align BPA fields with the AToL schema. This step requires NCBI taxonomy files (`nodes.dmp` and `names.dmp`).

```bash
map-metadata \
    -i filtered.jsonl.gz \
    -o mapped.jsonl.gz \
    --nodes path/to/nodes.dmp \
    --names path/to/names.dmp \
    --cache_dir ./taxonomy_cache \
    --mapping_log mapping_details.csv.gz
```

### 3. Transforming Data
Use `transform-data` to extract unique samples and organisms, resolving relationships and conflicts between packages.

```bash
transform-data \
    -i mapped.jsonl.gz \
    -o transformed.jsonl.gz \
    --unique_organisms organisms.json \
    --sample_conflicts conflicts.txt
```

## Expert Tips and Best Practices

- **Containerized Execution**: The BioContainer is the only officially supported method. Use Apptainer/Singularity to ensure environment consistency:
  `apptainer exec docker://quay.io/biocontainers/atol-bpa-datamapper:0.1.17--pyhdfd78af_0 <command>`
- **Taxonomy Caching**: Always use the `--cache_dir` flag with `map-metadata`. Processing the NCBI taxdump is resource-intensive; caching significantly speeds up subsequent runs.
- **Dry Runs**: Use the `-n` or `--dry-run` flag during initial configuration. This outputs uncompressed jsonlines to stdout, allowing for quick inspection of mapping logic without writing large files.
- **Logging for Debugging**: 
    - Use `--decision_log` in the filter step to understand why specific packages were included or excluded.
    - Use `--sanitization_changes` in the mapping step to track how raw values were modified to fit the schema.
- **Reference Data**: Ensure you are using the "new_taxdump" format from NCBI for `nodes.dmp` and `names.dmp` to avoid parsing errors.

## Reference documentation
- [Main Repository and CLI Usage](./references/github_com_TomHarrop_atol-bpa-datamapper.md)
- [Installation and Versioning](./references/anaconda_org_channels_bioconda_packages_atol-bpa-datamapper_overview.md)