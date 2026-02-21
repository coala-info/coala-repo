---
name: rust-ncbitaxonomy
description: The `rust-ncbitaxonomy` suite provides high-performance utilities for working with the NCBI Taxonomy database via a local SQLite backend.
homepage: https://github.com/pvanheus/ncbitaxonomy
---

# rust-ncbitaxonomy

## Overview
The `rust-ncbitaxonomy` suite provides high-performance utilities for working with the NCBI Taxonomy database via a local SQLite backend. It is designed for bioinformatics workflows that require taxonomic filtering of large sequence datasets without relying on remote API calls. The toolset includes a utility for database management and specialized filters for RefSeq FASTA and classified FASTQ files.

## Database Initialization
Before using the filtering tools, you must convert the NCBI taxdump into a local SQLite database.

1.  **Download Data**: Obtain `taxdump.tar.gz` from the NCBI FTP site.
2.  **Convert to SQLite**:
    ```bash
    taxonomy_util to_sqlite --db taxonomy.sqlite
    ```
    *Note: Ensure the input files (nodes.dmp, names.dmp, etc.) are in the current directory or specified path.*

## Taxonomic Metadata Retrieval
Use `taxonomy_util` to query the database for specific taxonomic information.

*   **Find TaxID by Name**:
    ```bash
    taxonomy_util get_id "Homo sapiens" --db taxonomy.sqlite
    ```
*   **Get Lineage**:
    ```bash
    taxonomy_util get_lineage "Escherichia coli" --db taxonomy.sqlite
    ```
*   **Calculate Common Ancestor Distance**:
    Find the tree distance between two taxa:
    ```bash
    taxonomy_util common_ancestor_distance <taxid1> <taxid2> --db taxonomy.sqlite
    ```

## Sequence Filtering Patterns

### Filtering RefSeq FASTA Files
The `taxonomy_filter_refseq` tool subsets FASTA files based on a specific ancestor.

*   **Basic Filter**:
    ```bash
    taxonomy_filter_refseq input.fasta "Mammalia" output.fasta --db taxonomy.sqlite
    ```
*   **Strict Filtering**:
    Exclude predicted or curated accessions (e.g., NM_, XM_) to keep only high-confidence sequences:
    ```bash
    taxonomy_filter_refseq --no_curated --no_predicted input.fasta "Bacteria" output.fasta --db taxonomy.sqlite
    ```

### Filtering FASTQ Files
Filter sequencing reads that have already been classified by Kraken2 or Centrifuge.

*   **Kraken2 Output**:
    ```bash
    taxonomy_filter_fastq --kraken2 --ancestor_taxid 1234 --tax_report_filename report.k2 input.fastq --db taxonomy.sqlite
    ```
*   **Centrifuge Output**:
    ```bash
    taxonomy_filter_fastq --centrifuge --ancestor_taxid 567 --tax_report_filename report.centrifuge input.fastq --db taxonomy.sqlite
    ```

## Best Practices
*   **Database Path**: Always specify the `--db` (or `-d`) flag to point to your local SQLite file to avoid "database not found" errors.
*   **Standard Output**: If an output filename is omitted in `taxonomy_filter_refseq`, the tool defaults to stdout, which is useful for piping into other tools like `samtools` or `minimap2`.
*   **Memory Efficiency**: Because these tools use a local SQLite database, they are generally more memory-efficient than tools that load the entire taxonomy into RAM, making them suitable for environments with limited resources.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_pvanheus_ncbitaxonomy.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_rust-ncbitaxonomy_overview.md)