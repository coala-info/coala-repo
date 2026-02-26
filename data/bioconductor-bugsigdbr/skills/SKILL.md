---
name: bioconductor-bugsigdbr
description: The bugsigdbr package provides an R interface to access and process manually curated microbial signatures from the BugSigDB database. Use when user asks to import microbial signatures, filter signatures by metadata or ontology terms, extract taxonomic lists for specific levels, or export signatures to GMT format for enrichment analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/bugsigdbr.html
---


# bioconductor-bugsigdbr

## Overview

The `bugsigdbr` package provides an R interface to **BugSigDB**, a manually curated database of microbial signatures from published differential abundance studies. It allows users to programmatically retrieve signatures, filter them based on study metadata (like host species, body site, or condition), and convert them into standard formats for downstream analysis.

## Core Workflow

### 1. Importing Data
The primary way to access the database is via `importBugSigDB()`. This downloads and caches the full collection of curated signatures.

```r
library(bugsigdbr)
bsdb <- importBugSigDB()
# Returns a data.frame where each row is a signature
```

### 2. Filtering Signatures
You can subset the database using standard R `subset` logic on metadata columns such as `Condition`, `Body site`, or `Location of subjects`.

```r
# Example: Subset to obesity studies in feces
obesity_sigs <- subset(bsdb, Condition == "obesity" & `Body site` == "feces")
```

### 3. Extracting Microbe Signatures
Use `getSignatures()` to extract the list of microbes associated with each signature. You can specify the identifier type and taxonomic level.

*   **tax.id.type**: "ncbi" (default), "metaphlan", or "taxname".
*   **tax.level**: "genus", "species", etc.
*   **exact.tax.level**: If `FALSE`, it will map more specific taxa (e.g., species) up to the requested level (e.g., genus).

```r
# Get genus-level signatures using taxonomic names
sigs <- getSignatures(bsdb, 
                      tax.id.type = "taxname", 
                      tax.level = "genus", 
                      exact.tax.level = FALSE)
```

### 4. Ontology-Based Queries
BugSigDB uses the Experimental Factor Ontology (EFO) for conditions and UBERON for body sites. Use `subsetByOntology` to include a term and all its descendants.

```r
# Load ontologies
efo <- getOntology("efo")
uberon <- getOntology("uberon")

# Subset by a general term (e.g., all types of cancer)
cancer_sigs <- subsetByOntology(bsdb, 
                                column = "Condition", 
                                term = "cancer", 
                                ontology = efo)
```

### 5. Exporting and Browsing
Signatures can be exported to GMT format for use in Gene Set Enrichment Analysis (GSEA) or similar tools.

```r
# Write to GMT file
writeGMT(sigs, gmt.file = "signatures.gmt")

# Open the BugSigDB wiki page for a specific signature or taxon
browseSignature(names(sigs)[1])
browseTaxon("2702") # NCBI ID
```

## Tips and Best Practices
*   **Caching**: `importBugSigDB` caches data locally. Use `cache = FALSE` to force a fresh download if the database has been updated.
*   **Taxonomic Levels**: By default, `getSignatures` with a specific `tax.level` and `exact.tax.level = TRUE` will exclude any microbes not reported exactly at that level. Set `exact.tax.level = FALSE` to maximize the number of microbes included by performing taxonomic roll-up.
*   **Metadata**: The `bsdb` object contains 50 columns of metadata, including study design, sample size, and statistical tests, which are useful for filtering for high-quality or specific study types.

## Reference documentation
- [bugsigdbr](./references/bugsigdbr.md)