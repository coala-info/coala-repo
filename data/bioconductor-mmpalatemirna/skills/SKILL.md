---
name: bioconductor-mmpalatemirna
description: This package provides specialized tools for the preprocessing, normalization, and differential expression analysis of murine palate miRNA microarray data. Use when user asks to perform quality control, normalize two-color miRNA arrays, identify differentially expressed miRNAs, or predict target genes in mouse developmental studies.
homepage: https://bioconductor.org/packages/3.8/bioc/html/MmPalateMiRNA.html
---


# bioconductor-mmpalatemirna

name: bioconductor-mmpalatemirna
description: Analysis of murine palate miRNA microarray data using the MmPalateMiRNA package. Use this skill to perform preprocessing (outlier detection, imputation, filtering), normalization (quantile, VSN, loess), differential expression analysis with limma, clustering of miRNA profiles, and target gene identification for mouse developmental studies.

# bioconductor-mmpalatemirna

## Overview
The `MmPalateMiRNA` package is a Bioconductor compendium for analyzing two-color miRNA microarray data, specifically from the Miltenyi Biotech miRXplore platform. It provides specialized methods for quality control, normalization, and downstream functional analysis (target identification and gene set enrichment) tailored to the unique characteristics of miRNA arrays, which typically have fewer probes than mRNA arrays.

## Core Workflow

### 1. Data Loading and Initial QC
The package includes the `PalateData` dataset (an `RGList` object).
```R
library(MmPalateMiRNA)
data(PalateData)

# Visualize intensity densities to identify outlying arrays
res <- densityplot(PalateData, channel="G", group="probe.type", 
                   subset = c("Other miRNAs", "MMU miRNAs", "Control"))
print(res)

# Check for pairwise distance between arrays
res_level <- levelplot(PalateData, channel="G", group="probe.type")
print(res_level)
```

### 2. Preprocessing and Cleaning
Handle outlying values and missing data before normalization.
- `checkOutliers()` / `fixOutliers()`: Detect and replace extreme values (replicate mean).
- `checkMVs()` / `fixMVs()`: Detect and impute missing values in background/foreground.
- `filterArray()`: Remove low-intensity probes.
```R
# Fix outliers and missing values
outliers <- checkOutliers(PalateData)
PalateData$R <- fixOutliers(PalateData$R, outliers$Rout, PalateData$genes$Gene)

mvs <- checkMVs(PalateData)
PalateData$Rb <- fixMVs(PalateData$Rb, mvs$Rb.na, PalateData$genes$Gene)

# Filter: keep probes 1.1x above background in at least 3 samples
reducedSet <- filterArray(PalateData, keep=c("MIR", "LET", "POSCON", "CALIB"), 
                          frac=1.1, number=3, reps=4)
```

### 3. Normalization
Evaluate multiple methods. Quantile normalization is often most effective for this platform.
```R
# Quantile normalization (between arrays)
ndata <- normalizeBetweenArrays(reducedSet, method="quantile")

# VSN normalization
ndata.vsn <- normalizeVSN(reducedSet)

# Impute remaining NAs (e.g., from negative intensities)
ndata$M <- imputeKNN(as.matrix(ndata$M), dist="cor")
```

### 4. Differential Expression (limma)
Use `limma` to find miRNAs changing across gestational days (GD12, GD13, GD14).
```R
# Setup design and contrasts
design <- model.matrix(~ 0 + factor(c(1,1,2,2,3,3)))
colnames(design) <- c("Day12", "Day13", "Day14")
contrast.matrix <- makeContrasts(Day13-Day12, Day14-Day12, Day14-Day13, levels=design)

# Fit model accounting for quadruplicate spots
corfit <- duplicateCorrelation(ndata, design, ndups=4)
fit <- lmFit(ndata, design, ndups=4, correlation=corfit$consensus)
fitc <- eBayes(contrasts.fit(fit, contrast.matrix))

# Get results
top13v12 <- topTable(fitc, coef=1, number=Inf, adjust="fdr")
```

### 5. Clustering and Target Identification
Group miRNAs by expression profile and find biological targets.
- `clustPlot()`: Visualize clusters.
- Use `targetscan.Mm.eg.db` and `microRNA` packages for target mapping.
```R
# Plot clusters (requires cluster assignments from clValid or hclust)
# aveExpr should be a matrix of averaged replicates
clustPlot(clusters, aveExpr, rows=3, cols=2)

# Intersection of TargetScan and miRBase targets
# (Requires external mapping of miRNA names to Entrez/Ensembl)
```

## Tips for miRNA Analysis
- **Probe Filtering**: miRNA arrays have many probes with intensities near background; filtering is critical to reduce the false discovery rate.
- **Normalization Choice**: Use `MADvsMedianPlot()` and `MAplot()` to verify that normalization removed intensity-dependent bias without collapsing biological variation.
- **Target Intersection**: To reduce false positives in target prediction, take the intersection of multiple databases (e.g., TargetScan and miRBase).

## Reference documentation
- [MmPalateMiRNA](./references/MmPalateMiRNA.md)