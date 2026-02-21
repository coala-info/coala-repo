---
name: ncbi-datasets-pyclient
description: The `ncbi-datasets-pyclient` provides a Python-based interface to the NCBI Datasets API, allowing for automated retrieval of large-scale biological datasets.
homepage: https://www.ncbi.nlm.nih.gov/datasets
---

# ncbi-datasets-pyclient

## Overview
The `ncbi-datasets-pyclient` provides a Python-based interface to the NCBI Datasets API, allowing for automated retrieval of large-scale biological datasets. It is designed to replace legacy tools like E-utilities for specific dataset-oriented tasks, offering a more structured way to query and download genomic sequences, annotation files (GFF3, GTF), and comprehensive metadata in JSON format.

## Usage Guidelines

### Core Client Initialization
To interact with the API, initialize the specific service client required for your data type. The library is organized into sub-packages corresponding to NCBI data domains.

```python
import ncbi.datasets
from ncbi.datasets.openapi import ApiClient as DatasetsApiClient

# Initialize the base API client
with DatasetsApiClient() as api_client:
    # For Genome data
    genome_api = ncbi.datasets.GenomeApi(api_client)
    # For Gene data
    gene_api = ncbi.datasets.GeneApi(api_client)
```

### Common Patterns

#### 1. Fetching Genome Metadata by Accession
Use the `assembly_descriptors_by_accessions` method to retrieve metadata for specific RefSeq or GenBank assemblies.

```python
accessions = ["GCF_000001405.40", "GCF_000001635.27"]
reply = genome_api.assembly_descriptors_by_accessions(accessions)
for assembly in reply.assemblies:
    print(f"Assembly: {assembly.assembly.name}, TaxID: {assembly.assembly.tax_id}")
```

#### 2. Downloading Dataset Packages
The client allows you to request a "dataset package" (a zip file containing sequences and metadata).

```python
# Download a genome dataset for a specific taxon
zipfile_path = "human_genome.zip"
genome_api.download_assembly_package(
    ["GCF_000001405.40"], 
    include_annotation_type=["GENOME_GFF", "SEQUENCE_GENOMIC"],
    _preload_content=False
)
# Note: Use _preload_content=False for large binary streams to write directly to disk
```

#### 3. Gene Queries by Symbol
Retrieve gene information using symbols and taxonomic constraints.

```python
gene_reply = gene_api.gene_metadata_by_tax_and_symbol(
    symbols=["BRCA1"], 
    taxon="human"
)
```

### Best Practices
- **Batching**: When requesting metadata for thousands of accessions, batch your requests (e.g., 100-500 accessions per call) to avoid timeouts or payload limits.
- **Error Handling**: Wrap API calls in try-except blocks to handle `ncbi.datasets.openapi.exceptions.ApiException`, which covers 404 (not found) and 429 (rate limiting) errors.
- **Resource Management**: Always use the `with DatasetsApiClient() as api_client:` context manager to ensure underlying network connections are closed properly.
- **Data Formats**: Prefer requesting metadata in JSON format for easier parsing into Python dictionaries or Pandas DataFrames.

## Reference documentation
- [NCBI Datasets API Overview](./references/anaconda_org_channels_bioconda_packages_ncbi-datasets-pyclient_overview.md)