---
name: bioconductor-biseq
description: The package takes already aligned BS data from one or multiple samples.
homepage: https://bioconductor.org/packages/release/bioc/html/BiSeq.html
---

# bioconductor-biseq

name: bioconductor-biseq
description: Analysis of targeted bisulfite sequencing (BS) data, such as RRBS. Use this skill to detect differentially methylated regions (DMRs) between groups or samples, perform CpG clustering, smooth methylation data using beta regression, and test predefined genomic regions.

# bioconductor-biseq

## Overview

The `BiSeq` package is designed for the analysis of targeted bisulfite sequencing data (e.g., RRBS). It provides a specialized workflow to detect Differentially Methylated Regions (DMRs) by clustering CpG sites, smoothing methylation levels, and applying a hierarchical testing procedure based on beta regression. It handles both group-wise comparisons and two-sample comparisons.

## Data Import and Classes

The package utilizes two primary classes derived from `RangedSummarizedExperiment`:
- `BSraw`: Holds raw data (total reads and methylated reads).
- `BSrel`: Holds relative methylation levels (0 to 1).

### Importing Bismark Output
```R
library(BiSeq)
# files: vector of paths to Bismark methylation extractor output
# colData: DataFrame with sample metadata
rrbs <- readBismark(files, colData)
```

### Manual Object Creation
```R
# Create BSraw
rrbs <- BSraw(metadata = list(), rowRanges = gr, colData = df, 
              totalReads = total_mat, methReads = meth_mat)

# Convert to BSrel
rrbs.rel <- rawToRel(rrbs)
```

## Workflow: Detection of DMRs (Groups)

### 1. Define CpG Clusters
Identify regions with high spatial density of CpG sites.
```R
rrbs.clust <- clusterSites(object = rrbs, 
                           groups = colData(rrbs)$group, 
                           perc.samples = 4/5, 
                           min.sites = 20, 
                           max.dist = 100)
```

### 2. Smooth Methylation Data
Limit coverage to reduce bias and predict methylation levels.
```R
# Limit coverage to 90% quantile
quant <- quantile(totalReads(rrbs.clust)[totalReads(rrbs.clust) > 0], 0.9)
rrbs.lim <- limitCov(rrbs.clust, maxCov = quant)

# Smooth data
predictedMeth <- predictMeth(object = rrbs.lim, mc.cores = 4)
```

### 3. Model and Test Group Effect
Use beta regression to model methylation.
```R
betaResults <- betaRegression(formula = ~group, 
                              link = "probit", 
                              object = predictedMeth, 
                              type = "BR")
```

### 4. Hierarchical Testing
Estimate the variogram under the null hypothesis (using resampled data) to account for spatial correlation, then test clusters.
```R
# 1. Estimate variogram (usually on resampled/null data)
vario <- makeVariogram(betaResultsNull)
vario.sm <- smoothVariogram(vario, sill = 0.9)

# 2. Estimate local correlation
vario.sm$pValsList <- makeVariogram(betaResults, make.variogram=FALSE)$pValsList
locCor <- estLocCor(vario.sm)

# 3. Test clusters
clusters.rej <- testClusters(locCor, FDR.cluster = 0.1)

# 4. Trim clusters to find specific CpG sites
clusters.trimmed <- trimClusters(clusters.rej, FDR.loc = 0.05)
```

### 5. Define DMR Boundaries
```R
DMRs <- findDMRs(clusters.trimmed, max.dist = 100, diff.dir = TRUE)
```

## Two-Sample Comparison
For comparing exactly two samples without replicates:
```R
DMRs.2 <- compareTwoSamples(object = predictedMeth, 
                            sample1 = "SampleA", 
                            sample2 = "SampleB", 
                            minDiff = 0.3, 
                            max.dist = 100)
```

## Testing Predefined Regions
Instead of `clusterSites`, assign CpG sites to known regions (e.g., promoters).
```R
# Subset data by overlaps with promoters GRanges
rrbs.red <- subsetByOverlaps(rrbs, promoters)
ov <- findOverlaps(rrbs.red, promoters)
rowRanges(rrbs.red)$cluster.id[queryHits(ov)] <- promoters$id[subjectHits(ov)]

# Proceed with smoothing and betaRegression
```

## Visualization and Annotation
- `plotMeth(object.raw, object.rel, region)`: Compare raw and smoothed data.
- `plotMethMap(predictedMeth, region, groups)`: Heatmap of methylation levels.
- `plotSmoothMeth(predictedMeth, region, groups)`: Plot smoothed curves.
- `annotateGRanges(DMRs, regions, name, regionInfo)`: Annotate DMRs with genomic features.
- `writeBED(object, name, file)`: Export tracks for IGV visualization.

## Reference documentation
- [BiSeq](./references/BiSeq.md)