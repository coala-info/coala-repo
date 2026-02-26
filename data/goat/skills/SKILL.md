---
name: goat
description: The goat CLI provides a command-line interface to search and retrieve genomic metadata and phylogenetic trees from the Genomes on a Tree database. Use when user asks to search for biological metadata, count genomic records, lookup taxon summaries, or generate phylogenetic trees in Newick format.
homepage: https://github.com/genomehubs/goat-cli
---


# goat

## Overview
The `goat` CLI (Genomes on a Tree) provides a streamlined interface for the GoaT API, allowing users to access a massive collection of genomic metadata without writing complex API calls. It transforms the genomic tree of life into a searchable database, enabling researchers to find specific biological attributes for any taxon or assembly. The tool primarily outputs tab-separated values (TSV), making it highly compatible with standard Unix text-processing pipelines.

## Core Usage Patterns

### Index Selection
GoaT queries are divided into two primary indices. You must specify the index before the command:
- `taxon`: Use for biological metadata associated with a species or group (e.g., "What is the average genome size of Mammalia?").
- `assembly`: Use for metadata associated with specific sequencing records (e.g., "Find all chromosome-level assemblies for Hominidae").

### Primary Commands
- `search`: Returns a list of records matching your criteria.
- `count`: Returns the number of records matching the query.
- `lookup`: Provides a quick summary of a specific taxon or assembly.
- `newick`: Generates a phylogenetic tree in Newick format based on the query.

## Expert CLI Tips and Best Practices

### Filtering for Direct Evidence
By default, GoaT may return ancestral or estimated values if a specific taxon lacks data. 
- Use the `-x` or `--exclude` flag to return only direct results and omit missing or ancestral estimates.

### Debugging Queries
If a query isn't returning what you expect, use the `-U` flag. This prints the underlying GoaT API URL to the terminal instead of the data. You can paste this URL into a browser to inspect the raw JSON response or verify the query logic.

### Data Source Transparency
When performing TSV exports, use the `--toggle-direct` flag. This adds columns to your output that break down whether a value is direct, inherited from an ancestor, or aggregated from descendants.

### Handling Large Trees
When using the `newick` command for large taxonomic groups, use the `treeThreshold` parameter to limit the complexity of the returned tree and avoid performance bottlenecks.

### Pipeline Integration
Since `goat` outputs TSV by default, it is designed to be piped into other tools.
- **Filtering columns**: `goat taxon search ... | cut -f 1,3`
- **Sorting by attribute**: `goat taxon search ... | sort -k 3 -n`
- **Quick previews**: `goat taxon search ... | column -t -s $'\t' | less -S`

## Common Command Examples
- Search for genome size in a genus: `goat taxon search -n "Felis" -v "genome_size"`
- Count assemblies for a family: `goat assembly count -n "Hominidae"`
- Generate a tree for a specific order: `goat taxon newick -n "Primates"`

## Reference documentation
- [GoaT CLI README](./references/github_com_genomehubs_goat-cli.md)
- [GoaT CLI Wiki](./references/github_com_genomehubs_goat-cli_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_goat_overview.md)