---
name: bioconductor-chimphumanbraindata
description: This package provides raw Affymetrix gene expression data and workflows for comparing human and chimpanzee brain regions. Use when user asks to load ChimpHumanBrainData CEL files, preprocess brain expression datasets with RMA, or perform split-plot differential expression analysis using limma.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ChimpHumanBrainData.html
---


# bioconductor-chimphumanbraindata

## Overview
The `ChimpHumanBrainData` package provides a specialized dataset for comparing gene expression across different brain regions in humans and chimpanzees. It contains raw Affymetrix Genechip (HG_U95B) data from a split-plot design experiment. This skill guides the user through loading the raw CEL files, preprocessing with RMA, and conducting complex differential expression analysis using linear models and empirical Bayes methods (limma).

## Data Loading and Preprocessing

To access the raw data, you must locate the external data directory within the package and read the CEL files.

```r
library(ChimpHumanBrainData)
library(affy)

# Locate and load raw CEL files
celfileDir <- system.file("extdata", package="ChimpHumanBrainData")
celfileNames <- list.celfiles(celfileDir)
brainBatch <- ReadAffy(filenames=celfileNames, celfile.path=celfileDir, compress=TRUE)

# Assign informative sample names
# Order: 3 Chimp replicates (4 regions each), then 3 Human replicates (4 regions each)
sampleNames(brainBatch) <- paste(rep(c("CH","HU"), each=12), 
                               rep(c(1:3, 1:3), each=4), 
                               rep(c("Prefrontal","Caudate","Cerebellum","Broca"), 6), 
                               sep="")

# Normalize using RMA
brain.rma <- rma(brainBatch)
```

## Differential Expression Workflow

The dataset uses a split-plot design (Species as whole-plot, Region as subplot, Brain as block). Analysis is typically performed using `limma` with `duplicateCorrelation` to account for multiple samples from the same individual.

### 1. Design Matrix and Correlation
```r
library(limma)
library(statmod)

# Create treatment factor and design matrix
trts <- factor(paste(rep(c("CH","HU"), each=12), 
                    rep(c("Prefrontal","Caudate","Cerebellum","Broca"), 6), sep=""))
design.trt <- model.matrix(~0 + trts)

# Define blocks (6 individual brains)
blocks <- factor(rep(1:6, each=4))

# Compute within-block correlation (consensus correlation for the split-plot design)
corfit <- duplicateCorrelation(brain.rma, design.trt, block = blocks)
consensus_corr <- corfit$consensus.correlation
```

### 2. Linear Model Fitting
```r
# Fit model accounting for block correlation
fitTrtMean <- lmFit(brain.rma, design.trt, block = blocks, cor = consensus_corr)
```

### 3. Contrasts and Statistics
Define specific comparisons between species or regions.

```r
# Example: Species effect and Interaction
contrast.matrix <- makeContrasts(
    ChVsHu = (trtsCHBroca+trtsCHCaudate+trtsCHCerebellum+trtsCHPrefrontal)/4 - 
             (trtsHUBroca+trtsHUCaudate+trtsHUCerebellum+trtsHUPrefrontal)/4,
    Interact = (trtsCHCerebellum-trtsHUCerebellum)-(trtsCHBroca-trtsHUBroca),
    levels = design.trt
)

# Compute contrasts and moderated t-tests
fit.contrast <- contrasts.fit(fitTrtMean, contrast.matrix)
efit.contrast <- eBayes(fit.contrast)

# View top genes for a specific contrast (e.g., ChVsHu)
topTable(efit.contrast, coef="ChVsHu", adjust.method="BY")
```

## Tips and Interpretation
- **Quality Control**: Use `hexbin` plots on `log2(exprs(brainBatch))` to visualize correlations between replicates before normalization.
- **P-value Distribution**: Always plot histograms of p-values (`hist(efit.contrast$p.value[,i])`) to assess the proportion of differentially expressed genes and detection power.
- **Multiple Testing**: The "BY" (Benjamini & Yekutieli) or "fdr" methods are recommended given the high number of expected differentially expressed genes in species comparisons.
- **Data Structure**: The data includes 4 specific regions: Prefrontal cortex, Caudate nucleus, Cerebellum, and Broca’s region.

## Reference documentation
- [Differential Expression Analysis using LIMMA](./references/DiffExpressVignette.md)