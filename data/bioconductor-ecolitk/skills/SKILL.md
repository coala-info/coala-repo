---
name: bioconductor-ecolitk
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ecolitk.html
---

# bioconductor-ecolitk

## Overview
The `ecolitk` package provides a mixture of data and code specifically designed for the Escherichia coli genome. It excels at handling the unique coordinate systems of circular DNA and provides specialized plotting routines for circular genomes. While centered on E. coli, its geometric primitives can be applied to any circular plasmid or bacterial genome.

## Core Workflows

### Loading Data and Mapping Locations
The package relies on environment-based data structures (e.g., `ecoligenomeSYMBOL2AFFY`, `ecoligenomeCHRLOC`) to map between gene symbols, Affymetrix probe IDs, and genomic coordinates.

```r
library(ecolitk)
data(ecoligenomeSYMBOL2AFFY)
data(ecoligenomeCHRLOC)

# Find genes by pattern (e.g., lactose operon)
lac_indices <- grep("^lac", ls(ecoligenomeSYMBOL2AFFY))
lac_symbols <- ls(ecoligenomeSYMBOL2AFFY)[lac_indices]

# Convert symbols to Affy IDs then to coordinates
lac_affy <- unlist(mget(lac_symbols, ecoligenomeSYMBOL2AFFY))
beg_end <- matrix(unlist(mget(lac_affy, ecoligenomeCHRLOC)), nc=2, byrow=TRUE)
```

### Circular Genome Visualization
The package provides `cPlotCircle` as a base for circular plots. You can layer information using `polygonChrom`, `linesChrom`, or `arrowsArc`.

```r
# Basic circular plot
cPlotCircle(main.inside = "E. coli - K12")

# Plot specific genes as polygons on the circle
# ecoli.len is a built-in constant for the genome length
polygonChrom(beg_end[, 1], beg_end[, 2], ecoli.len, 1, 1.4, col="red")

# Zooming into a specific region
l <- data.frame(x=c(0.47, 0.48), y=c(0.87, 0.90))
cPlotCircle(xlim=range(l$x), ylim=range(l$y))
polygonChrom(beg_end[, 1], beg_end[, 2], ecoli.len, 1, 1.007, col=rainbow(4))
```

### Geometric Primitives for Circular DNA
For custom visualizations, use these low-level functions:
- `polar2xy(rhos, thetas)`: Convert polar coordinates to Cartesian.
- `linesCircle(radius, center.x, center.y)`: Draw a circle.
- `polygonArc(theta0, theta1, rho0, rho1)`: Draw a filled arc segment.
- `arrowsArc(theta0, theta1, rho)`: Draw directional arrows along an arc (useful for gene orientation).

### GC Content Analysis
You can calculate and plot GC content over genomic fragments using `wstringapply`.

```r
# Example: Calculate GC content for a 1MB fragment
fragment <- substring(ecoli.m52.genome, 1, 1000000)
tmp <- wstringapply(fragment, 400, 200, basecontent)
gccontent <- unlist(lapply(tmp, function(x) sum(x[3:4]) / sum(x)))

# Plot GC content on the outer ring
theta0 <- chromPos2angle(0, ecoli.len)
theta1 <- chromPos2angle(1000000, ecoli.len)
linesArc(theta0, theta1, gccontent + 1)
```

### Operon Analysis
The package includes `ecoligenome.operon` data to group genes into functional units for expression analysis.

```r
data(ecoligenome.operon)
# Group Affy IDs by operon name
affy_operons <- split(ecoligenome.operon$affyid, ecoligenome.operon$operon.name)

# Use with 'affy' package to compute expression sets for specific operons
# eset <- computeExprSet(abatch, ids = affy_operons[["lac"]])
```

## Tips and Best Practices
- **Coordinate Conversion**: Use `chromPos2angle(position, len)` to convert base-pair positions to radians for use with arc functions.
- **Strand Visualization**: When plotting genes, use different radii (the `rho` parameters) in `linesChrom` or `polygonChrom` to distinguish between the forward and reverse strands.
- **Data Dependencies**: Many functions expect `ecoli.len` (4,639,221 bp for K12) to be available in the workspace or provided as an argument.

## Reference documentation
- [ecolitk](./references/ecolitk.md)