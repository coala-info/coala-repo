---
name: bioconductor-prada
description: This tool provides specialized analysis of cell-based fluorescence assays and flow cytometry data. Use when user asks to perform automated gating using bivariate normal distributions, clean flow cytometry data, or integrate screening results into the cellHTS2 pipeline.
homepage: https://bioconductor.org/packages/3.5/bioc/html/prada.html
---


# bioconductor-prada

name: bioconductor-prada
description: Analysis of cell-based fluorescence assays, specifically flow cytometry (FACS) data. Use this skill to perform automated gating (fitting bivariate normal distributions), data cleaning, and integration of flow cytometry results into the cellHTS2 pipeline for high-throughput screening analysis.

## Overview

The `prada` package (Practical Analysis of DNA-chip/Cell-based Assays) provides tools for the specialized analysis of flow cytometry data. Its primary strengths include automated identification of cell populations using bivariate normal distributions and the ability to bridge flow cytometry outputs with high-throughput screening frameworks like `cellHTS2`.

## Core Workflows

### 1. Automated Gating and Data Cleaning
A common task is removing cell debris or conjugates from a population based on Forward Scatter (FSC) and Side Scatter (SSC).

```r
library(prada)

# Load FCS data
sampdat <- readFCS(system.file("extdata", "fas-Bcl2-plate323-04-04.A01", package="prada"))
fdat <- exprs(sampdat)

# Fit a bivariate normal distribution to FSC and SSC
# scalefac controls the size of the ellipse (higher = more inclusive)
nfit <- fitNorm2(fdat[,"FSC-H"], fdat[,"SSC-H"], scalefac=2)

# Visualize the fit and selection
plotNorm2(nfit, selection=TRUE, ellipse=TRUE)

# Extract the 'clean' data (points within the ellipse)
cleanfdat <- fdat[nfit$sel, ]
```

### 2. Visualizing High-Density Scatter Plots
For datasets with thousands of points where standard scatter plots become unreadable:

```r
# Use smoothScatter for density-based visualization
smoothScatter(fdat[, c("FSC-H", "SSC-H")], nrpoints=50)
```

### 3. Integrating with cellHTS2
`prada` facilitates the transition from raw flow data to structured screening objects. This involves mapping plate lists and applying transformations (e.g., log-transforming odds ratios).

```r
library(cellHTS2)
dataPath <- system.file("extdata", package = "prada")

# Import plate data using a custom function to process prada-derived files
x <- readPlateList("Platelist.txt", 
                   name = "ApoptosisScreen", 
                   path = dataPath, 
                   importFun = function(file, path) {
                     data <- read.delim(file, header=FALSE, as.is=TRUE)
                     # Example: calculate negative log transformation
                     return(list(data.frame(well=I(as.character(data[,2])), 
                                            val=-log10(data[,3])), 
                                 readLines(file)))
                   })

# Standard cellHTS2 workflow follows:
x <- configure(x, confFile="Plateconf.txt", descripFile="Description.txt", path=dataPath)
x <- annotate(x, file.path(dataPath, "GeneIDs.txt"))
```

## Key Functions

- `readFCS()`: Reads Flow Cytometry Standard (FCS) files.
- `fitNorm2()`: Fits a robust bivariate normal distribution to identify the main cell population.
- `plotNorm2()`: Specialized plotting for the results of `fitNorm2`, showing the selection ellipse and outliers.
- `smoothScatter()`: Produces a smoothed color density representation of a scatter plot.

## Tips for Success

- **Scalefac Tuning**: The `scalefac` parameter in `fitNorm2` is critical. A value of 2-3 is standard, but it should be adjusted based on the tightness of your specific cell population.
- **Data Access**: Use `exprs()` on the object returned by `readFCS` to access the underlying numerical matrix for analysis.
- **Integration**: When moving to `cellHTS2`, ensure your `importFun` correctly maps the well identifiers and applies necessary transformations to ensure symmetry around zero (like `-log10` for odds ratios).

## Reference documentation

- [Fitting a bivariate normal distribution to a 2D scatterplot](./references/norm2.md)
- [Feeding the output of a flow cytometry assay into cellHTS2](./references/prada2cellHTS.md)