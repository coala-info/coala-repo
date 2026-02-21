---
name: biothings_client
description: The `biothings_client` is a unified Python wrapper designed to interact with various BioThings.api-based backends.
homepage: https://github.com/biothings/biothings_client.py
---

# biothings_client

## Overview

The `biothings_client` is a unified Python wrapper designed to interact with various BioThings.api-based backends. It eliminates the need to write manual REST API requests by providing specialized client objects for different biological entities. This skill allows for efficient data retrieval, supporting both synchronous and asynchronous operations, and integrates well with data science tools like pandas for downstream analysis.

## Installation and Setup

The package can be installed via pip or conda:

```bash
pip install biothings_client
# OR
conda install bioconda::biothings_client
```

## Core Usage Patterns

### Initializing a Client
Always use the `get_client` factory function to instantiate the specific service you need.

```python
from biothings_client import get_client

# Available client types: "gene", "variant", "chem", "disease", "geneset", "taxon"
mg = get_client("gene")
mv = get_client("variant")
mc = get_client("chem")
```

### Basic Data Retrieval
Each client has a specific "get" method named after the entity type (e.g., `getgene`, `getvariant`).

```python
# Fetch a gene by Entrez ID
gene_info = mg.getgene(1017)

# Fetch a variant by HGVS ID
variant_info = mv.getvariant("chr7:g.140453134T>C")

# Fetch a chemical by InChIKey
chem_info = mc.getchem("ATBDZSAENDYQDW-UHFFFAOYSA-N")
```

### Filtering Fields
To minimize network overhead and simplify the response object, use the `fields` parameter to specify exactly which data points you require.

```python
# Retrieve only specific fields for a gene
mg.getgene(1017, fields='name,symbol,refseq')

# Retrieve specific drug properties
mc.getchem("ATBDZSAENDYQDW-UHFFFAOYSA-N", fields="pubchem")
```

### Asynchronous Operations
For high-throughput tasks or integration into async frameworks, use `get_async_client`.

```python
from biothings_client import get_async_client

async def fetch_data():
    mv = get_async_client("variant")
    res = await mv.getvariant("chr7:g.140453134T>C")
    return res
```

## Expert Tips and Best Practices

1. **Pandas Integration**: If you have `pandas` installed, you can easily convert lists of objects into DataFrames. This is particularly useful when querying multiple IDs or using the query services.
2. **Batch Queries**: While `get_client` is used for single ID lookups, most clients also support `query` and `querymany` methods for searching and batch retrieval (refer to specific API documentation for MyGene/MyVariant for query syntax).
3. **Python Version**: Ensure you are using Python 3.7 or higher, as older versions may lack support for the latest client features, especially async functionality.
4. **Field Discovery**: If you are unsure what fields are available, perform a lookup without the `fields` parameter first to see the full JSON structure, then refine your production code to request only what is necessary.

## Reference documentation
- [biothings_client - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_biothings_client_overview.md)
- [GitHub - biothings/biothings_client.py](./references/github_com_biothings_biothings_client.py.md)