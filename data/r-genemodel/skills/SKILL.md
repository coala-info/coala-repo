---
name: r-genemodel
description: The r-genemodel package creates publication-quality visualizations of gene models and genomic features based on coordinate data. Use when user asks to plot gene architecture, visualize alternative splicing variants, or overlay mutations and haplotypes onto genomic models.
homepage: https://cloud.r-project.org/web/packages/genemodel/index.html
---


# r-genemodel

## Overview
The `genemodel` package is designed to produce publication-quality gene model plots similar to those found on The Arabidopsis Information Resource (TAIR). It allows for the visualization of gene architecture based on coordinate data and the overlay of mutations or haplotypes at specific genomic positions.

## Installation
```R
install.packages("genemodel")
library(genemodel)
```

## Core Workflows

### 1. Plotting a Gene Model
To plot a gene, you need a data frame containing the feature types and their coordinates, along with the genomic start/stop positions and orientation.

**Data Structure:**
The model data frame requires two columns:
- `type`: Feature name (e.g., "5' utr", "coding_region", "intron", "3' utr").
- `coordinates`: String format "start-stop" (e.g., "100-250").

**Example:**
```R
# Load example data
data("AT5G62640")

# Plot the gene
genemodel.plot(model = AT5G62640, 
               start = 25149433, 
               bpstop = 25152541, 
               orientation = "reverse", 
               xaxis = TRUE)
```

### 2. Visualizing Alternative Splicing
You can compare splice variants by creating multiple data frames and plotting them in the same device using `par(mfrow=...)`.

```R
# Variant 1
spl1 <- data.frame(
  type = c("5' utr", "coding_region", "intron", "coding_region", "3' utr"), 
  coordinates = c("1-50", "50-100", "100-150", "150-200", "200-250"))

# Variant 2 (Exon skipping)
spl2 <- data.frame(
  type = c("5' utr", "coding_region", "intron", "3' utr"), 
  coordinates = c("1-50", "50-100", "100-200", "200-250"))

par(mfrow=c(2,1))
genemodel.plot(model=spl1, start=1, bpstop=250, orientation="forward", xaxis=TRUE)
genemodel.plot(model=spl2, start=1, bpstop=250, orientation="forward", xaxis=FALSE)
```

### 3. Adding Mutations and Features
Use `mutation.plot()` after calling `genemodel.plot()` to overlay specific points of interest.

```R
# First, plot the base model
genemodel.plot(model=AT5G62640, start=25149433, bpstop=25152541, orientation="reverse")

# Add mutations
# mutation.plot(start, stop, text, col, drop, haplotypes)
mutation.plot(25150214, 25150214, text="P->S", col="black", drop=-0.15, haplotypes=c("red", "blue"))
```

## Tips and Parameters
- **Orientation**: Set to `"forward"` or `"reverse"`. This determines the direction of the arrow head.
- **Feature Recognition**: The package automatically recognizes TAIR-style labels. It ignores "ORF" and "exon" types if "coding_region" and "intron" are provided to avoid redundancy.
- **The `drop` parameter**: In `mutation.plot()`, use negative values for `drop` (e.g., `-0.2`) to move labels further below the gene model to avoid overlapping text.
- **Haplotypes**: Passing a vector of colors to the `haplotypes` argument in `mutation.plot()` will create colored dots representing different groups sharing that mutation.

## Reference documentation
- [genemodel Tutorial](./references/vignette.Rmd)