---
name: bioconductor-gep2pep
description: The gep2pep package converts gene expression profiles into pathway expression profiles to perform enrichment analysis across multiple experimental conditions. Use when user asks to create pathway expression profiles, perform condition-set enrichment analysis, or identify conditions that dysregulate specific pathways.
homepage: https://bioconductor.org/packages/release/bioc/html/gep2pep.html
---


# bioconductor-gep2pep

## Overview

The `gep2pep` package facilitates the transition from gene-level analysis to pathway-level analysis by creating Pathway Expression Profiles (PEPs). It uses a repository-based system to store gene sets and their corresponding enrichment scores across various experimental conditions. This approach allows for two primary types of analysis:
1.  **CondSEA (Condition-Set Enrichment Analysis):** Identifying pathways consistently dysregulated by a specific set of conditions (e.g., Drug-Set Enrichment Analysis).
2.  **PathSEA (Pathway-Set Enrichment Analysis):** Identifying conditions that consistently dysregulate a specific set of pathways (e.g., gene2drug analysis).

## Core Workflow

### 1. Repository Initialization
All data in `gep2pep` is managed via a local repository.

```r
library(gep2pep)
library(GSEABase)

# Create a repository with a GeneSetCollection
# db is a GeneSetCollection object (e.g., from MSigDB)
repoRoot <- "path/to/repo_folder"
rp <- createRepository(repoRoot, db)

# Open an existing repository
rp <- openRepository(repoRoot)
```

### 2. Building PEPs
To convert Gene Expression Profiles (GEPs) to PEPs, you must provide a matrix where rows are genes, columns are conditions, and values are **ranks** (1 = most UP-regulated).

```r
# geps: matrix of ranks with gene symbols as rownames
buildPEPs(rp, geps)

# Access stored Enrichment Scores (ES) or P-values (PV)
es_matrix <- loadESmatrix(rp, "collection_name")
pv_matrix <- loadPVmatrix(rp, "collection_name")
```

### 3. Condition-Set Enrichment Analysis (CondSEA)
Use this to find pathways shared by a set of conditions (e.g., finding the mechanism of action for a class of drugs).

```r
# pgset: vector of condition names present in the repository
results <- CondSEA(rp, pgset)

# View results for a specific collection
res_table <- getResults(results, "collection_id")
```

### 4. Pathway-Set Enrichment Analysis (PathSEA)
Use this to find conditions that target a specific set of pathways. This is often used for drug repositioning (gene2drug).

```r
# 1. Get pathways associated with a gene of interest
pws <- gene2pathways(rp, "GENE_SYMBOL")

# 2. Run PathSEA
psea_results <- PathSEA(rp, pws)

# 3. View top conditions
top_conditions <- getResults(psea_results, "collection_id")
```

## Key Functions and Tips

- **`importMSigDB.xml`**: Imports MSigDB XML files. Use `as.CategorizedCollection` to ensure compatibility with `gep2pep`'s category/subcategory requirements.
- **`makeCollectionIDs`**: Generates the internal IDs used to reference specific gene set collections within the repository.
- **`exportSEA`**: Exports analysis results to Excel format for external review.
- **`checkRepository`**: Validates the integrity of the repository and ensures PEPs are consistent across collections.
- **Rank Requirement**: Ensure input GEPs are strictly ranks. If you have log-fold changes, convert them using `apply(matrix, 2, rank, ties.method="random")` (note: `gep2pep` expects rank 1 to be the most UP-regulated).

## Reference documentation

- [Introduction to gep2pep](./references/vignette.md)