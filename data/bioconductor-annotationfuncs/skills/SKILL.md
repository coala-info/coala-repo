---
name: bioconductor-annotationfuncs
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/3.5/bioc/html/AnnotationFuncs.html
---

# bioconductor-annotationfuncs

name: bioconductor-annotationfuncs
description: Mapping between different types of biological annotations (Entrez, Symbol, RefSeq, Ensembl, GO) using Bioconductor annotation packages. Use this skill when you need to translate gene identifiers, find orthologs using INPARANOID data, or filter Gene Ontology and RefSeq results in R.

# bioconductor-annotationfuncs

## Overview

The `AnnotationFuncs` package provides high-level wrapper functions to simplify mapping between different identifier types in Bioconductor. While standard `AnnotationDbi` queries can be verbose and fail on missing keys, `AnnotationFuncs` provides "one-liner" solutions for complex multi-step translations (e.g., Symbol -> Entrez -> RefSeq) and handles missing data gracefully.

## Core Workflows

### 1. Basic Translation
Use `translate()` to map identifiers. It automatically handles the central ID mapping required by most `.db` packages.

```R
library(AnnotationFuncs)
library(org.Bt.eg.db)

# Simple mapping: Entrez to Symbol
genes <- c("280705", "280706", "123")
translate(genes, org.Bt.egSYMBOL)

# Multi-step mapping: Symbol to RefSeq
# 'from' maps input to central ID; 'to' maps central ID to target
symbols <- c("SERPINA1", "KERA")
translate(symbols, from=org.Bt.egSYMBOL2EG, to=org.Bt.egREFSEQ)
```

### 2. Handling Results
*   **Missing Values**: By default, unmapped elements are removed. Use `remove.missing=FALSE` to keep them as `NA`.
*   **Reducing Multi-mappings**: If one ID maps to many, use `reduce="first"` or `reduce="last"`.
*   **Output Format**: Use `return.list=FALSE` to get a data frame/matrix instead of a named list.
*   **Simplifying**: When using `lapply`, set `simplify=TRUE` to return a character vector.

### 3. RefSeq and GO Filtering
Specialized functions help pick specific types of records from a list of results.

```R
# Filter RefSeq for mRNA only
refseq_list <- translate(symbols, from=org.Bt.egSYMBOL2EG, to=org.Bt.egREFSEQ)
mRNA <- pickRefSeq(refseq_list, priorities=c("NM", "XM"))

# Filter Gene Ontology by category and evidence
go_list <- translate(symbols, from=org.Bt.egSYMBOL2EG, to=org.Bt.egGO)
bp_only <- pickGO(go_list, category="BP")
```

### 4. Finding Orthologs
The `getOrthologs` function interacts with `hom.Xx.inp.db` packages. It is significantly faster than standard `toTable` methods for large datasets.

```R
library(hom.Hs.inp.db)
# Map Human Symbols to Bovine Symbols
# pre.* translates input to Ensembl Protein (required by INPARANOID)
# post.* translates result from Ensembl Protein to target
getOrthologs(symbols, 
             hom.Hs.inpBOSTA, 
             "BOSTA", 
             pre.from=org.Hs.egSYMBOL2EG, 
             pre.to=org.Hs.egENSEMBLPROT, 
             post.from=org.Bt.egENSEMBLPROT2EG, 
             post.to=org.Bt.egSYMBOL)
```

## Tips
*   **Reversing Maps**: Use `revmap()` on a mapping object (e.g., `revmap(org.Bt.egSYMBOL)`) to switch direction.
*   **Speed**: When unlisting groups for translation, use `unlist(groups, use.names=FALSE)` for better performance.
*   **Evidence Codes**: Use `getEvidenceCodes()` to see valid strings for GO filtering.

## Reference documentation
- [AnnotationFuncs User Guide](./references/AnnotationFuncsUserguide.md)