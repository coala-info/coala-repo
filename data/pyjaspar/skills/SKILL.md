---
name: pyjaspar
description: pyjaspar provides a serverless Python interface to access and query the JASPAR transcription factor motif database using a local SQLite backend. Use when user asks to fetch transcription factor motifs by ID or name, retrieve specific JASPAR collections, or access motif matrices as Biopython objects for sequence analysis.
homepage: https://github.com/asntech/pyjaspar
metadata:
  docker_image: "quay.io/biocontainers/pyjaspar:4.0.0--pyhdfd78af_0"
---

# pyjaspar

## Overview

pyjaspar is a serverless Python interface that provides access to the JASPAR transcription factor motif database using a local SQLite backend. It eliminates the need for a live MySQL connection to JASPAR, allowing for faster, offline queries. The tool returns native Biopython `Bio.motifs.jaspar.Motif` objects, making it immediately compatible with the broader Biopython ecosystem for sequence analysis and motif scanning.

## Usage Instructions

### Initialization and Release Selection

Always specify the JASPAR release version during initialization to ensure reproducibility. If no release is specified, the library typically defaults to the latest available version (e.g., JASPAR2026).

```python
from pyjaspar import jaspardb

# Initialize a specific database release
jdb_obj = jaspardb(release='JASPAR2024')

# List all available releases
print(jdb_obj.get_releases())
```

### Fetching Motifs

You can retrieve motifs using specific identifiers, names, or broad taxonomic filters.

*   **By ID**: Use the unique JASPAR matrix ID (e.g., 'MA0095.2').
*   **By Name**: Search for motifs by the transcription factor name (e.g., 'CTCF'). Note that this returns a list as names may not be unique.
*   **By Filter**: Use `fetch_motifs` to get collections based on taxonomic groups or specific JASPAR collections (CORE, CNE, etc.).

```python
# Fetch a single motif by ID
motif = jdb_obj.fetch_motif_by_id('MA0095.2')

# Fetch motifs by TF name (returns a list)
motifs = jdb_obj.fetch_motifs_by_name('KLF4')

# Fetch a non-redundant vertebrate CORE collection
vertebrate_motifs = jdb_obj.fetch_motifs(
    collection=['CORE'], 
    tax_group=['Vertebrates'], 
    all_versions=False
)
```

### Working with Motif Objects

The returned objects are `Bio.motifs.jaspar.Motif` instances. Key attributes include:

*   `.counts`: A dictionary containing the Position Frequency Matrix (PFM).
*   `.name`: The common name of the transcription factor.
*   `.matrix_id`: The JASPAR identifier.
*   `.base_id`: The ID without the version suffix.

```python
# Accessing the PFM
pfm = motif.counts
print(f"A: {pfm['A']}")

# Convert to a Position Weight Matrix (PWM) using Biopython
pwm = motif.counts.normalize(pseudocounts=0.8)
```

## Best Practices

1.  **Redundancy Management**: When fetching large collections, set `all_versions=False` to retrieve only the latest version of each motif, preventing redundant data in your analysis.
2.  **Taxonomic Filtering**: Use specific `tax_group` values (e.g., 'Vertebrates', 'Plants', 'Insects', 'Fungi', 'Nematodes', 'Urochordates') to narrow down search results and improve performance.
3.  **Memory Efficiency**: When iterating over thousands of motifs from a collection, process them within the loop rather than storing all transformed matrices (like PWMs) in memory simultaneously if resources are limited.
4.  **Version Control**: Always document the JASPAR release version used in your scripts to ensure that results can be replicated, as motif profiles can be updated between releases.

## Reference documentation
- [pyjaspar GitHub Repository](./references/github_com_asntech_pyjaspar.md)
- [Bioconda pyjaspar Overview](./references/anaconda_org_channels_bioconda_packages_pyjaspar_overview.md)