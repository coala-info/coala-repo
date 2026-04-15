---
name: bioconductor-psicquic
description: The PSICQUIC package provides an R interface to query a distributed network of molecular interaction databases using the Molecular Interaction Query Language. Use when user asks to retrieve protein-protein interactions from multiple providers, search for interactions by gene symbol or species, and map interaction identifiers to gene symbols.
homepage: https://bioconductor.org/packages/3.5/bioc/html/PSICQUIC.html
---

# bioconductor-psicquic

## Overview

The `PSICQUIC` package provides an R interface to a distributed network of molecular interaction databases. It allows users to query multiple providers (like BioGrid, IntAct, and MINT) using the Molecular Interaction Query Language (MIQL). It is best suited for studying interactions among a specific set of genes (up to a few dozen) rather than bulk genomic downloads.

## Core Workflow

### 1. Initialization and Provider Discovery
To begin, create a PSICQUIC object and check which data providers are currently available.

```R
library(PSICQUIC)
psicquic <- PSICQUIC()
providers(psicquic)
```

### 2. Retrieving Interactions
Use the `interactions` function to query databases. You can search by gene symbols, species (Taxonomy ID), and specific publications (PubMed ID).

```R
# Find interactions between specific proteins (e.g., TP53 and MYC) in humans (9606)
tbl <- interactions(psicquic, id=c("TP53", "MYC"), species="9606")

# Retrieve all interactions reported in a specific paper
tbl.myc <- interactions(psicquic, "MYC", species="9606", publicationID="21150319")
```

**Key Arguments:**
- `id`: One or more identifiers (HUGO gene symbols are recommended).
- `species`: NCBI Taxonomy ID (e.g., "9606" for human, "10090" for mouse).
- `publicationID`: PubMed ID to restrict results to a specific study.
- `provider`: Optional character vector to limit search to specific databases (e.g., `provider="IntAct"`).

### 3. Mapping Identifiers
PSICQUIC providers often return "native" identifiers (Uniprot, RefSeq, etc.). For human data, use the `IDMapper` class to add readable Gene Symbols and Entrez IDs to your results.

```R
# Initialize mapper for human (9606)
idMapper <- IDMapper("9606")

# Add A.name, B.name, A.id, and B.id columns to the interaction table
tbl.annotated <- addGeneInfo(idMapper, tbl)
```

### 4. Analyzing Results
The returned object is a `data.frame`. You can use standard R functions to filter by confidence scores or detection methods.

```R
# View distribution of providers
table(tbl$provider)

# Filter for high-confidence interactions or specific methods
physical_interactions <- tbl[grep("physical association", tbl$type), ]
affinity_purification <- tbl[grep("affinity", tbl$detectionMethod), ]
```

## Tips and Best Practices
- **Gene Symbols vs. Protein IDs**: Always prefer HUGO gene symbols for input. If you provide a specific protein ID (e.g., a Uniprot ID), the provider will return only interactions matching that exact ID without translation.
- **Query Limits**: Querying for interactions among a large set of genes (e.g., >50) is computationally expensive because the number of pairs grows non-linearly. For large-scale data, download the provider's database directly.
- **Data Heterogeneity**: Different providers may report the same interaction from the same paper using different terms or confidence scores. Always inspect the `detectionMethod` and `confidenceScore` columns.

## Reference documentation
- [PSICQUIC](./references/PSICQUIC.md)