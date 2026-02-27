---
name: bioconductor-m20kcod.db
description: This package provides Bioconductor annotation data for mapping m20kcod platform probe identifiers to biological metadata for Mus musculus. Use when user asks to map manufacturer probe IDs to gene symbols, Entrez IDs, Ensembl accessions, or functional annotations like GO and KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/m20kcod.db.html
---


# bioconductor-m20kcod.db

name: bioconductor-m20kcod.db
description: Annotation data for the m20kcod platform. Use when mapping manufacturer probe identifiers to biological metadata (Entrez, Symbol, GO, KEGG, Ensembl, etc.) for Mus musculus.

# bioconductor-m20kcod.db

## Overview

The `m20kcod.db` package is a Bioconductor annotation data package for the m20kcod platform (typically associated with mouse genomic studies). It provides SQLite-based mappings between manufacturer-specific probe identifiers and various gene identifiers, chromosomal locations, and functional annotations.

## Instructions for Using m20kcod.db

### Loading the Package and Exploring Content

Load the library and list all available mapping objects:

```r
library(m20kcod.db)
ls("package:m20kcod.db")
```

### Basic Mapping Workflow

To map manufacturer IDs to specific identifiers (e.g., Gene Symbols), use the `as.list()` function or the `select()` interface from `AnnotationDbi`.

**Using as.list():**
```r
# Get the mapping object
x <- m20kcodSYMBOL
# Get mapped probe IDs
mapped_probes <- mappedkeys(x)
# Convert to a list for lookup
symbol_list <- as.list(x[mapped_probes])
# Access specific probes
symbol_list[1:5]
```

**Using select() (Recommended for complex queries):**
```r
library(AnnotationDbi)
probes <- c("probe_id_1", "probe_id_2") # Replace with actual IDs
select(m20kcod.db, keys = probes, columns = c("SYMBOL", "ENTREZID", "GENENAME"), keytype = "PROBEID")
```

### Common Mapping Objects

*   **Gene Identifiers**:
    *   `m20kcodENTREZID`: Map to Entrez Gene identifiers.
    *   `m20kcodSYMBOL`: Map to official Gene Symbols.
    *   `m20kcodGENENAME`: Map to full Gene Names.
    *   `m20kcodENSEMBL`: Map to Ensembl gene accession numbers.
    *   `m20kcodMGI`: Map to Jackson Laboratory MGI gene accession numbers.
    *   `m20kcodUNIPROT`: Map to UniProt accession numbers.

*   **Functional Annotations**:
    *   `m20kcodGO`: Map to Gene Ontology (GO) identifiers (includes Evidence and Ontology type).
    *   `m20kcodPATH`: Map to KEGG pathway identifiers.
    *   `m20kcodENZYME`: Map to Enzyme Commission (EC) numbers.

*   **Positional Information**:
    *   `m20kcodCHR`: Map to chromosomes.
    *   `m20kcodCHRLOC`: Map to chromosomal starting positions.
    *   `m20kcodCHRLENGTHS`: Get lengths of chromosomes.

### Reverse Mappings

Many objects have specific reverse mappings (e.g., mapping Symbols back to Probes):
*   `m20kcodALIAS2PROBE`: Map common gene symbols/aliases to manufacturer IDs.
*   `m20kcodGO2PROBE`: Map GO IDs to manufacturer IDs.
*   `m20kcodPATH2PROBE`: Map KEGG IDs to manufacturer IDs.

Alternatively, use `revmap()` on a standard mapping object:
```r
rev_map <- revmap(m20kcodSYMBOL)
```

### Database Connection Utilities

Access the underlying SQLite database directly if needed:
*   `m20kcod_dbconn()`: Returns the DBIConnection object.
*   `m20kcod_dbfile()`: Returns the path to the SQLite database file.
*   `m20kcod_dbschema()`: Prints the database schema.

## Reference documentation

- [m20kcod.db Reference Manual](./references/reference_manual.md)