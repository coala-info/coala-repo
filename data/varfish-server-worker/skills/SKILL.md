---
name: varfish-server-worker
description: VarFish Server Worker processes genomic data by converting VCF files into optimized internal formats, building reference databases, and executing high-speed variant queries. Use when user asks to ingest sequence or structural variants, execute variant filtration queries, aggregate carrier counts, or compile reference databases into binary formats.
homepage: https://github.com/bihealth/varfish-server-worker
---

# varfish-server-worker

## Overview
The `varfish-server-worker` is a specialized tool designed to handle the heavy lifting of genomic data processing within the VarFish ecosystem. It provides a command-line interface for converting standard VCF files into optimized internal formats, building binary reference databases, and executing high-speed queries for variant filtration. It is particularly useful for bioinformaticians and developers managing VarFish instances who need to automate data imports or perform on-the-fly annotation of large-scale genomic datasets.

## Command Line Usage Patterns

### Sequence Variant (SNV/Indel) Processing
Use the `seqvars` subcommand for small variants.

*   **Ingest VCF Data**: Convert a single VCF into the internal format required for querying.
    ```bash
    varfish-server-worker seqvars ingest --input-vcf input.vcf.gz --output-path internal_format.bin
    ```
    *Note: Supports GATK (HaplotypeCaller, UnifiedGenotyper) and Illumina Dragen outputs, interpreting fields like GT, GQ, DP, AD, PS, and SQ.*

*   **Execute Queries**: Filter variants based on a JSON query definition.
    ```bash
    varfish-server-worker seqvars query --input-path internal_format.bin --query-json query.json --output-results results.json
    ```

*   **Aggregate Carriers**: Compute carrier counts across multiple ingested files.
    ```bash
    varfish-server-worker seqvars aggregate --input-paths file1.bin file2.bin --output-path carrier_counts.bin
    ```

### Structural Variant (SV) Processing
Use the `strucvars` subcommand for large variants and CNVs.

*   **Ingest SVs**: Prepare structural variant files for querying.
    ```bash
    varfish-server-worker strucvars ingest --input-vcf sv_input.vcf.gz --output-path sv_internal.bin
    ```

*   **Database Conversion**: Convert text-based databases (from varfish-db-downloader) to high-speed binary formats.
    ```bash
    varfish-server-worker strucvars txt-to-bin --input-txt db_file.txt --output-bin db_file.bin
    ```

### Database Management
Use the `db` subcommand to compile reference data.
```bash
varfish-server-worker db compile --input-path reference_data/ --output-path database.bin
```

## Best Practices and Tips
*   **Internal Format**: Always use the `ingest` command before attempting a `query`. The worker is optimized for its internal binary format, not raw VCFs, during the filtration phase.
*   **S3 Integration**: In production environments, the worker typically interacts with VCFs stored in S3. Ensure environment variables for S3 access are configured if the VarFish server is delegating tasks to the worker.
*   **Memory Efficiency**: For large-scale aggregations (`seqvars aggregate`), ensure sufficient temporary disk space as the tool reads through multiple ingested files to build carrier tables.
*   **Query Definitions**: Queries are defined via JSON. Ensure the JSON schema matches the expected protobuf-based definitions used by the current worker version (0.13.0+).



## Subcommands

| Command | Description |
|---------|-------------|
| varfish-server-worker | varfish-server-worker |
| varfish-server-worker seqvars | Sequence variant related commands |
| varfish-server-worker strucvars | Structural variant related commands |

## Reference documentation
- [VarFish Server Worker README](./references/github_com_varfish-org_varfish-server-worker_blob_main_README.md)
- [VarFish Server Worker Overview](./references/anaconda_org_channels_bioconda_packages_varfish-server-worker_overview.md)