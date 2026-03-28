---
name: guidescan
description: GuideScan2 is a bioinformatics toolset for designing CRISPR guide RNAs and assessing their specificity through off-target analysis. Use when user asks to download genomic indices, enumerate gRNAs, or generate specificity-ranked guide databases in CSV or SAM formats.
homepage: https://github.com/pritykinlab/guidescan-cli
---

# guidescan

## Overview

GuideScan2 (guidescan) is a specialized bioinformatics toolset for the systematic design and specificity assessment of CRISPR guide RNAs. It is primarily used to generate gRNA databases for custom genomes and to evaluate potential off-targets using Cutting Frequency Determination (CFD) scores. Use this skill to navigate the CLI for database generation, guide discovery, and outputting results in standard formats like CSV or SAM for downstream genomic analysis.

## Installation and Setup

GuideScan2 is most efficiently installed via the Bioconda channel.

```bash
conda install -c bioconda guidescan
```

To verify the installation and check the current version:
```bash
guidescan --version
```

## Core Workflows

### 1. Database Management
Before enumerating guides, you must have a processed genomic database. GuideScan2 includes a utility to fetch pre-indexed resources.

- **Download**: Use the `download` subcommand to retrieve genomic indices.
- **Pattern**: `guidescan download --download-url <URL>`

### 2. Guide Enumeration
The `enumerate` command is the primary tool for identifying gRNAs within a target region or genome.

- **Output Formats**: Use the `--format` flag to specify the output type.
  - `csv`: Best for manual inspection and spreadsheet-based filtering.
  - `sam`: Best for integration into standard bioinformatics pipelines (e.g., viewing in IGV or processing with samtools).
- **Specificity Analysis**: The tool automatically calculates CFD scores during enumeration to rank guides by their off-target risk.

### 3. Common CLI Patterns
- **CSV Generation**: `guidescan enumerate --format csv`
- **SAM Generation**: `guidescan enumerate --format sam`

## Expert Tips and Best Practices

- **Handling Wildcards**: GuideScan2 automatically filters out gRNAs containing wildcard nucleotides (N) or those with incorrect lengths to ensure synthesis compatibility.
- **Specificity Accuracy**: When using SAM output, ensure you are using version 2.1.8 or later, as these versions include critical fixes for specificity calculations and coordinate mapping (ensuring match positions reflect the chromosome/position of the match rather than the k-mer).
- **PAM Flexibility**: The tool supports alternate PAM sequences. If your research involves non-SpCas9 nucleases, ensure the database was indexed with the appropriate PAM requirements.
- **Memory Management**: For genome-wide enumeration, ensure the environment has sufficient RAM to load the genomic index, as GuideScan2 utilizes high-performance C++ structures for rapid lookups.



## Subcommands

| Command | Description |
|---------|-------------|
| guidescan download | Downloads GuideScan data over HTTP. |
| guidescan index | Builds an genomic index over a FASTA file. |
| guidescan_enumerate | Enumerates off-targets against a reference. |

## Reference documentation

- [anaconda_org_channels_bioconda_packages_guidescan_overview.md](./references/anaconda_org_channels_bioconda_packages_guidescan_overview.md)
- [github_com_pritykinlab_guidescan-cli.md](./references/github_com_pritykinlab_guidescan-cli.md)
- [github_com_pritykinlab_guidescan-cli_commits_master.md](./references/github_com_pritykinlab_guidescan-cli_commits_master.md)