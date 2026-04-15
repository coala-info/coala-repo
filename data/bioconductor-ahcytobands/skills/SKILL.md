---
name: bioconductor-ahcytobands
description: This tool provides access to chromosomal cytogenetic band data and ideograms for various organisms via AnnotationHub. Use when user asks to retrieve cytoband coordinates, map genomic locations to cytogenetic bands, or obtain Giemsa stain information for visualizing ideograms.
homepage: https://bioconductor.org/packages/release/data/annotation/html/AHCytoBands.html
---

# bioconductor-ahcytobands

name: bioconductor-ahcytobands
description: Provides access to cytogenetic band data (ideograms) for various organisms via AnnotationHub. Use this skill when you need to retrieve, visualize, or analyze chromosomal cytoband coordinates (e.g., p and q arms, staining intensities) for genomic data mapping in R.

# bioconductor-ahcytobands

## Overview
AHCytoBands is a Bioconductor data package that provides a streamlined way to access cytogenetic band information for multiple genomes. Instead of manually downloading UCSC tracks, it leverages `AnnotationHub` to provide `GRanges` objects containing cytoband locations, names, and Giemsa stain densities. This is essential for creating ideograms or mapping genomic coordinates to cytogenetic locations.

## Core Workflow

### 1. Loading the Data
The package primarily acts as a container for metadata that points to `AnnotationHub`. To use it, you must first load `AnnotationHub`.

```r
library(AnnotationHub)
library(AHCytoBands)

# Initialize AnnotationHub
ah <- AnnotationHub()

# Query for AHCytoBands resources
query(ah, "AHCytoBands")
```

### 2. Selecting a Genome
You can filter the hub for specific organisms or genome builds (e.g., hg19, hg38, mm10).

```r
# Example: Get human hg38 cytobands
res <- query(ah, c("AHCytoBands", "Homo sapiens", "hg38"))
cytobands <- res[[1]]
```

### 3. Data Structure
The returned object is a `GRanges` object. Key columns typically include:
- `name`: The band designation (e.g., p11.2).
- `gieStain`: The Giemsa stain result (e.g., gneg, gpos50, acen).

```r
head(cytobands)
# Access specific chromosomes
chr1_bands <- cytobands[seqnames(cytobands) == "chr1"]
```

## Common Use Cases

### Mapping a Genomic Coordinate to a Band
To find which cytoband a specific SNP or gene falls into:

```r
library(GenomicRanges)
my_region <- GRanges(seqnames = "chr1", ranges = IRanges(start = 1500000, end = 1600000))
hits <- findOverlaps(my_region, cytobands)
cytobands[subjectHits(hits)]$name
```

### Visualizing Ideograms
While AHCytoBands provides the data, it is often used in conjunction with plotting packages like `Gviz` or `ggbio`.

```r
# Example logic for Gviz
library(Gviz)
# Use the GRanges object to create an IdeogramTrack
itrac <- IdeogramTrack(genome = "hg38", chromosome = "chr1", bands = cytobands)
plotTracks(itrac)
```

## Tips
- **Internet Connection**: Since this package relies on `AnnotationHub`, an active internet connection is required for the initial download. Subsequent calls will use the local cache.
- **Genome Versions**: Always ensure the genome build of the cytobands matches your experimental data (e.g., do not mix hg19 and hg38).
- **Stain Colors**: When plotting, `gieStain` values correspond to standard cytogenetic colors (e.g., 'acen' for centromeres, 'gneg' for white/light bands).

## Reference documentation
- [AHCytoBands Bioconductor Page](https://bioconductor.org/packages/release/data/annotation/html/AHCytoBands.html)