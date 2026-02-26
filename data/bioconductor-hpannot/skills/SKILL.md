---
name: bioconductor-hpannot
description: This tool provides signaling pathway topologies and functional annotations for human, mouse, and rat to support the Hipathia signal transduction method. Use when user asks to retrieve pathway graphs, map gene identifiers, or access functional annotations like GO and UniProt for signaling network analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hpAnnot.html
---


# bioconductor-hpannot

name: bioconductor-hpannot
description: Access and use the hpAnnot Bioconductor package for signaling pathway annotation and data. Use this skill when you need to retrieve functional annotations (GO, UniProt), pathway topologies, or cross-reference maps for the Hipathia signal transduction method. It supports data for Homo sapiens, Mus musculus, and Rattus norvegicus.

## Overview

`hpAnnot` is a specialized data and annotation package designed to support the `hipathia` package. It provides the necessary network topologies and functional annotations required to compute signal intensity through signaling pathways. The package is primarily accessed through `AnnotationHub`, allowing users to retrieve specific versions of pathway graphs, gene ID mappings, and functional annotations for human, mouse, and rat.

## Accessing Data via AnnotationHub

The data in `hpAnnot` is stored in `AnnotationHub`. To use it, you must first initialize the hub and query for the package.

```r
library(AnnotationHub)

# Initialize the hub
ah <- AnnotationHub()

# Query for hpAnnot records
hp <- query(ah, "hpAnnot")

# View available records
mcols(hp)[, c("title", "description")]
```

## Common Data Types

The package contains several types of resources, often suffixed with `_v2` for the latest versions:

- **Functional Annotations (`annofuns_`, `annot_`)**: GO and UniProt annotations for effector nodes in pathways.
- **Cross-References (`xref_`, `entrez_hgnc_`)**: Mapping tables between different gene identifiers (e.g., Entrez, HGNC, Uniprot).
- **Pathway Topology (`pmgi_`, `meta_graph_info_`)**: Information regarding the structure of signaling pathways and pseudo-pathways.
- **GO Networks (`go_bp_net`)**: Biological process networks for Gene Ontology.

## Typical Workflow

### 1. Selecting a Specific Resource
Identify the AH ID (e.g., "AH69123") or use the title to retrieve a specific object.

```r
# Retrieve a specific cross-reference table for Human (v2)
xref_hsa <- hp[["AH69123"]]

# Retrieve GO annotations for Human effector nodes
annofuns_go <- hp[["AH60887"]]
```

### 2. Inspecting Annotation Data
The annotation objects typically contain mappings between effector nodes and functions.

```r
# View the structure of the annotation data
head(annofuns_go)

# Columns usually include:
# - effector.nodes: The specific node in the pathway
# - paths: The pathway ID
# - funs: The functional description (e.g., GO term)
```

### 3. Filtering by Species or Provider
You can summarize the available data to find what you need for a specific organism.

```r
# See distribution of data by provider and species
xtabs(~dataprovider + species, mcols(hp))
```

## Tips for Success

- **Version Control**: Always prefer the `_v2` versions of files (e.g., `xref_hsa_v2.rda`) for the most up-to-date mappings unless reproducing older research.
- **Hipathia Integration**: This package is rarely used in isolation. It provides the `annotation` argument data for `hipathia` functions.
- **Memory Management**: `AnnotationHub` caches files locally. If you encounter issues, check your `getAnnotationHubCache()` directory.

## Reference documentation

- [hpAnnot Vignette](./references/hpAnnot-vignette.md)