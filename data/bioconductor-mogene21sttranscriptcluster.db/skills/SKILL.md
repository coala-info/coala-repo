---
name: bioconductor-mogene21sttranscriptcluster.db
description: This package provides annotation data for the Affymetrix Mouse Gene 2.1 ST Transcript Cluster platform. Use when user asks to map mouse probe identifiers to gene symbols, Entrez IDs, GO terms, KEGG pathways, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mogene21sttranscriptcluster.db.html
---

# bioconductor-mogene21sttranscriptcluster.db

name: bioconductor-mogene21sttranscriptcluster.db
description: Annotation data for the Affymetrix Mouse Gene 2.1 ST Transcript Cluster platform. Use this skill when you need to map manufacturer probe identifiers to biological metadata such as Entrez Gene IDs, Gene Symbols, Chromosomal locations, GO terms, and KEGG pathways for mouse transcriptomics data.

# bioconductor-mogene21sttranscriptcluster.db

## Overview

The `mogene21sttranscriptcluster.db` package is a Bioconductor annotation hub for the Affymetrix Mouse Gene 2.1 ST Transcript Cluster array. It provides a SQLite-based interface to map probe set identifiers (transcript clusters) to various genomic and functional annotations. The primary method for interaction is the `select()` interface from the `AnnotationDbi` package, though legacy "Bimap" objects are also available.

## Core Workflows

### Loading the Package
```r
library(mogene21sttranscriptcluster.db)
```

### Inspecting Available Data
To see what types of data (columns) can be retrieved and what keys can be used:
```r
# List available columns (e.g., SYMBOL, ENTREZID, GO, PATH)
columns(mogene21sttranscriptcluster.db)

# List available key types
keytypes(mogene21sttranscriptcluster.db)

# Preview the first few probe IDs
head(keys(mogene21sttranscriptcluster.db))
```

### Mapping Probe IDs to Gene Symbols and Entrez IDs
The most common task is converting manufacturer IDs to standard gene identifiers.
```r
probes <- c("17210870", "17210874", "17210881") # Example IDs

select(mogene21sttranscriptcluster.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Functional Annotation (GO and KEGG)
Retrieve Gene Ontology (GO) terms or KEGG pathway identifiers associated with specific probes.
```r
# Get GO terms with evidence codes
select(mogene21sttranscriptcluster.db, 
       keys = probes, 
       columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
       keytype = "PROBEID")

# Get KEGG Pathways
select(mogene21sttranscriptcluster.db, 
       keys = probes, 
       columns = "PATH", 
       keytype = "PROBEID")
```

### Chromosomal Locations
Find where the genes represented by the probes are located on the mouse genome.
```r
select(mogene21sttranscriptcluster.db, 
       keys = probes, 
       columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
       keytype = "PROBEID")
```

## Legacy Bimap Interface
While `select()` is preferred, you can use the older Bimap objects for specific list-based operations:
- `mogene21sttranscriptclusterSYMBOL`: Maps IDs to Gene Symbols.
- `mogene21sttranscriptclusterENTREZID`: Maps IDs to Entrez Gene identifiers.
- `mogene21sttranscriptclusterALIAS2PROBE`: Maps common gene aliases back to probe IDs.
- `mogene21sttranscriptclusterGO2ALLPROBES`: Maps GO IDs to all associated probes (including child terms).

Example of Bimap usage:
```r
# Convert a map to a list
symbol_list <- as.list(mogene21sttranscriptclusterSYMBOL[1:10])
```

## Database Information
To check the metadata of the annotation source (e.g., source URLs, date stamps):
```r
mogene21sttranscriptcluster_dbInfo()
```

## Reference documentation
- [mogene21sttranscriptcluster.db Reference Manual](./references/reference_manual.md)