---
name: bioconductor-ctdquerier
description: This tool queries and analyzes curated relationships between chemicals, genes, and diseases from the Comparative Toxicogenomics Database. Use when user asks to retrieve toxicogenomic interactions, perform enrichment analysis, or visualize gene-chemical-disease networks and heatmaps.
homepage: https://bioconductor.org/packages/release/bioc/html/CTDquerier.html
---

# bioconductor-ctdquerier

name: bioconductor-ctdquerier
description: Query and analyze data from the Comparative Toxicogenomics Database (CTD) using the CTDquerier R package. Use this skill to retrieve interactions between genes, chemicals, and diseases, perform enrichment analysis, and visualize toxicogenomic networks and heatmaps.

# bioconductor-ctdquerier

## Overview
The `CTDquerier` package provides an interface to the Comparative Toxicogenomics Database (CTD), allowing users to retrieve and analyze curated relationships between chemicals, genes, and diseases. It encapsulates results in `CTDdata` objects, which support downstream analysis like Fisher's exact test enrichment and specialized visualizations (networks and heatmaps).

## Core Workflow

### 1. Querying CTDbase
Queries are performed based on the type of input term. Each function returns a `CTDdata` object.

```R
library(CTDquerier)

# Query by Gene Symbols
gene_data <- query_ctd_gene(terms = c("APP", "HMOX1"))

# Query by Chemical Names
chem_data <- query_ctd_chem(terms = c("Iron", "Air Pollutants"))

# Query by Disease Names
dise_data <- query_ctd_dise(terms = "Asthma")
```

### 2. Data Extraction
Use `get_table` to retrieve specific data frames from the `CTDdata` object.

*   **Available indices:** `"gene interactions"`, `"chemical interactions"`, `"diseases"`, `"gene-gene interactions"`, `"kegg pathways"`, `"go terms"`.

```R
# Extract disease associations for the queried genes
diseases_df <- get_table(gene_data, index_name = "diseases")

# Extract chemical interactions for the queried genes
chem_int <- get_table(gene_data, index_name = "chemical interactions")
```

### 3. Enrichment Analysis
Perform enrichment analysis (Fisher's test) by comparing two `CTDdata` objects or a set of genes against a universe.

```R
# Compare a gene set (gala) against a chemical's associated genes (air)
data("gala")
air <- query_ctd_chem(terms = "Air Pollutants")
enrich_results <- enrich(gala, air)
```

### 4. Visualization
The `plot` method is overloaded for `CTDdata` objects. Use `index_name` and `representation` to control the output.

*   **Heatmaps:** Best for inference scores or reference counts.
*   **Networks:** Best for KEGG pathways, GO terms, or gene-gene interactions.

```R
# Heatmap of gene-disease inference scores
plot(gene_data, index_name = "disease", representation = "heatmap")

# Network of gene-GO term associations
plot(gene_data, index_name = "go terms", representation = "network")

# Network of chemical-gene interactions (includes mechanism)
plot(chem_data, index_name = "gene interactions", representation = "network")
```

## Vocabulary Management
If you need to browse the available terms before querying, you can download and load the full vocabularies.

```R
# Download and load chemical vocabulary
download_ctd_chem()
chem_vocab <- load_ctd_chem()

# Check for terms found vs lost in a query
terms_info <- get_terms(gene_data)
found_genes <- terms_info$used
missing_genes <- terms_info$lost
```

## Tips
*   **Max Distance:** In `query_ctd_chem`, use the `max.distance` argument to control fuzzy matching for chemical names.
*   **Filtering:** The `plot` function supports `subset.chemical`, `subset.gene`, and `subset.pathway` to declutter complex networks.
*   **Curated vs All:** In `enrich`, use the `use` argument (default "curated") to decide whether to include non-curated CTD associations.

## Reference documentation
- [CTDquerier Reference Manual](./references/reference_manual.md)