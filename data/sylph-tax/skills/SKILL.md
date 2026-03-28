---
name: sylph-tax
description: sylph-tax maps metagenomic profiling results from sylph to standardized taxonomic nomenclatures like GTDB or RefSeq. Use when user asks to download taxonomic metadata, convert sylph results into taxonomic profiles, generate Pavian-compatible reports, or merge multiple profiles into a single table.
homepage: https://github.com/bluenote-1577/sylph-tax
---


# sylph-tax

## Overview

sylph-tax is a Python-based utility designed to bridge the gap between the high-speed metagenomic profiling of sylph and the requirement for standardized taxonomic nomenclature. While sylph identifies genomic matches, sylph-tax maps these matches to established taxonomies (such as GTDB or RefSeq), producing profiles similar to Kraken or MetaPhlAn. This skill provides the necessary CLI patterns to manage databases, process results in restricted environments like HPC clusters, and format data for comparative analysis.

## Common CLI Patterns and Best Practices

### Database Management
Before profiling, you must obtain the relevant taxonomic metadata.
- **Standard Download**: Use `sylph-tax download` to fetch default databases.
- **Custom Location**: Use the `--download-to <directory>` flag to specify a non-default path. This is recommended for shared environments to avoid filling home directory quotas.

### Processing sylph Results
The primary workflow involves taking the `.tsv` output from a sylph run and converting it into a taxonomic profile.
- **Basic Conversion**: Run `sylph-tax` pointing to your sylph output file.
- **Pavian Compatibility**: Use the `--pavian` flag to generate a report that replicates MetaPhlAn4 columns, making it directly compatible with the Pavian Shiny app for visualization.
- **Handling Unknowns**: By default, the tool replaces empty taxonomic ranks with "UNKNOWN" to maintain table integrity.

### Expert Tips for HPC and Restricted Environments
- **Bypass Config Files**: In HPC environments with broken or non-shared file systems, use the `--no-config` option. This prevents the tool from attempting to read or write to `~/.config/sylph-tax/config.json` and allows you to explicitly define database paths via the command line.
- **Metadata Matching**: The tool is flexible with genome IDs. It can match IDs like `GCF_00120` even if the metadata file originally expected extensions like `.fa` or `.fna`.
- **Merging Profiles**: When dealing with multiple samples, ensure you are using the latest version to avoid bugs related to merging empty dataframes (samples with no detected species).



## Subcommands

| Command | Description |
|---------|-------------|
| sylph-tax download | Download taxonomy metadata |
| sylph-tax merge | Merge multiple sylph-tax taxonomy files into a single TSV table. |
| sylph-tax taxprof | Generates a taxonomy profile from SYLPH result files. |

## Reference documentation
- [sylph-tax GitHub Repository](./references/github_com_bluenote-1577_sylph-tax.md)
- [sylph-tax Changelog](./references/github_com_bluenote-1577_sylph-tax_blob_main_CHANGELOG.md)
- [sylph-tax README](./references/github_com_bluenote-1577_sylph-tax_blob_main_README.md)