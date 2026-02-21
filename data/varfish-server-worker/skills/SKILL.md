---
name: varfish-server-worker
description: The `varfish-server-worker` is a high-performance Rust-based utility designed to handle computationally intensive background tasks for VarFish Server.
homepage: https://github.com/bihealth/varfish-server-worker
---

# varfish-server-worker

## Overview

The `varfish-server-worker` is a high-performance Rust-based utility designed to handle computationally intensive background tasks for VarFish Server. It bridges the gap between raw genomic data (VCFs) and the VarFish web interface by converting data into optimized binary formats and executing complex queries. Use this tool when you need to prepare data for import into VarFish or when you need to run variant filtration workflows outside of the main server process.

## Core Workflows

### Sequence Variant (seqvars) Processing

The `seqvars` suite is used for small variants (SNVs and indels).

1.  **Ingestion**: Convert standard VCF files into the internal format required for querying.
    ```bash
    varfish-server-worker seqvars ingest --input-vcf IN.vcf.gz --output-vcf OUT.vcf.gz
    ```
    *   **Note**: The tool interprets standard fields like `GT`, `GQ`, `DP`, `AD`, and `PS`.
    *   **Annotation**: It automatically adds gnomAD (exomes/genomes) and HelixMtDb frequencies, and functional annotations (ANN field).

2.  **Querying**: Filter variants based on a JSON query configuration.
    ```bash
    varfish-server-worker seqvars query --input-vcf INGESTED.vcf.gz --input-query QUERY.json --output-results RESULTS.json
    ```

3.  **Aggregation**: Compute carrier counts across multiple ingested files.
    ```bash
    varfish-server-worker seqvars aggregate --input-vcf FILE1.vcf.gz FILE2.vcf.gz --output-vcf CARRIER_COUNTS.vcf.gz
    ```

### Structural Variant (strucvars) Processing

The `strucvars` suite handles large variants and CNVs.

1.  **Ingestion**: Prepare SV files for querying.
    ```bash
    varfish-server-worker strucvars ingest --input-vcf SV_IN.vcf.gz --output-vcf SV_OUT.vcf.gz
    ```

2.  **Database Conversion**: Convert text-based database files (from `varfish-db-downloader`) into binary format for fast lookups.
    ```bash
    varfish-server-worker strucvars txt-to-bin --input-txt DB.txt --output-bin DB.bin
    ```

3.  **Querying**: Perform SV filtration and annotation.
    ```bash
    varfish-server-worker strucvars query --input-vcf SV_INGESTED.vcf.gz --input-query QUERY.json --output-results RESULTS.json
    ```

## Expert Tips and Best Practices

*   **Data Expansion**: Be aware that `seqvars ingest` emits one output line for every variant allele and every affected gene. A single VCF record affecting multiple genes will result in multiple internal records.
*   **Field Requirements**: For optimal results, ensure your input VCFs contain `AD` (Allelic Depth) and `GQ` (Genotype Quality) fields. The worker uses these for sophisticated quality filtering.
*   **Somatic Quality**: For Dragen VCFs, the worker maps `FORMAT/SQ` (Somatic Quality) to `FORMAT/GQ` during ingestion.
*   **Prefiltering**: Use `seqvars prefilter` to significantly reduce file size by removing variants with high population frequency or those far from exons before running intensive queries.
*   **Binary Databases**: Always use the `db` subcommands or `txt-to-bin` to prepare reference databases. The worker is optimized for these binary formats, and using raw text files will severely degrade performance.

## Reference documentation
- [VarFish Server Worker GitHub Repository](./references/github_com_varfish-org_varfish-server-worker.md)
- [VarFish Server Worker Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_varfish-server-worker_overview.md)