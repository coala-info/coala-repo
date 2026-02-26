---
name: bioconductor-h10kcod.db
description: This package provides SQLite-based maps to link manufacturer probe identifiers from the h10kcod platform to various biological annotations. Use when user asks to map h10kcod probes to Entrez Gene IDs, gene symbols, GO terms, KEGG pathways, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/h10kcod.db.html
---


# bioconductor-h10kcod.db

name: bioconductor-h10kcod.db
description: Use this skill when you need to map manufacturer identifiers (probes) from the h10kcod platform to biological annotations. This includes mapping to Entrez Gene IDs, Gene Symbols, RefSeq accessions, Ensembl IDs, GO terms, KEGG pathways, and chromosomal locations.

# bioconductor-h10kcod.db

## Overview

The `h10kcod.db` package is a Bioconductor annotation data package for the h10kcod platform. It provides a set of SQLite-based maps that link manufacturer-specific probe identifiers to various types of biological data. This package is essential for downstream analysis of microarray data where probe-level results must be interpreted in the context of genes, pathways, and functions.

## Core Usage

### Loading the Package and Exploring Maps

To begin, load the library and list all available mapping objects:

```r
library(h10kcod.db)
# List all available maps in the package
ls("package:h10kcod.db")
```

### Basic Mapping Workflow

Most objects in this package are used by converting them to a list or using the `AnnotationDbi::select` interface.

```r
# Example: Mapping probes to Gene Symbols
# 1. Get the mapping object
x <- h10kcodSYMBOL
# 2. Get probes that have a mapping
probes <- mappedkeys(x)
# 3. Convert to a list for specific probes
symbol_list <- as.list(x[probes[1:5]])
```

### Common Mapping Objects

- **Gene Identifiers**:
  - `h10kcodENTREZID`: Maps probes to Entrez Gene identifiers.
  - `h10kcodSYMBOL`: Maps probes to official Gene Symbols.
  - `h10kcodGENENAME`: Maps probes to full Gene Names.
  - `h10kcodALIAS2PROBE`: Maps common gene aliases to manufacturer identifiers (reverse map).

- **External Databases**:
  - `h10kcodENSEMBL`: Maps probes to Ensembl gene accession numbers.
  - `h10kcodUNIPROT`: Maps probes to UniProt accession numbers.
  - `h10kcodREFSEQ`: Maps probes to RefSeq identifiers.
  - `h10kcodACCNUM`: Maps probes to GenBank accession numbers.

- **Functional Annotation**:
  - `h10kcodGO`: Maps probes to Gene Ontology (GO) identifiers (direct associations).
  - `h10kcodGO2ALLPROBES`: Maps GO identifiers to all associated probes (including child terms).
  - `h10kcodPATH`: Maps probes to KEGG pathway identifiers.
  - `h10kcodENZYME`: Maps probes to Enzyme Commission (EC) numbers.

- **Genomic Location**:
  - `h10kcodCHR`: Maps probes to chromosomes.
  - `h10kcodMAP`: Maps probes to cytogenetic bands.
  - `h10kcodCHRLOC`: Maps probes to chromosomal starting positions.

### Reverse Mappings

Many objects have a reverse mapping available (e.g., finding which probes correspond to a specific GO term or Pathway). These are typically named with a `2PROBE` suffix:

```r
# Find probes associated with a specific KEGG pathway
path_to_probe <- as.list(h10kcodPATH2PROBE)
my_probes <- path_to_probe[["04110"]]
```

### Database Connection and Metadata

You can access the underlying SQLite database directly or check the package metadata:

```r
# Get database connection
conn <- h10kcod_dbconn()
# Show database schema
h10kcod_dbschema()
# Get organism information
h10kcodORGANISM
```

## Tips for Efficient Use

1. **Check Mapping Counts**: Use `h10kcodMAPCOUNTS` to see how many keys are successfully mapped for each object before running large loops.
2. **Use AnnotationDbi**: For more complex queries involving multiple types of data at once, use the `select()` function from the `AnnotationDbi` package:
   ```r
   select(h10kcod.db, keys = my_probes, columns = c("SYMBOL", "ENTREZID", "GO"), keytype = "PROBEID")
   ```
3. **Handle Multiple Mappings**: Be aware that one probe can sometimes map to multiple Entrez IDs or GO terms. `as.list()` will return a vector of values for each key in such cases.

## Reference documentation

- [h10kcod.db](./references/reference_manual.md)