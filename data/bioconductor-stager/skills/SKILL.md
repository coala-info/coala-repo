---
name: bioconductor-stager
description: The stageR package implements a statistical framework for stage-wise testing to control the overall false discovery rate in high-throughput experiments. Use when user asks to perform stage-wise p-value adjustment, analyze differential transcript usage, or conduct screening and confirmation testing for complex differential gene expression designs.
homepage: https://bioconductor.org/packages/release/bioc/html/stageR.html
---


# bioconductor-stager

## Overview

The `stageR` package implements a statistical framework for stage-wise testing. This approach is designed for experiments where multiple hypotheses are tested for each gene. It consists of two stages:
1.  **Screening Stage**: An omnibus test (e.g., F-test) to identify genes with any significant effect.
2.  **Confirmation Stage**: Testing individual hypotheses (e.g., specific contrasts or transcripts) only for genes that passed the screening stage.

This method provides better biological interpretation and statistical power while controlling the Overall False Discovery Rate (OFDR).

## Core Workflows

### 1. Differential Gene Expression (DGE)
Used for complex designs (e.g., multiple time points, treatments, or interactions).

```R
library(stageR)

# 1. Prepare p-values from a standard analysis (e.g., limma, DESeq2, edgeR)
# pScreen: Vector of p-values from an omnibus test (e.g., topTableF)
# pConfirmation: Matrix of p-values for individual contrasts (rows=genes, cols=contrasts)

# 2. Create stageR object
stageRObj <- stageR(pScreen = pScreen, 
                    pConfirmation = pConfirmation, 
                    pScreenAdjusted = FALSE)

# 3. Perform stage-wise adjustment
# method: "none", "bonferroni", "holm", etc.
stageRObj <- stageWiseAdjustment(object = stageRObj, 
                                 method = "none", 
                                 alpha = 0.05)

# 4. Extract results
results <- getResults(stageRObj)
padj <- getAdjustedPValues(stageRObj, onlySignificantGenes = TRUE)
```

### 2. Differential Transcript Usage (DTU)
Used for transcript-level analysis where hypotheses correspond to different isoforms.

```R
# 1. Prepare inputs
# pScreen: Named vector of gene-level q-values (e.g., from DEXSeq::perGeneQValue)
# pConfirmation: Named matrix of transcript-level p-values
# tx2gene: data.frame with 'transcript' and 'gene' columns

# 2. Create stageRTx object
stageRObj <- stageRTx(pScreen = pScreen, 
                      pConfirmation = pConfirmation, 
                      pScreenAdjusted = TRUE, 
                      tx2gene = tx2gene)

# 3. Perform adjustment using the "dtu" method
stageRObj <- stageWiseAdjustment(object = stageRObj, 
                                 method = "dtu", 
                                 alpha = 0.05)

# 4. Access significant features
sigGenes <- getSignificantGenes(stageRObj)
sigTx <- getSignificantTx(stageRObj)
```

## Key Functions and Parameters

- `stageR()` / `stageRTx()`: Constructors for gene-level and transcript-level objects.
- `stageWiseAdjustment()`: The core engine for p-value correction.
    - `method`: Use `"dtu"` for transcript usage. For DGE, use `"none"` if hypotheses are logically related such that only one can be true (Shaffer's MSRB), or `"holm"`/`"bonferroni"` for conservative FWER control.
    - `alpha`: The target OFDR level. **Note**: Adjusted p-values are only valid for the specific alpha provided. If you change alpha, you must re-run the adjustment.
- `getAdjustedPValues()`: Returns a table of adjusted p-values. Values for genes that fail the screening stage are returned as `NA`.
- `getResults()`: Returns a binary matrix (0/1) indicating significance for each hypothesis.

## Tips for Success

- **Sorting**: Ensure that `pScreen` and `pConfirmation` are sorted identically by gene/feature name before creating the object.
- **Filtering**: If using `DEXSeq`, ensure that transcripts belonging to genes filtered out during the gene-level q-value calculation are also removed from the `pConfirmation` and `tx2gene` objects to avoid mismatch errors.
- **Interpretation**: A transcript/contrast is only considered significant if its adjusted p-value is $\le$ alpha. The screening p-value in the output is typically BH-adjusted, while confirmation p-values are adjusted to control the FWER within the gene.

## Reference documentation

- [stageR Vignette](./references/stageRVignette.md)