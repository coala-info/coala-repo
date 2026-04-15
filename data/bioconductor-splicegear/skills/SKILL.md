---
name: bioconductor-splicegear
description: Bioconductor-splicegear provides a framework for managing, visualizing, and analyzing alternative splicing data integrated with microarray probe intensities. Use when user asks to handle splice site positions, visualize genomic splice variants, or link PALSdb data with expression analysis.
homepage: https://bioconductor.org/packages/3.5/bioc/html/splicegear.html
---

# bioconductor-splicegear

name: bioconductor-splicegear
description: Tools for managing, visualizing, and analyzing alternative splicing data in the context of microarray experiments. Use this skill when you need to handle splice site positions, probe intensities (ExpressionSet), and genomic coordinates for splice variants. It is particularly useful for linking PALSdb data with R-based expression analysis.

# bioconductor-splicegear

## Overview

The `splicegear` package provides a framework for integrating alternative splicing information with microarray probe intensities. It uses a three-part data model:
1. **SpliceSites**: Locations of putative or known splice sites.
2. **Probes**: Mapping of microarray probes to a reference sequence.
3. **ExpressionSet**: The actual intensity data from hybridization experiments.

The core class, `SpliceExprSet`, combines these elements to allow for the visualization and statistical analysis of how different splice variants affect probe-level expression.

## Typical Workflow

### 1. Data Acquisition and Object Creation
You can create `SpliceSites` objects from XML data (often from PALSdb) or manually for genomic views.

```r
library(splicegear)
library(XML)

# From an XML file
filename <- system.file("extdata", "example.xml", package="splicegear")
xml <- xmlTreeParse(filename, asTree=TRUE)
spsites <- buildSpliceSites(xml, verbose=FALSE)

# Querying PALSdb directly (requires internet)
# xml <- queryPALSdb("gene_symbol")
# spsites <- buildSpliceSites(xml)
```

### 2. Visualizing Splice Sites
The package provides plotting methods to visualize the distribution of splice sites and variants along a sequence.

```r
# Plotting a SpliceSites object
my.spsites <- spsites[[1]]
plot(my.spsites)
```

### 3. Working with Genomic Views
To represent exons as boxes and variants as connecting lines (standard "broken line" view), use the `SpliceSitesGenomic` class.

```r
# Define exon boundaries (start, end)
spsiteIpos <- matrix(c(1, 3.5, 5, 9, 3, 4, 8, 10), nc=2)
# Define which exons are included in which variants
variants <- list(a=c(1,2,3,4), b=c(1,2,3), c=c(1,3,4))

spvar <- new("SpliceSitesGenomic", 
             spsiteIpos=spsiteIpos, 
             variants=variants, 
             seq.length=as.integer(10))

# Plot variants
par(mfrow = c(3,1))
plot(spvar, split=TRUE, col.exon=rainbow(4))
```

### 4. Integrating Expression Data
The `SpliceExprSet` object links the splicing model to experimental data. You can convert these complex objects to standard R data frames for linear modeling.

```r
data(spliceset) # Load example SpliceExprSet

# Convert to data.frame for analysis
dataf <- as.data.frame(spliceset)

# Example: Plotting expression conditioned by probe position
# coplot(log(exprs) ~ Material | begin, data=dataf)
```

## Key Classes and Functions

- `SpliceSites`: Stores site positions. Type I (standard), Type II, and Type III sites are supported.
- `SpliceSitesGenomic`: Extension for exon-box representations.
- `SpliceExprSet`: The container for sites, probes, and expression data.
- `buildSpliceSites()`: Parser for XML-based splice site descriptions.
- `as.data.frame()`: S3 method to flatten `SpliceExprSet` for use in `lm()`, `lattice`, or `ggplot2`.

## Tips for Analysis
- **Probes Mapping**: Use the `matchprobes` package to map Affymetrix or custom probe sequences to the reference sequences used in your `SpliceSites` object.
- **Data Exchange**: The package uses a specific XML DTD for splice information; if importing custom data, ensure it matches the expected structure or manually construct the `SpliceSites` object using `new()`.

## Reference documentation
- [Splicegear package](./references/splicegear.md)