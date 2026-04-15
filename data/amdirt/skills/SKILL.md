---
name: amdirt
description: The amdirt toolkit manages ancient DNA metadata by facilitating the download, validation, and conversion of AncientMetagenomeDir datasets into pipeline-ready formats. Use when user asks to download metadata tables, validate new submissions against schemas, autofill tables from ENA accessions, or convert metadata into samplesheets for nf-core/eager, nf-core/taxprofiler, and aMeta.
homepage: https://github.com/SPAAM-community/AMDirT
metadata:
  docker_image: "quay.io/biocontainers/amdirt:1.7.0--pyhdfd78af_0"
---

# amdirt

## Overview

The `amdirt` (AncientMetagenomeDir Toolkit) skill provides a specialized workflow for managing ancient DNA (aDNA) metadata. It allows users to programmatically access the AncientMetagenomeDir repository to find sequencing data, download specific metadata tables, and validate new submissions against standardized schemas. Crucially, it automates the conversion of complex metadata into pipeline-ready samplesheets, reducing manual formatting errors in paleogenomic workflows.

## Core Workflows

### 1. Data Acquisition
Use the `download` command to retrieve the latest or specific versions of metadata tables.
- **Download samples table**: `amdirt download -t ancientmetagenome-hostassociated -y samples`
- **Download libraries table**: `amdirt download -t ancientmetagenome-hostassociated -y libraries`
- **Specific release**: Use `-r` (e.g., `-r v24.06.0`) to ensure reproducibility by pinning a specific dataset version.

### 2. Metadata Exploration and Filtering
- **Interactive Viewer**: Run `amdirt viewer` to launch a Streamlit-based GUI for filtering datasets.
- **Autofill from ENA**: If you have ENA project accessions (e.g., PRJNA123), use `amdirt autofill ACCESSION` to automatically pull metadata and populate library/sample tables.

### 3. Pipeline Preparation (Conversion)
Convert filtered AncientMetagenomeDir TSV files into specific formats for bioinformatic pipelines:
- **nf-core/eager**: `amdirt convert SAMPLES.tsv TABLE_NAME --eager`
- **nf-core/taxprofiler**: `amdirt convert SAMPLES.tsv TABLE_NAME --taxprofiler`
- **aMeta**: `amdirt convert SAMPLES.tsv TABLE_NAME --ameta`
- **Download Scripts**: Generate bash scripts for bulk data retrieval using `--curl`, `--aspera`, or `--sratoolkit`.

### 4. Validation and Merging
Before submitting new data to AncientMetagenomeDir, validate the format:
- **Schema Check**: `amdirt validate DATASET.tsv SCHEMA.json --schema_check`
- **Check for Duplicates**: Use `-d` (line duplicates) and `-i` (DOI duplicates).
- **ENA Validation**: Use `-a` to verify that accessions exist in the European Nucleotide Archive.
- **Merging**: Use `amdirt merge DATASET.tsv -n TABLE_NAME -t table_type` to integrate new data with existing local tables.

## Expert Tips
- **Table Names**: Common table names include `ancientmetagenome-hostassociated`, `ancientmetagenome-environmental`, and `ancientsinglegenome-hostassociated`.
- **Output Management**: Always specify an output directory with `-o` to avoid cluttering the working directory, especially during `convert` operations which may generate multiple files (samplesheets, bibliographies, and scripts).
- **Bibliography Generation**: Use the `--bibliography` flag during conversion to automatically generate a BibTeX file for all studies included in your filtered dataset.



## Subcommands

| Command | Description |
|---------|-------------|
| amdirt autofill | Autofills library and/or sample table(s) using ENA API and accession numbers |
| amdirt convert | Converts filtered samples and libraries tables to eager, ameta, taxprofiler, and fetchNGS input tables |
| amdirt download | Download a table from the amdirt repository |
| amdirt merge | Merges new dataset with existing table |
| amdirt validate | Run validity check of AncientMetagenomeDir datasets |

## Reference documentation
- [Quick Reference](./references/amdirt_readthedocs_io_en_master_reference.html.md)
- [Python API](./references/amdirt_readthedocs_io_en_master_API.html.md)
- [Installation and Overview](./references/github_com_SPAAM-community_amdirt_blob_master_README.md)