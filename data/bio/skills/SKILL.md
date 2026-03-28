---
name: bio
description: bio is a modular CLI toolkit designed to simplify common bioinformatics tasks like data retrieval, sequence manipulation, and alignment. Use when user asks to fetch GenBank records, convert sequences to FASTA or JSON, extract features, translate nucleotides, perform pairwise alignments, or query taxonomic and ontological data.
homepage: https://github.com/ialbert/bio
---

# bio

## Overview

`bio` is a modular, stream-oriented CLI toolkit designed to simplify common bioinformatics tasks. It replaces complex multi-step scripts with intuitive commands that can be piped together. Use this skill to quickly extract features, translate sequences, perform alignments, and query biological databases without leaving the terminal. It is particularly effective for exploratory data analysis and teaching bioinformatics concepts.

## Core Workflows

### Data Retrieval and Conversion
*   **Fetch GenBank records**: Use `bio fetch [accession]` to download data directly from NCBI.
*   **Convert to FASTA**: Pipe GenBank data into `bio fasta` to extract sequences. Use `--end [num]` or `--start [num]` for specific ranges.
*   **JSON Transformation**: Use `bio json` or `bio json --lines` to convert biological records into machine-readable formats for downstream processing with tools like `jq`.

### Sequence Manipulation
*   **Feature Extraction**: Extract specific genes or features using `--gene [name]` or `--type [feature_type]`.
*   **Translation**: Convert nucleotide sequences to protein sequences using the `--protein` or `--translate` flags.
*   **Coordinate Filtering**: Use `--olap [coordinate]` to find features overlapping a specific genomic position.
*   **Renaming**: Use `--rename {isolate}` or `--rename [file]` to clean up FASTA headers based on metadata.

### Alignment and Variants
*   **Quick Alignment**: Run `bio align [seq1] [seq2]` for immediate pairwise alignment.
*   **Global vs. Local**: Specify alignment type with `--global` or `--local`.
*   **VCF Generation**: Generate variant calls from an alignment using the `--vcf` flag.
*   **Visual Diff**: Use `--diff` to see a color-coded comparison of sequences.

### Taxonomy and Ontologies
*   **Taxonomic Lookups**: Use `bio taxon [taxid]` to see descendants or `--lineage` to see the full path.
*   **Metadata**: Retrieve viral sample metadata using `bio meta [id]`.
*   **Definitions**: Use `bio explain [term]` to get definitions for Sequence Ontology (SO) or Gene Ontology (GO) terms like "exon" or "vacuole".

## Expert Tips
*   **Stream Chaining**: `bio` is designed for pipes. A common pattern is `bio fetch | bio fasta --gene X | bio align`.
*   **Table Summaries**: Use `bio table` to generate a tab-delimited summary of features, which is easier to read than raw GFF for quick inspections.
*   **Frame Shifts**: When translating, use `--frame [-3 to 3]` to handle specific reading frames.
*   **Regex Matching**: Use `-m [pattern]` within `bio fasta` to filter sequences by matching descriptions.



## Subcommands

| Command | Description |
|---------|-------------|
| bio | Perform sequence alignment |
| bio | A better 'comm' command. Prints elements common from columns from two files. |
| bio | Runs the enrichr tool on a csv file where one column contains gene names and some column contains pvalues. |
| bio | Search database by ontological name or GO/SO ids. |
| bio | A tool for manipulating FASTA files. |
| bio | Fetch biological data from various databases. |
| bio | Parses and processes biological sequence files. |
| bio | Parses and filters GFF files. |
| bio | Runs the g:Profiler tool on a csv file where one column contains gene names and some column contains pvalues. |
| bio | A tool for biological metadata operations. |
| bio | Download gene information from NCBI Gene. |
| bio | Search biological databases |
| bio | Generates tabular output from data. |
| bio | Taxonomic ID lookup and database management tool. |
| bio | (No description) |
| bio_code | Biostar Workflows: https://www.biostarhandbook.com/ |

## Reference documentation
- [bio: making bioinformatics fun again](./references/github_com_ialbert_bio_blob_master_README.md)
- [bio usage examples and test patterns](./references/github_com_ialbert_bio_blob_master_src_biorun_data_usage.sh.md)