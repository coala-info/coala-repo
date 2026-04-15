---
name: bioconductor-chippeakanno
description: This tool provides expert guidance for the ChIPpeakAnno R package to annotate, visualize, and compare genomic peaks from ChIP-seq, ATAC-seq, and CUT&RUN experiments. Use when user asks to convert peak files to GRanges, annotate peaks with genomic features, perform GO or pathway enrichment analysis, visualize peak distributions and overlaps, or discover DNA motifs.
homepage: https://bioconductor.org/packages/release/bioc/html/ChIPpeakAnno.html
---

# bioconductor-chippeakanno

name: bioconductor-chippeakanno
description: Expert guidance for the ChIPpeakAnno R package to annotate, visualize, and compare genomic peaks (ChIP-seq, ATAC-seq, CUT&RUN). Use this skill when you need to: (1) Convert peak files (BED, GFF, MACS) to GRanges, (2) Annotate peaks with nearest or overlapping genomic features (genes, TSS, exons), (3) Perform GO or Pathway enrichment analysis on annotated peaks, (4) Visualize peak distributions and overlaps (Venn diagrams, UpSet plots), or (5) Discover and summarize DNA motifs within peak regions.

# bioconductor-chippeakanno

## Overview
The `ChIPpeakAnno` package is a comprehensive tool for the functional annotation of genomic intervals. It bridges the gap between raw peak calls and biological insights by associating peaks with genomic features (using `biomaRt`, `EnsDb`, or `TxDb`), performing enrichment analysis, and facilitating comparative studies between multiple datasets.

## Core Workflows

### 1. Data Import and Conversion
Convert various peak formats into `GRanges` objects, the standard input for most functions.
```r
library(ChIPpeakAnno)
# Convert MACS, BED, or GFF files
peaks <- toGRanges("peaks.bed", format = "BED", header = FALSE)
# Supported formats: "BED", "GFF", "MACS", "narrowPeak", "broadPeak", "CSV"
```

### 2. Preparing Annotations
Annotations can be retrieved from `EnsDb` (recommended for Ensembl), `TxDb` (UCSC/RefSeq), or via `biomaRt`.
```r
# Using EnsDb (Comprehensive)
library(EnsDb.Hsapiens.v86)
annoData <- genes(EnsDb.Hsapiens.v86)

# Using biomaRt (Up-to-date)
library(biomaRt)
mart <- useMart(biomart = "ENSEMBL_MART_ENSEMBL", dataset = "hsapiens_gene_ensembl")
annoData_bm <- getAnnotation(mart, featureType = "TSS")
```

### 3. Peak Annotation
The `annotatePeakInBatch` function is the primary tool for associating peaks with features.
```r
# Peak-centric: Find nearest TSS
annotatedPeaks <- annotatePeakInBatch(peaks, 
                                      AnnotationData = annoData, 
                                      output = "nearestLocation",
                                      bindingRegion = c(-2000, 500))

# Add gene symbols to the results
library(org.Hs.eg.db)
annotatedPeaks <- addGeneIDs(annotatedPeaks, 
                             orgAnn = "org.Hs.eg.db", 
                             IDs2Add = "symbol")
```

### 4. Visualization and Quality Control
Evaluate peak localization and replicate concordance.
```r
# Distribution relative to TSS
binOverFeature(peaks, annotationData = annoData, featureSite = "FeatureStart")

# Genomic element distribution (Pie/Bar chart)
genomicElementDistribution(peaks, TxDb = TxDb.Hsapiens.UCSC.hg38.knownGene)

# Overlap between replicates
ol <- findOverlapsOfPeaks(peaks1, peaks2)
makeVennDiagram(ol, totalTest = 10000)
```

### 5. Enrichment and Motif Analysis
Identify biological functions and sequence patterns.
```r
# GO Enrichment
enriched.go <- getEnrichedGO(annotatedPeaks, orgAnn = "org.Hs.eg.db", maxP = 0.01)

# Pathway Enrichment (Reactome)
enriched.path <- getEnrichedPATH(annotatedPeaks, orgAnn = "org.Hs.eg.db", pathAnn = "reactome.db")

# Motif Discovery
library(BSgenome.Hsapiens.UCSC.hg38)
seqs <- getAllPeakSequence(peaks, genome = BSgenome.Hsapiens.UCSC.hg38)
# Scan for specific patterns
summarizePatternInPeaks(patternFilePath = "motifs.fa", peaks = peaks, BSgenomeName = BSgenome.Hsapiens.UCSC.hg38)
```

## Key Tips
- **Genome Versions**: Always ensure your `AnnotationData` and `BSgenome` match the assembly used for peak calling (e.g., hg19 vs hg38).
- **totalTest**: When using `makeVennDiagram`, the P-value is sensitive to `totalTest`. Use `peakPermTest` for a more robust, non-parametric significance measure.
- **Feature IDs**: If `addGeneIDs` fails, check that the `feature` column in your annotated object matches the `feature_id_type` (e.g., "ensembl_gene_id").

## Reference documentation
- [ChIPpeakAnno: annotate, visualize, and compare peak data](./references/ChIPpeakAnno.md)