---
name: pybiomart
description: pybiomart provides a Python interface to the BioMart data federation system for querying and retrieving biological data as Pandas DataFrames. Use when user asks to retrieve gene metadata, query Ensembl datasets, map orthologs, or list available BioMart attributes and filters.
homepage: https://github.com/jrderuiter/pybiomart
---


# pybiomart

## Overview

The `pybiomart` library provides a Pythonic interface to the BioMart data federation system. It allows users to explore available marts and datasets, and perform complex queries to retrieve data as Pandas DataFrames. This skill is particularly useful for bioinformatics workflows that require automated retrieval of gene metadata, transcript information, or ortholog mappings from Ensembl and other BioMart-compatible servers.

## Installation

Install the package via bioconda:

```bash
conda install bioconda::pybiomart
```

## Core Usage Patterns

### Querying via the Server Interface
Use the `Server` class to browse available marts and datasets dynamically.

```python
from pybiomart import Server

# Connect to Ensembl
server = Server(host='http://www.ensembl.org')

# List available marts
# print(server.marts)

# Select a specific dataset
dataset = server.marts['ENSEMBL_MART_ENSEMBL'].datasets['hsapiens_gene_ensembl']

# Run a query
results = dataset.query(
    attributes=['ensembl_gene_id', 'external_gene_name'],
    filters={'chromosome_name': ['1', '2']}
)
```

### Direct Dataset Access
If the dataset name and host are already known, instantiate the `Dataset` class directly for efficiency.

```python
from pybiomart import Dataset

dataset = Dataset(name='hsapiens_gene_ensembl', host='http://www.ensembl.org')

results = dataset.query(
    attributes=['ensembl_gene_id', 'external_gene_name'],
    filters={'gene_biotype': 'protein_coding'}
)
```

## Expert Tips and Best Practices

### Handling Data Types
When retrieving large datasets, you can specify column data types to optimize memory usage or ensure correct parsing of IDs.

```python
dataset.query(
    attributes=['ensembl_gene_id', 'start_position'],
    dtypes={'start_position': 'int64'}
)
```

### Attribute and Filter Discovery
If you are unsure of the exact internal names for attributes or filters, use the following methods to inspect the dataset:

```python
# List all available attributes
# dataset.attributes

# List all available filters
# dataset.filters
```

### Performance and Limitations
- **Filter Limits**: Be cautious when passing very large lists to filters (e.g., >100 gene IDs). Some BioMart servers may return errors or time out. For massive lists, consider chunking the query.
- **Caching**: While `requests_cache` can be used to speed up repeated queries, ensure it is configured correctly to avoid stale metadata if the server version updates.
- **Attribute Names**: By default, `pybiomart` uses the display names for columns. Use `use_attr_names=True` in the `query` method to use the internal BioMart attribute names as DataFrame columns. Note that `use_attr_names` and `dtypes` may occasionally conflict in older versions; verify column names if using both.

## Reference documentation
- [pybiomart GitHub Repository](./references/github_com_jrderuiter_pybiomart.md)
- [Bioconda pybiomart Overview](./references/anaconda_org_channels_bioconda_packages_pybiomart_overview.md)
- [pybiomart Issues and Known Limitations](./references/github_com_jrderuiter_pybiomart_issues.md)