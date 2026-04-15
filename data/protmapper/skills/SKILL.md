---
name: protmapper
description: Protmapper resolves inconsistencies in protein modification site numbering by validating and mapping sites to a standard human reference sequence. Use when user asks to validate modification sites, map sites from different isoforms or species to a reference, or clean up proteomic datasets.
homepage: https://github.com/indralab/protmapper
metadata:
  docker_image: "quay.io/biocontainers/protmapper:0.0.29--pyhdfd78af_0"
---

# protmapper

## Overview
The `protmapper` tool is designed to resolve inconsistencies in protein site numbering often found in proteomic datasets and literature. It validates whether a reported modification site (e.g., Phosphorylation at T184) actually exists on the reference sequence and, if not, attempts to find the correct position by checking for common shifts or looking at equivalent sites in other species and isoforms. Use this skill when you need to clean up a list of protein modifications or ensure that sites from different databases are comparable on a single human reference scale.

## Usage Patterns

### Command Line Interface (CLI)
The primary way to process batches of sites is via the CLI. The input must be a comma-separated text file with four columns: `Protein ID`, `Namespace`, `Residue`, and `Position`.

**Basic Mapping:**
```bash
protmapper input_sites.csv output_mapped.csv
```

**Input Format (`input_sites.csv`):**
```csv
MAPK1,hgnc,T,183
P28482,uniprot,T,184
```

**Advanced Mapping Options:**
- `--peptide`: Use this if the third column contains a peptide sequence instead of a single amino acid.
- `--no_methionine_offset`: Disable the check for off-by-one errors caused by the removal of the initial methionine.
- `--no_orthology_mapping`: Disable mapping known sites from mouse/rat sequences to human.
- `--no_isoform_mapping`: Disable checking for modifications in other human isoforms.

### Python API
For integration into scripts, use the `ProtMapper` class or the REST API logic.

**Mapping a single site:**
```python
from protmapper import ProtMapper
pm = ProtMapper()
# Example: MAPK1 (P28482) Threonine at 185
result = pm.map_to_human_ref('P28482', 'uniprot', 'T', '185')
```

### REST API (Docker)
If running via Docker (`gyorilab/protmapper`), you can send JSON payloads to the local service.

**Example Request:**
```bash
curl -X POST -H "Content-Type: application/json" \
-d '{"site_list": [["P28482", "uniprot", "T", "184"]]}' \
http://localhost:8008/map_sitelist_to_human_ref
```

## Best Practices
- **Namespace Consistency**: Always specify whether your ID is `uniprot` or `hgnc`. Mixing them without proper labeling will lead to mapping failures.
- **Interpreting Output**: 
    - `VALID`: The site exists exactly as described in the reference.
    - `INFERRED_METHIONINE_CLEAVAGE`: The site was found by shifting the position by 1.
    - `INFERRED_MOUSE_SITE`: The position matches a known modification site in the mouse ortholog.
- **Batch Processing**: For large datasets, use the CLI or the `map_sitelist_to_human_ref` endpoint rather than looping individual Python calls to improve performance.

## Reference documentation
- [Protmapper GitHub Repository](./references/github_com_gyorilab_protmapper.md)