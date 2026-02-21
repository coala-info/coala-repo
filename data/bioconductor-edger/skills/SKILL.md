---
name: bioconductor-edger
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/edgeR.html
---

# bioconductor-edger

name: bioconductor-edger
description: Expert guidance for differential expression analysis of digital gene expression data (RNA-seq, ChIP-seq, CRISPR screens) using the edgeR Bioconductor package. Use this skill when performing statistical analysis on read count matrices, including normalization (TMM), dispersion estimation (Empirical Bayes), and testing for differential expression using Quasi-Likelihood (QL) F-tests or Likelihood Ratio Tests (LRT).

# bioconductor-edger

## Overview
The `edgeR` package is a comprehensive statistical framework for analyzing "count" data from high-throughput sequencing. It uses the Negative Binomial (NB) distribution to model overdispersion and employs Empirical Bayes methods to share information across genes, making it highly effective even with small numbers of replicates. The modern recommended workflow utilizes Quasi-Likelihood (QL) methods for robust error rate control.

## Core Workflow: The QL Pipeline
The QL pipeline is the most rigorous approach for bulk RNA-seq.

```R
library(edgeR)

# 1. Data Preparation
# counts: matrix of integer counts; group: factor defining experimental conditions
y <- DGEList(counts = counts, group = group)

# 2. Filtering (removes lowly expressed genes)
keep <- filterByExpr(y)
y <- y[keep, , keep.lib.sizes = FALSE]

# 3. Normalization (TMM method)
y <- normLibSizes(y)

# 4. Design Matrix and Dispersion Estimation
design <- model.matrix(~group)
y <- estimateDisp(y, design) # Estimates common, trended, and tagwise dispersions

# 5. Model Fitting (Quasi-Likelihood)
fit <- glmQLFit(y, design)

# 6. Testing (e.g., testing the second coefficient)
qlf <- glmQLFTest(fit, coef = 2)

# 7. Results
topTags(qlf)
```

## Key Functions and Concepts

### Data Objects
- `DGEList`: The primary container for counts, sample metadata (`samples`), and gene annotation (`genes`).

### Normalization
- `normLibSizes(y)`: Calculates scaling factors (default TMM) to account for composition bias. It does not change the raw counts but adjusts the "effective" library size used in modeling.

### Dispersion Estimation
- `estimateDisp(y, design)`: The "all-in-one" function for estimating NB dispersions.
- **BCV (Biological Coefficient of Variation)**: The square root of the dispersion. Typical values: 0.4 for humans, 0.1 for genetically identical model organisms.

### Testing Frameworks
1. **QL F-test (`glmQLFit` -> `glmQLFTest`)**: Recommended for bulk RNA-seq. Accounts for uncertainty in dispersion estimates.
2. **Likelihood Ratio Test (`glmFit` -> `glmLRT`)**: Useful for single-cell data or experiments with no replicates.
3. **Exact Test (`exactTest`)**: Only for simple two-group comparisons without covariates (classic edgeR).

### Complex Designs
- **Additive Models (Blocking)**: To correct for batch effects or paired samples: `model.matrix(~Batch + Treatment)`.
- **Contrasts**: To compare specific groups (e.g., Group B vs Group C):
  ```R
  con <- makeContrasts(BvsC = GroupB - GroupC, levels = design)
  qlf <- glmQLFTest(fit, contrast = con)
  ```

### Downstream Analysis
- `plotMDS(y)`: Visualizes sample relationships (similar to PCA).
- `plotBCV(y)`: Visualizes the dispersion-mean relationship.
- `plotMD(qlf)`: Mean-Difference plot highlighting DE genes.
- `goana(qlf)` / `kegga(qlf)`: Gene Ontology and KEGG pathway enrichment.
- `glmTreat(fit, lfc = 1)`: Tests for differential expression relative to a minimum fold-change threshold.

## Tips for Success
- **Raw Counts**: Always input raw, untransformed integer counts. Do not use RPKM, FPKM, or TPM.
- **Filtering**: Always use `filterByExpr` to remove noise and improve statistical power.
- **No Replicates**: If you have no replicates, you must manually provide a `dispersion` value (e.g., `0.1` or `0.4`) to `exactTest` or `glmLRT`, as dispersion cannot be estimated from a single sample.

## Reference documentation
- [edgeR User's Guide](./references/edgeRUsersGuide.md)
- [Introduction to edgeR](./references/intro.md)