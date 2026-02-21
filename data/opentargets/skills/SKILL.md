---
name: opentargets
description: The `opentargets` skill utilizes the official Python client to interface with the Open Targets REST API.
homepage: https://github.com/opentargets/opentargets-py
---

# opentargets

## Overview
The `opentargets` skill utilizes the official Python client to interface with the Open Targets REST API. It streamlines bioinformatics workflows by providing high-level wrappers for complex queries, including automatic handling of pagination, fair usage limits, and gene identifier mapping (e.g., converting gene symbols to Ensembl IDs). This tool is essential for drug discovery tasks that require programmatic access to target-disease association scores and supporting evidence.

## Installation
The package can be installed via conda:
```bash
conda install bioconda::opentargets
```

## Core Usage Patterns

### Initializing the Client
Always start by instantiating the `OpenTargetsClient`. By default, it connects to the public Open Targets Platform API.
```python
from opentargets import OpenTargetsClient
ot = OpenTargetsClient()
```

### Searching for Targets and Diseases
Use the `search` method for general queries. This is useful when you have a string (like a gene name or disease) but not a specific ID.
```python
# Search for a specific gene or disease
search_results = ot.search('BRAF')
top_hit = search_results[0]
```

### Retrieving Associations
Associations represent the connection between a target and a disease, quantified by an association score.
```python
# Get all diseases associated with a specific target gene symbol
target_associations = ot.get_associations_for_target('BRAF')
for assoc in target_associations:
    print(assoc['id'], assoc['association_score']['overall'])

# Get all targets associated with a specific disease
disease_associations = ot.get_associations_for_disease('cancer')
```

### Accessing Evidence
Evidence provides the raw data (e.g., clinical trials, genetic mutations) that supports a target-disease association.
```python
# Get evidence for a target
evidence = ot.get_evidence_for_target('BRAF')

# Export evidence to JSON format
evidence_json = evidence.to_json()
```

### Getting Platform Statistics
To check the current state of the data or API metadata:
```python
stats = ot.get_stats().info
print(stats)
```

## Expert Tips
- **Identifier Flexibility**: You do not need to know Ensembl Gene IDs; the client allows you to use common gene symbols (e.g., 'BRAF') directly in most methods.
- **Pagination**: The client uses an iterator pattern for methods returning multiple results (like `get_associations_for_target`). You can loop through them without manually managing API page offsets.
- **Data Export**: While the client returns Python dictionaries/objects, use the built-in tools to save results directly to CSV or Excel for downstream analysis in spreadsheets.
- **Fair Usage**: The client handles "fair usage" limits transparently, so you don't need to implement custom sleep or retry logic for standard query volumes.

## Reference documentation
- [Python client for the Open Targets REST API](./references/github_com_opentargets-archive_opentargets-py.md)
- [Open Targets Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_opentargets_overview.md)