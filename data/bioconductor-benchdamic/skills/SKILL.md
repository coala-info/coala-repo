---
name: bioconductor-benchdamic
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/benchdamic.html
---

# bioconductor-benchdamic

name: bioconductor-benchdamic
description: Expert guidance for the benchdamic R package to benchmark differential abundance (DA) detection methods in microbial data. Use this skill when performing Goodness of Fit (GOF) assessments, Type I Error Control (TIEC) analysis, Concordance At the Top (CAT) metrics, or Enrichment analysis for microbiome datasets.

# bioconductor-benchdamic

## Overview
The `benchdamic` package provides a comprehensive framework for benchmarking differential abundance (DA) detection methods specifically for microbial data (16S, metagenomics). It allows users to evaluate methods based on distributional assumptions (Goodness of Fit), false discovery control (Type I Error), result replicability (Concordance), and biological validity (Enrichment).

## Core Workflow

### 1. Data Preparation
`benchdamic` works with `phyloseq` or `TreeSummarizedExperiment` objects.
```R
library(benchdamic)
library(phyloseq)

# Load example data
data("ps_stool_16S")

# Optional: Add normalization factors
my_norms <- setNormalizations(fun = c("norm_edgeR", "norm_CSS"), method = c("TMM", "CSS"))
ps_stool_16S <- runNormalizations(normalization_list = my_norms, object = ps_stool_16S)
```

### 2. Goodness of Fit (GOF)
Evaluate which parametric distributions (NB, ZINB, DM, ZIG, HURDLE) best fit your data.
```R
gof_results <- fitModels(
    object = ps_stool_16S,
    models = c("NB", "ZINB", "DM", "ZIG", "HURDLE"),
    scale_HURDLE = "median"
)

# Visualize Mean Differences (MD) and Root Mean Squared Error (RMSE)
plotMD(data = gof_results, difference = "MD", split = TRUE)
plotRMSE(gof_results, difference = "MD")
```

### 3. Type I Error Control (TIEC)
Assess false positive rates using mock comparisons (randomly shuffling group labels).
```R
# 1. Create mocks
my_mocks <- createMocks(nsamples = nsamples(ps_stool_16S), N = 10) # 1000+ recommended

# 2. Define DA methods to test
my_methods <- c(
    set_edgeR(group_name = "group", design = ~ group, norm = "TMM"),
    set_DESeq2(design = ~ group, contrast = c("group", "grp2", "grp1"), norm = "poscounts")
)

# 3. Run mocks
mock_results <- runMocks(mocks = my_mocks, method_list = my_methods, object = ps_stool_16S)

# 4. Evaluate TIEC
tiec_summary <- createTIEC(mock_results)
plotFPR(df_FPR = tiec_summary$df_FPR)
plotQQ(df_QQ = tiec_summary$df_QQ, zoom = c(0, 0.1))
```

### 4. Concordance Analysis
Measure how much different methods agree with each other (Between Methods) or themselves (Within Method) using "Concordance At the Top" (CAT).
```R
# 1. Split data
my_splits <- createSplits(object = ps_plaque_16S, varName = "HMP_BODY_SUBSITE", N = 2)

# 2. Run DA on splits
split_results <- runSplits(split_list = my_splits, method_list = my_methods, object = ps_plaque_16S)

# 3. Create and plot concordance
concordance <- createConcordance(object = split_results, slot = "pValMat", colName = "rawP")
pC <- plotConcordance(concordance = concordance, threshold = 30)
```

### 5. Enrichment Analysis
Validate DA results against prior biological knowledge (e.g., aerobic vs. anaerobic metabolism).
```R
# 1. Run DA on the full dataset
da_results <- runDA(method_list = my_methods, object = ps_plaque_16S)

# 2. Test enrichment (requires a priorKnowledge data frame)
enrichment <- createEnrichment(
    object = da_results,
    priorKnowledge = my_prior_info,
    enrichmentCol = "Metabolism",
    namesCol = "Genus",
    threshold_pvalue = 0.1
)

# 3. Visualize
plotEnrichment(enrichment = enrichment, enrichmentCol = "Metabolism")
```

## Key Functions Reference
- `set_<method>`: Configures instructions for a specific DA method (e.g., `set_edgeR`, `set_ANCOM`).
- `runDA`: Executes a list of DA methods on a single dataset.
- `weights_ZINB`: Computes observational weights to handle zero-inflation in GLM frameworks.
- `createPositives`: Compares DA results to a "ground truth" (simulated or prior knowledge) to calculate TP/FP differences.

## Reference documentation
- [An introduction to benchdamic](./references/intro.Rmd)