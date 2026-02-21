---
name: bioconductor-hthgu133plusb.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hthgu133plusb.db.html
---

# bioconductor-hthgu133plusb.db

name: bioconductor-hthgu133plusb.db
description: Comprehensive annotation data for the Affymetrix hthgu133plusb platform. Use this skill when you need to map manufacturer probe identifiers to biological metadata such as Entrez Gene IDs, Gene Symbols, Chromosomal locations, GO terms, KEGG pathways, and Ensembl accessions for human genomic data.

# bioconductor-hthgu133plusb.db

## Overview

The `hthgu133plusb.db` package is a Bioconductor annotation data package for the Affymetrix Human Genome U133 Plus 2.0 Array (HT-HG_U133_Plus_B). It provides an SQLite-based interface to map probe set identifiers to various genomic annotations. The primary way to interact with this package is through the `select()` interface from the `AnnotationDbi` package, though legacy "Bimap" objects are also available.

## Core Workflows

### Loading the Package
```r
library(hthgu133plusb.db)
```

### Using the select() Interface
The `select()` function is the recommended method for retrieving data. It requires four arguments: the database object, the keys (input IDs), the columns (desired information), and the keytype (type of input IDs).

```r
# List available columns
columns(hthgu133plusb.db)

# List available keytypes
keytypes(hthgu133plusb.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1007_s_at", "1053_at", "117_at")
select(hthgu133plusb.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Annotation Mappings

| Target Data | Column Name | Description |
|-------------|-------------|-------------|
| Entrez Gene | `ENTREZID` | Primary NCBI gene identifier |
| Gene Symbol | `SYMBOL` | Official gene abbreviation |
| Gene Name | `GENENAME` | Full descriptive name of the gene |
| Chromosome | `CHR` | Chromosome location |
| GO Terms | `GO` | Gene Ontology identifiers and evidence codes |
| KEGG Path | `PATH` | KEGG pathway identifiers |
| Ensembl | `ENSEMBL` | Ensembl gene accession numbers |
| RefSeq | `REFSEQ` | NCBI Reference Sequence identifiers |

### Legacy Bimap Interface
While `select()` is preferred, you can access specific maps directly as Bimap objects for quick lookups or list conversions.

```r
# Map Probes to Symbols
mapped_probes <- mappedkeys(hthgu133plusbSYMBOL)
probe_to_symbol <- as.list(hthgu133plusbSYMBOL[mapped_probes])

# Map Symbols back to Probes (Alias map)
alias_to_probe <- as.list(hthgu133plusbALIAS2PROBE)
```

### Database Metadata
To inspect the database schema or connection details:
```r
hthgu133plusb_dbschema()
hthgu133plusb_dbInfo()
```

## Tips and Best Practices
- **Handling 1-to-Many Mappings**: Some probes map to multiple genes or GO terms. The `select()` function will return a data frame with multiple rows for these cases.
- **GO Evidence Codes**: When retrieving GO terms, use the `EVIDENCE` column to filter by the quality of the association (e.g., IDA for direct assay, IEA for electronic annotation).
- **Reverse Mappings**: Use the `ALIAS2PROBE` map when you have common gene symbols (including aliases) and need to find the corresponding manufacturer probe sets.
- **Package Dependencies**: Ensure `AnnotationDbi` is loaded to use `select()`, `keys()`, and `columns()`.

## Reference documentation
- [hthgu133plusb.db Reference Manual](./references/reference_manual.md)