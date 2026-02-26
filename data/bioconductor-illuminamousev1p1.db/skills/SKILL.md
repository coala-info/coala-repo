---
name: bioconductor-illuminamousev1p1.db
description: This package provides biological annotation and re-annotation data for the Illumina Mouse v1.1 platform. Use when user asks to map Illumina Mouse v1.1 probe IDs to gene identifiers, retrieve probe sequences, or filter probes by quality metrics.
homepage: https://bioconductor.org/packages/release/data/annotation/html/illuminaMousev1p1.db.html
---


# bioconductor-illuminamousev1p1.db

name: bioconductor-illuminamousev1p1.db
description: Use this skill to perform biological annotation and probe re-annotation for the Illumina Mouse v1.1 platform. This includes mapping manufacturer probe IDs to gene symbols, Entrez IDs, Ensembl IDs, GO terms, and KEGG pathways, as well as accessing probe-specific quality metrics and sequences.

## Overview

The `illuminaMousev1p1.db` package is a Bioconductor annotation data package for the Illumina Mouse v1.1 platform. It provides SQLite-based mappings between manufacturer identifiers (probes) and various biological databases. A key feature of this specific package is the inclusion of "New Mappings" based on a re-annotation pipeline that provides probe quality grades and genomic coordinates.

## Core Workflows

### Loading and Discovery
To use the package, load the library and explore available mapping objects:

```r
library(illuminaMousev1p1.db)

# List all available mapping objects in the package
ls("package:illuminaMousev1p1.db")

# View the database schema and metadata
illuminaMousev1p1_dbschema()
illuminaMousev1p1_dbInfo()
```

### Basic Identifier Mapping
Mappings are typically accessed by converting the map object to a list or using the `AnnotationDbi` interface (`select`, `mapIds`).

```r
# Map probes to Gene Symbols
probes <- c("ILMN_1212", "ILMN_1213") # Example IDs
symbols <- mapIds(illuminaMousev1p1.db, keys = probes, column = "SYMBOL", keytype = "PROBEID")

# Using the specific map object (older style)
x <- illuminaMousev1p1SYMBOL
mapped_probes <- mappedkeys(x)
xx <- as.list(x[mapped_probes[1:5]])
```

### Using Re-annotation Data
This package provides enhanced probe-level information. It is highly recommended to filter probes by quality before analysis.

```r
# List custom re-annotation mappings
illuminaMousev1p1listNewMappings()

# Check probe quality (Perfect, Good, Bad, No match)
qual <- as.list(illuminaMousev1p1PROBEQUALITY)
table(unlist(qual))

# Filter for "Perfect" probes
perfect_probes <- names(qual)[qual == "Perfect"]

# Get probe sequences
seqs <- as.list(illuminaMousev1p1PROBESEQUENCE[probes])
```

### Common Mapping Objects
- `illuminaMousev1p1ENTREZID`: Maps probes to Entrez Gene identifiers.
- `illuminaMousev1p1SYMBOL`: Maps probes to official Gene Symbols.
- `illuminaMousev1p1GENENAME`: Maps probes to full Gene Names.
- `illuminaMousev1p1GO`: Maps probes to Gene Ontology (GO) terms (includes Evidence and Ontology codes).
- `illuminaMousev1p1PATH`: Maps probes to KEGG Pathway identifiers.
- `illuminaMousev1p1PROBEQUALITY`: Quality grade based on sequence alignment.

### Reverse Mappings
To map from a biological identifier back to probe IDs, use `revmap()`:

```r
# Map Gene Symbols back to Illumina Probe IDs
sym2probe <- revmap(illuminaMousev1p1SYMBOL)
probes_for_gene <- sym2probe[["Gfi1"]]
```

## Tips
- **Probe Quality:** Always check `illuminaMousev1p1PROBEQUALITY`. Probes marked as "Bad" or "No match" should generally be excluded from differential expression analysis to reduce noise.
- **Memory Efficiency:** For large-scale lookups, use `AnnotationDbi::select()` instead of `as.list()` to keep data in a data frame format.
- **Control Probes:** Use `illuminaMousev1p1REPORTERGROUPNAME` to identify internal Illumina control probes.

## Reference documentation
- [illuminaMousev1p1.db Reference Manual](./references/reference_manual.md)