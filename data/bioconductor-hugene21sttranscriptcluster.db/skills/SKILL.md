---
name: bioconductor-hugene21sttranscriptcluster.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hugene21sttranscriptcluster.db.html
---

# bioconductor-hugene21sttranscriptcluster.db

name: bioconductor-hugene21sttranscriptcluster.db
description: Use this skill to perform genomic annotation for the Affymetrix Human Gene 2.1 ST Transcript Cluster array. It provides mappings between manufacturer probe identifiers and various biological identifiers like Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, and chromosomal locations. Use this when you need to annotate differential expression results or map transcript cluster IDs to functional data.

## Overview

The `hugene21sttranscriptcluster.db` package is a Bioconductor annotation data package for the Affymetrix Human Gene 2.1 ST array. It uses the `AnnotationDbi` interface to provide a SQLite-based mapping between transcript cluster identifiers (probes) and biological metadata. The primary method for interaction is the `select()` interface, though older "Bimap" objects are also available.

## Core Workflows

### Loading the Package
```R
library(hugene21sttranscriptcluster.db)
```

### Exploring Available Data
To see what types of information (columns) you can retrieve:
```R
columns(hugene21sttranscriptcluster.db)
# Common columns: "ENTREZID", "SYMBOL", "GENENAME", "GO", "PATH", "ENSEMBL"
```

To see the types of keys you can use as input:
```R
keytypes(hugene21sttranscriptcluster.db)
```

### Using the select() Interface
The `select()` function is the recommended way to extract data. It requires the database object, the keys (IDs) you want to look up, the columns you want to retrieve, and the keytype of your input.

```R
# Example: Map transcript cluster IDs to Gene Symbols and Entrez IDs
probes <- c("16650001", "16650003", "16650005")
annotations <- select(hugene21sttranscriptcluster.db, 
                      keys = probes, 
                      columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                      keytype = "PROBEID")
```

### Mapping Gene Symbols to Probes
If you have gene symbols and need to find the corresponding transcript cluster IDs:
```R
symbols <- c("TP53", "BRCA1")
probe_ids <- select(hugene21sttranscriptcluster.db, 
                    keys = symbols, 
                    columns = "PROBEID", 
                    keytype = "SYMBOL")
```

### Functional Annotation (GO and KEGG)
- **GO Terms**: Retrieve Gene Ontology identifiers and evidence codes.
- **KEGG Pathways**: Map probes to PATH identifiers for pathway analysis.

```R
# Get GO terms for specific probes
go_annos <- select(hugene21sttranscriptcluster.db, 
                   keys = probes, 
                   columns = "GO", 
                   keytype = "PROBEID")
```

### Chromosomal Location
Use `CHR`, `CHRLOC`, and `CHRLOCEND` to find the physical mapping of the transcript clusters.
```R
locs <- select(hugene21sttranscriptcluster.db, 
               keys = probes, 
               columns = c("CHR", "CHRLOC"), 
               keytype = "PROBEID")
```

## Tips and Best Practices
- **One-to-Many Mappings**: Note that `select()` may return more rows than input keys if a probe maps to multiple GO terms or genes. Use `multiVals` arguments in related functions or handle duplicates in the resulting data frame.
- **Bimap Interface**: While `as.list(hugene21sttranscriptclusterSYMBOL)` still works, the `select()` interface is more robust and consistent with modern Bioconductor standards.
- **Database Connection**: You can inspect the underlying SQLite database using `hugene21sttranscriptcluster_dbconn()`.

## Reference documentation
- [hugene21sttranscriptcluster.db](./references/reference_manual.md)