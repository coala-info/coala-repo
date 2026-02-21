---
name: bioconductor-illuminahumanwgdaslv3.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/illuminaHumanWGDASLv3.db.html
---

# bioconductor-illuminahumanwgdaslv3.db

name: bioconductor-illuminahumanwgdaslv3.db
description: Provides annotation data for the Illumina Human Whole-Genome DASL v3 platform. Use this skill when you need to map Illumina manufacturer probe identifiers to various biological identifiers (Entrez Gene, Ensembl, RefSeq, Gene Symbols), genomic locations, Gene Ontology (GO) terms, or KEGG pathways. It is also essential for accessing custom re-annotation data including probe quality, sequences, and genomic match similarity.

## Overview

The `illuminaHumanWGDASLv3.db` package is a Bioconductor annotation data package for the Illumina HumanWGDASLv3 platform. It uses the SQLite-based `AnnotationDbi` framework to provide high-performance mapping between manufacturer-specific probe IDs and public database identifiers. A unique feature of this package is the inclusion of custom re-annotation data (e.g., `PROBEQUALITY`, `NUID`, `PROBESEQUENCE`) which allows for more rigorous filtering of expression data based on probe performance.

## Core Workflows

### Loading the Package and Exploring Maps
To begin, load the library and list all available mapping objects:
```R
library(illuminaHumanWGDASLv3.db)
ls("package:illuminaHumanWGDASLv3.db")
```

### Basic Identifier Mapping
Most mappings follow a standard pattern: convert the mapping object to a list or use `select()` for bulk retrieval.

```R
# Map probes to Gene Symbols
probes <- c("ILMN_1720131", "ILMN_1804541") # Example IDs
symbols <- as.list(illuminaHumanWGDASLv3SYMBOL[probes])

# Map probes to Entrez IDs
entrez_ids <- as.list(illuminaHumanWGDASLv3ENTREZID[probes])
```

### Using Custom Re-annotation Data
This package provides enhanced probe-level information not found in standard Bioconductor packages. Use these to filter out "Bad" or "No match" probes.

```R
# Check probe quality
qual <- as.list(illuminaHumanWGDASLv3PROBEQUALITY[probes])

# Get probe sequences
seqs <- as.list(illuminaHumanWGDASLv3PROBESEQUENCE[probes])

# List all custom re-annotation mappings
illuminaHumanWGDASLv3listNewMappings()
```

### Functional Annotation (GO and KEGG)
Map probes to functional categories for enrichment analysis.

```R
# Map to GO terms (direct evidence)
go_terms <- as.list(illuminaHumanWGDASLv3GO[probes])

# Map to KEGG Pathways
pathways <- as.list(illuminaHumanWGDASLv3PATH[probes])
```

### Reverse Mappings
To find which probes correspond to a specific gene or pathway, use `revmap()` or the pre-defined reverse objects.

```R
# Find probes for a specific Gene Symbol
sym2probe <- as.list(illuminaHumanWGDASLv3ALIAS2PROBE)
my_probes <- sym2probe[["TP53"]]

# Find probes for a specific Enzyme Commission (EC) number
ec2probe <- as.list(illuminaHumanWGDASLv3ENZYME2PROBE)
```

## Database Connection and Metadata
For advanced users needing direct SQL access or package metadata:

```R
# Get DB connection
conn <- illuminaHumanWGDASLv3_dbconn()
dbGetQuery(conn, "SELECT COUNT(*) FROM probes")

# Get organism info
illuminaHumanWGDASLv3ORGANISM
illuminaHumanWGDASLv3ORGPKG
```

## Tips for Effective Use
- **Filtering**: Always check `illuminaHumanWGDASLv3PROBEQUALITY`. It is recommended to retain only "Perfect" or "Good" probes for downstream analysis.
- **Mapping Counts**: Use `illuminaHumanWGDASLv3MAPCOUNTS` to verify the number of mapped keys in the package.
- **Data Versions**: Mappings are based on Entrez Gene data (e.g., 2015-Mar17) and UCSC hg19. Ensure these align with your experimental design.

## Reference documentation
- [illuminaHumanWGDASLv3.db Reference Manual](./references/reference_manual.md)