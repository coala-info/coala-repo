---
name: sylph-tax
description: The `sylph-tax` skill enables the transformation of raw metagenomic profiling data from `sylph` into taxonomically annotated formats.
homepage: https://github.com/bluenote-1577/sylph-tax
---

# sylph-tax

## Overview
The `sylph-tax` skill enables the transformation of raw metagenomic profiling data from `sylph` into taxonomically annotated formats. While `sylph` provides efficient profiling, its native output lacks hierarchical taxonomic strings. This tool bridges that gap, allowing researchers to generate profiles compatible with downstream visualization and analysis tools like Pavian. Use this skill to handle taxonomy assignment, merge sample results, and format outputs for GTDB or fungal databases.

## Installation and Setup
Install the tool via Bioconda:
```bash
conda install bioconda::sylph-tax
```

## Core Workflows

### Generating Taxonomic Profiles
The primary function is converting `sylph` TSV files into taxonomic profiles.
- **Input**: TSV output from a `sylph` run.
- **Output**: Taxonomic profiles in formats similar to Kraken or MetaPhlAn.
- **Pavian Support**: Use the tool to generate Pavian-compatible outputs for interactive visualization.

### Merging Results
When working with multiple samples, use the merging functionality to create a unified table.
- **Coverage Data**: The tool supports `True_cov` (True Coverage) metrics during the merge process to provide more accurate abundance estimates.
- **Empty Dataframes**: Recent versions (v1.7.1+) correctly handle merges involving samples with no detected species.

### Database Integration
The tool is designed to work with specific taxonomic databases:
- **GTDB**: Supports GTDB r226 and earlier versions.
- **Fungi**: Includes specialized support for fungal databases (v1.6.0+).
- **Metadata**: Handles metadata splits (e.g., `_ASM` or `_Genomic` suffixes) to ensure correct taxonomic mapping.

## Expert Tips and Best Practices
- **No-Config Runs**: As of v1.8.0, the tool supports "no-config" execution, simplifying the workflow by reducing the need for external configuration files.
- **Handling Metadata**: If your metadata files contain complex suffixes from assembly or genomic splits, `sylph-tax` includes logic to parse these correctly without requiring manual filename cleaning.
- **Abundance Metrics**: When merging, prioritize using the `True_cov` support to ensure that the resulting taxonomic table reflects the estimated genomic coverage rather than just raw read counts.

## Reference documentation
- [sylph-tax Overview (Bioconda)](./references/anaconda_org_channels_bioconda_packages_sylph-tax_overview.md)
- [sylph-tax Repository and README](./references/github_com_bluenote-1577_sylph-tax.md)
- [sylph-tax Version History and Changes](./references/github_com_bluenote-1577_sylph-tax_tags.md)