---
name: bioconductor-derfinderplot
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/derfinderPlot.html
---

# bioconductor-derfinderplot

name: bioconductor-derfinderplot
description: Visualization of differentially expressed regions (DERs) and coverage data from RNA-seq analysis. Use this skill when plotting results from the derfinder package, including genome-wide overviews, region-specific coverage plots, and cluster visualizations.

## Overview
The `derfinderPlot` package is a companion to `derfinder`, providing specialized functions to visualize candidate differentially expressed regions (DERs). It supports high-level genomic overviews, detailed base-pair resolution coverage plots for specific regions, and cluster-based visualizations that integrate gene annotation and sample-level coverage.

## Core Functions

### 1. Genome-wide Overview: `plotOverview()`
Visualizes the distribution of DERs across chromosomes.
- **Usage**: `plotOverview(regions, annotation, type = "qval")`
- **Types**: 
  - `"qval"`: Colors regions by significance (e.g., q-value < 0.10).
  - `"annotation"`: Colors regions by nearest gene feature (exon, intron, intergenic).
- **Requirement**: Requires output from `bumphunter::matchGenes()`.

### 2. Region Coverage: `plotRegionCoverage()`
Fast, base-graphics plotting of coverage for specific regions.
- **Workflow**:
  1. Annotate regions: `annoRegs <- annotateRegions(regions, genomicState$fullGenome)`
  2. Get coverage: `regionCov <- getRegionCoverage(fullCov, regions)`
  3. Plot: `plotRegionCoverage(regions, regionCoverage = regionCov, groupInfo = group, ...)`
- **Features**: Displays log2 coverage, sample-level data, and gene/transcript models if `txdb` is provided.

### 3. Cluster Visualization: `plotCluster()`
A `ggbio`-based plot showing all regions within a cluster (regions within 300bp by default).
- **Usage**: `plotCluster(idx, regions, annotation, coverageInfo, txdb, groupInfo)`
- **Components**: Includes a chromosome ideogram, sample-level coverage, group means, and known transcripts.

### 4. Annotation Summary: `vennRegions()`
Creates a Venn diagram showing the overlap of regions with genomic states (exon, intron, intergenic).
- **Usage**: `vennRegions(annotatedRegions)`
- **Input**: Output from `derfinder::annotateRegions()`.

## Typical Workflow

1.  **Load Data**: Load `derfinder` results (regions and coverage).
    ```r
    library(derfinderPlot)
    library(TxDb.Hsapiens.UCSC.hg19.knownGene)
    txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
    ```
2.  **Global Assessment**: Use `plotOverview()` to check for chromosomal bias or annotation trends.
3.  **Detailed Inspection**: Use `plotRegionCoverage()` for the top N significant regions to verify the raw signal.
4.  **Contextualize**: Use `plotCluster()` to see if a DER is part of a larger transcriptional unit or if nearby regions also show sub-threshold changes.

## Tips for Success
- **Annotation**: Most functions require a `TxDb` object to display gene structures. Ensure the `seqlevelsStyle` matches your data (e.g., "UCSC" vs "Ensembl").
- **Scalability**: `plotRegionCoverage()` is significantly faster than `plotCluster()` for viewing many individual regions.
- **Data Prep**: Ensure `fullCov` is a `SimpleRleList` (the standard output from `derfinder::fullCoverage`).

## Reference documentation
- [Introduction to derfinderPlot](./references/derfinderPlot.md)