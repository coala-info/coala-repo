---
name: bioconductor-bioplex
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.14/bioc/html/BioPlex.html
---

# bioconductor-bioplex

name: bioconductor-bioplex
description: Access and analyze BioPlex protein-protein interaction (PPI) networks, CORUM complexes, and associated transcriptome/proteome data for human cell lines (293T and HCT116). Use this skill to retrieve PPI data, map protein identifiers, convert networks to graph objects, and integrate interaction data with PFAM domains or expression profiles.

## Overview

The BioPlex package provides R-based access to the BioPlex project's high-throughput affinity-purification mass spectrometry (AP-MS) data. It allows users to explore the human interactome by retrieving cell-line-specific PPI networks (293T and HCT116), CORUM protein complexes, and corresponding RNA-seq and proteomic datasets. The package facilitates the conversion of these data into standard Bioconductor structures like `graphNEL` and `SummarizedExperiment` for downstream systems biology analysis.

## Core Workflows

### 1. Retrieving PPI Networks
Access the latest BioPlex interaction data for specific cell lines.

```r
library(BioPlex)

# Get BioPlex 3.0 for 293T cells
bp.293t <- getBioPlex(cell.line = "293T", version = "3.0")

# Get BioPlex 1.0 for HCT116 cells
bp.hct116 <- getBioPlex(cell.line = "HCT116", version = "1.0")

# Optional: Remap Uniprot IDs to current symbols/Entrez IDs
bp.remapped <- getBioPlex(cell.line = "293T", version = "3.0", remap.uniprot.ids = TRUE)
```

### 2. Graph Representation and Analysis
Convert data frames into graph objects to perform network analysis.

```r
# Convert to directed graph (bait -> prey)
bp.gr <- bioplex2graph(bp.293t)

# Add PFAM domain annotations to nodes (requires OrgDb)
library(AnnotationHub)
ah <- AnnotationHub()
orgdb <- query(ah, c("orgDb", "Homo sapiens"))[[1]]
bp.gr <- annotatePFAM(bp.gr, orgdb)

# Extract a subnetwork based on specific nodes
nodes_of_interest <- c("P24941", "P24385") # Uniprot IDs
bp.sub <- graph::subGraph(nodes_of_interest, bp.gr)
```

### 3. Working with CORUM Complexes
Retrieve and manipulate known protein complex data.

```r
# Get the core set of human complexes
core.corum <- getCorum(set = "core", organism = "Human")

# Convert to a list of UniProt IDs
corum.list <- corum2list(core.corum)

# Convert to a list of undirected graphs (all-to-all connectivity)
corum.glist <- corum2graphlist(core.corum)

# Check if a specific subunit exists in complexes
has.cdk2 <- hasSubunit(corum.glist, subunit = "CDK2", id.type = "SYMBOL")
cdk2.complexes <- corum.glist[has.cdk2]
```

### 4. Integrating Expression Data
Retrieve transcriptome and proteome data associated with BioPlex cell lines.

```r
# Get RNA-seq data (SummarizedExperiment) for 293T
se.rna <- getGSE122425()

# Get relative protein expression (293T vs HCT116)
bp.prot <- getBioplexProteome()

# Access CCLE proteome data via ExperimentHub
library(ExperimentHub)
eh <- ExperimentHub()
ccle.prot <- eh[["EH3459"]]
# Convert to SummarizedExperiment
se.prot <- ccleProteome2SummarizedExperiment(ccle.prot)
```

## Tips and Best Practices

- **Identifier Mapping**: BioPlex functions primarily use UniProt IDs as node keys. Use `remap.uniprot.ids = TRUE` in getter functions to ensure gene symbols and Entrez IDs are synchronized with current Bioconductor annotations.
- **Interaction Scores**: The `pInt` column in the PPI data frame represents the probability of a bona fide interaction. Filter this (e.g., `pInt > 0.95`) for high-confidence networks.
- **Graph Conversion**: `bioplex2graph` creates a `graphNEL` object. If you prefer `igraph`, use `igraph::graph_from_graphnel(bp.gr)`.
- **Caching**: Data is cached locally using `BiocFileCache`. To force a fresh download, set `cache = FALSE` in the `get*` functions.

## Reference documentation

- [Basic checks of BioPlex PPI data](./references/BasicChecks.md)
- [Import and representation of BioPlex PPI data and related resources](./references/BioPlex.md)