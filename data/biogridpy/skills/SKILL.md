---
name: biogridpy
description: biogridpy retrieves protein-protein and genetic interaction data from the BioGRID database. Use when user asks to fetch biological interaction datasets, query gene interactions by taxonomy ID, or list valid experimental evidence types.
homepage: https://github.com/arvkevi/biogridpy
metadata:
  docker_image: "quay.io/biocontainers/biogridpy:0.1.1--py35_1"
---

# biogridpy

## Overview
The `biogridpy` skill enables seamless integration with the BioGRID (Biological General Repository for Interaction Datasets) REST service. It is designed for researchers and developers who need to fetch protein-protein or genetic interaction data directly into Python environments. The tool simplifies API authentication, query construction, and data transformation, allowing for easy conversion of biological datasets into analysis-ready formats like pandas DataFrames.

## Configuration and Setup
Before using the client, ensure an access key is configured. The tool looks for a configuration file (typically named `biogridpyrc`).

**Configuration File Format (`biogridpyrc`):**
```ini
[BioGRID_ak]
access_key = YourAccessKeyHere
```

**Initialization:**
```python
from biogridpy.biogrid_client import BioGRID
# Initialize with the path to your config file
BG = BioGRID(config_filepath='/path/to/biogridpyrc')
```

## Core Usage Patterns

### Querying Interactions
The `interactions` method is the primary endpoint. It requires a result format string and accepts various keyword arguments for filtering.

**Common Parameters:**
- `geneList`: Python list of gene symbols or a path to a file with one identifier per line.
- `evidenceList`: List of specific evidence types or a path to a file.
- `taxId`: NCBI Taxonomy ID (e.g., 9606 for Human, 10090 for Mouse).
- `includeEvidence`: Set to 'true' to include experimental evidence details.

**Example Query:**
```python
results = BG.interactions('tab2', 
                         geneList=['RB1', 'E2F1'], 
                         taxId=9606, 
                         includeEvidence='true')
```

### Handling Results
The result object provides several attributes for data inspection:
- `results.count`: Number of interactions returned.
- `results.result`: The formatted result data.
- `results.raw_result`: The original API response.
- `results.export(outdir='path', filename='name')`: Saves the result to a file.

### Integration with Pandas
To transform BioGRID data for analysis, use the `toDataFrame()` method. Note that the parsing logic depends on the requested format.

```python
import pandas as pd
import io

# For tab-delimited formats (tab2, extendedTab2, tab1)
df = pd.read_csv(io.StringIO(results.toDataFrame()), sep='\t')

# For JSON formats (json, jsonExtended)
df = pd.read_json(io.StringIO(results.toDataFrame()), orient='index')
```

## Metadata Endpoints
Use these methods to explore valid parameters for your interaction queries:
- `BG.evidence()`: Returns a list of valid evidence types (e.g., 'AFFINITY CAPTURE-MS').
- `BG.organisms()`: Returns supported organisms and their TaxIDs.
- `BG.identifiers()`: Returns valid identifier types.
- `BG.version()`: Returns the current BioGRID version.

## Expert Tips
- **Batch Processing**: When querying large sets of genes, pass a Python list to `geneList` rather than making individual calls to stay within API rate limits and improve performance.
- **Format Selection**: Use `'tab2'` for standard interaction data and `'jsonExtended'` when you need the most comprehensive metadata available for each interaction.
- **Evidence Filtering**: Use the `evidence()` method first to verify the exact strings required for the `evidenceList` parameter to avoid empty result sets due to typos.

## Reference documentation
- [BioGRID Python Client Overview](./references/github_com_arvkevi_biogridpy.md)