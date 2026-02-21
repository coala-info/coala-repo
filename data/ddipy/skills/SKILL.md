---
name: ddipy
description: The `ddipy` skill provides a specialized interface for interacting with the Omics Discovery Index (OmicsDI).
homepage: https://github.com/OmicsDI/ddipy
---

# ddipy

## Overview

The `ddipy` skill provides a specialized interface for interacting with the Omics Discovery Index (OmicsDI). It enables AI agents to perform complex searches across various omics repositories, retrieve specific dataset metadata (such as PRIDE or BioModels accessions), and manage file downloads. It is particularly useful for bioinformatics workflows requiring data discovery across proteomics, genomics, and metabolomics domains.

## Installation

Install via pip or conda:
```bash
pip install ddipy
# OR
conda install bioconda::ddipy
```

## Python API Usage

The library is organized into specialized clients. The `DatasetClient` is the primary tool for data discovery.

### Searching Datasets
Use the `search` method for general queries. It supports sorting and pagination.
```python
from ddipy.dataset_client import DatasetClient
client = DatasetClient()

# Basic search
res = client.search("cancer human", "publication_date", "ascending")

# Search with pagination (start, size, face_count)
res = client.search("cancer human", "publication_date", "ascending", 0, 20, 10)
```

### Retrieving Specific Metadata
To get full details for a known dataset:
```python
# Parameters: (database_name, accession, include_metrics)
res = client.get_dataset_details("pride", "PXD000210", False)
```

### Domain-Specific Queries
You can search using specific biological identifiers:
- **UniProt**: `client.search("UNIPROT:P21399")`
- **Ensembl**: `client.search("ENSEMBL:ENSG00000147251")`

### Statistics and Terms
Use specialized clients for repository-wide information:
- **Statistics**: `StatisticsClient().get_statistics_tissues(20)` or `get_statistics_diseases(20)`.
- **Databases**: `DatabaseClient().get_database_all()` to list all recorded databases.
- **Terms**: `TermClient().get_term_by_pattern("hom", 10)` for dictionary term lookups.

## Command Line Interface (CLI)

The `omicsdi` command (sometimes referred to as `omicsdi_fetcher`) is used for listing and downloading files.

### Basic Usage
List available data links for an accession:
```bash
omicsdi E-MTAB-5612
```

### Downloading Files
Download all files for a dataset to the current directory:
```bash
omicsdi E-MTAB-5612 -d
```

### Advanced CLI Options
- **Verbose Mode**: Use `-v` to see internal identifiers and file extensions alongside URLs.
- **Selective Download**: Use `-i` followed by a comma-separated list of identifiers to download specific files.
- **Output Directory**: Use `-o <PATH>` to specify a destination.

Example of a selective, verbose download:
```bash
omicsdi BIOMD0000000048 -d -v -i "8b52492888, d3144265ac"
```

## Expert Tips

1. **Pagination Logic**: When looping over large search results, ensure you increment the `start` parameter by the `size` value in each iteration of `client.search()`.
2. **Database Names**: Common database strings include `"pride"`, `"biomodels"`, `"metabolights"`, and `"ega"`. Use `DatabaseClient` to verify the exact string required for `get_dataset_details`.
3. **SEO Metadata**: If you need structured data for web indexing or JSON-LD formats, use the `SeoClient`.

## Reference documentation
- [OmicsDI ddipy GitHub Repository](./references/github_com_OmicsDI_ddipy.md)
- [ddipy Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ddipy_overview.md)