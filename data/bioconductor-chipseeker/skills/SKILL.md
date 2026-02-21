---
name: bioconductor-chipseeker
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ChIPseeker.html
---

# bioconductor-chipseeker

name: bioconductor-chipseeker
description: Expert guidance for using the ChIPseeker R/Bioconductor package for ChIP-seq peak annotation, comparison, and visualization. Use this skill when you need to: (1) Read peak files (BED/GRanges), (2) Annotate peaks with genomic features (Promoter, Exon, Intron, etc.) and nearest genes, (3) Visualize peak coverage and binding profiles (TSS, gene body), (4) Perform functional enrichment analysis on peak-associated genes, or (5) Compare multiple ChIP-seq datasets.

## Overview

ChIPseeker is a comprehensive R package designed for the downstream analysis of ChIP-seq data. It bridges the gap between raw peak calls and biological insights by providing robust tools for genomic annotation and visualization. It integrates seamlessly with other Bioconductor packages like `TxDb` for genomic features and `clusterProfiler` for functional analysis.

## Core Workflow

### 1. Data Loading and Initial Profiling
Load peak files into R and visualize their distribution across chromosomes.

```r
library(ChIPseeker)
# Read a BED file
peak <- readPeakFile("path/to/peaks.bed")

# Visualize peak coverage across the genome
covplot(peak, weightCol="V5")
```

### 2. Peak Annotation
Assign peaks to genomic features and identify the nearest genes. This requires a `TxDb` object (e.g., `TxDb.Hsapiens.UCSC.hg19.knownGene`).

```r
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

# Annotate peaks
peakAnno <- annotatePeak(peak, tssRegion=c(-3000, 3000), 
                         TxDb=txdb, annoDb="org.Hs.eg.db")

# Convert to data frame for export
anno_df <- as.data.frame(peakAnno)

# Visualize annotation distribution
plotAnnoPie(peakAnno)
plotAnnoBar(peakAnno)
upsetplot(peakAnno)
```

### 3. Binding Profiles (TSS and Gene Body)
Generate heatmaps and average profiles to see where proteins bind relative to Transcription Start Sites (TSS) or across gene bodies.

```r
# Profile around TSS
peakHeatmap(peak, TxDb=txdb, upstream=3000, downstream=3000)
plotAvgProf2(peak, TxDb=txdb, upstream=3000, downstream=3000)

# Profile across Gene Body (using binning for different gene lengths)
plotPeakProf2(peak, TxDb=txdb, type="body", by="gene", 
              upstream=rel(0.2), downstream=rel(0.2), nbin=800)
```

### 4. Functional Enrichment
Link genomic regions to genes and perform pathway analysis.

```r
# Method 1: Using annotated nearest genes
library(clusterProfiler)
genes <- as.data.frame(peakAnno)$geneId
enrich <- enrichGO(gene = genes, OrgDb = "org.Hs.eg.db", ont = "BP")

# Method 2: seq2gene (many-to-many mapping including flanking genes)
genes_flank <- seq2gene(peak, tssRegion=c(-1000, 1000), flankDistance=3000, TxDb=txdb)
```

### 5. Dataset Comparison
Compare multiple BED files to identify common binding patterns or overlapping genes.

```r
files <- list(sample1="peaks1.bed", sample2="peaks2.bed")
peakAnnoList <- lapply(files, annotatePeak, TxDb=txdb)

# Compare genomic annotations
plotAnnoBar(peakAnnoList)

# Compare overlap of nearest genes
genes_list <- lapply(peakAnnoList, function(i) as.data.frame(i)$geneId)
vennplot(genes_list)
```

## Key Tips
- **Genomic Priority**: By default, ChIPseeker prioritizes annotations as: Promoter > 5' UTR > 3' UTR > Exon > Intron > Downstream > Intergenic. You can change this using the `genomicAnnotationPriority` argument in `annotatePeak`.
- **Binning**: When plotting gene bodies, use `nbin` (e.g., 800) to scale genes of different lengths to a uniform size for visualization.
- **GEO Data**: Use `getGEOInfo(genome="hg19")` to explore thousands of publicly available ChIP-seq datasets that can be compared with your own data using `enrichPeakOverlap`.

## Reference documentation
- [ChIPseeker: an R package for ChIP peak Annotation, Comparison and Visualization](./references/ChIPseeker.md)