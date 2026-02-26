---
name: chembl_webresource_client
description: The chembl_webresource_client provides a Python interface for querying the ChEMBL database of bioactive molecules and their properties. Use when user asks to search for molecules, retrieve bioactivity data, filter targets or assays, and access chemical metadata for drug discovery.
homepage: https://github.com/chembl/chembl_webresource_client
---


# chembl_webresource_client

## Overview
The `chembl_webresource_client` skill provides a high-level Python interface to the ChEMBL database, the primary open-source repository for bioactive molecules with drug-like properties. It utilizes a Django-style QuerySet API, allowing for lazy evaluation and efficient data retrieval. This skill is essential for automating drug discovery workflows, performing large-scale bioactivity data mining, and integrating chemical metadata into data science pipelines.

## Core Usage Patterns

### Initializing the Client
Always use the `new_client` object to access various ChEMBL entities (endpoints).
```python
from chembl_webresource_client.new_client import new_client

# Common endpoints
molecule = new_client.molecule
target = new_client.target
assay = new_client.assay
activity = new_client.activity
```

### Filtering and Searching
The client supports standard Django-style lookups. Use these to narrow down results efficiently.
- **Exact matches**: `molecule.filter(molecule_chembl_id='CHEMBL25')`
- **Case-insensitive**: `target.filter(pref_name__iexact='HERG')`
- **Numeric ranges**: `activity.filter(pchembl_value__gte=7.0)`
- **List membership**: `molecule.filter(molecule_type__in=['Small molecule', 'Protein'])`
- **String patterns**: `molecule.filter(pref_name__istartswith='ASPIRIN')`

### Performance Optimization with `only`
To save bandwidth and improve speed, use the `only()` method to retrieve only the specific fields required for your analysis.
```python
# Only retrieve the ChEMBL ID and SMILES string
res = molecule.filter(molecule_type='Small molecule').only(['molecule_chembl_id', 'molecule_structures'])
```
*Note: `only()` does not support nested fields directly; calling it on a nested field like `molecule_properties__alogp` is equivalent to requesting the entire `molecule_properties` object.*

### Configuring Client Settings
Adjust the global settings for timeouts, retries, and caching behavior. This must be done before executing queries.
```python
from chembl_webresource_client.settings import Settings
settings = Settings.Instance()

settings.TIMEOUT = 20            # Increase timeout for slow connections
settings.TOTAL_RETRIES = 5       # Increase retries for unstable networks
settings.CACHE_EXPIRE = 3600     # Set cache expiry (in seconds)
```

## Best Practices
- **Lazy Evaluation**: Remember that queries are only executed when you actually iterate over the results or access a specific index.
- **Caching**: The client automatically caches results in a local SQLite database (`.sqlite` file) to speed up repeated queries.
- **Field Validation**: Ensure that fields passed to `only()` or `filter()` exist in the specific endpoint schema.
- **Large Datasets**: When dealing with thousands of results, use slicing (e.g., `res[:100]`) to manage memory and network load.

## Reference documentation
- [ChEMBL Webresource Client README](./references/github_com_chembl_chembl_webresource_client.md)