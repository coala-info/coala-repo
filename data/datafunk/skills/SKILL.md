---
name: datafunk
description: Datafunk is a Python-based utility suite designed to streamline the preparation, cleaning, and processing of genomic sequence data and metadata for viral surveillance pipelines. Use when user asks to clean FASTA headers, filter sequences by coverage or length, merge genomic files, process GISAID data, or standardize metadata for phylogenetic analysis.
homepage: https://github.com/cov-ert/datafunk
metadata:
  docker_image: "quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0"
---

# datafunk

## Overview
Datafunk is a specialized Python-based utility suite designed for the "snake-flu" and broader genomic surveillance pipelines. It provides a collection of subcommands to streamline the preparation and cleaning of sequence data and metadata, particularly for SARS-CoV-2 workflows. Use this skill to automate repetitive bioinformatics tasks like FASTA record filtering, coverage-based pruning, and metadata standardization without writing custom scripts.

## CLI Usage and Patterns

The tool is invoked using the `datafunk` entry point followed by a specific subcommand.

### Core Subcommands
- **clean_names**: Sanitizes FASTA headers to ensure compatibility with downstream phylogenetic tools.
- **merge_fasta**: Combines multiple FASTA files into a single output.
- **remove_fasta**: Removes specific sequences from a FASTA file based on a list of IDs.
- **filter_low_coverage**: Filters out sequences that do not meet a minimum coverage threshold.
- **process_gisaid_data**: Specialized parser for GISAID-formatted genomic data and metadata.
- **sam_2_fasta**: Extracts sequence data from SAM alignment files into FASTA format.
- **phylotype_consensus**: Produces consensus sequences grouped by phylotype.

### Common Command Patterns
Most subcommands follow a standard input/output flag pattern:

```bash
# General syntax
datafunk <subcommand> -i <input_file> -o <output_file> [options]

# Example: Removing specific records
datafunk remove_fasta -i sequences.fasta -f exclude_list.txt -o filtered_sequences.fasta
```

## Expert Tips
- **Environment**: Ensure `biopython`, `pysam`, and `pandas` are installed in your environment, as datafunk relies heavily on these for sequence and metadata handling.
- **GISAID Workflows**: When using `process_gisaid_data`, ensure your metadata headers match the expected GISAID fields (e.g., "Virus name", "Accession ID").
- **Header Cleaning**: Use `clean_names` early in your pipeline. Many phylogenetic tools (like IQ-TREE or RAxML) fail if headers contain special characters or spaces that datafunk can automatically resolve.
- **Coverage Filtering**: When running `filter_low_coverage`, you typically need to provide a threshold (e.g., 90%) to keep only high-quality genomes for analysis.



## Subcommands

| Command | Description |
|---------|-------------|
| datafunk | A collection of bioinformatics tools for sequence data processing. |
| datafunk | Process GISAID sequence data |
| datafunk | A command-line tool with various subcommands for data manipulation and analysis. |
| datafunk | External subcommand for datafunk. The provided help text indicates an error and lists available subcommands. |
| datafunk | A collection of bioinformatics tools for sequence data manipulation and analysis. |
| datafunk | A collection of bioinformatics tools for data processing and analysis. |
| datafunk | A command-line tool for various bioinformatics data processing tasks. |
| datafunk | A collection of bioinformatics tools for sequence data processing and analysis. |
| datafunk | A tool with various subcommands for data processing. |
| datafunk AA_finder | Query a codon position for amino acids |
| datafunk Gisaid | Process GISAID sequence data |
| datafunk Split | Split a fasta file into multiple files based on padding. |
| datafunk add_epi_week | Add epidemiological week and day columns to metadata. |
| datafunk add_header_column | Add header column to metadata table corresponding to fasta record ids |
| datafunk bootstrap | bootstrap an alignment |
| datafunk cell | Subcommand for datafunk. The provided 'cell' is not a valid subcommand. Please choose from the available subcommands. |
| datafunk clean_names | Cleans trait names in a metadata file. |
| datafunk consensus | Subcommand for datafunk, specifically 'consensus'. The available subcommands for datafunk are: 'repair_names', 'remove_fasta', 'clean_names', 'merge_fasta', 'filter_fasta_by_covg_and_length', 'process_gisaid_sequence_data', 'sam_2_fasta', 'phylotype_consensus', 'gisaid_json_2_metadata', 'set_uniform_header', 'add_epi_week', 'process_gisaid_data', 'pad_alignment -i <input.fasta> -o <output.fasta> --left-pad <int> --right-pad <int> [--stdout]', 'exclude_uk_seqs', 'get_CDS', 'distance_to_root', 'mask', 'curate_lineages', 'snp_finder', 'del_finder', 'add_header_column', 'extract_unannotated_seqs', 'AA_finder', 'bootstrap'. |
| datafunk curate_lineages | Find new lineages, merge ones that need merging, split ones that need splitting |
| datafunk del_finder | Query an alignment position for deletions |
| datafunk distance_to_root | calculates per sample genetic distance to WH04 and writes it to 'distances.tsv' |
| datafunk duplicates | Subcommand for datafunk. The provided help text indicates 'duplicates' is an invalid choice, suggesting it might be a placeholder or an incorrect subcommand name. The valid subcommands are listed. |
| datafunk exclude_uk_seqs | exclude UK sequences from fasta |
| datafunk extract | Extract unannotated sequences from a FASTA file. |
| datafunk extract_unannotated_seqs | extract sequences with an empty cell in a specified cell in a metadata table |
| datafunk falls | Subcommand 'falls' is not a valid subcommand for datafunk. Please choose from the available subcommands. |
| datafunk filter_fasta_by_covg_and_length | Filters a FASTA file based on coverage and length thresholds. |
| datafunk get_CDS | Extracts CDS from alignments in Wuhan-Hu-1 coordinates |
| datafunk gisaid_json_2_metadata | Add the info from a Gisaid json dump to an existing metadata table (or create a new one) |
| datafunk mask | mask regions of a fasta file using information in an external file |
| datafunk merge_fasta | Merges multiple FASTA files into a single FASTA file based on a metadata file. |
| datafunk pad | Pad an alignment with gaps |
| datafunk pad_alignment | Pads a FASTA alignment with gaps on the left and/or right. |
| datafunk phylotype_consensus | Splits a fasta file into phylotypes based on metadata and clade definitions, and generates consensus sequences. |
| datafunk process_gisaid_data | Gisaid json (+ metadata) -> (new) gisaid.fasta + metadata |
| datafunk process_gisaid_sequence_data | Process raw sequence data in fasta or json format |
| datafunk remove_fasta | Removes sequences from a FASTA file based on a filter file. |
| datafunk repair_names | Repair FASTA headers using a phylogenetic tree. |
| datafunk sam_2_fasta | aligned sam -> fasta (with optional trim to user-defined (reference) co-ordinates) |
| datafunk set_uniform_header | Set uniform headers for FASTA and metadata files. |
| datafunk snp_finder | Find SNPs from alignment files. |

## Reference documentation
- [Datafunk README](./references/github_com_snake-flu_datafunk_blob_master_README.md)
- [Setup and Dependencies](./references/github_com_snake-flu_datafunk_blob_master_setup.py.md)