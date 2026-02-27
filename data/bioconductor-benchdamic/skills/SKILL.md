---
name: bioconductor-benchdamic
description: This package provides a framework for benchmarking differential abundance detection methods in microbial data through goodness of fit, error control, concordance, and enrichment analyses. Use when user asks to evaluate statistical models for microbiome data, perform type I error control using mock datasets, measure concordance between different differential abundance methods, or validate findings against biological ground truth.
homepage: https://bioconductor.org/packages/release/bioc/html/benchdamic.html
---


# bioconductor-benchdamic

## Overview

The `benchdamic` package provides a comprehensive framework for benchmarking differential abundance (DA) detection methods specifically for microbial data. It allows users to evaluate methods based on four key pillars:
1. **Goodness of Fit (GOF):** Assessing how well parametric distributions (NB, ZINB, ZIG, HURDLE, DM) fit observed counts and zeros.
2. **Type I Error Control (TIEC):** Evaluating false positive rates using mock comparisons.
3. **Concordance:** Measuring agreement between different methods (BMC) and a method's self-consistency across data splits (WMC).
4. **Enrichment:** Validating findings against *a priori* biological knowledge or simulated ground truth.

## Typical Workflow

### 1. Data Preparation
`benchdamic` works with `phyloseq` or `TreeSummarizedExperiment` objects.

```r
library(benchdamic)
data("ps_stool_16S")

# Optional: Add normalization factors
my_normalizations <- setNormalizations(fun = c("norm_edgeR", "norm_CSS"), method = c("TMM", "CSS"))
ps_stool_16S <- runNormalizations(normalization_list = my_normalizations, object = ps_stool_16S)
```

### 2. Goodness of Fit (GOF)
Evaluate which statistical model best represents your data's distribution.

```r
# Fit multiple models
gof_results <- fitModels(
    object = ps_stool_16S,
    models = c("NB", "ZINB", "DM", "ZIG", "HURDLE"),
    scale_HURDLE = "median"
)

# Visualize Mean Differences (MD) and Zero Probability Differences (ZPD)
plotMD(data = gof_results, difference = "MD", split = TRUE)
plotRMSE(gof_results, difference = "MD")
```

### 3. Type I Error Control (TIEC)
Use mock datasets (randomly shuffling group labels) to check if methods control false discoveries.

```r
# 1. Create mocks
my_mocks <- createMocks(nsamples = phyloseq::nsamples(ps_stool_16S), N = 10)

# 2. Set up DA methods to test
my_methods <- c(
    set_edgeR(group_name = "group", design = ~ group, norm = "TMM"),
    set_DESeq2(design = ~ group, contrast = c("group", "grp2", "grp1"), norm = "poscounts")
)

# 3. Run mocks
mock_da <- runMocks(mocks = my_mocks, method_list = my_methods, object = ps_stool_16S)

# 4. Evaluate TIEC
tiec_summary <- createTIEC(mock_da)
plotFPR(tiec_summary$df_FPR)
plotQQ(tiec_summary$df_QQ, zoom = c(0, 0.1))
```

### 4. Concordance Analysis
Check if different methods agree on the top-ranked features using "Concordance At the Top" (CAT).

```r
# 1. Create data splits
my_splits <- createSplits(object = ps_plaque_16S, varName = "HMP_BODY_SUBSITE", N = 5)

# 2. Run DA on splits
split_da <- runSplits(split_list = my_splits, method_list = my_methods, object = ps_plaque_16S)

# 3. Calculate and plot concordance
concordance <- createConcordance(object = split_da, slot = "pValMat", colName = "rawP")
pC <- plotConcordance(concordance = concordance, threshold = 30)
```

### 5. Enrichment Analysis
Validate DA results against known biological traits (e.g., metabolism).

```r
# 1. Run DA on the real comparison
da_results <- runDA(method_list = my_methods, object = ps_plaque_16S)

# 2. Create enrichment object with prior knowledge
# priorInfo should be a data.frame mapping taxa to a trait (e.g., "Aerobic")
enrichment <- createEnrichment(
    object = da_results,
    priorKnowledge = priorInfo,
    enrichmentCol = "Type",
    namesCol = "Genus",
    threshold_pvalue = 0.1
)

# 3. Visualize
plotEnrichment(enrichment, enrichmentCol = "Type")
plotMutualFindings(enrichment, enrichmentCol = "Type", n_methods = 2)
```

## Key Functions and Tips

- **Method Setup:** Always use `set_<method_name>` (e.g., `set_edgeR`, `set_ALDEx2`, `set_ANCOM`) to create instruction lists. This allows `runMocks`, `runSplits`, and `runDA` to execute multiple configurations efficiently.
- **Custom Methods:** You can add custom DA functions. They must return a list containing `pValMat` (with `rawP` and `adjP`), `statInfo` (with `logFC`), and `name`.
- **Weights:** Use `weights_ZINB()` to calculate observational weights that can be passed to `edgeR`, `DESeq2`, or `limma` to handle zero-inflation.
- **Parallelization:** Use `BiocParallel` parameters (e.g., `MulticoreParam()`) in `runMocks` and `runSplits`. Note: `ANCOM` methods often require `SerialParam()` due to internal parallelization.

## Reference documentation

- [An introduction to benchdamic](./references/intro.md)