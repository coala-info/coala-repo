---
name: entrezpy
description: entrezpy is a Python library for building complex, multi-step pipelines to interface with NCBI Entrez Programming Utilities. Use when user asks to retrieve data from NCBI databases, manage E-utility requests with multithreading, or process XML and JSON responses using custom analyzers.
homepage: https://gitlab.com/ncbipy/entrezpy
---


# entrezpy

## Overview
entrezpy is a specialized Python library designed to interface with the NCBI Entrez Programming Utilities (E-utilities). It moves beyond simple URL construction by providing a robust framework for building complex, multi-step pipelines. It handles the technical overhead of NCBI's rate limits and request management, allowing for efficient data retrieval through its "Conduit" system and customizable "Analyzers" for processing raw XML or JSON responses.

## Installation
Install via Bioconda for the most stable environment:
```bash
conda install bioconda::entrezpy
```

## Core Usage Patterns

### Using the Conduit Pipeline
The `Conduit` class is the primary way to manage multiple E-utility requests. It handles authentication and threading.

```python
import entrezpy.conduit

# Initialize Conduit with your email and API key
c = entrezpy.conduit.Conduit('your_email@example.com', apikey='your_api_key', threads=4)

# Create a new pipeline
pipeline = c.new_pipeline()

# Add a search step
sid = pipeline.add_search({'db': 'pubmed', 'term': 'biopython'})

# Add a summary step dependent on the search results
pipeline.add_summary({'rettype': 'docsum', 'retmode': 'json'}, dependency=sid)

# Run the pipeline
results = c.run(pipeline)
```

### Iterative Query Management
A known behavior in `entrezpy` is that results in iterative queries can aggregate. If you are performing multiple searches in a loop using the same searcher object, you must manually reset the result attribute to prevent data from previous iterations from leaking into the current one.

**Expert Tip: Resetting Results**
```python
# Inside a loop performing multiple inquiries
a = es.inquire({'db': db, 'term': query})
result = a.get_result().uids
# CRITICAL: Reset the result attribute to clear the cache for the next iteration
a.result = None
```

### Multithreading
To speed up large-scale data retrieval, specify the `threads` parameter in the `Conduit` constructor. Note that while `entrezpy` supports multithreading, the actual speedup is subject to NCBI's server-side rate limits. Using an API key is highly recommended when using multiple threads.

## Limitations and Best Practices
- **No Remote BLAST**: `entrezpy` is designed for database queries and data fetching. It does not support remote BLAST searches. For remote BLAST, use the NCBI BLAST+ standalone tools with the `-remote` flag.
- **Custom Analyzers**: For complex data structures, implement a custom `Analyzer` class to process the raw response. This is more memory-efficient than loading massive XML/JSON files into memory after the fetch.
- **Logging**: You can configure the library's logging level from your application to debug request/response cycles or monitor pipeline progress.

## Reference documentation
- [gitlab_com_ncbipy_entrezpy.md](./references/gitlab_com_ncbipy_entrezpy.md)
- [anaconda_org_channels_bioconda_packages_entrezpy_overview.md](./references/anaconda_org_channels_bioconda_packages_entrezpy_overview.md)