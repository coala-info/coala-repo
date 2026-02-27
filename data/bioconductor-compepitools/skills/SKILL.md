---
name: bioconductor-compepitools
description: This package provides a specialized toolkit for the integrative analysis and visualization of epigenomics data. Use when user asks to count reads from BAM files in genomic regions, annotate ranges with gene or TSS information, identify enhancers and lncRNAs, calculate PolII stalling indices, or create integrative heatmaps of epigenetic data.
homepage: https://bioconductor.org/packages/release/bioc/html/compEpiTools.html
---


# bioconductor-compepitools

name: bioconductor-compepitools
description: Specialized toolkit for the integrative analysis of epigenomics data. Use this skill to count reads from BAM files in genomic regions, annotate GRanges with gene and TSS information, identify enhancers and lncRNAs, calculate PolII stalling indices, and create integrative heatmaps of heterogeneous epigenetic data.

# bioconductor-compepitools

## Overview

The `compEpiTools` package provides a comprehensive suite of tools for epigenomics research. It excels at bridging the gap between raw sequencing data (BAM files) and functional biological insights. Key capabilities include high-resolution read counting, genomic region annotation (TSS, promoters, CpG content), identification of functional elements like enhancers and long non-coding RNAs (lncRNAs), and sophisticated visualization of multiple data tracks.

## Core Workflows

### 1. Counting Reads in Genomic Regions
Use these functions to quantify signal from BAM files within specific `GRanges` objects.

*   **Base-level coverage**: `GRbaseCoverage(Object, bam)` returns a list of coverage vectors.
*   **Region coverage**: `GRcoverage(Object, bam)` calculates total counts per region.
*   **Binned coverage**: `GRcoverageInbins(Object, bam, Nbins)` divides regions into equal bins for pattern analysis.
*   **Summit identification**: `GRcoverageSummit(Object, bam)` finds the position of maximum coverage.
*   **ChIP-seq Enrichment**: `GRenrichment(Object, ChIPbam, Inputbam)` calculates log2 enrichment of ChIP over Input.

### 2. Genomic Annotation
Map your genomic ranges to gene models and transcription start sites (TSS).

*   **TSS Extraction**: `TSS(txdb)` extracts TSS positions from a `TranscriptDb`.
*   **Distance Calculation**: `distanceFromTSS(Object, txdb)` computes the distance to the nearest TSS.
*   **Simple Annotation**: `GRannotateSimple(Object, txdb)` categorizes regions as promoter, intragenic, or intergenic.
*   **Comprehensive Annotation**: `GRannotate(Object, txdb, EG2GS, userAnn)` provides detailed mapping including gene symbols and overlaps with user-defined regions (e.g., CpG Islands).

### 3. Functional Epigenomics
Identify specific regulatory elements based on chromatin marks.

*   **Enhancers**: `enhancers(checkpeaks, distalpeaks, upstream, downstream)` identifies putative enhancers (H3K4me1/H3K27ac) distal to TSS and CpG islands.
*   **Enhancer-Target Matching**: `matchEnhancers(enhancers, targets)` links enhancers to putative target genes based on distance and intervening TSS.
*   **PolII Stalling**: `stallingIndex(Object, bam)` calculates the ratio of PolII signal at the TSS vs. the gene body.
*   **lncRNA Discovery**: `findLncRNA(peaks1, peaks2)` identifies potential intergenic lncRNAs based on epigenetic signatures (e.g., K4-K36 domains).
*   **Promoter Classification**: `getPromoterClass(Object, txdb)` classifies promoters by CpG content (HCP, ICP, LCP).

### 4. Visualization with Heatmaps
The package provides a flexible system for visualizing multiple data types (BAM, GRanges, methylation) across regions of interest (ROIs).

1.  **Prepare Data**: `data <- heatmapData(grl, refgr, type, nbins, txdb)`
    *   `grl`: List of data tracks (e.g., ChIP-seq peaks).
    *   `refgr`: The reference genomic regions to plot.
2.  **Plot**: `heatmapPlot(matList, sigMat, clusterInds)`
    *   `sigMat`: Optional matrix to dim colors based on significance (e.g., p-values).
    *   `clusterInds`: Indices of tracks to use for clustering regions.

## Tips for Success
*   **Normalization**: When using `GRcoverage` or `GRcoverageInbins`, set `Nnorm=TRUE` to normalize by the total number of reads in the BAM file.
*   **GTF Export**: Use `makeGtfFromDb(txdb, file)` to export gene models to GTF format for consistency with external tools like HTSeq or TopHat.
*   **GO Enrichment**: Use `topGOres` for enrichment and `simplifyGOterms` to remove redundant parent terms, keeping only the most specific biological insights.

## Reference documentation
- [compEpiTools](./references/compEpiTools.md)