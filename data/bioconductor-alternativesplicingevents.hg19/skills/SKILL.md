---
name: bioconductor-alternativesplicingevents.hg19
description: This package provides a unified collection of alternative splicing event annotations for the human hg19 genome assembly from multiple quantification tools. Use when user asks to retrieve hg19 alternative splicing data, map splicing events across different tools, or filter splicing annotations by gene and event type.
homepage: https://bioconductor.org/packages/release/data/annotation/html/alternativeSplicingEvents.hg19.html
---

# bioconductor-alternativesplicingevents.hg19

name: bioconductor-alternativesplicingevents.hg19
description: Access and utilize the alternativeSplicingEvents.hg19 annotation data package. Use this skill when a user needs to retrieve or analyze human (hg19) alternative splicing event annotations compiled from MISO, VAST-TOOLS, rMATS, and SUPPA. This is particularly useful for mapping splice junctions to genes or comparing splicing event identifiers across different quantification tools.

# bioconductor-alternativesplicingevents.hg19

## Overview

The `alternativeSplicingEvents.hg19` package provides a comprehensive data frame of alternative splicing events for the Human genome (assembly hg19/GRCh37). It serves as a unified resource that harmonizes annotations from four major splicing analysis tools: MISO, VAST-TOOLS, rMATS, and SUPPA.

The dataset includes the following event types:
*   **SE**: Skipped Exon
*   **MXE**: Mutually Exclusive Exon
*   **AFE**: Alternative First Exon
*   **ALE**: Alternative Last Exon
*   **A3SS**: Alternative 3' Splice Site
*   **A5SS**: Alternative 5' Splice Site
*   **RI**: Retained Intron
*   **Tandem UTR**

## Data Retrieval

This package is a data-only annotation package. The primary way to access the data is through `AnnotationHub`.

```r
library(AnnotationHub)

# Initialize AnnotationHub
hub <- AnnotationHub()

# Query for the specific hg19 splicing events dataset
# Note: "alternativeSplicingEvents.hg19_V2" is the current version
query_results <- query(hub, "alternativeSplicingEvents.hg19_V2")

# Load the data frame
events <- query_results[[1]]
```

## Data Structure and Usage

The retrieved object is a `data.frame` where each row represents a unique splicing event. Key columns typically include:

*   **Event Type**: (e.g., SE, RI, A3SS)
*   **Coordinates**: Chromosome, strand, and splice junction positions.
*   **Gene Association**: Associated gene symbols (Ensembl/UCSC). Events not mapping to known genes are labeled "Hypothetical".
*   **Source Identifiers**: Original IDs from the source programs (MISO, VAST-TOOLS, etc.), allowing for cross-tool mapping.

### Common Workflows

**1. Filtering by Event Type**
To isolate specific splicing patterns, such as Retained Introns:
```r
ri_events <- events[events$eventType == "RI", ]
```

**2. Searching for Events by Gene**
To find all annotated splicing events associated with a specific gene of interest:
```r
gene_events <- events[events$geneSymbol == "BRCA1", ]
```

**3. Cross-Referencing Tool IDs**
If you have an identifier from rMATS and want to find the corresponding VAST-TOOLS ID or genomic coordinates:
```r
# Example: Finding a match for a specific tool ID
match <- events[events$rMATS_ID == "specific_id_here", ]
```

## Tips for Success

*   **Coordinate Systems**: Be aware that the underlying data involved coordinate shifts (e.g., rMATS increments) to ensure 1-based coordinate consistency across sources.
*   **Genome Build**: This package is strictly for **hg19**. For hg38, look for the corresponding `alternativeSplicingEvents.hg38` package.
*   **Hypothetical Genes**: If an event is marked "Hypothetical", it means the splice junction coordinates did not overlap with known exon/gene coordinates during the package's construction.

## Reference documentation

- [alternativeSplicingEvents.hg19 Reference Manual](./references/reference_manual.md)