---
name: bioconductor-maigespack
description: The maigesPack package provides a comprehensive toolkit for the pre-processing, normalization, and statistical analysis of microarray data with a focus on gene groups and networks. Use when user asks to load raw microarray data, perform local loess normalization, identify differentially expressed genes using T-tests or ANOVA, and conduct functional classification of gene modules.
homepage: https://bioconductor.org/packages/3.6/bioc/html/maigesPack.html
---

# bioconductor-maigespack

## Overview

The `maigesPack` package is a comprehensive toolkit for microarray data analysis. It integrates several Bioconductor and CRAN packages to provide a unified workflow for pre-processing and high-level statistical analysis. It is particularly strong in handling gene groups (modules) and gene networks (pathways) to provide biological context to statistical results.

## Core Workflow

### 1. Data Loading and Initialization
The package uses a configuration-based approach for loading raw data.

```r
library(maigesPack)

# Load raw data using a configuration file
# The config file specifies data columns and file locations
gastro = loadData(fileConf="load_gastro.conf")

# Optional: Add gene groups and networks
gastro = addGeneGrps(gastro, folder="geneGrps", ext="txt")
gastro = addPaths(gastro, folder="geneNets", ext="tgf")

# Convert to maigesRaw object for processing
gastro.raw = createMaigesRaw(gastro, 
                             greenDataField="Ch1.Mean", 
                             greenBackDataField="Ch1.B.Mean", 
                             redDataField="Ch2.Mean", 
                             redBackDataField="Ch2.B.Mean", 
                             flagDataField="Flags",
                             gLabelGrp="GeneName", 
                             gLabelPath="GeneName")
```

### 2. Exploratory Analysis
Before normalization, visualize data quality using WA plots (log-ratio vs average intensity) and spatial images.

```r
# WA plot (equivalent to MA plot) for the first chip
plot(gastro.raw[,1], bkgSub="none")

# Spatial image of log-ratios (W values)
image(gastro.raw[,1])

# Hierarchical clustering to check for batch effects or replicates
hierM(gastro.raw, sLabelID="Sample", gLabelID="Name", doHeat=FALSE)
```

### 3. Normalization
Normalization involves selecting reliable spots and applying local or global regressions.

```r
# Select spots based on signal-to-noise or flags
gastro.raw2 = selSpots(gastro.raw, sigNoise=1, rmFlag=NULL, gLabelsID="Name")

# Local loess normalization
gastro.norm = normLoc(gastro.raw2, span=0.4, method="loess")

# Scale adjustment (e.g., global MAD)
gastro.norm = normScaleMarray(gastro.norm, norm="globalMAD")

# Summarize replicates (spots or samples)
gastro.summ = summarizeReplicates(gastro.norm, gLabelID="GeneName", sLabelID="Sample", funcS="mean", funcG="median")
```

### 4. Differential Expression (DE)
`maigesPack` supports T-tests, Wilcoxon tests, and ANOVA models.

```r
# 2-group comparison (T-test)
gastro.ttest = deGenes2by2Ttest(gastro.summ, sLabelID="Type")

# ANOVA for multiple groups
gastro.ANOVA = designANOVA(gastro.summ, factors="Tissue")
gastro.ANOVAfit = deGenesANOVA(gastro.ANOVA, retF=TRUE)

# Visualize results
plot(gastro.ttest) # Volcano plot
tablesDE(gastro.ttest) # Save results to HTML/CSV
```

### 5. Advanced Functional Analysis

#### Functional Classification of Gene Groups
Search for modules with more DE genes than expected by chance.
```r
gastro.mod = activeMod(gastro.summ, sLabelID="Tissue", cutExp=1, cutPhiper=0.05)
plot(gastro.mod, "C") # Heatmap of active modules
```

#### Relevance Networks
Analyze altered correlations between genes in specific tissues.
```r
# Construct network for a specific tissue and gene group
gastro.net = relNetworkB(gastro.summ, sLabelID="Tissue", samples="Neso", geneGrp=1)
plot(gastro.net, cutPval=0.05)

# Compare correlations between two conditions
gastro.net2 = relNetworkM(gastro.summ, sLabelID="Tissue", 
                          samples = list(Neso="Neso", Aeso="Aeso"), geneGrp=7)
```

#### Active Networks
Measure the significance of gene network activation using a gamma distribution statistic.
```r
gastro.active = activeNet(gastro.summ, sLabelID="Tissue")
plot(gastro.active, type="score")
```

## Tips for Success
- **Configuration Files**: The `loadData` function relies heavily on a correctly formatted `.conf` file. Ensure column names match your image processing software output (e.g., GenePix, ScanArray).
- **Memory Management**: Functions like `normOLIN` or `deGenes2by2BootT` are computationally intensive. Use them on subsetted data first to estimate time.
- **Object Classes**: Pay attention to the transition from `maigesPreRaw` -> `maigesRaw` -> `maiges` (normalized) -> `maigesDEcluster`. Most analysis functions require specific classes.

## Reference documentation
- [Quick start guide for maigesPack – from start to finish](./references/maigesPack_tutorial.md)