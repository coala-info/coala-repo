---
name: bioconductor-doser
description: bioconductor-doser analyzes dosage compensation by comparing gene expression across different genomic groupings and biological treatments. Use when user asks to calculate RPKM values, compare expression ratios between sexes, or perform statistical tests on dosage effects across chromosomes.
homepage: https://bioconductor.org/packages/release/bioc/html/doseR.html
---

# bioconductor-doser

## Overview

The `doseR` package provides a framework for analyzing dosage compensation by comparing gene expression across different genomic groupings (typically chromosomes) and biological treatments (typically sexes). It utilizes the `SummarizedExperiment` class to manage read counts, RPKM values, and metadata.

## Core Workflow

### 1. Data Preparation
The workflow requires three primary inputs: a matrix of read counts, a vector of transcript lengths, and a dataframe of gene annotations (e.g., chromosome assignments).

```r
library(doseR)
library(SummarizedExperiment)

# Load example or user data
data(hmel.data.doser) # hmel.dat contains readcounts, chromosome, trxLength

# 1. Define replicates
reps <- c("Male", "Male", "Male", "Female", "Female", "Female")

# 2. Create annotation dataframe (factorize for plotting order)
annotxn <- data.frame("Chromosome" = factor(hmel.dat$chromosome, levels = 1:21))
annotxn$ZA <- factor(ifelse(hmel.dat$chromosome == 21, "Z", "A"), levels = c("A", "Z"))

# 3. Construct SummarizedExperiment
colData <- S4Vectors::DataFrame(Treatment=as.factor(reps), row.names=colnames(hmel.dat$readcounts))
rowData <- S4Vectors::DataFrame(annotation = annotxn, seglens = hmel.dat$trxLength)
se <- SummarizedExperiment(assays=list(counts=hmel.dat$readcounts), colData=colData, rowData=rowData)
```

### 2. Normalization and RPKM Calculation
`doseR` scales counts by library size and transcript length.

```r
# Calculate library sizes (scaling factors)
colData(se)$Libsizes <- getLibsizes3(se, estimationType = "total")

# Generate RPKM assay
assays(se)$rpkm <- make_RPKM(se)

# Diagnostic MA plot to check normalization
plotMA.se(se, samplesA ="Male", samplesB = "Female")
```

### 3. Filtering Unexpressed Loci
Removing low-abundance transcripts is critical to avoid artifacts in dosage analysis.

```r
# Filter by mean RPKM across all samples
f_se <- simpleFilter(se, mean_cutoff = 0.01, counts = FALSE)
```

### 4. Analyzing Absolute Expression
Compare the distribution of expression levels within a treatment across gene groups.

```r
# Boxplot of RPKM by grouping (e.g., Z vs Autosome)
plotExpr(f_se, groupings = "annotation.ZA", notch = TRUE, ylab = "Log2(RPKM)")

# Statistical summary and Kruskal-Wallis test
se.male <- f_se[, colData(f_se)$Treatment == "Male"]
male_stats <- generateStats(se.male, groupings = "annotation.ZA")
male_stats$summary
male_stats$kruskal
```

### 5. Analyzing Relative Expression (Ratios)
Assess dosage effects by comparing ratios (e.g., Male:Female) across gene groups.

```r
# Boxplot of ratios
plotRatioBoxes(f_se, groupings = "annotation.ZA", treatment1 = "Male", treatment2 = "Female")

# Density plot of ratios
plotRatioDensity(f_se, groupings = "annotation.ZA", treatment1 = "Male", treatment2 = "Female")

# Statistical test for ratio differences between groups
ratio_test <- test_diffs(f_se, groupings = "annotation.ZA", treatment1 = "Male", treatment2 = "Female")
ratio_test$kruskal
```

## Key Functions
- `getLibsizes3()`: Calculates library scaling factors (options: "total", "median", "quant").
- `make_RPKM()`: Converts raw counts to RPKM using stored library sizes and segment lengths.
- `simpleFilter()`: Removes rows based on expression thresholds.
- `plotExpr()`: Visualizes absolute expression distributions.
- `plotRatioBoxes()` / `plotRatioDensity()`: Visualizes expression shifts between treatments.
- `generateStats()` / `test_diffs()`: Provides distributional summaries and non-parametric statistical tests.

## Reference documentation
- [doseR](./references/doseR.md)