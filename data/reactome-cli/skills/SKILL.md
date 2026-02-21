---
name: reactome-cli
description: The `reactome-cli` is a command-line utility designed to wrap Reactome's web APIs, providing a streamlined interface for biological pathway analysis.
homepage: https://github.com/reactome/reactome_galaxy
---

# reactome-cli

## Overview

The `reactome-cli` is a command-line utility designed to wrap Reactome's web APIs, providing a streamlined interface for biological pathway analysis. It eliminates the need for manual HTTP request construction, allowing researchers to submit gene lists or identifiers and receive detailed pathway analysis results in structured formats like CSV. The tool supports standard gene analysis, tissue-specific analysis (e.g., liver, heart), and species comparison analysis.

## Installation and Setup

The tool is available via Bioconda. To install:

```bash
conda install bioconda::reactome-cli
```

If running the standalone Java executable, use:
`java -jar reactome-cli.jar [command] [options]`

## Core Analysis Commands

### Gene Analysis
Use the `genes` command to analyze a list of identifiers against the Reactome database.

```bash
java -jar reactome-cli.jar genes \
  --reactome_url https://release.reactome.org \
  --identifiers_file input_genes.txt \
  --pathways results.csv
```

### Tissue-Specific Analysis
Use the `tissue` command to filter pathway analysis based on a specific biological tissue.

```bash
java -jar reactome-cli.jar tissue \
  --reactome_url https://release.reactome.org \
  --identifiers_file input_ids.txt \
  --tissue liver \
  --pathways tissue_results.csv
```

### Species Comparison
Use the `species` command to compare pathways across different species.

## CLI Best Practices

- **URL Specification**: Always provide the `--reactome_url`. For the most current stable data, use `https://release.reactome.org`.
- **Input Formatting**: The `--identifiers_file` should typically be a plain text file containing one identifier (e.g., UniProt, Entrez Gene ID) per line.
- **Help Documentation**: Access specific parameter details for any subcommand using the `--help` flag:
  - `java -jar reactome-cli.jar genes --help`
  - `java -jar reactome-cli.jar tissue --help`
- **Output Management**: Ensure the path provided to `--pathways` is writable. The tool generates a CSV file containing pathway names, identifiers, and statistical significance values (p-values/FDR).
- **GSA Analysis**: For advanced Gene Set Analysis (GSA) using the ReactomeGSA R package, ensure the environment has the necessary R dependencies if using the `reactome-gsa` specific wrappers.

## Reference documentation
- [Reactome Galaxy Integration Overview](./references/github_com_reactome_reactome_galaxy.md)
- [Bioconda reactome-cli Package](./references/anaconda_org_channels_bioconda_packages_reactome-cli_overview.md)