---
name: sdrf-pipelines
description: sdrf-pipelines validates Sample and Data Relationship Format files and converts them into configuration files for proteomics analysis workflows. Use when user asks to validate SDRF metadata, check ontology terms, or generate configuration files for OpenMS, MaxQuant, and MSstats.
homepage: https://github.com/bigbio/sdrf-pipelines
metadata:
  docker_image: "quay.io/biocontainers/sdrf-pipelines:0.0.33--pyhdfd78af_0"
---

# sdrf-pipelines

## Overview
sdrf-pipelines is a specialized toolkit designed to bridge the gap between experimental metadata and proteomics analysis workflows. It provides a robust command-line interface to validate SDRF files—ensuring they adhere to structural and ontology standards—and automates the generation of pipeline-specific configuration files. By using this tool, you can verify that sample descriptions are accurate and ready for processing by major mass spectrometry software suites.

## Installation and Setup
The tool is best installed with all extras to ensure ontology validation and all converters are available.

```bash
# Recommended installation using uv or pip
uv tool install sdrf-pipelines[all]
# OR
pip install sdrf-pipelines[all]
```

## Core CLI Patterns

### Validation
Validation checks for column structure, formatting, and uniqueness. By default, it also performs ontology term validation (e.g., checking EFO, CL, or MS terms).

*   **Basic Validation**:
    `parse_sdrf validate-sdrf --sdrf_file experiment.sdrf.tsv`
*   **Template-Specific Validation**: Use a template to enforce specific metadata requirements (e.g., for human samples).
    `parse_sdrf validate-sdrf --sdrf_file experiment.sdrf.tsv --template human`
*   **Fast Structural Check**: Skip time-consuming ontology lookups if you only need to verify the file format.
    `parse_sdrf validate-sdrf --sdrf_file experiment.sdrf.tsv --skip-ontology`

### Conversion
Convert SDRF metadata into configuration files for specific proteomics pipelines.

*   **OpenMS**: Generates experimental design files.
    `parse_sdrf convert-openms -s sdrf.tsv`
*   **MaxQuant**: Requires a FASTA database and the path to the raw data files.
    `parse_sdrf convert-maxquant -s sdrf.tsv -f protein_db.fasta -r /path/to/raw_data/`
*   **MSstats**: Creates the annotation file required for statistical analysis.
    `parse_sdrf convert-msstats -s sdrf.tsv -o msstats_annotation.csv`

## Expert Tips
*   **Help Discovery**: Use `parse_sdrf --help` or `parse_sdrf [subcommand] --help` to see all available flags for specific converters, as requirements (like FASTA files) vary significantly between tools.
*   **Ontology Errors**: If validation fails on ontology terms, ensure you have installed the `[ontology]` or `[all]` extra. If the error persists, check that the terms in your SDRF file match the expected accessions in the Proteomics Standards Initiative (PSI) ontologies.
*   **Data Integrity**: Always run `validate-sdrf` before attempting a conversion. The converters assume a valid SDRF structure and may produce cryptic errors if the input file is malformed.

## Reference documentation
- [github_com_bigbio_sdrf-pipelines.md](./references/github_com_bigbio_sdrf-pipelines.md)