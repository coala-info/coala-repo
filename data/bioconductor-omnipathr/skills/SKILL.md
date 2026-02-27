---
name: bioconductor-omnipathr
description: "OmnipathR retrieves and analyzes comprehensive molecular signaling data including protein interactions, gene regulatory networks, and intercellular communication. Use when user asks to retrieve signaling networks, access enzyme-substrate relationships, identify protein complexes, analyze cell-cell communication, translate protein identifiers, or perform graph-based path finding."
homepage: https://bioconductor.org/packages/release/bioc/html/OmnipathR.html
---


# bioconductor-omnipathr

name: bioconductor-omnipathr
description: Comprehensive molecular signaling knowledge retrieval and analysis using the OmnipathR Bioconductor package. Use this skill to access protein-protein interactions, gene regulatory networks, enzyme-PTM relationships, protein complexes, and intercellular communication data. It supports identifier translation, igraph integration, and building prior knowledge networks (PKN) for modeling tools like COSMOS or NicheNet.

# bioconductor-omnipathr

## Overview
OmnipathR is an R client for the OmniPath database, a massive integration of over 100 molecular biology resources. It provides a unified interface to retrieve directed, signed signaling networks, functional annotations, and intercellular communication roles. The package is designed for mechanistic modeling, causal reasoning, and multi-omics integration.

## Core Workflows

### 1. Retrieving Networks
OmniPath categorizes interactions into several datasets. Use the specific functions to retrieve data frames of interactions.

```r
library(OmnipathR)

# Literature curated, directed, and signed PPI (The "classic" OmniPath)
interactions <- omnipath()

# Gene regulatory interactions (TF-target) from DoRothEA
gr_interactions <- transcriptional()

# Enzyme-substrate relationships with PTM details
enz_sub <- enzyme_substrate()

# miRNA-target interactions
mirna_targets <- mirnatarget()
```

### 2. Functional Annotations and Complexes
Access protein function, localization, and structural information from ~60 resources.

```r
# Get protein complexes
cplx <- complexes()

# Get annotations (e.g., localization from UniProt)
# Use wide = TRUE to get a resource-specific format
uniprot_loc <- annotations(
    resources = 'UniProt_location',
    wide = TRUE
)

# Add annotations directly to a network
network <- omnipath()
annotated_net <- annotated_network(network, 'SignaLink_pathway')
```

### 3. Intercellular Communication
OmniPath defines roles (ligand, receptor, etc.) to build cell-cell communication networks.

```r
# Get roles for individual proteins
roles <- intercell()

# Build a ligand-receptor network
icn <- intercell_network(high_confidence = TRUE)

# Fine-grained filtering of the communication network
icn_filtered <- filter_intercell_network(
    icn,
    ligand_receptor = TRUE,
    consensus_percentile = 30
)
```

### 4. Graph Analysis and Path Finding
Integrate with `igraph` for network topology analysis.

```r
library(igraph)

# Convert data frame to igraph object
g <- interaction_graph(interactions)

# Find all paths between specific nodes (up to length 3)
paths <- find_all_paths(
    graph = g,
    start = c('EGFR', 'STAT3'),
    end = c('AKT1', 'ULK1'),
    attr = 'name'
)
```

### 5. Identifier Translation
OmnipathR provides robust ID mapping using UniProt as the backbone.

```r
d <- data.frame(uniprot_id = c('P00533', 'Q9ULV1'))
d <- translate_ids(
    d,
    uniprot_id = uniprot, # source
    genesymbol            # target
)
```

## Advanced Features

### COSMOS Prior Knowledge Network (PKN)
Build heterogeneous networks (protein-protein + metabolic) for COSMOS.
```r
# Build the complete PKN (combines OmniPath, STITCH, and Chalmers GEM)
pkn <- cosmos_pkn()
```

### Database Management
The package manages large datasets with an internal cache and expiry system.
```r
# List available internal databases
omnipath_show_db()

# Access a specific database (e.g., UniProt-GeneSymbol mapping)
up_gs <- get_db('up_gs')

# Clear cache if needed
omnipath_cache_remove('specific_query_string')
```

## Tips for Success
- **License Filtering**: Some resources are for academic use only. Use `options(omnipath.license = 'commercial')` to restrict results to commercially friendly data.
- **Resource Selection**: Use `..._resources()` functions (e.g., `annotation_resources()`) to see available data providers before querying.
- **Tidyverse Integration**: Most functions return `tibbles`, making them compatible with `dplyr` and `ggplot2`.
- **Logging**: If a download fails or results are unexpected, check `omnipath_log()`.

## Reference documentation
- [OmniPath Bioconductor Workshop](./references/bioc_workshop.md)
- [Building PKN for COSMOS](./references/cosmos.md)
- [The Database Manager in OmnipathR](./references/db_manager.md)
- [Building Networks Around Drug-Targets](./references/drug_targets.md)
- [Extra Attributes in OmniPath](./references/extra_attrs.md)
- [NicheNet Integration](./references/nichenet.md)
- [OmnipathR Introduction](./references/omnipath_intro.md)
- [Path Construction from Networks](./references/paths.md)