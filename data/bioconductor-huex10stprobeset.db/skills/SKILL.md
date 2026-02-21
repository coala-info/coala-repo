---
name: bioconductor-huex10stprobeset.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/huex10stprobeset.db.html
---

# bioconductor-huex10stprobeset.db

## Overview

The `huex10stprobeset.db` package is a Bioconductor annotation hub for the Affymetrix Human Exon 1.0 ST Array, specifically at the probeset level. It provides a comprehensive set of mappings between manufacturer probe IDs and standard biological identifiers. This package is essential for downstream analysis of microarray data, allowing researchers to interpret probe-level signals in the context of known genes, pathways, and genomic coordinates.

## Core Workflows

### Loading the Package
To begin using the annotation data, load the library in R:

```r
library(huex10stprobeset.db)
```

### Using the select() Interface
The recommended way to interact with this package is through the `select()` interface from the `AnnotationDbi` package. This allows for tabular retrieval of data.

```r
# List available columns for mapping
columns(huex10stprobeset.db)

# List available key types (usually PROBEID)
keytypes(huex10stprobeset.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("2315100", "2315106", "2315109")
select(huex10stprobeset.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

*   **Gene Symbols:** Map probes to official gene symbols using `SYMBOL`.
*   **Chromosomal Location:** Use `CHR`, `CHRLOC`, and `CHRLOCEND` to find the genomic coordinates of the target genes.
*   **Functional Annotation:** Use `GO` (Gene Ontology) or `PATH` (KEGG Pathways) for enrichment analysis preparation.
*   **External IDs:** Map to `ENSEMBL`, `UNIPROT`, or `REFSEQ` identifiers.

### Legacy Bimap Interface
While `select()` is preferred, you can still access specific mappings using the "Bimap" style:

```r
# Get a list of probe IDs to Gene Symbols
mapped_symbols <- as.list(huex10stprobesetSYMBOL)

# Access a specific probe
mapped_symbols[["2315100"]]
```

### Database Metadata
To inspect the underlying database schema or connection information:

```r
huex10stprobeset_dbschema()
huex10stprobeset_dbInfo()
```

## Tips for Effective Use
*   **Handling Multiple Matches:** Some probes may map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with one row per match, which may result in more rows than input keys.
*   **Filtering GO Terms:** When retrieving GO IDs, the package provides `Evidence` codes. You may want to filter these (e.g., excluding 'IEA' - Inferred from Electronic Annotation) for higher confidence analyses.
*   **Organism Context:** This package is specific to *Homo sapiens*. For gene-centric information, it relies on the `org.Hs.eg.db` parent package.

## Reference documentation
- [huex10stprobeset.db Reference Manual](./references/reference_manual.md)