---
name: bioconductor-hgu2beta7
description: This package provides annotation data and mappings for the Affymetrix hgu2beta7 microarray. Use when user asks to map probe identifiers to gene symbols, retrieve functional annotations like GO terms and KEGG pathways, or find genomic locations for this specific array.
homepage: https://bioconductor.org/packages/release/data/experiment/html/hgu2beta7.html
---

# bioconductor-hgu2beta7

## Overview

The `hgu2beta7` package is a Bioconductor annotation data package for the hgu2beta7 Affymetrix array. It provides environment-based mappings between manufacturer probe identifiers and various public data identifiers (GenBank, Entrez, UniGene, etc.) and functional annotations (GO, KEGG, OMIM).

## Core Workflows

### Loading the Package and Data
To use the mappings, load the library. The package uses the `AnnotationDbi` interface (or older environment-style access).

```r
library(hgu2beta7)
# View summary of the package contents and quality control
hgu2beta7()
```

### Mapping Probe IDs to Gene Symbols and Names
One of the most common tasks is converting probe-set IDs to human-readable gene symbols or full gene names.

```r
# Get gene symbols
probes <- c("100_g_at", "101_at") # Example probe IDs
symbols <- mget(probes, hgu2beta7SYMBOL, ifnotfound = NA)
unlist(symbols)

# Get full gene names
genenames <- mget(probes, hgu2beta7GENENAME, ifnotfound = NA)
unlist(genenames)
```

### Biological Context: GO and KEGG
Map probes to Gene Ontology (GO) terms or KEGG pathway identifiers for functional enrichment analysis.

```r
# Map to GO terms
go_terms <- mget(probes[1], hgu2beta7GO)
# This returns a list with GOID, Ontology (BP, CC, MF), and Evidence code

# Map to KEGG Pathways
pathways <- mget(probes[1], hgu2beta7PATH)
unlist(pathways)
```

### Genomic Location
Retrieve chromosomal positions and cytogenetic bands.

```r
# Get chromosome number
chr <- mget(probes, hgu2beta7CHR)

# Get chromosomal location (start position in base pairs)
loc <- mget(probes, hgu2beta7CHRLOC)

# Get cytogenetic band (e.g., "7q31.2")
band <- mget(probes, hgu2beta7MAP)
```

### Reverse Mappings
Find all probes associated with a specific biological identifier (e.g., a specific GO term or Enzyme Commission number).

```r
# Find probes for a specific GO ID
probes_in_go <- as.list(hgu2beta7GO2PROBE[["GO:0006915"]])

# Find probes for a specific KEGG pathway
probes_in_path <- as.list(hgu2beta7PATH2PROBE[["04110"]])
```

## Usage Tips
- **Data Structures**: Most objects in this package are environments. Use `as.list()` to convert them to standard R lists for easier manipulation, or `mget()` for targeted lookups.
- **Missing Values**: Probes that could not be mapped at the time of the package build are assigned `NA`. Always handle `NA` values when processing results.
- **Organism**: This package specifically concerns *Homo sapiens* data, as confirmed by `hgu2beta7ORGANISM`.
- **Version Consistency**: This package is based on a specific build (e.g., NCBI LocusLink/Entrez and HG17). For the most current genomic coordinates, consider using `biomaRt` or `OrgDb` packages, though `hgu2beta7` remains the standard for legacy Affymetrix analysis.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)