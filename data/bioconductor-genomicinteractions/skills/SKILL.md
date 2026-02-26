---
name: bioconductor-genomicinteractions
description: This tool provides a framework for the analysis, annotation, and visualization of genome-wide chromatin interaction data such as Hi-C and ChIA-PET. Use when user asks to load interaction data from HOMER or ChIA-PET files, annotate anchors with genomic features, categorize interaction types, or visualize interactions using Gviz.
homepage: https://bioconductor.org/packages/release/bioc/html/GenomicInteractions.html
---


# bioconductor-genomicinteractions

name: bioconductor-genomicinteractions
description: Analysis and visualization of genome-wide chromatin interaction data (ChIA-PET, Hi-C). Use when Claude needs to load interaction data from files (HOMER, ChIA-PET tool), annotate anchors with genomic features (promoters, enhancers), calculate interaction distances, or visualize interactions using Gviz.

# bioconductor-genomicinteractions

## Overview

The `GenomicInteractions` package provides an S4 class for representing and manipulating genomic interaction data. It extends the `InteractionSet` framework to facilitate the annotation of interaction anchors with genomic features and the categorization of interactions (e.g., promoter-promoter, promoter-distal). It is particularly useful for downstream analysis of significant interactions identified by tools like HOMER or the ChIA-PET tool.

## Core Workflow

### 1. Loading Data

Data can be imported from common interaction calling formats into a `GenomicInteractions` object.

```r
library(GenomicInteractions)

# From ChIA-PET tool output
gi <- makeGenomicInteractionsFromFile("data.txt", 
                                      type="chiapet.tool", 
                                      experiment_name="K562", 
                                      description="PolII ChIA-PET")

# From HOMER interaction files
gi_hic <- makeGenomicInteractionsFromFile("hic_interactions.txt", 
                                          type="homer", 
                                          experiment_name="HiC_100kb")
```

### 2. Basic Manipulation and Statistics

The object behaves similarly to `GRanges` and `GInteractions`.

*   **Accessors**: `anchorOne(gi)`, `anchorTwo(gi)`, `interactionCounts(gi)`.
*   **Metadata**: Access columns via `mcols(gi)` or `$`.
*   **Cis/Trans**: `is.cis(gi)` and `is.trans(gi)` return logical vectors.
*   **Distances**: `calculateDistances(gi, method="midpoint")` (returns `NA` for trans).
*   **Subsetting**: `gi[is.cis(gi) & gi$fdr < 0.05]`.

### 3. Annotation and Categorization

Annotating anchors allows for functional classification of interactions.

```r
# Define features as a named list of GRanges
annotation.features <- list(promoter = refseq_promoters, 
                            enhancer = thymus_enhancers,
                            gene.body = refseq_genes)

# Annotate (order in list determines priority for node.class)
annotateInteractions(gi, annotation.features)

# View available classes
annotationFeatures(gi) 

# Categorize interaction types (e.g., promoter-promoter)
categoriseInteractions(gi)
```

### 4. Filtering by Interaction Type

Convenience functions exist for common types:
*   `is.pp(gi)`: Promoter-Promoter
*   `is.pd(gi)`: Promoter-Distal
*   `is.pt(gi)`: Promoter-Terminator
*   `is.dd(gi)`: Distal-Distal
*   General: `isInteractionType(gi, "promoter", "enhancer")`

### 5. Visualization

Integrates with `Gviz` via the `InteractionTrack` class.

```r
library(Gviz)
i_track <- InteractionTrack(gi, name = "HiC", chromosome = "chr15")

# Customize display
displayPars(i_track) <- list(col.interactions="red", 
                             interaction.dimension="height", 
                             interaction.measure ="counts")

plotTracks(list(i_track, GenomeAxisTrack()), chromosome="chr15", from=start, to=end)
```

## Feature Summaries

Use `summariseByFeatures` to aggregate interaction data around specific loci (e.g., how many distal elements each promoter contacts).

```r
promo_summary <- summariseByFeatures(gi, refseq_promoters, "promoter")
# Returns a data frame with counts of unique interactions per promoter
```

## Reference documentation

- [Genomic Interactions: ChIA-PET data](./references/chiapet_vignette.md)
- [HiC vignette for GenomicInteractions package (Rmd)](./references/hic_vignette.Rmd)
- [HiC vignette for GenomicInteractions package (md)](./references/hic_vignette.md)