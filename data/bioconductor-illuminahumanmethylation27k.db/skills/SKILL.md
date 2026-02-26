---
name: bioconductor-illuminahumanmethylation27k.db
description: This package provides comprehensive annotation data for the Illumina Human Methylation 27k platform. Use when user asks to map Illumina 27k probe identifiers to gene symbols, Entrez IDs, genomic coordinates, CpG island status, or functional annotations like GO terms and KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/IlluminaHumanMethylation27k.db.html
---


# bioconductor-illuminahumanmethylation27k.db

name: bioconductor-illuminahumanmethylation27k.db
description: Comprehensive annotation data for the Illumina Human Methylation 27k platform. Use when Claude needs to map Illumina 27k probe identifiers to gene symbols, Entrez IDs, genomic coordinates, GO terms, KEGG pathways, or platform-specific metadata like CpG island status and color channels.

# bioconductor-illuminahumanmethylation27k.db

## Overview

The `IlluminaHumanMethylation27k.db` package is a Bioconductor annotation data package for the Illumina Human Methylation 27k platform. It provides SQLite-based mappings between manufacturer probe identifiers (e.g., cg00000292) and various biological annotations. This is essential for interpreting DNA methylation data by linking specific probes to genes, genomic locations, and functional pathways.

## Core Workflows

### Loading and Exploration

To use the package, load it into the R environment and list available mapping objects:

```r
library(IlluminaHumanMethylation27k.db)
# List all available mapping objects
ls("package:IlluminaHumanMethylation27k.db")
```

### Mapping Probes to Gene Information

The most common task is converting probe IDs to gene symbols or Entrez IDs:

```r
# Map probes to Gene Symbols
probes <- c("cg00000292", "cg00002426")
symbols <- as.list(IlluminaHumanMethylation27kSYMBOL[probes])

# Map probes to Entrez Gene IDs
entrez_ids <- as.list(IlluminaHumanMethylation27kENTREZID[probes])

# Map Gene Aliases back to Probes
probes_for_gene <- as.list(IlluminaHumanMethylation27kALIAS2PROBE["TP53"])
```

### Genomic and CpG Metadata

Retrieve physical locations and platform-specific characteristics:

```r
# Get Chromosome for probes
chrom <- as.list(IlluminaHumanMethylation27kCHR[probes])

# Check if probes are in a CpG Island (returns TRUE/FALSE)
is_island <- as.list(IlluminaHumanMethylation27kISCPGISLAND[probes])

# Get distance to the nearest Transcription Start Site (TSS)
dist_tss <- as.list(IlluminaHumanMethylation27kDISTTOTSS[probes])

# Get genomic coordinates (Build 36)
coords <- as.list(IlluminaHumanMethylation27kCPGCOORDINATE[probes])
```

### Functional Annotation

Map probes to Gene Ontology (GO) or KEGG pathways:

```r
# Map to GO terms
go_terms <- as.list(IlluminaHumanMethylation27kGO[probes])

# Map to KEGG Pathways
kegg_paths <- as.list(IlluminaHumanMethylation27kPATH[probes])
```

### Database Utilities

The package includes helper functions for low-level database access and platform-specific ordering:

- `IlluminaHumanMethylation27k_getControls()`: Retrieve addresses of control probes.
- `IlluminaHumanMethylation27k_getProbeOrdering()`: Get probe IDs in the order they appear in the manifest.
- `IlluminaHumanMethylation27k_dbconn()`: Access the underlying SQLite connection.
- `IlluminaHumanMethylation27kCHRLENGTHS`: A named vector of chromosome lengths.

## Usage Tips

- **Mapping Keys**: Use `mappedkeys(x)` to see which probes have valid mappings for a specific object.
- **Data Format**: Most objects return a named vector or a list. Use `as.list()` for a standard R list format.
- **Multiple Mappings**: Some probes may map to multiple genes or GO terms; always check the length of the returned list elements.
- **Build Version**: Note that coordinates in this specific legacy package are typically based on NCBI Build 36 (hg18).

## Reference documentation

- [IlluminaHumanMethylation27k.db](./references/reference_manual.md)