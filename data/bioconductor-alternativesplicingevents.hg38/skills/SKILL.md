---
name: bioconductor-alternativesplicingevents.hg38
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/alternativeSplicingEvents.hg38.html
---

# bioconductor-alternativesplicingevents.hg38

name: bioconductor-alternativesplicingevents.hg38
description: Access and use the alternativeSplicingEvents.hg38 annotation data package. This skill is used to retrieve comprehensive alternative splicing event annotations for the Human genome (hg38), including coordinates for Skipped Exons (SE), Mutually Exclusive Exons (MXE), Alternative First/Last Exons (AFE/ALE), Alternative 3'/5' Splice Sites (A3SS/A5SS), Retained Introns (RI), and Tandem UTRs. Use this when a user needs to map splicing events to genes or requires standardized coordinates derived from MISO, VAST-TOOLS, SUPPA, or rMATS for hg38.

# bioconductor-alternativesplicingevents.hg38

## Overview
The `alternativeSplicingEvents.hg38` package provides a consolidated data frame of alternative splicing events for the Human genome assembly hg38. It serves as a unified resource that merges annotations from several major splicing quantification tools (MISO, VAST-TOOLS, rMATS, and SUPPA). Each event is characterized by its genomic coordinates (chromosome, strand, splice junctions), associated gene symbols (Ensembl), and original identifiers from the source tools.

## Data Retrieval
This package is a data-only annotation package. The primary way to access the data is through `AnnotationHub`.

```r
library(AnnotationHub)

# Initialize the hub
hub <- AnnotationHub()

# Query for the specific hg38 splicing events resource
# The current version is typically "alternativeSplicingEvents.hg38_V2"
query_results <- query(hub, "alternativeSplicingEvents.hg38")
events <- query_results[[1]]
```

## Data Structure
The retrieved object is a `data.frame` (or `DataFrame`). Key columns include:
- **Event Type**: SE, MXE, AFE, ALE, A3SS, A5SS, RI, or Tandem UTR.
- **Coordinates**: Chromosome, strand, and specific splice junction positions.
- **Gene Symbol**: Ensembl gene symbols assigned based on overlapping coordinates.
- **Source ID**: The original identifier from the source program (e.g., MISO ID).

## Common Workflows

### Filtering by Event Type
To isolate specific types of splicing, such as Skipped Exons:
```r
se_events <- events[events$eventType == "SE", ]
```

### Finding Events for a Specific Gene
To find all annotated splicing events associated with a gene of interest:
```r
gene_events <- events[events$geneSymbol == "BRCA1", ]
```

### Overlapping with Experimental Data
If you have RNA-seq junction coordinates, you can use this package to annotate them with known event types by matching the chromosome and junction coordinates provided in the data frame.

## Usage Tips
- **Coordinate System**: Note that coordinates were originally compiled from hg19 and lifted over to hg38 using `rtracklayer::liftOver`.
- **Hypothetical Genes**: Events that do not overlap with known gene coordinates are labeled as "Hypothetical".
- **Tool Integration**: This resource is particularly useful for cross-referencing results between different splicing callers, as it provides a common coordinate framework.

## Reference documentation
- [alternativeSplicingEvents.hg38 Reference Manual](./references/reference_manual.md)