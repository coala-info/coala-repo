---
name: enasearch
description: ENASearch interacts with the European Nucleotide Archive (ENA) to search for and retrieve genomic data and metadata. Use when user asks to search the ENA database, retrieve run or analysis reports, download sequence data in various formats, or identify available metadata fields.
homepage: http://bebatut.fr/enasearch/
metadata:
  docker_image: "quay.io/biocontainers/enasearch:0.2.2--py27_0"
---

# enasearch

## Overview
ENASearch is a specialized tool designed to simplify interactions with the ENA database. It abstracts the complexity of ENA's REST API into a user-friendly command-line interface and Python library. This skill enables the efficient discovery of genomic datasets, retrieval of metadata reports (runs/analyses), and downloading of sequence data in various formats (FASTA, FASTQ, XML, Text).

## Core Workflows

### 1. Data Discovery and Metadata
Before downloading data, use discovery commands to identify available fields and result types.
- **List Result Types**: `enasearch get_results` (e.g., `read_run`, `assembly`, `study`).
- **Identify Fields**: 
  - For filtering: `enasearch get_filter_fields --result <result_id>`
  - For extraction: `enasearch get_returnable_fields --result <result_id>`
- **Check Filter Logic**: `enasearch get_filter_types` to see valid operators for different data types.

### 2. Searching the Data Warehouse
Use `search_data` to find records matching specific biological or technical criteria.
- **Free Text Search**: `enasearch search_data --free_text_search --query "SMP1+homo" --result sequence_release --display fasta`
- **Structured Query**: Use double quotes for complex queries.
  - Example: `enasearch search_data --query "instrument_platform=ILLUMINA AND library_strategy=WGS" --result read_run --display report --fields run_accession,fastq_ftp`

### 3. Retrieving Reports and Records
If you already have accession IDs, use specific retrieval commands for better performance.
- **Run Reports**: `enasearch retrieve_run_report --accession ERR1558694 --fields run_accession,read_count,fastq_ftp`
- **Analysis Reports**: `enasearch retrieve_analysis_report --accession ERZ000000 --fields analysis_accession,center_name`
- **Taxonomy**: `enasearch retrieve_taxons --ids 9606 --display xml` (Note: Taxonomy requires `retrieve_taxons` specifically).
- **Bulk Data**: `enasearch retrieve_data --ids AF081282,AF458851 --display fasta`

## Expert Tips
- **Display Options**: Use `get_display_options` to see supported formats. `report` is best for metadata, while `fasta`/`fastq` are used for sequences.
- **Pagination**: For large result sets, use `--offset` and `--length` to manage data flow and avoid timeouts.
- **File Output**: Use the `--file <path>` argument in any retrieval command to save results directly to disk instead of printing to stdout.
- **Subsequences**: When retrieving large genomic records, use `--subseq_range <start>-<stop>` to extract only the region of interest.



## Subcommands

| Command | Description |
|---------|-------------|
| enasearch retrieve_analysis_report | Retrieve analysis report from ENA. |
| enasearch retrieve_data | Retrieve ENA data (other than taxon). |
| enasearch retrieve_run_report | Retrieve run report from ENA. |
| enasearch retrieve_taxons | Retrieve data from the ENA Taxon Portal. |
| enasearch search_data | Search data given a query. |
| enasearch_get_analysis_fields | Get analysis fields from ENA. |
| enasearch_get_display_options | Get display options for ENA search results. |
| enasearch_get_filter_fields | Get the filter fields of a result to build a query. |
| enasearch_get_filter_types | Get available filter types and their associated operators and value descriptions. |
| enasearch_get_results | Get results from ENA. |
| enasearch_get_returnable_fields | Get the fields extractable for a result. |
| enasearch_get_sortable_fields | Get the fields of a result that can sorted. |
| enasearch_get_taxonomy_results | Get taxonomy results for a given accession. |

## Reference documentation
- [Interacting with ENA Database](./references/bebatut_fr_enasearch_ena.html.md)
- [Usage with command-line](./references/bebatut_fr_enasearch_cli_usage.html.md)
- [Usage within Python](./references/bebatut_fr_enasearch_api_usage.html.md)
- [Example Use Cases](./references/bebatut_fr_enasearch_use_case.html.md)