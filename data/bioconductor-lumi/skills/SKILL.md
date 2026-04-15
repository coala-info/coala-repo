---
name: bioconductor-lumi
description: The bioconductor-lumi package provides a comprehensive pipeline for processing and analyzing Illumina BeadArray expression and methylation data. Use when user asks to import GenomeStudio or IDAT files, perform variance stabilization and normalization, or conduct quality control on Illumina microarray datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/lumi.html
---

# bioconductor-lumi

name: bioconductor-lumi
description: Expert guidance for the Bioconductor R package 'lumi'. Use this skill when processing Illumina BeadArray data, including expression and methylation microarrays. It covers data input (BeadStudio/GenomeStudio files, .idat files), quality control, variance stabilization (VST), normalization (RSN, SSN), and probe annotation using nuIDs.

# bioconductor-lumi

## Overview
The `lumi` package is a comprehensive pipeline for Illumina microarray data analysis. It is specifically designed to handle the unique properties of BeadArray technology, providing specialized methods for variance stabilization and normalization. It supports both gene expression and Infinium methylation (27k, 450k) platforms.

## Core Workflows

### 1. Gene Expression Analysis
The standard workflow for expression data involves reading raw output from GenomeStudio and applying the `lumiExpresso` wrapper.

```r
library(lumi)

# Load data (supports .txt or .csv from GenomeStudio)
# Automatically converts Probe IDs to nuIDs if possible
x.lumi <- lumiR("Sample_Probe_Profile.txt")

# Comprehensive preprocessing: BG correction, VST, and RSN normalization
lumi.processed <- lumiExpresso(x.lumi)

# Extract normalized expression matrix
normData <- exprs(lumi.processed)
```

### 2. DNA Methylation Analysis
For methylation data, `lumi` handles color-bias adjustment between the red and green channels and converts intensities to Beta or M-values.

```r
# Import .idat files directly
# sampleInfo can be a data.frame with 'Sentrix_Barcode' and 'Sentrix_Position'
methyLumiM <- importMethyIDAT(sampleInfo)

# Preprocessing pipeline for methylation
methy.bg <- lumiMethyB(methyLumiM)  # Background adjustment
methy.color <- lumiMethyC(methy.bg) # Color bias adjustment
methy.norm <- lumiMethyN(methy.color) # Normalization

# Convert to M-values or Beta-values
m_values <- estimateM(methy.norm)
beta_values <- estimateBeta(methy.norm)
```

## Key Functions

### Data Input and Annotation
- `lumiR()`: Reads Illumina expression text files.
- `importMethyIDAT()`: Imports raw methylation IDAT files.
- `addNuID2lumi()`: Maps Illumina IDs to nuIDs (Nucleotide Universal Identifiers), which are sequence-based and stable across array versions.
- `getChipInfo()`: Identifies the Illumina chip version based on probe IDs.

### Preprocessing
- `lumiT()`: Performs Variance Stabilizing Transformation (VST). This is superior to log2 for Illumina data as it handles the mean-variance relationship better.
- `lumiN()`: Performs between-chip normalization. Recommended method: `method="rsn"` (Robust Spline Normalization).
- `lumiB()`: Background correction.

### Quality Control and Visualization
- `lumiQ()`: Generates a QC summary object.
- `plot(x.lumi, what="density")`: Visualizes intensity distributions.
- `plotSampleRelation(x.lumi)`: Performs MDS or hierarchical clustering to check for outliers or batch effects.
- `boxplotColorBias(methyLumiM)`: Checks for channel imbalance in methylation data.

## Tips for Success
- **nuIDs**: Always prefer using nuIDs over Illumina Probe IDs. nuIDs are MD5 hashes of the probe sequence, ensuring that the same sequence always has the same ID regardless of manifest changes.
- **Memory Management**: For very large datasets, use `asBigMatrix()` to convert data matrices into file-backed objects.
- **Detection P-values**: Use `detectionCall(x.lumi)` to filter out probes that are not significantly expressed above background before downstream differential analysis.
- **M-values vs Beta-values**: For statistical testing in methylation, M-values are preferred due to their better distributional properties (homoscedasticity), while Beta-values are preferred for biological interpretation (0 to 1 scale).

## Reference documentation
- [Package ‘lumi’ Reference Manual](./references/reference_manual.md)