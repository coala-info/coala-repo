---
name: konezumiaid
description: konezumiaid automates the identification of optimal gRNA sequences for creating multiplex knockout mouse models via Target-AID base editing. Use when user asks to identify gRNAs for premature termination codons, find splice site disruptions, or perform batch processing of gene symbols and transcript IDs.
homepage: https://github.com/aki2274/KOnezumi-AID
metadata:
  docker_image: "quay.io/biocontainers/konezumiaid:0.3.6.1--pyhdfd78af_0"
---

# konezumiaid

## Overview
konezumiaid is a specialized bioinformatics tool designed to streamline the creation of multiplex knockout mouse models. It specifically automates the identification of optimal gRNA sequences that facilitate base editing via Target-AID. The tool identifies three primary types of genomic disruptions: the introduction of premature termination codons (PTC) and the disruption of splice donor or acceptor sites. It supports both individual gene/transcript queries and high-throughput batch processing.

## Installation and Setup
Before running searches, ensure the environment is prepared with necessary dependencies and genomic data.

- **Dependencies**: Requires `bedtools` and `bowtie`.
- **Data Preparation**: Download `refFlat.txt.gz` (locus info) and `mm39.fa.gz` (genomic sequence) from UCSC.
- **Initialization**: You must preprocess the raw genomic files into a format the tool can use:
  ```bash
  konezumiaid preprocess data/refFlat.txt data/mm39.fa
  ```

## Command Line Usage

### Single Query Search
Search for gRNA candidates using either a gene symbol or a specific RefSeq transcript ID.

- **By Gene Symbol**: Returns gRNAs present in all transcript variants.
  ```bash
  konezumiaid --name Sox17
  ```
- **By Transcript Name**: Provides detailed information including exon index and "Recommended" status.
  ```bash
  konezumiaid -n NM_011283
  ```

### Batch Processing
For large-scale experiments, use a single-column CSV or Excel file (no headers) containing a list of gene symbols or transcript names.
```bash
konezumiaid batch --file gene_list.csv
```

## Output Interpretation
The tool generates results in the standard output and saves CSV files in `data/output/`.

- **PTC gRNAs**: Targets specific amino acids (e.g., Q, R, W) to induce early termination.
- **Splice gRNAs**: Targets the conserved sequences at exon-intron junctions.
- **Recommended Flag**: In transcript-specific searches, look for the `True` value in the "Recommended" column to identify gRNAs with higher predicted efficiency or better targeting context.

## Expert Tips
- **RefSeq Versions**: KOnezumi-AID ignores minor version numbers (e.g., `NM_111111.2` becomes `NM_111111`) because the underlying `refFlat` format does not support them.
- **CRISPRdirect Integration**: The CLI output provides direct URLs to CRISPRdirect for every candidate gRNA, allowing for quick off-target analysis and secondary validation.
- **Workspace Organization**: Always maintain a `data/` directory in your working path, as the tool defaults to this location for both input preprocessing and output generation.



## Subcommands

| Command | Description |
|---------|-------------|
| konezumiaid batch | (No description) |
| konezumiaid_preprocess | Preprocesses data for konezumiaid. |

## Reference documentation
- [KOnezumi-AID Main Repository](./references/github_com_aki2274_KOnezumi-AID.md)
- [README and Usage Guide](./references/github_com_aki2274_KOnezumi-AID_blob_main_README.md)
- [Project Configuration](./references/github_com_aki2274_KOnezumi-AID_blob_main_pyproject.toml.md)