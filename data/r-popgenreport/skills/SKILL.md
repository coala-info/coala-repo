---
name: r-popgenreport
description: PopGenReport is an R package for performing population and landscape genetic analyses and generating automated reports. Use when user asks to analyze population genetic data, calculate genetic distances, perform spatial autocorrelation, or conduct landscape genetic analysis using least-cost path modeling.
homepage: https://cloud.r-project.org/web/packages/PopGenReport/index.html
---


# r-popgenreport

name: r-popgenreport
description: A framework for population and landscape genetic analysis in R. Use this skill when you need to analyze population genetic data (adegenet objects), generate comprehensive PDF reports, calculate genetic distances (Kosman, Smouse & Peakall), perform spatial autocorrelation, or conduct landscape genetic analysis (least-cost path modeling).

# r-popgenreport

## Overview
The `PopGenReport` package provides a streamlined workflow for population genetic analysis. It bridges the gap between raw genetic data and professional reporting by automating common analyses like heterozygosity tests, F-statistics, allelic richness, and spatial autocorrelation. It also includes a landscape genetics module (`landgenreport`) for least-cost path modeling.

## Installation
```R
install.packages("PopGenReport")
# Note: For PDF report generation, a LaTeX installation (e.g., MiKTeX or MacTeX) is required.
```

## Core Workflow: Basic Population Genetics
The primary entry point is the `popgenreport` function, which accepts a `genind` object and produces a suite of analyses.

### 1. Loading Data
You can import data from CSV or standard genetic formats (STRUCTURE, Genepop, etc.).
```R
library(PopGenReport)

# Import from a formatted CSV
# Required columns: 'ind', 'pop', 'lat', 'long' (or 'x', 'y')
my_data <- read.genetable("my_data.csv", ind=1, pop=2, lat=3, long=4, sep="/", ploidy=2)
```

### 2. Generating a Report
Use switches (`mk.*`) to toggle specific analyses.
```R
# Generate a comprehensive analysis
results <- popgenreport(my_data, 
                        mk.counts=TRUE, 
                        mk.fst=TRUE, 
                        mk.hwe=TRUE, 
                        mk.allele.dist=TRUE,
                        mk.pdf=TRUE,        # Set to FALSE if LaTeX is not installed
                        foldername="results")
```

### Analysis Switches
- `mk.counts`: Summary of samples, loci, and alleles.
- `mk.map`: Map of individual locations.
- `mk.lozihz`: Observed and expected heterozygosity.
- `mk.hwe`: Hardy-Weinberg Equilibrium tests.
- `mk.fst`: F-statistics (Fit, Fst, Fis).
- `mk.gd.smouse` / `mk.gd.kosman`: Individual pairwise genetic distances.
- `mk.spautocor`: Spatial autocorrelation (Smouse & Peakall).
- `mk.allel.rich`: Allelic richness.

## Landscape Genetics: landgenreport
The `landgenreport` function performs Least-Cost Path Modeling Analysis (LCPMA).

### Required Inputs
1. **genind object**: Must contain spatial coordinates in `@other$xy`.
2. **Resistance Raster**: A `raster` object where cell values represent movement cost.
3. **Genetic Distance**: A metric (e.g., "D", "Gst.Hedrick", "Kosman").

### Example Workflow
```R
library(raster)

# 1. Prepare coordinates (must be projected, not lat/long)
# If you have lat/long, project them to Mercator first
# my_genind@other$xy <- project_coordinates(my_genind@other$latlong)

# 2. Load resistance surface
cost_r <- raster("resistance.tif")

# 3. Run landscape analysis
land_res <- landgenreport(my_genind, 
                          fric.raster=cost_r, 
                          gen.dist="D", 
                          nn=8, 
                          mk.pdf=FALSE)

# 4. Access results (Mantel tests and MMRR)
print(land_res$leastcost$mantel.tab)
print(land_res$leastcost$mmrr.tab)
```

## Tips for Success
- **Coordinate Systems**: Ensure your genetic sample coordinates and your resistance raster use the same projected coordinate system (e.g., UTM or Mercator). Do not use decimal degrees for distance-based calculations.
- **Folder Names**: Avoid spaces or special characters in the `foldername` or `path.pgr` arguments to prevent LaTeX compilation errors.
- **Subsetting**: You can run analyses on subsets of data using standard R indexing: `popgenreport(my_data[my_data@other$sex=="Female"], ...)`.
- **Customization**: Use `mk.Rcode=TRUE` in `popgenreport` to generate the underlying R script used for the analysis, which you can then modify for bespoke needs.

## Reference documentation
- [Introduction to PopGenReport](./references/PopGenReportIntroduction.md)
- [Landscape Genetic Analysis with landgenreport](./references/Tutorial_landgenreport.md)
- [Optimizing Resistance Surfaces](./references/Tutorial_optimizer.md)