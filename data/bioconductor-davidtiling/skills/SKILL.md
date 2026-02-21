---
name: bioconductor-davidtiling
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/davidTiling.html
---

# bioconductor-davidtiling

name: bioconductor-davidtiling
description: Analysis of yeast tiling array data using the davidTiling package. Use this skill to access raw CEL file intensities, genomic probe mappings, and S. cerevisiae GFF annotations from the David et al. (2006) PNAS study. It supports workflows for transcript mapping, GO enrichment analysis, and visualizing genomic signal densities.

# bioconductor-davidtiling

## Overview

The `davidTiling` package provides data and analysis scripts for high-resolution transcription mapping in *Saccharomyces cerevisiae*. It includes raw intensity data from Affymetrix tiling chips, probe-to-genome mapping environments, and yeast genomic features (GFF). This skill enables the exploration of yeast tiling data, segmentation scoring, and functional annotation.

## Core Data Objects

The package centers around three primary datasets:

- `davidTiling`: An `eSet` object containing raw intensities from 8 CEL files.
- `probeAnno`: An environment containing probe mapping information (indices, start/end positions, and strand specificity) for the yeast genome.
- `gff`: A data frame containing genomic features of *S. cerevisiae* used for annotation.

```r
library(davidTiling)

# Load the main expression data
data("davidTiling")
# Access raw intensities
intensities <- exprs(davidTiling)

# Load probe mapping information
data("probeAnno")
# List available chromosomes/strands (e.g., "1.+.start")
ls(probeAnno)

# Load genomic annotations
data("gff")
```

## Genomic Feature Manipulation

Use these functions to parse GFF attributes and map genes to functional categories.

### Extracting GFF Attributes
The `getAttributeField` function parses the "attributes" column of the GFF data frame.

```r
# Extract gene names from GFF attributes
gene_names <- getAttributeField(gff$attributes, field = "Name")
```

### GO Annotation and Enrichment
Perform hypergeometric tests for GO category enrichment based on the provided GFF data.

```r
# Get all GO categories for a list of genes including ancestors
go_list <- getAllGO(x = c("YAL001C", "YAL002W"), gff = gff)

# Perform Hypergeometric test for enrichment
# candidates: character vector of gene names
GOHyperG(candidates = my_genes, gff = gff, plotmain = "GO Enrichment Analysis")
```

## Visualization and Analysis

### Specialized Plotting
The package provides functions for visualizing distributions and tiling data.

```r
# Scatterplot with marginal histograms
# x: numeric matrix with 2 columns
scatterWithHist(x, xlab="Sample 1", ylab="Sample 2")

# Compare multiple densities
showDens(list(Set1=runif(100), Set2=runif(100)), col=c("red", "blue"))
```

### Scoring Segments
After performing segmentation (typically via the `tilingArray` package), use `scoreSegments` to compare found segments against the genome annotation.

```r
# Score segments 's' against GFF annotation
scores <- scoreSegments(s, gff)
```

## Workflow Tips

- **Memory Management**: The `probeAnno` object is an environment to save memory. Access specific elements using `probeAnno$"1.+.start"`.
- **Strand Specificity**: `probeDirect` is used for samples hybridized without reverse transcription, while `probeReverse` is for those with a reverse transcription step.
- **Feature Metadata**: Use `data(yeastFeatures)` to see which feature categories (e.g., CDS, telomere) are considered transcribable.

## Reference documentation

- [davidTiling Reference Manual](./references/reference_manual.md)