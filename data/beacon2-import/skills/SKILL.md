---
name: beacon2-import
description: The beacon2-import toolkit facilitates the ingestion of genomic data into a Beacon v2 database and provides a command-line interface for querying that data. Use when user asks to import local or Galaxy data into a Beacon store, perform genomic variation searches, or query metadata for individuals and biosamples.
homepage: https://pypi.org/project/beacon2-import/
---


# beacon2-import

## Overview
The `beacon2-import` toolkit is designed for bioinformaticians and genomic data managers who need to populate or query a Beacon v2 database. It facilitates the transition of local genetic data into a structured Beacon store and provides a robust command-line interface for searching that data. Use this skill when you need to automate data ingestion from Galaxy, perform range-based or gene-based genomic queries, or manage Beacon database collections.

## Installation
Install the toolkit via pip or conda:
```bash
pip install beacon2-import
# OR
conda install -c bioconda beacon2-import
```

## Data Import Patterns
The `beacon2-import` command handles data ingestion. It requires a connection to a MongoDB instance.

### Local JSON Import
To import a local JSON file into a specific database and collection:
```bash
beacon2-import -H <db_host> -P <db_port> -d <database_name> -c <collection_name> -i <path_to_json>
```

### Galaxy Integration
To pull data directly from a Galaxy history:
```bash
beacon2-import -g -u <galaxy_url> -k <api_key> -d <database_name> -c <collection_name> -i <history_file_name>
```
*Note: The API key must belong to a Galaxy user with admin privileges.*

### Database Management
*   **Authentication**: Use `-a` and provide a JSON config with `-A` for authenticated MongoDB connections.
*   **Cleanup**: Use `-ca` to clear all data before a new import, or `-cc` to clear only the targeted collection.
*   **Provenance**: Use `-s` and `-o <path>` to generate a local file mapping variant IDs to their source datasets.

## Querying the Beacon
The `beacon2-search` command provides subcommands for different Beacon v2 entities.

### Genomic Variation Queries
*   **Sequence-based**: Search by specific reference and alternate bases.
    ```bash
    beacon2-search sequence -d <db> -c <coll> -rn <ref_name> -s <start_pos> -ab <alt_bases>
    ```
*   **Range-based**: Search within a genomic coordinate range.
    ```bash
    beacon2-search range -d <db> -c <coll> -rn <ref_name> -s <start> -e <end> -v <variant_type>
    ```
*   **Gene-based**: Search by Gene ID with optional length filters.
    ```bash
    beacon2-search gene -d <db> -c <coll> -g <gene_id> -vmin <min_len> -vmax <max_len>
    ```

### Metadata Queries
You can query non-variant collections using specific subcommands:
*   **Individuals**: Filter by `age_group`, `sex`, `ethnicity`, or `disease_ontology`.
*   **Biosamples**: Filter by `sample_origin_type` or `collection_date`.
*   **Runs**: Filter by `library_strategy`, `platform`, or `platform_model`.
*   **Analyses**: Filter by `pipeline_name` or `variant_caller`.

## Expert Tips
*   **Verbosity**: Always use `-V` (verbose) or `-D` (debug) during initial imports to ensure the connection to MongoDB is stable and the JSON schema is being parsed correctly.
*   **CNV Queries**: Use the `cnv` subcommand for copy number variants, which allows filtering by `chromosome`, `primarySite`, and `diseaseType` in addition to coordinates.
*   **Auth Config**: When using `-A`, ensure your JSON file follows this structure: `{"db_auth_source": "admin", "db_user": "root", "db_password": "password"}`.

## Reference documentation
- [Beacon2 Import Toolkit Overview](./references/pypi_org_project_beacon2-import.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_beacon2-import_overview.md)