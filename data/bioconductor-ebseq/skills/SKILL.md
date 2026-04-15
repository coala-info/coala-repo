---
name: bioconductor-ebseq
description: This tool performs differential expression analysis for RNA-seq data at both gene and isoform levels using empirical Bayesian models. Use when user asks to identify differentially expressed genes or isoforms, calculate posterior fold changes, or analyze complex multi-condition experimental designs.
homepage: https://bioconductor.org/packages/release/bioc/html/EBSeq.html
---

# bioconductor-ebseq

name: bioconductor-ebseq
description: Differential expression analysis for RNA-seq data at both gene and isoform levels using empirical Bayesian models. Use this skill to identify differentially expressed (DE) genes or isoforms, calculate posterior fold changes, and handle complex multi-condition experimental designs.

# bioconductor-ebseq

## Overview
EBSeq is an R package designed for identifying differentially expressed (DE) genes and isoforms in RNA-seq experiments. It uses an empirical Bayesian hierarchical model that accounts for the increased uncertainty inherent in isoform expression estimation. For isoform-level analysis, it groups isoforms based on the number of constituent isoforms of the parent gene ($I_g$ groups) to model differential variability.

## Core Workflow

### 1. Data Preparation
Input data must be a matrix of **raw counts** (not normalized).
```R
library(EBSeq)
# Data: G x S matrix (Genes/Isoforms as rows, Samples as columns)
# Conditions: Factor vector defining sample groups
Conditions <- as.factor(c("C1","C1","C2","C2"))
```

### 2. Normalization
Calculate library size factors using median normalization (similar to DESeq).
```R
Sizes <- MedianNorm(Data)
```

### 3. Gene-Level DE Analysis (Two Conditions)
```R
EBOut <- EBTest(Data = GeneMat, 
                Conditions = Conditions, 
                sizeFactors = Sizes, 
                maxround = 5) # Increase maxround for convergence (e.g., 20)

# Extract results at 5% FDR
EBDERes <- GetDEResults(EBOut, FDR = 0.05)
# EBDERes$DEfound contains the list of DE genes
# EBDERes$PPMat contains Posterior Probabilities (PPEE and PPDE)
```

### 4. Isoform-Level DE Analysis (Two Conditions)
Requires an "Ng" vector to group isoforms by parent gene complexity.
```R
# IsoformNames and IsosGeneNames must be provided
NgList <- GetNg(IsoformNames, IsosGeneNames)
IsoNgTrun <- NgList$IsoformNgTrun

IsoEBOut <- EBTest(Data = IsoMat, 
                   NgVector = IsoNgTrun,
                   Conditions = Conditions, 
                   sizeFactors = Sizes, 
                   maxround = 5)
IsoEBDERes <- GetDEResults(IsoEBOut, FDR = 0.05)
```

### 5. Multi-Condition Analysis
EBSeq can test multiple expression patterns (e.g., C1=C2<C3).
```R
# Define possible patterns
PosParti <- GetPatterns(Conditions)

# Run multi-test
MultiOut <- EBMultiTest(Data, 
                        NgVector = NULL, # Use NgVector for isoforms
                        Conditions = Conditions,
                        AllParti = PosParti, 
                        sizeFactors = Sizes, 
                        maxround = 5)

# Get Posterior Probabilities for each pattern
MultiPP <- GetMultiPP(MultiOut)
# MultiPP$MAP provides the Most Likely Pattern for each gene
```

## Diagnostics and Post-Processing

### Fold Change Calculation
Calculate posterior fold changes which are more robust for low-count genes.
```R
# For two conditions
GeneFC <- PostFC(EBOut)

# For multiple conditions
MultiFC <- GetMultiFC(MultiOut)
```

### Checking Convergence and Fit
Always verify that the model parameters have stabilized and the Beta prior fits the data.
```R
# Check parameter changes across iterations
EBOut$Alpha
EBOut$Beta

# Visual diagnostics
par(mfrow=c(1,2))
QQP(EBOut)      # Q-Q plot for Beta prior assumption
DenNHist(EBOut) # Density plot of empirical vs simulated q's
```

### Handling Data Without Replicates
If no replicates exist, EBSeq estimates variance by pooling genes with similar mean expressions.
```R
# Workflow remains the same; EBTest automatically detects lack of replicates
EBOut.norep <- EBTest(Data = Data.norep, 
                      Conditions = as.factor(c("C1","C2")),
                      sizeFactors = Sizes.norep, 
                      maxround = 5)
```

## Tips for Success
- **Low Expression Filter**: By default, `GetDEResults` is robust, but you can manually filter genes with very low counts (e.g., 75th quantile < 10) to improve power.
- **Convergence**: If parameters are still shifting significantly at the last iteration, increase `maxround`.
- **Input Format**: Ensure the input is a `matrix` of raw counts. Use `data.matrix()` after `read.csv()` if necessary.
- **FDR Control**: To get a list of DE targets at a specific FDR $\alpha$, filter for `PPDE >= (1 - α)`.

## Reference documentation
- [EBSeq: An R package for differential expression analysis using RNA-seq data](./references/EBSeq_Vignette.md)