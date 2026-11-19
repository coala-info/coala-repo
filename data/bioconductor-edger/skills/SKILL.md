---
name: bioconductor-edger
description: This tool performs differential expression analysis of digital gene expression data using negative binomial models. Use when user asks to perform differential expression analysis, normalize read counts using TMM or a spike-in (external) normalisation, estimate dispersions, or conduct statistical testing for RNA-seq, ChIP-seq, or CRISPR screen data.
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

## Fixed external normalisation (spike-in; a global change may be real)
TMM (`normLibSizes`) assumes most features do not change. When a treatment can raise or lower
the signal everywhere (ChIP-seq of a histone mark after an inhibitor, total RNA changes), TMM
removes that global change. Use a scale measured outside the host features instead (a spike-in,
external reference or exogenous standard), as a fixed exposure per library, and learn no extra
factor from the host counts:

```r
y <- DGEList(counts)                                  # all features, unfiltered if each needs a result
y$samples$lib.size <- exposure                        # one external exposure per library
y$samples$norm.factors <- 1
y$offset <- matrix(log(exposure), nrow(y), ncol(y), byrow = TRUE)
design <- model.matrix(~ replicate + condition, data = meta)   # matched pairs: block on the pair
y <- estimateDisp(y, design, robust = TRUE)
fit <- glmQLFit(y, design, robust = TRUE)              # shares information across sparse features
res <- glmQLFTest(fit, coef = "conditionperturbed")
res$table$FDR <- p.adjust(res$table$PValue, "BH")    # BH within each experiment
```

- Tested in `quay.io/biocontainers/bioconductor-edger:4.10.7--r45h262fe30_0` on simulated
  counts with a true global loss: these offsets keep it, TMM moves the median log fold change to 0.
- A single aberrant count in one library: `estimateGLMRobustDisp(y, design)` gives observation
  weights, then `glmFit` and `glmLRT`. It needs enough replicates to tell an outlier apart.
- Effect sizes per matched pair: `cpm(y, log = TRUE, prior.count = 2)` uses the exposures, so the
  perturbed minus control difference within each pair is on the external scale. Summarise the
  pairs with a median when one pair may be bad.
- Global change: per pair, log2 of (host total / exposure) perturbed minus control; test the
  pair values with a one-sample t-test.
- ChIP-seq with spike-in chromatin and inputs: a library's exposure is proportional to its host
  input depth times its spike-in enrichment (spike-in IP over spike-in input), taken as a robust
  summary (median of region log ratios) over spike-in regions that behave alike across samples.
  Check the spike-in first: compare each library's region-wise spike-in IP/input profile with its
  matched peers; a library whose profile departs is not a sound scaling anchor, and removing it
  usually means removing its whole matched pair.

## Tips for Success
- **Raw Counts**: Always input raw, untransformed integer counts. Do not use RPKM, FPKM, or TPM.
- **Filtering**: Use `filterByExpr` to remove noise and improve statistical power, unless every feature needs a reported result.
- **No Replicates**: If you have no replicates, you must manually provide a `dispersion` value (e.g., `0.1` or `0.4`) to `exactTest` or `glmLRT`, as dispersion cannot be estimated from a single sample.

## Reference documentation
- [edgeR User's Guide](./references/edgeRUsersGuide.md)
- [Introduction to edgeR](./references/intro.md)