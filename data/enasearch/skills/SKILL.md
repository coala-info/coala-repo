---
name: enasearch
description: Enasearch provides a high-level interface for searching and retrieving metadata and sequence data from the European Nucleotide Archive. Use when user asks to search ENA data domains, retrieve run or analysis reports, download raw sequence data, or identify available search fields.
homepage: http://bebatut.fr/enasearch/
---


# enasearch

## Overview
The `enasearch` skill enables efficient interaction with the ENA database without manually constructing complex REST URLs. It provides a high-level interface to query 11 different data domains (such as Read, Analysis, and Taxon) and retrieve metadata reports or raw sequence data in various formats (FASTA, FASTQ, XML, Text). This skill is particularly useful for bioinformatics workflows requiring automated selection of datasets based on specific metadata criteria like sequencing platform, library strategy, or taxon ID.

## Command-Line Usage
The `enasearch` CLI follows a pattern of `enasearch <command> [options]`.

### Discovery Commands
Use these to identify valid parameters for search and retrieval:
- `enasearch get_results`: Lists all accessible ENA data domains (e.g., `read_run`, `assembly`, `taxon`).
- `enasearch get_returnable_fields --result <result_id>`: Lists fields you can extract for a specific domain.
- `enasearch get_filter_fields --result <result_id>`: Lists fields available for building queries.
- `enasearch get_display_options`: Shows supported output formats (e.g., `fasta`, `xml`, `report`).

### Data Retrieval
- **Standard Data**: `enasearch retrieve_data --ids <accession_ids> --display <format>`
- **Taxonomy**: `enasearch retrieve_taxons --ids <taxon_ids> --display <format>`
- **Reports**: 
  - `enasearch retrieve_run_report --accession <accession_id> --fields <comma_sep_fields>`
  - `enasearch retrieve_analysis_report --accession <accession_id> --fields <comma_sep_fields>`

### Searching
- **Free Text**: `enasearch search_data --free_text_search --query "term1+term2" --result <domain> --display <format>`
- **Data Warehouse (Structured)**: `enasearch search_data --query "library_strategy=\"WGS\" AND instrument_platform=\"ILLUMINA\"" --result read_run --display report --fields run_accession,fastq_ftp`

## Python API Best Practices
When using the library within Python scripts:
```python
import enasearch

# 1. Check the number of results before downloading
count = enasearch.get_search_result_number(free_text_search=True, query="human", result="sequence_release")

# 2. Retrieve data as BioPython SeqRecord objects
# Set display="fasta" or "fastq" to get objects instead of raw strings
sequences = enasearch.search_data(
    free_text_search=True, 
    query="SMP1+homo", 
    result="sequence_release", 
    display="fasta"
)

# 3. Generate reports for specific accessions
report = enasearch.retrieve_run_report(
    accession="ERR1558694",
    fields="run_accession,instrument_platform,read_count"
)
```

## Expert Tips
- **Pagination**: Use `--offset` and `--length` to manage large result sets. By default, ENA limits results; use `get_search_result_number` to determine if you need to iterate.
- **Filtering**: When using structured queries (non-free text), ensure values are bound by double quotes (e.g., `instrument_platform="ILLUMINA"`).
- **Subsequences**: For large genomic records, use `--subseq_range <start>-<stop>` to retrieve only the relevant portion of the sequence.
- **File Output**: Use the `--file <path>` option in the CLI or the `file` parameter in Python to stream large downloads directly to disk rather than loading them into memory.

## Reference documentation
- [CLI Usage Guide](./references/bebatut_fr_enasearch_cli_usage.html.md)
- [Python API Usage](./references/bebatut_fr_enasearch_api_usage.html.md)
- [ENA Database Structure](./references/bebatut_fr_enasearch_ena.html.md)
- [Example Use Cases](./references/bebatut_fr_enasearch_use_case.html.md)