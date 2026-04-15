---
name: ebisearch
description: EBI Search provides high-performance text search and automated data retrieval from biological databases hosted at the European Bioinformatics Institute. Use when user asks to search biological data, retrieve specific database entries, find cross-referenced records, or get metadata from domains like UniProt, Ensembl, and ChEBI.
homepage: https://github.com/ebi-wp/EBISearch-webservice-clients
metadata:
  docker_image: "quay.io/biocontainers/ebisearch:0.0.3--py27_1"
---

# ebisearch

## Overview
EBI Search is a high-performance text search engine providing access to the vast biological data hosted at the European Bioinformatics Institute (EMBL-EBI). This skill enables the use of specialized web service clients to interact with the EBI Search RESTful API. It is particularly useful for bioinformatics workflows that require automated data retrieval from databases like UniProt, Ensembl, and ChEBI without using a web browser.

## Client Usage Patterns

The EBI Search clients follow a consistent pattern: `<client_executable> <method_name> <arguments>`.

### Python Client (Recommended)
Requires the `requests` library (`pip install requests`).
- **Pattern**: `python python/ebeye_requests.py <method> <args>`
- **Example**: `python python/ebeye_requests.py getNumberOfResults uniprot VAV_HUMAN`

### Perl Client
Requires `XML::Simple`, `LWP`, and `LWP::Protocol::https`.
- **Pattern**: `perl perl/ebeye_lwp.pl <method> <args>`
- **Example**: `perl perl/ebeye_lwp.pl getDomainDetails chebi`

### Java Client
Requires OpenJDK 8 (Note: Java 9 and above are not supported).
- **Pattern**: `java -Djava.ext.dirs=java/lib/ -jar java/jar/EBeye_JAXRS.jar --<method> <args>`
- **Example**: `java -Djava.ext.dirs=java/lib/ -jar java/jar/EBeye_JAXRS.jar --getNumberOfResults hgnc human`

## Common Methods and CLI Examples

### 1. Metadata and Discovery
- **getDomainDetails**: Retrieve information about a specific data domain.
  `python python/ebeye_requests.py getDomainDetails chebi`
- **getDomainsReferencedInDomain**: List domains that have cross-references from the target domain.
  `python python/ebeye_requests.py getDomainsReferencedInDomain hgnc`

### 2. Searching and Counting
- **getNumberOfResults**: Get the hit count for a specific query.
  `python python/ebeye_requests.py getNumberOfResults uniprot "cancer"`
- **getAutoComplete**: Get suggestions for a partial search term.
  `python python/ebeye_requests.py getAutoComplete uniprot vav`

### 3. Data Retrieval
- **getEntries**: Fetch specific fields for a list of entry IDs.
  `python python/ebeye_requests.py getEntries uniprot "Q9GZU1,P80567" "acc,organism_scientific_name"`
- **getResults**: Search and retrieve specific fields for the results.
  `python python/ebeye_requests.py getResults ensembl_gene tpi name`

### 4. Cross-Referencing and Similarity
- **getReferencedEntries**: Find entries in a different domain that are linked to your source entry.
  `python python/ebeye_requests.py getReferencedEntries ensembl_gene ENSG00000141968 uniprot acc`
- **getMoreLikeThis**: Find entries similar to a specific entry.
  `python python/ebeye_requests.py getMoreLikeThis ensembl_gene ENSG00000141968 "id,name"`

## Expert Tips
- **Field Selection**: When using `getEntries` or `getResults`, provide a comma-separated list of fields (e.g., `"acc,name,description"`) to minimize payload size and focus on relevant data.
- **Query Syntax**: Queries can be simple terms or complex boolean expressions. Use quotes for queries containing spaces or special characters.
- **Batching**: For `getEntries`, you can provide multiple IDs separated by commas to reduce the number of API calls.
- **Debugging**: The Java client supports a `-debugLevel 1` flag to provide more verbose output during execution.



## Subcommands

| Command | Description |
|---------|-------------|
| ebisearch get_fields | Get specific fields from EBI Search |
| ebisearch get_query_results | Return the all the results for a query on a specific domain in EBI |
| ebisearch_get_domains | Get domains from EBI Search |
| ebisearch_get_entries | Get entries from EBI Search |

## Reference documentation
- [EBISearch Web Service Clients README](./references/github_com_ebi-wp_EBISearch-webservice-clients_blob_master_README.md)
- [EBI Search Web Service Client CI Tests](./references/github_com_ebi-wp_EBISearch-webservice-clients_blob_master_.gitlab-ci.yml.md)