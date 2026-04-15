---
name: bioconductor-beadarrayusecases
description: This package provides workflows and example datasets for the analysis of Illumina BeadArray gene expression data. Use when user asks to process raw bead-level data, perform spatial quality assessment, normalize summarized BeadStudio output, or conduct differential expression analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/BeadArrayUseCases.html
---

# bioconductor-beadarrayusecases

name: bioconductor-beadarrayusecases
description: Analysis of Illumina BeadArray gene expression data using the BeadArrayUseCases package. Use this skill to process raw bead-level data (.bab, .txt, .tif), summarized BeadStudio/GenomeStudio output, and public GEO datasets. It includes workflows for quality assessment (BASH, HULK), normalization (neqc), and differential expression analysis using limma.

# bioconductor-beadarrayusecases

## Overview
The `BeadArrayUseCases` package provides example datasets and workflows for the analysis of Illumina BeadArray technology. It serves as a comprehensive guide for using `beadarray`, `limma`, and `GEOquery` to handle various Illumina data formats, from raw pixel-level images to summarized expression matrices.

## Core Workflows

### 1. Bead-Level Data Analysis
Use this workflow when you have raw files (TIFFs, .locs, or .bab) and want to perform spatial quality control.

```r
library(beadarray)
library(BeadArrayUseCases)

# Locate and read data
chipPath <- system.file("extdata/Chips", package = "BeadArrayUseCases")
sampleSheetFile <- paste0(chipPath, "/sampleSheet.csv")
data <- readIllumina(dir = chipPath, sampleSheet = sampleSheetFile, illuminaAnnotation = "Humanv3")

# Quality Assessment
boxplot(data, transFun = logGreenChannelTransform)
imageplot(data, array = 1) # Visualizing spatial artifacts

# Spatial Artifact Management (BASH)
# Identifies and masks clusters of outliers
BASHoutput <- BASH(data, array = 1)
data <- setWeights(data, wts = BASHoutput$wts, array = 1)

# Gradient Correction (HULK)
HULKoutput <- HULK(data, array = 1, transFun = logGreenChannelTransform)
data <- insertBeadData(data, array = 1, data = HULKoutput, what = "GrnHulk")

# Summarization to ExpressionSetIllumina
datasumm <- summarize(BLData = data)
```

### 2. Summarized Data (BeadStudio/GenomeStudio)
Use this workflow for data exported from Illumina's software.

```r
library(limma)

# Read BeadStudio output
# Requires the sample probe profile and optionally the control profile
maqc <- read.ilmn(files = "AsuragenMAQC-probe-raw.txt", 
                 ctrlfiles = "AsuragenMAQC-controls.txt")

# Background correction and normalization (NEQC)
# This performs normexp background correction using negative controls
maqc.norm <- neqc(maqc)

# Filtering based on probe quality (requires annotation package)
library(illuminaHumanv2.db)
qual <- unlist(mget(rownames(maqc.norm), illuminaHumanv2PROBEQUALITY, ifnotfound = NA))
maqc.filt <- maqc.norm[qual %in% c("Perfect", "Good"), ]
```

### 3. Differential Expression Analysis
Standard `limma` pipeline adapted for BeadArray objects.

```r
# Setup design matrix
group <- factor(c("UHRR", "UHRR", "UHRR", "Brain", "Brain", "Brain"))
design <- model.matrix(~ 0 + group)
colnames(design) <- levels(group)

# Empirical array weights to down-weight poor quality arrays
aw <- arrayWeights(maqc.filt, design)

# Linear modeling
fit <- lmFit(maqc.filt, design, weights = aw)
contr <- makeContrasts(UHRR - Brain, levels = design)
fit2 <- contrasts.fit(fit, contr)
fit2 <- eBayes(fit2)

# Results
topTable(fit2)
```

### 4. Public Data (GEO)
Retrieve and process data directly from the Gene Expression Omnibus.

```r
library(GEOquery)
gse <- getGEO("GSE5350")[[1]]

# Remove batch effects (e.g., different processing sites)
sites <- pData(gse)$site # hypothetical column
exprs(gse) <- removeBatchEffect(exprs(gse), batch = sites)
```

## Key Functions and Tips
- `suggestAnnotation(data)`: Use this if the chip type is unknown; it compares IDs against known Illumina platforms.
- `calculateDetection(datasumm)`: Calculates detection p-values for summarized data based on negative control distributions.
- `poscontPlot(data, array = 1)`: Plots intensities of internal controls (Biotin, Housekeeping) to verify hybridization and staining.
- **Memory Management**: Bead-level data is RAM-intensive. Process in batches or use the compressed `.bab` format via `BeadDataPackR`.
- **Probe Quality**: Always filter "Bad" or "No match" probes using the `PROBEQUALITY` mapping in Bioconductor `.db` packages to reduce false positives from non-specific hybridization.

## Reference documentation
- [BeadArray expression analysis using Bioconductor](./references/BeadArrayUseCases.md)