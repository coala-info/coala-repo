---
name: bioconductor-simbindprofiles
description: This tool analyzes genome tiling array data to identify common and unique binding regions, increased binding, and compensation events across different datasets. Use when user asks to compare genomic signal profiles, identify differentially bound regions without peak calling, or classify binding events across multiple ChIP-chip or DamID experiments.
homepage: https://bioconductor.org/packages/3.5/bioc/html/SimBindProfiles.html
---


# bioconductor-simbindprofiles

name: bioconductor-simbindprofiles
description: Analysis of genome tiling array data (ChIP-chip, DamID) to identify common and unique binding regions, increased binding, and compensation events. Use this skill when comparing binding profiles processed on the same array platform to find differentially bound regions without relying on peak calling.

## Overview

SimBindProfiles implements a threshold-based approach to compare genomic signal data (SGR format) across different conditions or transcription factors. It is particularly useful for identifying functional redundancy, compensation, or increased binding between datasets.

## Core Workflow

### 1. Data Loading and Normalization

Data should be in SGR format (tab-delimited: chromosome, position, signal).

```R
library(SimBindProfiles)

# Read SGR files and perform quantile normalization
# File names are specified without the .txt extension
dataPath <- "path/to/sgr/files"
sgr_files <- c("Sample1", "Sample2", "Sample3")
SGR <- readSgrFiles(X = sgr_files, dataPath = dataPath)

# Visualize correlations and distributions
eSetScatterPlot(SGR)
```

### 2. Defining Thresholds

Two critical thresholds must be defined:
- `bound.cutoff`: Signal level above which a probe is considered "bound".
- `diff.cutoff`: Minimum difference between signals to consider a probe "uniquely" bound in one set compared to another.

```R
# Find bound cutoff using a mixture of two Gaussians (recommended)
# fdr parameter controls the stringency
bound.cutoff <- findBoundCutoff(SGR, method = "twoGaussiansNull", fdr = 0.25)

# Set difference cutoff (typically 75% to 100% of bound.cutoff)
diff.cutoff <- round(bound.cutoff * 0.75, 2)

# QC: Plot histogram with cutoff
hist(exprs(SGR)[,1], breaks=1000)
abline(v=bound.cutoff, col="red")
```

### 3. Region Classification

The package provides several functions to classify probes into regions based on the thresholds and spatial parameters:
- `probes`: Minimum number of probes required to form a region.
- `probe.max.spacing`: Maximum distance (bp) between probes before splitting a region.

#### Pairwise Comparison
Identifies unique regions in set 1, unique in set 2, and common regions.
```R
pairwiseR <- pairwiseRegions(SGR, sgrset = c(1, 2), 
                             bound.cutoff, diff.cutoff, 
                             probes = 10, probe.max.spacing = 200)
```

#### Three-way Comparison
Identifies unique and common regions across three datasets (7 possible classes).
```R
threewayR <- threewayRegions(SGR, sgrset = c(1, 2, 3), 
                             bound.cutoff, diff.cutoff, 
                             probes = 10, probe.max.spacing = 200)
```

#### Increased Binding
Identifies regions where binding is significantly higher in one set compared to another.
```R
increasedR <- increasedBindingRegions(SGR, sgrset = c(2, 3), 
                                      bound.cutoff, diff.cutoff, 
                                      probes = 10, probe.max.spacing = 200)
```

#### Compensation
Identifies regions bound in two sets (e.g., Factor A in WT and Factor B in A-mutant) but not in a third (e.g., Factor B in WT).
```R
compR <- compensationRegions(SGR, sgrset = c(1, 2, 3), 
                             bound.cutoff, diff.cutoff, 
                             probes = 10, probe.max.spacing = 200)
```

### 4. Visualization

```R
# Create probe annotation for plotting
probeAnno <- probeAnnoFromESet(SGR, probeLength = 50)

# Plot signal profiles along a chromosome
plot(SGR, probeAnno, chrom = "X", xlim = c(start, end), samples = c(1, 2))

# Scatterplot of classified probes
plotBoundProbes(SGR, sgrset = c(1, 2), method = "pairwise", 
                bound.cutoff, diff.cutoff)
```

## Tips for Success

- **Data Sorting**: Ensure SGR files are sorted by chromosome and ascending position before reading.
- **Parameter Selection**: Use `probeLengthPlot` to help determine the `probes` parameter by looking at the frequency of probes per bound region.
- **Output**: Classification functions automatically write `.bed` files to the working directory, which can be loaded into genome browsers like IGV.
- **Score Calculation**: The "score" in the output regions represents the mean difference in signal (for unique/increased classes) or mean signal (for common classes) across the probes in that region.

## Reference documentation

- [SimBindProfiles](./references/SimBindProfiles.md)