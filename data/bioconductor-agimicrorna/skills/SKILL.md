---
name: bioconductor-agimicrorna
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/AgiMicroRna.html
---

# bioconductor-agimicrorna

name: bioconductor-agimicrorna
description: Processing, quality assessment, and differential expression analysis of Agilent microRNA array data. Use this skill when analyzing Agilent microRNA scanned data (AFE files) to perform normalization (TGS or RMA), quality control (boxplots, RLE, CV), and statistical inference using limma-based linear models.

## Overview

AgiMicroRna is designed for the analysis of Agilent microRNA microarrays. It reads data exported by Agilent Feature Extraction (AFE) software and provides two primary processing pipelines: Total Gene Signal (TGS) and Robust Multiarray Average (RMA). The package integrates seamlessly with `limma` for differential expression analysis, utilizing standard Bioconductor objects like `uRNAList` and `ExpressionSet`.

## Typical Workflow

### 1. Data Loading and Targets
A targets file (tab-delimited) is required with mandatory columns: `FileName`, `Treatment`, and `GErep` (numeric treatment code).

```r
library(AgiMicroRna)
# Read targets file
targets.micro <- readTargets(infile="targets.txt", verbose=TRUE)

# Read AFE data into a uRNAList object
dd.micro <- readMicroRnaAFE(targets.micro, verbose=TRUE)
```

### 2. Quality Control
Use `qcPlots` as a wrapper for comprehensive quality assessment, or call individual plotting functions.

```r
# Comprehensive QC (Boxplots, Density, MA, RLE, Hierarchical Clustering)
qcPlots(dd.micro, targets.micro, MeanSignal=TRUE)

# Check array reproducibility (Coefficient of Variation)
cvArray(dd.micro, "MeanSignal", targets.micro)
```

### 3. Normalization
Choose between the AFE Total Gene Signal (TGS) or the RMA algorithm.

**Option A: TGS Normalization**
```r
# Extract TGS and handle negative values
ddTGS <- tgsMicroRna(dd.micro, half=TRUE)

# Normalize (quantile, scale, or none)
ddNORM <- tgsNormalization(ddTGS, "quantile", targets.micro)
```

**Option B: RMA Normalization**
```r
# Background correction, quantile normalization, and median polish summarization
ddTGS.rma <- rmaMicroRna(dd.micro, normalize=TRUE, background=TRUE)
```

### 4. Filtering and ExpressionSet Creation
Filter out control probes and non-detected genes before statistical analysis.

```r
# Filter based on IsGeneDetected flag (e.g., must be detected in 75% of samples in at least one condition)
ddPROC <- filterMicroRna(ddNORM, dd.micro, control=TRUE, IsGeneDetected=TRUE, limIsGeneDetected=75, targets.micro=targets.micro)

# Convert to ExpressionSet for limma
esetPROC <- esetMicroRna(ddPROC, targets.micro)
```

### 5. Differential Expression (limma)
Define the design and contrast matrices to fit linear models.

```r
# Define Design (e.g., Treatment + Subject for paired design)
treatment <- factor(targets.micro$Treatment)
subject <- factor(targets.micro$Subject)
design <- model.matrix(~ -1 + treatment + subject)

# Define Contrasts
CM <- cbind(AvsB = c(1, -1, 0, 0), AvsC = c(1, 0, -1, 0))

# Fit model and compute moderated statistics
fit2 <- basicLimma(esetPROC, design, CM)

# Select significant microRNAs
DE <- getDecideTests(fit2, DEmethod="separate", MTestmethod="BH", PVcut=0.05)

# Generate summary tables and HTML reports with miRBase links
significantMicroRna(esetPROC, ddPROC, targets.micro, fit2, CM, DE, PVcut=0.05)
```

## Key Functions and Objects

- `uRNAList`: The primary data container (slots: `TGS`, `TPS`, `meanS`, `procS`, `targets`, `genes`, `other`).
- `readMicroRnaAFE()`: Reads Agilent FE files. Requires specific columns (gTotalGeneSignal, gMeanSignal, etc.).
- `tgsMicroRna()` / `rmaMicroRna()`: Core signal processing functions.
- `filterMicroRna()`: Removes low-quality features based on AFE flags.
- `significantMicroRna()`: The main output function for results and miRBase-linked HTML files.

## Reference documentation
- [AgiMicroRna](./references/AgiMicroRna.md)