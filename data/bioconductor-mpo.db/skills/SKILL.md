---
name: bioconductor-mpo.db
description: bioconductor-mpo.db provides semantic relationships, mappings, and hierarchical navigation for the Mouse Phenotype Ontology. Use when user asks to fetch mouse phenotype terms, navigate the ontology hierarchy, or map between mouse phenotype IDs, MGI gene IDs, and human disease ontology IDs.
homepage: https://bioconductor.org/packages/release/data/annotation/html/MPO.db.html
---

# bioconductor-mpo.db

## Overview

MPO.db is a Bioconductor annotation package that provides semantic relationships and mappings for the Mouse Phenotype Ontology (MP). It serves as a mouse-specific counterpart to human disease ontology packages (like HDO.db), enabling researchers to bridge the gap between mouse genotypes, phenotypes, and human diseases. The package is built on the `AnnotationDbi` framework, supporting standard `select()`, `keys()`, and `columns()` interfaces, as well as specific Bimap objects for ontology navigation.

## Core Workflows

### 1. Loading the Package and Exploring Metadata
To begin, load the library and inspect the available mappings and database version.

```r
library(MPO.db)
library(AnnotationDbi)

# List all available Bimap objects
ls("package:MPO.db")

# Check database metadata (source, date, schema version)
toTable(MPOmetadata)
```

### 2. Fetching Phenotype Terms and Synonyms
Use `MPOTERM` to get the primary names of MP IDs, and `MPOALIAS` or `MPOSYNONYM` for alternative identifiers.

```r
# Get all terms as a data frame
all_terms <- toTable(MPOTERM)
head(all_terms)

# Look up a specific term name
term_list <- as.list(MPOTERM)
term_list[["MP:0000003"]]

# Find synonyms for a term
synonyms <- as.list(MPOSYNONYM)
synonyms[["MP:0000003"]]
```

### 3. Navigating the Ontology Hierarchy
MPO.db provides four primary objects to traverse the Directed Acyclic Graph (DAG) of mouse phenotypes:

*   **MPOANCESTOR / MPOOFFSPRING**: All nodes above or below a term in the hierarchy.
*   **MPOPARENTS / MPOCHILDREN**: Only the direct nodes immediately above or below a term.

```r
# Get direct parents of a term
parents <- as.list(MPOPARENTS)
parents[["MP:0000013"]]

# Get all offspring (descendants) of a term
offspring <- as.list(MPOOFFSPRING)
off_ids <- offspring[["MP:0000010"]]
```

### 4. Cross-Referencing Genes and Diseases
The package allows mapping between Mouse Phenotype IDs (`mpid`), MGI Gene IDs (`mgi`), and Human Disease Ontology IDs (`doid`).

```r
# Check available columns for selection
columns(MPO.db)

# Map MP IDs to Genes and Diseases
res <- select(x = MPO.db, 
              keys = c("MP:0000015", "MP:0000010"), 
              keytype = "mpid", 
              columns = c("term", "mgi", "doid"))

# Map MGI Gene IDs to Phenotypes
gene_res <- select(x = MPO.db, 
                   keys = "69865", 
                   keytype = "mgi", 
                   columns = c("mpid", "term"))
```

## Tips for Efficient Usage
*   **Bimap vs. Select**: Use `toTable()` or `as.list()` on Bimap objects (like `MPOANCESTOR`) for fast, bulk access to the hierarchy. Use `select()` for complex joins between terms, genes, and diseases.
*   **Handling Large Results**: When using `select()` with columns like `offspring` or `ancestor`, the resulting data frame can be very large due to the many-to-many relationships in the ontology.
*   **Integration**: MPO.db is designed to work alongside `DOSE` and `GOSemSim` for downstream enrichment and semantic similarity analysis.

## Reference documentation
- [MPO_vignette](./references/MPO_vignette.md)
- [MPO_vignette R Source](./references/MPO_vignette.Rmd)