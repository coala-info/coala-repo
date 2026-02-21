---
name: bioconductor-anota2seq
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/anota2seq.html
---

# bioconductor-anota2seq

name: bioconductor-anota2seq
description: Analysis of translational efficiency using polysome-profiling or ribosome-profiling data. Use this skill to identify changes in mRNA abundance, translational efficiency (leading to altered protein levels), or translational buffering using Analysis of Partial Variance (APV). Suitable for RNA-seq (counts) or DNA-microarray data.

## Overview

The `anota2seq` package provides a regression-based framework (APV) to analyze translatome data. It avoids the biases of "translational efficiency scores" (log ratios) by using per-feature regression between translated mRNA (polysome-associated or RPF) and total mRNA. It categorizes genes into three modes:
1. **mRNA Abundance**: Similar changes in total and translated mRNA.
2. **Translation**: Changes in translated mRNA not explained by total mRNA (affects protein levels).
3. **Buffering**: Changes in total mRNA that are NOT reflected in translated mRNA (maintains constant protein levels).

## Core Workflow

### 1. Data Initialization
Load your count matrices (for RNA-seq) or normalized intensities (for microarrays).

```r
library(anota2seq)

# dataP: Translated mRNA (Polysome/RPF)
# dataT: Total mRNA
# phenoVec: Character vector of conditions (e.g., "ctrl", "treat")
ads <- anota2seqDataSetFromMatrix(
  dataP = count_matrix_P,
  dataT = count_matrix_T,
  phenoVec = conditions,
  dataType = "RNAseq",
  normalize = TRUE # Uses TMM-log2 by default for RNAseq
)
```

### 2. Quality Control (QC)
Assess model assumptions (influential data points, common slopes, and normal residuals).

```r
# Perform QC and check for outliers
ads <- anota2seqPerformQC(ads, generateSingleGenePlots = TRUE)
anota2seqResidOutlierTest(ads)
```

### 3. Analysis and Feature Selection
Run the APV analysis and filter for significant genes.

```r
# Run analysis for translation and buffering
ads <- anota2seqAnalyze(ads, analysis = c("translation", "buffering"))

# Filter results (e.g., FDR < 0.05)
ads <- anota2seqSelSigGenes(ads, maxPAdj = 0.05, selContrast = 1)
```

### 4. Categorization and Visualization
Classify genes into expression modes and plot results.

```r
# Categorize into modes (Abundance, Translation, Buffering)
ads <- anota2seqRegModes(ads)

# Plot Fold Changes (Translated vs Total)
anota2seqPlotFC(ads, selContrast = 1)

# Plot specific gene regressions
anota2seqPlotGenes(ads, selContrast = 1, analysis = "translation")
```

## One-Step Procedure
For a standard analysis with default parameters, use the wrapper function:

```r
ads <- anota2seqRun(ads, thresholds = list(maxPAdj = 0.05, minEff = 1.5))
```

## Key Functions and Parameters

- `anota2seqGetOutput()`: Retrieves data frames of results. Use `analysis = "translation"` or `"buffering"` and `output = "selected"`.
- `getRVM = TRUE`: Highly recommended. Uses the Random Variance Model to improve statistical power for small sample sizes.
- `selContrast`: Integer indicating which contrast to analyze (based on the order in the design matrix).
- `singleRegMode`: The column in the output that identifies the final classification of the gene.

## Reference documentation

- [Generally applicable transcriptome-wide analysis of translational efficiency using anota2seq](./references/anota2seq.md)