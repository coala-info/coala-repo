---
name: bioconductor-mmagilentdesign026655.db
description: This Bioconductor package provides SQLite-based annotation data for the Agilent Mouse Design 026655 microarray. Use when user asks to map Agilent probe identifiers to gene symbols, Entrez IDs, GO terms, KEGG pathways, or other genomic and functional annotations for Mus musculus.
homepage: https://bioconductor.org/packages/release/data/annotation/html/MmAgilentDesign026655.db.html
---


# bioconductor-mmagilentdesign026655.db

## Overview

The `MmAgilentDesign026655.db` package is a Bioconductor annotation data package for the Agilent Mouse Design 026655 microarray. It provides a SQLite-based interface to map manufacturer probe identifiers to various genomic and functional annotations.

## Core Usage

### Loading the Package
```r
library(MmAgilentDesign026655.db)
```

### The select() Interface
The recommended way to interact with this package is via the `select()` interface from `AnnotationDbi`.

```r
# View available columns (types of data)
columns(MmAgilentDesign026655.db)

# View available keytypes (what you can search by)
keytypes(MmAgilentDesign026655.db)

# Example: Map Agilent IDs to Gene Symbols and Entrez IDs
probes <- c("12345", "67890") # Replace with actual Agilent IDs
select(MmAgilentDesign026655.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Legacy Bimap Interface
While `select()` is preferred, you can still use the older Bimap interface for specific mappings.

```r
# Map Probes to Gene Symbols
x <- MmAgilentDesign026655SYMBOL
mapped_probes <- mappedkeys(x)
xx <- as.list(x[mapped_probes])

# Access first 5 mappings
xx[1:5]
```

## Common Mapping Tasks

### Functional Annotation
- **Gene Ontology (GO):** Use `MmAgilentDesign026655GO` for direct mappings or `MmAgilentDesign026655GO2ALLPROBES` to include child terms.
- **KEGG Pathways:** Use `MmAgilentDesign026655PATH` to find pathway associations.
- **Enzyme Commission (EC):** Use `MmAgilentDesign026655ENZYME`.

### Genomic Location
- **Chromosomes:** `MmAgilentDesign026655CHR`
- **Chromosomal Location:** `MmAgilentDesign026655CHRLOC` (start) and `MmAgilentDesign026655CHRLOCEND` (end). Negative values indicate the antisense strand.

### External Identifiers
- **Ensembl:** `MmAgilentDesign026655ENSEMBL`
- **RefSeq:** `MmAgilentDesign026655REFSEQ`
- **MGI (Mouse Genome Informatics):** `MmAgilentDesign026655MGI`
- **UniProt:** `MmAgilentDesign026655UNIPROT`

## Database Information
To inspect the underlying database schema or connection:
```r
MmAgilentDesign026655_dbschema()
MmAgilentDesign026655_dbInfo()
```

## Tips
- **NAs:** If a probe cannot be mapped to a specific identifier (e.g., a Symbol), it will return `NA`.
- **One-to-Many:** Some probes may map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with one row per mapping.
- **Organism:** This package is specific to *Mus musculus*. Use `MmAgilentDesign026655ORGANISM` to confirm.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)