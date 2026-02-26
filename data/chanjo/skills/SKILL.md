---
name: chanjo
description: "Chanjo manages and analyzes clinical genomics sequence coverage data by storing annotated metrics in a SQL database. Use when user asks to initialize a coverage database, link genomic region definitions, load processed coverage data, or calculate mean coverage and completeness metrics."
homepage: https://github.com/Clinical-Genomics/chanjo
---


# chanjo

## Overview

Chanjo is a specialized tool designed for clinical genomics to manage and analyze sequence coverage data. It follows the UNIX pipeline philosophy, leveraging Sambamba to annotate coverage and completeness for genomic regions defined in BED files. The tool stores this data in a SQL database (SQLite or MySQL), enabling efficient investigation of coverage across multiple samples and regions. Use this skill to streamline the workflow of transforming raw sequencing coverage into actionable clinical metrics.

## Core Workflow and CLI Patterns

### 1. Initialization and Setup
Before loading data, you must initialize the database and configuration.

- **Standard Setup**: Creates the configuration file and the database.
  ```bash
  chanjo init --setup
  ```
- **Automated Setup**: Useful for non-interactive environments or Docker.
  ```bash
  chanjo init --auto /path/to/data_directory
  ```
- **Database Specification**: You can specify a database URI directly if not using the default SQLite.
  ```bash
  chanjo -d "mysql+pymysql://user:pass@localhost/db" init --auto .
  ```

### 2. Linking Exon Definitions
Chanjo requires a reference set of genomic regions (usually exons) to be linked to the database before sample data can be loaded.

- **Link BED file**:
  ```bash
  chanjo link /path/to/exons.bed
  ```
- **Using a specific config**:
  ```bash
  chanjo --config chanjo.yaml link /path/to/exons.bed
  ```

### 3. Loading Coverage Data
Chanjo expects BED files that have been processed by Sambamba.

- **Load a sample**:
  ```bash
  chanjo load /path/to/sample.coverage.bed
  ```
- **Load with specific sample ID**:
  If the sample ID is not automatically detected or needs to be overridden.
  ```bash
  chanjo load --sample sample_id_001 /path/to/sample.coverage.bed
  ```

### 4. Calculating Metrics
Once data is loaded, you can extract summary statistics.

- **Calculate Mean Coverage**:
  ```bash
  chanjo calculate mean
  ```
- **Output Example**:
  The tool returns JSON formatted metrics:
  `{"metrics": {"completeness_10": 90.92, "mean_coverage": 193.85}, "sample_id": "sample1"}`

## Expert Tips and Best Practices

- **Input Preparation**: Chanjo is not a coverage calculator itself; it is an annotator and database manager. Always use `sambamba depth` to generate the input BED files for the `load` command.
- **Database Choice**: Use SQLite for local, single-user analysis or small projects. For production clinical pipelines with multiple concurrent users or large sample sets, use a MySQL/MariaDB backend.
- **Config Management**: The `chanjo.yaml` file created during `init` stores the database URI. Use the `--config` flag to switch between different projects or environments without changing environment variables.
- **Scope Limitation**: Do not use Chanjo for base-by-base coverage across the whole genome. It is optimized for region-based analysis (e.g., exons in a gene panel). For whole-genome histograms, use BEDTools.

## Reference documentation
- [Chanjo Main Repository and Usage](./references/github_com_Clinical-Genomics_chanjo.md)