---
name: bioconductor-crisprverse
description: The crisprVerse meta-package provides a comprehensive ecosystem for the design, scoring, and visualization of CRISPR guide RNAs. Use when user asks to design gRNAs, calculate on-target and off-target scores, align spacers to a reference genome, or visualize genomic tracks for CRISPR experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/crisprVerse.html
---


# bioconductor-crisprverse

## Overview

The `crisprVerse` is a meta-package that integrates several specialized R packages to provide a complete workflow for CRISPR gRNA design. It simplifies the process of installing and loading the core components of the CRISPR design ecosystem.

Core components include:
- **crisprBase**: Define nucleases (Cas9, Cas12, etc.) and PAM sequences.
- **crisprDesign**: The central engine for creating and manipulating `GuideSet` objects.
- **crisprScore**: Calculate efficiency (on-target) and specificity (off-target) scores.
- **crisprBowtie**: Fast alignment of spacers to reference genomes.
- **crisprViz**: Genomic track visualization of designed gRNAs.

## Installation and Setup

To install the complete ecosystem:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("crisprVerse")
```

To load the ecosystem and check for updates:

```r
library(crisprVerse)
crisprVerse_update()
```

## Typical Workflow

### 1. Define Nuclease
Use `crisprBase` to specify the enzyme and its constraints.
```r
library(crisprBase)
data(SpCas9)
# View PAM and cut site details
SpCas9
```

### 2. Design Guides
Use `crisprDesign` to find spacers within a target region or gene.
```r
library(crisprDesign)
# Assuming 'bsgenome' and 'gr' (GRanges object) are defined
gs <- findSpacers(gr, bsgenome = bsgenome, nuclease = SpCas9)
```

### 3. Alignment and Off-target Analysis
Use `crisprBowtie` to map spacers and identify potential off-targets.
```r
library(crisprBowtie)
# Requires a bowtie index for the reference genome
gs <- addSpacerAlignments(gs, bowtie_index = "path/to/index")
```

### 4. Scoring
Annotate the `GuideSet` with various biological scores using `crisprScore`.
```r
library(crisprScore)
# Add Azimuth scores for Cas9
gs <- addOnTargetScores(gs, methods = "azimuth")
# Add CFD scores for off-targets
gs <- addOffTargetScores(gs, methods = "cfd")
```

### 5. Visualization
Visualize the resulting guides in their genomic context.
```r
library(crisprViz)
plotGuideSet(gs, targetGene = "GeneName")
```

## Key Objects
- **GuideSet**: An extension of `GRanges` that stores spacer sequences, PAM sites, alignments, and scores. Use `mcols(gs)` to access the metadata and scores.

## Tips for Success
- **Memory Management**: CRISPR design against whole genomes can be memory-intensive. Use `crisprScoreData` to access pre-trained models without re-training.
- **Object Consistency**: Ensure the `BSgenome` object used for finding spacers matches the version used for the Bowtie index.
- **Filtering**: Use standard `GRanges` subsetting or `crisprDesign` filtering functions to narrow down candidates based on score thresholds (e.g., `gs[gs$azimuth > 0.5]`).

## Reference documentation

- [crisprVerse: ecosystem of R packages for CRISPR gRNA design](./references/crisprVerse.Rmd)
- [crisprVerse: ecosystem of R packages for CRISPR gRNA design (Markdown)](./references/crisprVerse.md)