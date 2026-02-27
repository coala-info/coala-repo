---
name: bioconductor-mgu74av2.db
description: This package provides annotation mappings for the Affymetrix MG-U74Av2 mouse expression array. Use when user asks to map probe IDs to gene symbols, Entrez IDs, GO terms, KEGG pathways, or chromosomal locations for mouse genomic analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mgu74av2.db.html
---


# bioconductor-mgu74av2.db

name: bioconductor-mgu74av2.db
description: Provides annotation mappings for the Affymetrix MG-U74Av2 mouse expression array. Use this skill to map probe IDs to gene symbols, Entrez IDs, Ensembl IDs, GO terms, and KEGG pathways for mouse genomic analysis.

## Overview
The `mgu74av2.db` package is a Bioconductor annotation data package for the Affymetrix MG-U74Av2 mouse array. It provides a SQLite-based interface to map manufacturer probe identifiers to various biological annotations, including gene symbols, chromosomal locations, and functional categories.

## Core Workflows

### 1. Using the select() Interface
The `select()` function from the `AnnotationDbi` package is the modern and preferred method for retrieving data from this package.

```r
library(mgu74av2.db)

# List all available annotation types (columns)
columns(mgu74av2.db)

# List available keytypes (the types of IDs you can use as input)
keytypes(mgu74av2.db)

# Map specific probe IDs to Symbols and Entrez IDs
probes <- c("1000_at", "1001_at", "1002_f_at")
res <- select(mgu74av2.db, 
              keys = probes, 
              columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
              keytype = "PROBEID")
print(res)
```

### 2. Functional Annotation (GO and KEGG)
You can map probes to Gene Ontology (GO) terms or KEGG pathways for functional enrichment analysis.

```r
# Map probes to GO terms with evidence codes
go_mappings <- select(mgu74av2.db, 
                      keys = probes, 
                      columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                      keytype = "PROBEID")

# Map probes to KEGG pathway identifiers
path_mappings <- select(mgu74av2.db, 
                        keys = probes, 
                        columns = "PATH", 
                        keytype = "PROBEID")
```

### 3. Using Bimaps (Legacy Interface)
Bimaps provide a list-like interface for quick lookups. While `select()` is more flexible, bimaps are still widely used in legacy code.

```r
# Map probes to symbols using the Bimap interface
x <- mgu74av2SYMBOL
mapped_probes <- mappedkeys(x)
# Convert to a list for the first 5 mapped probes
as.list(x[mapped_probes[1:5]])

# Reverse mapping: Find probes associated with a specific Gene Symbol (Alias)
alias_map <- as.list(mgu74av2ALIAS2PROBE)
alias_map[["Akt1"]]
```

### 4. Chromosomal Information
Retrieve the physical location of genes associated with the probes.

```r
# Get chromosome names
select(mgu74av2.db, keys = probes, columns = "CHR", keytype = "PROBEID")

# Get chromosomal start/end positions
select(mgu74av2.db, keys = probes, columns = c("CHRLOC", "CHRLOCEND"), keytype = "PROBEID")

# Get total chromosome lengths
mgu74av2CHRLENGTHS
```

### 5. Database Metadata and Connection
Access information about the data sources and the underlying SQLite database.

```r
# Get the organism name
mgu74av2ORGANISM

# Get the underlying SQLite connection (for advanced DBI queries)
conn <- mgu74av2_dbconn()
dbGetQuery(conn, "SELECT * FROM probes LIMIT 5")

# View the database schema
mgu74av2_dbschema()
```

## Tips
- **One-to-Many Mappings**: Be aware that a single probe ID may map to multiple GO terms or Entrez IDs. The `select()` function returns a "long" format data frame containing all matches.
- **Official Symbols**: Use `mgu74av2SYMBOL` for official gene symbols and `mgu74av2ALIAS2PROBE` if you are searching using common names or synonyms.
- **Data Versioning**: Mappings are based on Entrez Gene and other sources (e.g., NCBI, Ensembl, UCSC). Use `mgu74av2_dbInfo()` to check the date stamps of the source data.

## Reference documentation
- [mgu74av2.db Reference Manual](./references/reference_manual.md)