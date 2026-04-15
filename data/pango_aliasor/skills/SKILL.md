---
name: pango_aliasor
description: pango_aliasor manages SARS-CoV-2 Pango lineage nomenclature by converting between shortened aliases and full hierarchical strings. Use when user asks to uncompress aliases into full lineage names, compress full strings into standard aliases, or identify the parent of a specific lineage.
homepage: https://github.com/corneliusroemer/pango_aliasor
metadata:
  docker_image: "quay.io/biocontainers/pango_aliasor:0.3.0--pyhdfd78af_0"
---

# pango_aliasor

## Overview
`pango_aliasor` is a specialized utility for managing the complex nomenclature of SARS-CoV-2 Pango lineages. Because lineage names can become unwieldy as the virus evolves (e.g., B.1.1.529.5.3.1.5), the system uses aliases (e.g., BE.5). This skill allows you to programmatically expand these aliases to their full hierarchical form or compress full strings into their standard shortened versions. It also provides tools to identify the immediate parent of a specific lineage.

## Installation
The tool can be installed via pip or conda:
```bash
pip install pango_aliasor
# OR
conda install -c bioconda pango_aliasor
```

## Core Python Usage
The primary interface is the `Aliasor` class. For optimal performance, initialize the class once and reuse the instance.

### Initialization
By default, the tool downloads the latest `alias_key.json` from the official Pango designations GitHub repository.
```python
from pango_aliasor.aliasor import Aliasor

# Online initialization (fetches latest keys)
aliasor = Aliasor()

# Offline/Reproducible initialization (uses local file)
# aliasor = Aliasor('path/to/alias_key.json')
```

### Lineage Translation
*   **Uncompress (Alias -> Full):** Convert a shortened name to its full hierarchical string.
    ```python
    aliasor.uncompress("BA.5")  # Returns 'B.1.1.529.5'
    aliasor.uncompress("BE.5")  # Returns 'B.1.1.529.5.3.1.5'
    ```
*   **Compress (Full -> Alias):** Convert a full hierarchical string to its standard aliased form.
    ```python
    aliasor.compress("B.1.1.529.3.1")  # Returns 'BA.3.1'
    ```

### Relationship Analysis
*   **Find Parent:** Retrieve the immediate ancestor of a lineage.
    ```python
    aliasor.parent("BQ.1")  # Returns 'BE.1.1.1'
    ```

### Advanced Compression
Use `partial_compress` to control how many levels of the hierarchy are preserved or to restrict compression to specific accepted aliases.
```python
# Compress up to a specific depth
aliasor.partial_compress("B.1.1.529.3.1", up_to=1) # 'BA.3.1'

# Only use specific aliases (e.g., only AY)
aliasor.partial_compress("B.1.617.2", accepted_aliases=["AY"]) # 'AY.2'
```

## Processing Tabular Data (TSV/CSV)
When working with large datasets (e.g., metadata from GISAID or Nextstrain), use `pandas` to apply uncompression to entire columns.

```python
import pandas as pd
from pango_aliasor.aliasor import Aliasor

aliasor = Aliasor()

def get_unaliased(lineage):
    if not lineage or pd.isna(lineage):
        return "?"
    return aliasor.uncompress(lineage)

df = pd.read_csv("metadata.tsv", sep='\t')
df['pango_lineage_unaliased'] = df['pango_lineage'].apply(get_unaliased)
```

## Best Practices
*   **Network Awareness:** If running in a restricted environment or HPC cluster without internet access, always provide a local path to `alias_key.json` during initialization.
*   **Data Integrity:** When processing TSV files, handle null or empty lineage values explicitly (e.g., returning `?` or `None`) to prevent the uncompressor from failing on malformed input.
*   **Performance:** Avoid re-initializing the `Aliasor` object inside loops. The initialization involves loading and parsing a JSON mapping; doing this repeatedly will significantly slow down your script.

## Reference documentation
- [pango_aliasor GitHub Repository](./references/github_com_corneliusroemer_pango_aliasor.md)
- [pango_aliasor Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pango_aliasor_overview.md)