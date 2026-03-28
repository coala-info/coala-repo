---
name: viguno
description: Viguno integrates clinical phenotypes with genomic data by providing a high-performance interface for HPO and disease information. Use when user asks to convert HPO data to binary format, run a REST API server for phenotype-to-gene mappings, or query ontology associations.
homepage: https://github.com/bihealth/viguno
---


# viguno

## Overview

Viguno (Versatile Interface for Genetics Utilization of Nice Ontologies) is a specialized utility within the VarFish ecosystem that facilitates the integration of clinical phenotypes with genomic data. It provides a high-performance interface for accessing HPO phenotypes, disease information, and their associations with specific genes. The tool is primarily used to transform raw ontology files into optimized binary structures and to serve that data via a RESTful API for downstream analysis tools.

## Data Preparation

Before running the server, you must prepare the HPO and HGNC cross-link data.

1.  **Download HPO Data**: Obtain `hp.obo` (renamed from `hp-base.obo`), `phenotype.hpoa`, `phenotype_to_genes.txt`, and `genes_to_phenotype.txt` from the official HPO releases.
2.  **Generate HGNC Cross-links**: Create a `hgnc_xlink.tsv` file containing mappings between HGNC IDs, Ensembl IDs, Entrez IDs, and gene symbols. This file should be placed within the HPO data directory.

## Command Line Usage

### Converting Data to Binary Format
To improve loading speed and runtime performance, convert the raw text-based HPO files into a single binary file:

```bash
viguno convert \
    --path-hpo-dir /path/to/hpo_data \
    --path-out-bin /path/to/hpo_data/hpo.bin
```

### Running the REST API Server
Start the server by pointing it to the directory containing your HPO data (and the generated binary file):

```bash
viguno server run \
    --path-hpo-dir /path/to/hpo_data \
    --listen-host 127.0.0.1 \
    --listen-port 8080
```

## Expert Tips and Best Practices

- **Binary Performance**: Always use the `convert` command before running the server in production. Loading from a binary file is significantly faster than parsing raw OBO and text files on every startup.
- **API Documentation**: Once the server is running, access the interactive Swagger UI at `http://<host>:<port>/swagger-ui/` to explore available endpoints and test queries.
- **Gene Identifiers**: Viguno relies heavily on HGNC IDs. Ensure your `hgnc_xlink.tsv` is correctly formatted and sorted to prevent lookup errors during phenotype-to-gene mapping.
- **Docker Deployment**: For containerized environments, bind-mount your data directory to `/data` and ensure the `hgnc_xlink.tsv` is located inside the HPO subdirectory to match the expected internal paths.



## Subcommands

| Command | Description |
|---------|-------------|
| convert | Convert HPO text files to binary format |
| server | Clap sub command below "server" |
| viguno | A tool for processing and analyzing biological sequences. |
| viguno query | Prepare values for `query` |

## Reference documentation
- [Viguno README](./references/github_com_varfish-org_viguno_blob_main_README.md)
- [Viguno OpenAPI Specification](./references/github_com_varfish-org_viguno_blob_main_openapi.yaml.md)