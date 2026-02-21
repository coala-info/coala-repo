---
name: bioconductor-drosgenome1.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/drosgenome1.db.html
---

# bioconductor-drosgenome1.db

## Overview

The `drosgenome1.db` package is a Bioconductor annotation data package for the Affymetrix Drosophila Genome 1.0 Array. It provides a set of R objects (Bimaps) and a standard interface (`select`) to translate manufacturer probe IDs into biological metadata. This is essential for downstream analysis of microarray data, such as functional enrichment or genomic localization.

## Core Workflows

### Loading the Package
```r
library(drosgenome1.db)
```

### Using the select() Interface
The recommended way to access data is via the `select()`, `keys()`, and `columns()` functions from the `AnnotationDbi` framework.

```r
# List available annotation types
columns(drosgenome1.db)

# List all probe IDs (keys)
probes <- head(keys(drosgenome1.db))

# Map probes to Symbols and Entrez IDs
select(drosgenome1.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Annotation Mappings

#### Gene Identification
- **SYMBOL**: Official gene symbols.
- **ENTREZID**: Entrez Gene identifiers.
- **GENENAME**: Full gene names.
- **ACCNUM**: GenBank accession numbers.
- **UNIPROT**: UniProt accession numbers.

#### Genomic Location
- **CHR**: Chromosome assignment.
- **CHRLOC/CHRLOCEND**: Start and end positions (base pairs) on the chromosome.
- **MAP**: Cytogenetic bands.

#### Functional Annotation
- **GO**: Gene Ontology identifiers, including Evidence codes and Ontology (BP, CC, MF).
- **PATH**: KEGG pathway identifiers.
- **ENZYME**: Enzyme Commission (EC) numbers.

### Using the Bimap Interface (Legacy)
While `select()` is preferred, you can access specific maps directly as Bimap objects.

```r
# Map probes to symbols
x <- drosgenome1SYMBOL
mapped_probes <- mappedkeys(x)
as.list(x[mapped_probes][1:5])

# Reverse mapping: Symbols to Probes
rev_x <- revmap(x)
```

### Database Connection Information
To inspect the underlying SQLite database or schema:
```r
drosgenome1_dbconn()   # Get DB connection
drosgenome1_dbschema() # View table schemas
drosgenome1_dbInfo()   # View metadata
```

## Tips
- **Multiple Mappings**: Some probes may map to multiple GO terms or pathways. The `select()` function will return a data frame with one row per mapping, which may result in more rows than input keys.
- **Filtering GO Terms**: When using `drosgenome1GO`, you can filter by evidence code (e.g., IDA, TAS) to ensure high-confidence annotations.
- **FlyBase IDs**: For Drosophila research, `drosgenome1FLYBASE` and `drosgenome1FLYBASECG` provide direct links to FlyBase accession numbers.

## Reference documentation
- [drosgenome1.db Reference Manual](./references/reference_manual.md)