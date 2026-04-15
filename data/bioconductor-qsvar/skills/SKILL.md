---
name: bioconductor-qsvar
description: The bioconductor-qsvar package implements the Quality Surrogate Variable Analysis framework to identify and remove RNA degradation-related noise from differential expression models. Use when user asks to identify degradation-associated principal components, remove transcript degradation bias, or improve biological signal detection in RNA-seq data.
homepage: https://bioconductor.org/packages/release/bioc/html/qsvaR.html
---

# bioconductor-qsvar

## Overview

The `qsvaR` package implements the Quality Surrogate Variable Analysis (qSVA) framework. It identifies principal components (qSVs) associated with RNA degradation profiles. These qSVs are then included as covariates in differential expression models to remove degradation-related noise, improving the detection of true biological signals.

## Core Workflow

### 1. Prepare Transcript Data
The package requires a `RangedSummarizedExperiment` (RSE) object containing transcript-level quantification (e.g., from Salmon).

```r
library(qsvaR)
library(SummarizedExperiment)

# Load your RangedSummarizedExperiment object
# rse_tx <- ... 

# Recommended: Filter for lowly expressed transcripts
rse_tx <- rse_tx[rowMeans(assays(rse_tx)$tpm) > 0.3, ]
```

### 2. Select Degradation-Associated Transcripts
Identify the subset of transcripts known to be sensitive to degradation.

```r
# Select the signature transcripts (cell_component is generally most effective)
sig_tx <- select_transcripts(cell_component = TRUE)

# Subset your RSE to these transcripts
DegTx <- getDegTx(rse_tx, sig_transcripts = sig_tx)
```

### 3. Generate qSVs
Calculate the principal components and determine the optimal number (`k`) to include in your model.

```r
# Define your experimental design (excluding qSVs for now)
mod <- model.matrix(~ Dx + Age + Sex + Race + Region, data = colData(rse_tx))

# Calculate number of PCs needed (requires a seed for sva::num.sv reproducibility)
set.seed(20230621)
k <- k_qsvs(rse_tx = DegTx, mod = mod, assayname = "tpm")

# Extract the qSV matrix
pcTx <- getPCs(rse_tx = DegTx, assayname = "tpm")
qsvs <- get_qsvs(qsvPCs = pcTx, k = k)
```

### 4. Differential Expression with qSVs
Incorporate the qSVs into your final model matrix for use with `limma`.

```r
library(limma)

# Combine original model with qSVs
mod_qSVA <- cbind(mod, qsvs)

# Run differential expression on the FULL transcript set
txExprs <- log2(assays(rse_tx)$tpm + 1)
fit <- lmFit(txExprs, mod_qSVA)
eb <- eBayes(fit)
results <- topTable(eb, coef = 2, number = Inf)
```

## Wrapper Function
For a streamlined analysis, use the `qSVA` wrapper which combines steps 2 and 3.

```r
set.seed(20230621)
qsvs <- qSVA(
    rse_tx = rse_tx,
    sig_transcripts = select_transcripts(cell_component = TRUE),
    mod = mod,
    assayname = "tpm"
)
```

## Diagnostic Tools
Use `DEqual` to visualize if the differential expression results are still confounded by degradation. A correlation near 0 between the degradation t-statistics and your DE t-statistics indicates successful normalization.

```r
# Create a data frame of t-statistics from your results
DE_stats <- data.frame(t = results$t, row.names = rownames(results))

# Plot degradation association
DEqual(DE_stats)
```

## Tips
- **Transcript Level**: qSVA is designed for transcript-level data. While results can be aggregated to the gene level later, the qSVs should be calculated using transcript quantifications.
- **Model Selection**: Three models are available in `select_transcripts()`: `cell_component` (recommended), `top1000`, and `top1500`.
- **Assay Name**: Ensure the `assayname` argument matches the slot in your RSE (usually `"tpm"`).

## Reference documentation
- [Introduction to qsvaR](./references/Intro_qsvaR.md)