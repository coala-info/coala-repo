---
name: bioconductor-hgug4845a.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgug4845a.db.html
---

# bioconductor-hgug4845a.db

name: bioconductor-hgug4845a.db
description: Annotation data package for the hgug4845a platform. Use this skill to map manufacturer probe identifiers to various biological annotations including Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, and chromosomal locations.

# bioconductor-hgug4845a.db

## Overview

The `hgug4845a.db` package is a Bioconductor annotation data package for the Agilent hgug4845a platform. It provides SQLite-based mappings between manufacturer probe identifiers and various genomic databases. This skill guides you through loading the package, exploring available maps, and performing common identifier conversions.

## Basic Usage

### Loading the Package and Exploring Maps
To begin, load the library and list the available mapping objects:

```r
library(hgug4845a.db)
# List all available mapping objects in the package
ls("package:hgug4845a.db")
```

### Common Mapping Workflows

Most objects in this package are used by converting them to a list or using the `select()` interface from `AnnotationDbi`.

#### 1. Mapping Probes to Gene Symbols and Names
```r
# Map probes to Gene Symbols
probes <- c("1001_at", "1002_f_at") # Example probe IDs
symbols <- as.list(hgug4845aSYMBOL[probes])

# Map probes to Full Gene Names
gene_names <- as.list(hgug4845aGENENAME[probes])
```

#### 2. Mapping Probes to Entrez IDs and Accession Numbers
```r
# Get Entrez Gene Identifiers
entrez_ids <- as.list(hgug4845aENTREZID[probes])

# Get GenBank Accession Numbers
acc_nums <- as.list(hgug4845aACCNUM[probes])
```

#### 3. Functional Annotation (GO and KEGG)
```r
# Map probes to Gene Ontology (GO) terms
go_terms <- as.list(hgug4845aGO[probes])

# Map probes to KEGG Pathway IDs
kegg_paths <- as.list(hgug4845aPATH[probes])
```

#### 4. Chromosomal Location
```r
# Get chromosome assignment
chrom <- as.list(hgug4845aCHR[probes])

# Get specific base pair start positions
positions <- as.list(hgug4845aCHRLOC[probes])
```

### Reverse Mappings
Many maps have reverse counterparts (e.g., finding probes for a specific gene symbol or GO term):

```r
# Find probes associated with a specific Gene Alias
probes_by_alias <- as.list(hgug4845aALIAS2PROBE[["TP53"]])

# Find all probes associated with a specific GO ID
probes_by_go <- as.list(hgug4845aGO2PROBE[["GO:0008150"]])
```

## Database Connection and Metadata
You can access the underlying SQLite database connection or check map statistics:

```r
# Get number of mapped keys for all maps
hgug4845aMAPCOUNTS

# Get database metadata
hgug4845a_dbInfo()

# Get the organism name
hgug4845aORGANISM
```

## Tips for Efficient Usage
- **Handling NAs**: Not every probe maps to every database. Always check for `NA` values in your results.
- **Mapped Keys**: Use `mappedkeys(x)` to get only the identifiers that have a valid mapping in a specific object.
- **AnnotationDbi**: For more complex queries, use the `select()`, `keys()`, `columns()`, and `keytypes()` functions from the `AnnotationDbi` package.

## Reference documentation
- [hgug4845a.db Reference Manual](./references/reference_manual.md)