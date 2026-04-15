---
name: bioconductor-gghumanmethcancerpanelv1.db
description: This package provides SQLite-based annotation mappings for the Illumina GoldenGate Human Methylation Cancer Panel v1. Use when user asks to map probe identifiers to gene symbols, retrieve CpG island metadata, find genomic coordinates, or perform functional annotation using GO and KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/GGHumanMethCancerPanelv1.db.html
---

# bioconductor-gghumanmethcancerpanelv1.db

## Overview

The `GGHumanMethCancerPanelv1.db` package is a Bioconductor annotation data package for the Illumina GoldenGate Human Methylation Cancer Panel v1. It provides SQLite-based mappings between manufacturer probe identifiers and various biological databases (Entrez Gene, RefSeq, Ensembl, Gene Ontology, KEGG, etc.). This skill helps you navigate these mappings to annotate methylation data.

## Core Usage

### Loading the Package
```r
library(GGHumanMethCancerPanelv1.db)
# List all available mapping objects
ls("package:GGHumanMethCancerPanelv1.db")
```

### Common Mapping Workflows

Most objects in this package are used by converting them to lists or using the `select()` interface from `AnnotationDbi`.

#### 1. Mapping Probes to Gene Symbols and Names
To translate Illumina probe IDs to human-readable gene symbols:
```r
# Get symbols
probes_to_symbol <- as.list(GGHumanMethCancerPanelv1SYMBOL)
# Get full gene names
probes_to_name <- as.list(GGHumanMethCancerPanelv1GENENAME)

# Example: Look up a specific probe
symbol <- probes_to_symbol[["rs123456"]] # Replace with actual probe ID
```

#### 2. Genomic Coordinates and CpG Islands
Specific to methylation panels, you can retrieve CpG-specific metadata:
```r
# Check if a probe is in a CpG island (returns TRUE/FALSE)
is_island <- as.list(GGHumanMethCancerPanelv1ISCPGISLAND)

# Get CpG coordinates (Build 36)
coords <- as.list(GGHumanMethCancerPanelv1CPGCOORDINATE)

# Get distance to the nearest Transcription Start Site (TSS)
dist_tss <- as.list(GGHumanMethCancerPanelv1DISTTOTSS)
```

#### 3. Chromosomal Locations
```r
# Map to chromosome
probe_chr <- as.list(GGHumanMethCancerPanelv1CHR)

# Map to specific base pair location (start)
probe_loc <- as.list(GGHumanMethCancerPanelv1CHRLOC)
```

#### 4. Functional Annotation (GO and KEGG)
```r
# Map probes to Gene Ontology (GO) terms
probe_go <- as.list(GGHumanMethCancerPanelv1GO)

# Map probes to KEGG Pathways
probe_path <- as.list(GGHumanMethCancerPanelv1PATH)
```

### Reverse Mappings
Many objects have reverse maps (e.g., finding all probes associated with a specific gene):
```r
# Find probes for a specific gene symbol
alias_to_probe <- as.list(GGHumanMethCancerPanelv1ALIAS2PROBE)

# Find probes for a specific KEGG pathway
path_to_probe <- as.list(GGHumanMethCancerPanelv1PATH2PROBE)
```

## Database Utilities
To inspect the underlying database structure or connection:
```r
# Get database metadata
GGHumanMethCancerPanelv1_dbInfo()

# Get the number of mapped keys for all maps
GGHumanMethCancerPanelv1MAPCOUNTS
```

## Tips for Efficient Use
- **Memory Management**: Converting large mapping objects to lists (`as.list()`) can be memory-intensive. For large-scale queries, use `AnnotationDbi::select()`.
- **Build Version**: Note that CpG coordinates in this specific package are typically based on NCBI Build 36 (hg18).
- **Missing Values**: Probes that cannot be mapped to a specific resource will return `NA`. Use `mappedkeys()` to identify probes that have valid mappings.

## Reference documentation
- [GGHumanMethCancerPanelv1.db Reference Manual](./references/reference_manual.md)