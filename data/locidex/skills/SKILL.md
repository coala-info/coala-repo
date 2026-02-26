---
name: locidex
description: Locidex is a search engine for similarity-based typing applications, particularly for gene-by-gene analysis. Use when user asks to perform similarity searches against custom databases for MLST, cgMLST, wgMLST, antimicrobial resistance gene detection, virulence gene detection, and in silico phenotype predictions.
homepage: https://pypi.org/project/locidex/
---


# locidex

A common search engine for similarity-based typing applications, particularly useful for gene-by-gene analysis in bacterial typing. Use when Claude needs to perform similarity searches against custom databases for applications like MLST, cgMLST, wgMLST, antimicrobial resistance gene detection, virulence gene detection, and in silico phenotype predictions. Also useful for decentralized allele calling and managing custom criteria filtering by loci.
---
## Overview

Locidex is a powerful command-line tool designed to act as a common search engine for various similarity-based typing applications. It excels in gene-by-gene analysis, enabling tasks such as identifying specific target sequences, performing phylogenetic analysis, detecting antimicrobial resistance and virulence genes, and predicting phenotypes. Locidex is particularly valuable for decentralized allele calling, offering flexibility in input sequence data and custom criteria filtering by loci. It is optimized for routine operational-level searching and provides multiple output formats for downstream applications.

## Usage Instructions

Locidex is primarily used via its command-line interface. The core functionalities involve building databases, extracting sequence information, and performing searches.

### Core Commands and Patterns

The general workflow involves preparing your sequence data, building a locidex database, and then using that database for extraction or searching.

#### Database Preparation and Building

Locidex supports various input formats and can extract regions of interest. It leverages existing annotations from tools like Prodigal, Prokka, and Bakta, but also has built-in support for extracting sequence regions directly.

*   **Building a database:**
    The `locidex build` command is used to create a locidex database. You can specify input files, output directory, and various parameters to control the database structure and matching criteria.

    ```bash
    locidex build --input <input_files> --output <database_dir> [options]
    ```

    *   `--input`: Path to input sequence files (e.g., FASTA, annotated files). Can be a single file or a directory.
    *   `--output`: Directory to store the generated locidex database.
    *   **Customizing Loci Matching:** Locidex allows control over identity and coverage thresholds at a locus level. These can be specified during database building or overridden later.

#### Sequence Extraction and Searching

Locidex can extract specific sequence regions or perform similarity searches against its databases.

*   **Extracting sequences:**
    The `locidex extract` command is used to pull out specific sequence regions based on defined criteria.

    ```bash
    locidex extract --db <database_dir> --query <query_file> --output <output_file> [options]
    ```

    *   `--db`: Path to the locidex database.
    *   `--query`: File containing sequences to query against the database.
    *   `--output`: File to save the extracted sequences.

*   **Performing similarity searches:**
    The `locidex search` command performs similarity searches using NCBI BLAST against the locidex database.

    ```bash
    locidex search --db <database_dir> --query <query_file> --output <output_file> [options]
    ```

    *   `--db`: Path to the locidex database.
    *   `--query`: File containing sequences for searching.
    *   `--output`: File to save the search results.

#### Reporting and Filtering

Locidex provides a `report` module for filtering and customizing the output of search results.

*   **Generating reports and filtering:**
    The `locidex report` command allows for post-processing of search results, enabling filtering by various parameters and generating output in multiple formats.

    ```bash
    locidex report --input <search_results> --output <report_file> [options]
    ```

    *   `--input`: Results from a `locidex search` command.
    *   `--output`: File to save the formatted report.
    *   **Custom Filtering:** You can apply custom criteria filtering by loci, identity, coverage, and other attributes directly within the report generation.

### Expert Tips

*   **Input Flexibility:** Locidex is designed to handle various input types, including existing annotations, de novo annotations, and direct extraction of sequence regions of interest. Leverage this flexibility to prepare your data efficiently.
*   **Database Structure:** The database structure in locidex allows for the inclusion of additional fields beyond sequence identifiers, such as functional properties and phenotypic effects. Consider how to best structure your database to capture this rich metadata.
*   **Reproducibility and Flexibility:** Locidex aims to provide default parameters for reproducibility while allowing flexibility. Use the reporting module to explore different thresholds without recomputing BLAST searches.
*   **HPC Compatibility:** Locidex is designed to be compatible with HPC environments and avoid locking issues, making it suitable for large-scale analyses.

## Reference documentation

- [Locidex: Common search engine for similarity based typing applications](./references/github_com_phac-nml_locidex.md)