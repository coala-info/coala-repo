---
name: extract_genome_region
description: The `extract_genome_region` tool automates the retrieval of DNA sequences from large genomic datasets.
homepage: https://github.com/xguse/extract-genome-region
---

# extract_genome_region

## Overview
The `extract_genome_region` tool automates the retrieval of DNA sequences from large genomic datasets. Instead of manual slicing, you provide a CSV file containing coordinates and metadata, and the tool generates a new FASTA file containing only the regions of interest. This is particularly useful for creating subsets of genomes for downstream analysis like primer design, local alignments, or feature-specific studies.

## CSV Input Structure
The tool requires a CSV file (the `REGIONS` argument) with specific columns. Ensure your CSV includes these headers:

| Column | Description |
| :--- | :--- |
| `record_name` | The desired name for the sequence in the output FASTA. |
| `scaffold` | The exact name of the sequence in the source FASTA (e.g., "chr1", "scaffold_5"). |
| `start` | The starting base pair position. |
| `stop` | The ending base pair position. |
| `left_bfr` | Number of extra base pairs to include upstream (smaller coordinates). |
| `right_bfr` | Number of extra base pairs to include downstream (larger coordinates). |

## Command Line Usage
The basic syntax follows this pattern:
`extract_genome_region [OPTIONS] <REGIONS_CSV> <INPUT_FASTA> <OUTPUT_FASTA>`

### Naming Strategies
Use the `-n` or `--naming` option to control how the headers in your output FASTA are formatted:

*   **csv (Default)**: Uses only the `record_name` field.
    *   Example: `>MyGene`
*   **seq_range**: Uses the scaffold name and the coordinate range.
    *   Example: `>scaffold1:230-679`
*   **csv_seq_range**: Combines the record name with the scaffold and range.
    *   Example: `>MyGene scaffold1:230-679`

### Example Command
To extract regions defined in `targets.csv` from `genome.fasta` and include the coordinates in the headers:
```bash
extract_genome_region --naming csv_seq_range targets.csv genome.fasta extracted_regions.fasta
```

## Expert Tips
*   **Buffer Handling**: Use `left_bfr` and `right_bfr` to include promoter regions or splice sites without manually recalculating the `start` and `stop` coordinates. Set them to `0` if no extra sequence is needed.
*   **Exact Matching**: The `scaffold` column must exactly match the header in your source FASTA file (excluding the `>` symbol). If the tool fails to find a region, verify there are no trailing spaces or hidden characters in your CSV.
*   **Coordinate Systems**: Ensure your CSV coordinates match the indexing of your source file (typically 1-based for genomic coordinates).

## Reference documentation
- [Extract Genome Region README](./references/github_com_xguse_extract-genome-region.md)