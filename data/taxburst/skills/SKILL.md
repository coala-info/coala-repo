---
name: taxburst
description: taxburst is a specialized tool designed to create interactive sunburst plots for taxonomic data.
homepage: https://github.com/taxburst/taxburst
---

# taxburst

## Overview

taxburst is a specialized tool designed to create interactive sunburst plots for taxonomic data. It serves as a modern, Python-based successor to the Krona software, offering better maintenance and broader support for non-NCBI taxonomies like GTDB. Use this skill when you need to transform flat taxonomic frequency tables or lineage annotations into an exploratory web-based interface. It is particularly effective for visualizing the community composition of metagenomic samples.

## Installation

Install taxburst via pip or conda to access the CLI:

```bash
pip install taxburst
# OR
conda install -c bioconda taxburst
```

## Common CLI Patterns

### 1. Visualizing Sourmash Metagenome Results
The default behavior of taxburst is optimized for the `summary_csv` format produced by `sourmash tax metagenome`.

```bash
taxburst input_summary.csv -o output_plot.html
```

### 2. Visualizing Sourmash Annotations
When using the `with-lineages` format from `sourmash tax annotate`, specify the format explicitly using the `-F` flag.

```bash
taxburst -F tax_annotate input_lineages.csv -o output_plot.html
```

### 3. Visualizing SingleM Profiles
To process output from `singlem pipe`, use the `singleM` format flag.

```bash
taxburst -F singleM input_profile.tsv -o output_plot.html
```

## Expert Tips and Best Practices

- **Format Specification**: If your input file does not match the default sourmash summary format, always use the `-F` flag. Supported formats include `tax_annotate`, `singleM`, `krona`, and `json`.
- **Validation**: Use the `--check-tree` flag during development or in automated pipelines to ensure the taxonomic tree structure is valid before generating the HTML.
- **Strict Error Handling**: In production pipelines, include the `--fail-on-error` flag. This prevents the tool from generating a partial or broken plot if it encounters problematic input lines.
- **Interactive Exploration**: The resulting HTML files are standalone. They can be opened in any modern web browser and shared without needing a web server or additional dependencies.
- **Taxonomy Agnostic**: Unlike the original Krona, taxburst handles GTDB and other custom taxonomies gracefully because it focuses on the provided lineage strings rather than relying strictly on NCBI taxids.

## Reference documentation
- [github_com_taxburst_taxburst.md](./references/github_com_taxburst_taxburst.md)
- [anaconda_org_channels_bioconda_packages_taxburst_overview.md](./references/anaconda_org_channels_bioconda_packages_taxburst_overview.md)