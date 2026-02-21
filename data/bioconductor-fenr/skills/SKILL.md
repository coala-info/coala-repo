---
name: bioconductor-fenr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/fenr.html
---

# bioconductor-fenr

name: bioconductor-fenr
description: Rapid functional enrichment analysis using the fenr R package. Use this skill when you need to perform fast, interactive-ready overrepresentation analysis (Fisher's test) for gene or protein sets using databases like GO, KEGG, Reactome, BioPlanet, or WikiPathways.

# bioconductor-fenr

## Overview

The `fenr` package is designed for high-speed functional enrichment analysis. It achieves this by decoupling the time-consuming data acquisition and preparation steps from the statistical testing. This makes it ideal for exploratory data analysis and interactive applications (like Shiny) where multiple gene selections need to be tested against the same background in real-time.

## Core Workflow

### 1. Data Acquisition
Use helper functions to fetch functional terms and mappings.
```r
library(fenr)

# Fetch Gene Ontology data for a specific species (e.g., "sgd" for yeast)
go_data <- fetch_go(species = "sgd")

# To see available species/designations:
species_list <- fetch_go_species()

# Other fetch functions:
# fetch_kegg(species)
# fetch_reactome()
# fetch_bioplanet()
# fetch_wikipathways()
```

### 2. Preparation for Enrichment
Convert the raw data into a high-performance `fenr_terms` object. This step requires a "background" vector of all features (e.g., all genes detected in an experiment).
```r
# go_data$terms: term descriptions
# go_data$mapping: feature-to-term mapping
# background_genes: vector of all gene symbols/IDs in the study

go_terms_obj <- prepare_for_enrichment(
  terms = go_data$terms,
  mapping = go_data$mapping,
  features = background_genes,
  feature_name = "gene_symbol" # Must match column name in mapping
)
```

### 3. Running Enrichment
Perform the actual test on a selection of interest (e.g., differentially expressed genes).
```r
# selection_genes: vector of genes of interest
results <- functional_enrichment(background_genes, selection_genes, go_terms_obj)
```

## Interpreting Results

The output is a tibble containing:
- `N_with`: Total features in background with this term.
- `n_with_sel`: Features in your selection with this term.
- `n_expect`: Expected number of features by random chance.
- `enrichment`: Ratio of observed vs. expected.
- `odds_ratio`: Effect size from the contingency table.
- `p_value`: Raw hypergeometric p-value.
- `p_adjust`: Benjamini-Hochberg adjusted p-value.
- `ids`: String of feature identifiers from the selection associated with the term.

## Interactive Usage
`fenr` includes a built-in Shiny app demonstration for exploring differential expression results:
```r
# Requires a DE result object and a list of prepared fenr_terms objects
enrichment_interactive(de_results, list(GO = go_terms_obj))
```

## Tips
- **Evidence Filtering**: Before calling `prepare_for_enrichment`, you can filter `go_data$mapping` by the `evidence` column to restrict analysis to specific experimental evidence codes.
- **Speed**: While `prepare_for_enrichment` may take several seconds, `functional_enrichment` typically executes in milliseconds, allowing for rapid iteration.
- **Custom Ontologies**: You can use custom data by providing your own terms and mapping data frames to `prepare_for_enrichment`.

## Reference documentation
- [Fast functional enrichment](./references/fenr.Rmd)
- [Fast functional enrichment (Markdown)](./references/fenr.md)