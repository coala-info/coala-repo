---
name: bioconductor-genomicstate
description: This tool builds and accesses GenomicState objects from Gencode sources for use with derfinder and bumphunter analysis tools. Use when user asks to create or load TxDb, AnnotatedGenes, or GenomicState objects, query AnnotationHub for Gencode annotations, or annotate genomic regions for differential expression analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/GenomicState.html
---


# bioconductor-genomicstate

name: bioconductor-genomicstate
description: Build and access GenomicState objects for use with derfinder tools from sources like Gencode. Use this skill when you need to create or load annotation objects (TxDb, AnnotatedGenes, GenomicState) for genomic region analysis, specifically for human Gencode data on hg19 or hg38 coordinates.

## Overview

The `GenomicState` package streamlines the creation and retrieval of annotation objects required for differential expression analysis using the `derfinder` suite. It primarily facilitates working with Gencode annotations to generate `GenomicState` objects (used by `derfinder::annotateRegions()`) and `AnnotatedGenes` objects (used by `bumphunter::matchGenes()`).

## Core Workflows

### 1. Accessing Pre-computed Objects via AnnotationHub

The most efficient way to obtain `GenomicState` objects is through `AnnotationHub`.

```r
library(GenomicState)
library(AnnotationHub)

# Initialize hub
ah <- AnnotationHub()

# Query for specific Gencode version and genome
# filetype can be "GenomicState", "TxDb", or "AnnotatedGenes"
gs_query <- GenomicStateHub(
    version = "31",
    genome = "hg19",
    filetype = "GenomicState",
    ah = ah
)

# Retrieve the object
gs_obj <- gs_query[[1]]
```

### 2. Building Objects from Scratch

If a specific version is not in the hub, you can build the objects from Gencode sources.

```r
# 1. Create TxDb from Gencode
txdb <- gencode_txdb(version = "31", genome = "hg19", chrs = "chr21")

# 2. Create Annotated Genes (for bumphunter::matchGenes)
genes_annotated <- gencode_annotated_genes(txdb)

# 3. Create GenomicState (for derfinder::annotateRegions)
gs_object <- gencode_genomic_state(txdb)
```

### 3. Integration with derfinder and derfinderPlot

Once objects are loaded, they are used to annotate genomic regions or plot coverage.

```r
library(derfinder)
library(derfinderPlot)

# Annotate regions using the 'fullGenome' element of a GenomicState object
annotatedRegions <- annotateRegions(
    regions = my_regions,
    genomicState = gs_object$fullGenome,
    minoverlap = 1
)

# Plot region coverage
plotRegionCoverage(
    regions = my_regions,
    regionCoverage = my_regionCov,
    groupInfo = my_groups,
    nearestAnnotation = my_matchGenes_output,
    annotatedRegions = annotatedRegions,
    txdb = txdb
)
```

## Key Functions

- `GenomicStateHub()`: Easy interface to query `AnnotationHub` for Gencode-derived objects.
- `gencode_txdb()`: Downloads and builds a `TxDb` object from Gencode.
- `gencode_genomic_state()`: Transforms a `TxDb` into a list containing `fullGenome` and `codingGenome` GRanges, categorized by region type (exon, intron, intergenic, promoter).
- `gencode_annotated_genes()`: Creates a GRanges object of genes with associated metadata for use with `bumphunter::matchGenes()`.
- `local_metadata()`: Accesses metadata for locally stored objects (primarily for JHPCE cluster users).

## Tips for Success

- **Memory Management**: `GenomicState` objects for the full genome can be large. If memory is limited, specify specific chromosomes in `gencode_txdb(chrs = ...)` when building objects.
- **Object Structure**: A `GenomicState` object is a list. Always use `gs_object$fullGenome` when passing the state to `derfinder::annotateRegions()`.
- **Naming Conventions**: The package uses UCSC style chromosome names (e.g., "chr1"). Ensure your input GRanges match this convention.

## Reference documentation

- [Introduction to GenomicState](./references/GenomicState.md)