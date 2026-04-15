---
name: bioconductor-mwgcod.db
description: This tool provides biological identifier mapping and annotation for the MWG Cod platform. Use when user asks to translate manufacturer-specific probe IDs into standard identifiers like Entrez Gene IDs, Gene Symbols, Ensembl, or Gene Ontology terms.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mwgcod.db.html
---

# bioconductor-mwgcod.db

name: bioconductor-mwgcod.db
description: Use this skill to perform biological identifier mapping and annotation for the MWG Cod platform. This skill is applicable when you need to translate manufacturer-specific probe IDs into standard identifiers like Entrez Gene IDs, Gene Symbols, RefSeq, Ensembl, or Gene Ontology (GO) terms using the mwgcod.db R package.

# bioconductor-mwgcod.db

## Overview

The `mwgcod.db` package is a Bioconductor annotation data package for the MWG Cod platform. It provides a set of R objects that map manufacturer-specific probe identifiers to various biological annotations. These mappings are updated biannually and are based on data from sources like Entrez Gene, Ensembl, and the Gene Ontology Consortium.

## Core Workflows

### Loading the Package and Exploring Content

To begin using the annotation data, load the library and list the available mapping objects:

```r
library(mwgcod.db)
# List all available mapping objects in the package
ls("package:mwgcod.db")
```

### Basic Identifier Mapping

Most objects in `mwgcod.db` are used to map probe IDs to a single value or a vector of values.

```r
# Example: Mapping probes to Gene Symbols
# 1. Get the mapping object
x <- mwgcodSYMBOL
# 2. Get probes that have a mapping
probes <- mappedkeys(x)
# 3. Convert to a list for specific probes
symbol_list <- as.list(x[probes[1:5]])
```

### Common Mapping Objects

- **Gene Identifiers**:
  - `mwgcodENTREZID`: Maps probes to Entrez Gene identifiers.
  - `mwgcodSYMBOL`: Maps probes to official Gene Symbols.
  - `mwgcodGENENAME`: Maps probes to full Gene Names.
  - `mwgcodALIAS2PROBE`: Maps common gene aliases to manufacturer identifiers.
- **External Database Cross-references**:
  - `mwgcodENSEMBL`: Maps probes to Ensembl gene accession numbers.
  - `mwgcodUNIPROT`: Maps probes to Uniprot accession numbers.
  - `mwgcodREFSEQ`: Maps probes to RefSeq identifiers.
  - `mwgcodACCNUM`: Maps probes to GenBank accession numbers.
- **Functional Annotation**:
  - `mwgcodGO`: Maps probes to Gene Ontology (GO) identifiers (includes Evidence and Ontology type).
  - `mwgcodPATH`: Maps probes to KEGG pathway identifiers.
  - `mwgcodENZYME`: Maps probes to Enzyme Commission (EC) numbers.
- **Genomic Location**:
  - `mwgcodCHR`: Maps probes to chromosomes.
  - `mwgcodCHRLOC`: Maps probes to chromosomal starting positions.

### Working with Gene Ontology (GO)

GO mappings are more complex as they return lists containing the GO ID, Evidence code, and Ontology category (BP, CC, or MF).

```r
# Extract GO information for a probe
go_mapping <- as.list(mwgcodGO["your_probe_id_here"])

# To get all probes associated with a specific GO term (including child nodes)
all_probes_in_go <- as.list(mwgcodGO2ALLPROBES[["GO:0008150"]])
```

### Reverse Mappings

Many objects have a reverse mapping (e.g., mapping from a Symbol back to a Probe). These are typically named with a `2PROBE` suffix.

```r
# Map a KEGG pathway ID to all associated probes
pathway_probes <- as.list(mwgcodPATH2PROBE[["04110"]])
```

## Database Information

You can access metadata about the underlying SQLite database using convenience functions:

```r
# Get the database connection
conn <- mwgcod_dbconn()
# View the database schema
mwgcod_dbschema()
# View map counts (number of keys mapped)
mwgcodMAPCOUNTS
```

## Tips for Efficient Usage

1. **Check for NAs**: Not every probe identifier will map to every type of annotation. Always check for `NA` values in your results.
2. **Use mappedkeys**: To avoid errors when subsetting, use `mappedkeys(x)` to identify which keys actually exist in the mapping object.
3. **AnnotationDbi Interface**: While this package provides specific objects, it is also compatible with the standard `select()`, `keys()`, and `columns()` interface from the `AnnotationDbi` package.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)