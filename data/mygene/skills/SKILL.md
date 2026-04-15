---
name: mygene
description: The mygene tool provides a Python interface for accessing gene-centric data and functional annotations from the MyGene.Info REST services. Use when user asks to retrieve gene information, perform batch ID mapping, search for genes using Lucene syntax, or normalize gene identifiers across different databases.
homepage: https://github.com/suLab/mygene.py
metadata:
  docker_image: "quay.io/biocontainers/mygene:3.2.2--pyh5e36f6f_0"
---

# mygene

## Overview
The `mygene` skill provides a streamlined interface for accessing the MyGene.Info REST services. It allows for rapid retrieval of gene-centric data, supporting both single-gene lookups and massive batch operations. This tool is particularly effective for biological data scientists who need to normalize gene identifiers across different databases or extract specific functional annotations for a list of candidates.

## Core Usage Patterns

### Initialization
Always start by instantiating the `MyGeneInfo` class:
```python
import mygene
mg = mygene.MyGeneInfo()
```

### Single Gene Retrieval
Use `getgene` to fetch specific data for a known ID.
- **Basic**: `mg.getgene(1017)`
- **Specific Fields**: `mg.getgene(1017, fields='name,symbol,refseq.rna')`

### Batch Retrieval
Use `getgenes` for multiple IDs. To simplify downstream analysis, use the `as_dataframe` parameter.
```python
# Returns a Pandas DataFrame
mg.getgenes([1017, 1018, 'ENSG00000148795'], as_dataframe=True)
```

### Advanced Querying
The `query` method supports Lucene query syntax for flexible searching.
- **By Symbol and Species**: `mg.query('symbol:cdk2', species='human')`
- **By Reporter ID**: `mg.query('reporter:1000_at')`
- **Pagination**: Use `size` and `from` parameters to manage result sets.

### ID Mapping (Batch Querying)
The `querymany` method is the primary tool for converting one set of IDs to another.
```python
# Map Entrez IDs to Symbols for human
mg.querymany([1017, 695], scopes='entrezgene', species='human', fields='symbol')
```

## Expert Tips and Best Practices

- **Field Selection**: Always specify the `fields` you need. This reduces network latency and prevents your environment from being overwhelmed by the massive default annotation objects.
- **Handling Missing Data**: When using `querymany`, check the output for the `notfound: True` key to identify IDs that failed to map.
- **Large Scale Extraction**: For queries returning thousands of results, set `fetch_all=True`. This returns a Python generator, allowing you to iterate through results without loading the entire set into memory.
  ```python
  hits = mg.query('name:kinase', species='human', fetch_all=True)
  for gene in hits:
      print(gene['_id'], gene['symbol'])
  ```
- **Species Filtering**: You can use common names (e.g., 'human', 'mouse', 'rat') or Taxonomy IDs (e.g., 9606, 10090) interchangeably in the `species` argument.
- **Data Analysis Integration**: If you have `pandas` installed, always prefer `as_dataframe=True` for batch operations to immediately integrate with data science pipelines.

## Reference documentation
- [mygene - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_mygene_overview.md)
- [SuLab/mygene.py: Python wrapper for MyGene.Info](./references/github_com_suLab_mygene.py.md)