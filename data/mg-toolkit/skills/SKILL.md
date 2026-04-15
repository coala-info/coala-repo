---
name: mg-toolkit
description: The mg-toolkit is a command-line utility for fetching metadata, searching protein databases, and performing bulk downloads of analysis results from the MGnify repository. Use when user asks to extract sample metadata into CSV formats, search non-redundant protein databases with HMMER, or perform bulk downloads of specific analysis result groups for entire studies.
homepage: https://github.com/EBI-metagenomics/emg-toolkit
metadata:
  docker_image: "quay.io/biocontainers/mg-toolkit:0.10.4--pyhdfd78af_0"
---

# mg-toolkit

## Overview
The `mg-toolkit` is a specialized command-line utility designed for bioinformaticians and metagenomics researchers. It streamlines the process of fetching large-scale data from the MGnify repository. Its primary utility lies in three areas: programmatically extracting original sample metadata into portable CSV formats, searching non-redundant protein databases with HMMER to find matches within MGnify datasets, and performing bulk downloads of specific analysis result groups (like SSU rRNA or functional annotations) for entire studies.

## Core CLI Patterns

### Metadata Extraction
To download all sample metadata associated with a specific study or project accession:
```bash
mg-toolkit original_metadata -a <ACCESSION>
```
*Example:* `mg-toolkit original_metadata -a ERP001736`

### Sequence Searching
Search the MGnify non-redundant protein database using HMMER. This command requires a query FASTA file and produces a CSV with metadata for the matches.
```bash
mg-toolkit sequence_search -seq <input.fasta> -out <results.csv> -db <db_type> [evalue -incE <threshold>]
```
**Database Options (`-db`):**
- `full`: Full-length sequences (default).
- `all`: All sequences.
- `partial`: Partial sequences.

### Bulk Result Downloads
Download analysis files for an entire study. This is the most efficient way to gather raw or processed results for local analysis.
```bash
mg-toolkit bulk_download -a <ACCESSION> -o <output_directory> -p <pipeline_version> -g <result_group>
```

## Expert Tips and Best Practices

### 1. Filter by Pipeline Version
MGnify often re-analyzes studies as new pipelines are released. To ensure consistency in your local dataset, always specify the pipeline version using the `-p` flag (e.g., `4.1` or `5.0`). If omitted, the tool may download results from all available versions, leading to redundant data and confusion.

### 2. Target Specific Result Groups
Metagenomics datasets are massive. Use the `-g` flag to download only the specific data types you need. Common groups include:
- `functional_analysis`: For GO terms, InterPro, and pathway data.
- `taxonomic_analysis_ssu_rrna`: For 16S/18S rRNA based classifications (Pipeline >= 4.0).
- `sequence_data`: For processed reads or contigs.
- `statistics`: For summary metrics of the analysis.

### 3. Accession Formatting
Ensure you use the project or study accession (starting with ERP, SRP, or PRJ) rather than individual sample or analysis accessions when using `bulk_download` or `original_metadata`.

### 4. Debugging Connections
If a download fails or returns no results for a known public study, use the `-d` or `--debug` flag to inspect the API requests being made to the MGnify backend.



## Subcommands

| Command | Description |
|---------|-------------|
| mg-toolkit bulk_download | Bulk download study or project data from MGnify. |
| mg-toolkit original_metadata | Retrieve original metadata for given study accessions using mg-toolkit. |
| mg-toolkit sequence_search | Search non-redundant protein database using HMMER. |

## Reference documentation
- [MG-Toolkit README](./references/github_com_EBI-Metagenomics_emg-toolkit_blob_master_README.md)
- [MG-Toolkit Overview](./references/anaconda_org_channels_bioconda_packages_mg-toolkit_overview.md)