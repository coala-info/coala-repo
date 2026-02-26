---
name: bioconductor-charm
description: The charm package analyzes DNA methylation data from the CHARM platform to estimate methylation percentages and identify differentially methylated regions. Use when user asks to process raw Nimblegen files, perform quality control on methylation arrays, normalize DNA methylation data, or find differentially methylated regions between experimental groups.
homepage: https://bioconductor.org/packages/3.8/bioc/html/charm.html
---


# bioconductor-charm

## Overview

The `charm` package is designed for the analysis of DNA methylation data, specifically optimized for the CHARM (Comprehensive High-throughput Arrays for Relative Methylation) platform. It processes raw Nimblegen `.xys` files to produce percentage methylation estimates and identifies differentially methylated regions (DMRs) between experimental groups. The package supports batch effect correction via Surrogate Variable Analysis (SVA) and handles both independent and paired sample designs.

## Core Workflow

### 1. Data Loading and Validation
The package requires a phenodata file (sample description) and raw `.xys` files.

```R
library(charm)
# Read sample description
pd <- read.delim("phenodata.txt")
# Validate sample description (checks for filename and sampleID columns)
res <- validatePd(pd)

# Read raw data (assumes 532.xys for untreated and 635.xys for methyl-depleted)
rawData <- readCharm(files=pd$filename, path="data_dir", sampleKey=pd)
```

### 2. Quality Control
Assess array quality based on the signal strength of genomic probes relative to background (anti-genomic) probes.

```R
# Generate a PDF QC report and get quality scores
qual <- qcReport(rawData, file="qcReport.pdf")

# Filter low quality arrays (e.g., score < 78)
rawData <- rawData[, qual$pmSignal >= 78]

# Identify high-quality probes
pmq <- pmQuality(rawData)
okqc <- which(rowMeans(pmq) > 75)
```

### 3. Normalization and Methylation Estimation
Identify control probes (CpG-free regions) and estimate methylation percentages.

```R
library(BSgenome.Hsapiens.UCSC.hg18) # Use appropriate genome
# Find control probes
ctrlIdx <- getControlIndex(rawData, subject=Hsapiens, noCpGWindow=600)

# Estimate methylation (p-values)
p <- methp(rawData, controlIndex=ctrlIdx, plotDensity="density.pdf")
```

### 4. Finding Differentially Methylated Regions (DMRs)

#### Pipeline 1: Regression-based (Recommended)
This method uses SVA to account for batch effects and technical variation.

```R
# 1. Prepare design matrices
mod0 = matrix(1, nrow=nrow(pData(rawData)), ncol=1)
mod = model.matrix(~1 + factor(pData(rawData)$tissue))

# 2. Define clusters and filter probes
pns = clusterMaker(pmChr(rawData), pmPosition(rawData))
Index = setdiff(okqc, ctrlIdx)

# 3. Find DMRs
thedmrs = dmrFind(p=p[Index,], mod=mod, mod0=mod0, coeff=2, 
                  pns=pns[Index], chr=pmChr(rawData)[Index], 
                  pos=pmPosition(rawData)[Index])

# 4. Calculate FDR q-values
withq = qval(p=p[Index,], dmr=thedmrs, numiter=500)
```

#### Pipeline 2: Simple Pairwise Comparison
Use `dmrFinder` for simpler analyses without batch correction.

```R
dmr <- dmrFinder(rawData, p=p, groups=pd$tissue, 
                 compare=c("group1", "group2"))
```

### 5. Visualization
Visualize DMRs with genomic context, including CpG island locations.

```R
# Plot DMRs from dmrFind
plotDMRs(dmrs=thedmrs, Genome=Hsapiens, cpg.islands=cpg_table, 
         exposure=pd$tissue, outfile="dmr_plots.pdf")

# Plot specific regions
plotRegions(thetable=my_regions, cleanp=thedmrs$cleanp, 
            chr=chr, pos=pos, Genome=Hsapiens)
```

## Key Functions
- `readCharm`: Reads Nimblegen `.xys` files into a `TilingFeatureSet`.
- `qcReport`: Generates quality metrics and spatial artifact plots.
- `methp`: Performs normalization and calculates percentage methylation.
- `dmrFind`: Advanced DMR identification using SVA and smoothing.
- `dmrFinder`: Basic DMR identification for pairwise or paired comparisons.
- `clusterMaker`: Groups probes into potential regions based on genomic distance.

## Reference documentation
- [Using the charm package to estimate DNA methylation levels and find differentially methylated regions](./references/charm.md)