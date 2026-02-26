---
name: query_phenomizer
description: The query_phenomizer tool identifies and ranks syndromes or diseases associated with a provided set of Human Phenotype Ontology (HPO) terms. Use when user asks to search for diseases based on phenotypes, validate HPO identifiers, or perform clinical diagnostic queries.
homepage: https://www.github.com/moonso/query_phenomizer
---


# query_phenomizer

## Overview
The `query_phenomizer` tool is a specialized command-line interface for interacting with the Phenomizer service. It streamlines the process of clinical diagnostics by taking a set of HPO terms and returning a ranked list of associated syndromes or diseases. This skill provides the necessary procedural knowledge to execute queries, validate phenotype identifiers, and manage output for downstream genomic analysis.

## Authentication
As of February 2016, the Phenomizer service requires authentication. 
- **Credentials**: You must provide a username and password to use the service.
- **Acquisition**: If credentials are not already configured in your environment, they must be requested from the service maintainers (sebastian.koehler@charite.de).

## Command Line Usage

### Basic Query
To perform a standard search for diseases associated with specific phenotypes, provide the HPO terms as positional arguments:

```bash
query_phenomizer HP:0001623 HP:0002465 --output results.txt
```

### Term Validation
Before running large batches or when unsure of the validity of an HPO ID, use the check flag. This prevents the tool from submitting invalid queries to the server.

```bash
query_phenomizer HP:0001623 HP:9999999 --check_terms -v
```
*Note: The `-v` (verbose) flag is highly recommended when checking terms to see specific error messages for invalid IDs.*

### Output Management
By default, the tool can output results to a file using the `--output` flag. If no output file is specified, ensure you are prepared to capture the standard output (stdout).

## Best Practices
- **Batching**: When dealing with multiple patients, script the execution of `query_phenomizer` to handle one set of HPO terms at a time, saving each to a unique output file.
- **ID Formatting**: Always ensure HPO terms are prefixed with `HP:` followed by the seven-digit identifier (e.g., `HP:0001234`).
- **Error Handling**: If the tool fails to return results, first verify your internet connection and then use the `--check_terms` flag to ensure all input IDs are currently recognized by the HPO database.

## Reference documentation
- [query_phenomizer - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_query_phenomizer_overview.md)
- [GitHub - moonso/query_phenomizer](./references/github_com_moonso_query_phenomizer.md)