# Introduction

Constantin Ahlmann-Eltze

#### 30 October, 2025

# Contents

* [Latent Embedding Multivariate Regression (LEMUR)](#latent-embedding-multivariate-regression-lemur)
  + [Installation](#installation)
  + [Quick start](#quick-start)
  + [A worked through example](#a-worked-through-example)
* [FAQ](#faq)
* [Session Info](#session-info)

# Latent Embedding Multivariate Regression (LEMUR)

The goal of `lemur` is to simplify analysis the of multi-condition single-cell data. If you have collected a single-cell RNA-seq dataset with more than one condition, `lemur` predicts for each cell and gene how much the expression would change if the cell had been in the other condition. Furthermore, `lemur` finds neighborhoods of cells that show consistent differential expression. The results are statistically validated using a pseudo-bulk differential expression test on hold-out data using [glmGamPoi](https://bioconductor.org/packages/release/bioc/html/glmGamPoi.html) or edgeR.

`lemur` implements a novel framework to disentangle the effects of known covariates, latent cell states, and their interactions. At the core, is a combination of matrix factorization and regression analysis implemented as geodesic regression on Grassmann manifolds. We call this *latent embedding multivariate regression*. For more details see our [preprint](https://www.biorxiv.org/content/10.1101/2023.03.06.531268v1).

![](data:image/png;base64...)

Schematic of the matrix decomposition at the core of LEMUR

## Installation

You can install `lemur` directly from Bioconductor (available since version 3.18). Just paste the following snippet into your R console:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("lemur")
```

Alternatively, you can install the package from Github using `devtools`:

```
devtools::install_github("const-ae/lemur")
```

`lemur` depends on recent features from [`glmGamPoi`](https://github.com/const-ae/glmGamPoi), so make sure that `packageVersion("glmGamPoi")` is larger than `1.12.0`.

## Quick start

```
library("lemur")
library("SingleCellExperiment")

fit <- lemur(sce, design = ~ patient_id + condition, n_embedding = 15)
fit <- align_harmony(fit)   # This step is optional
fit <- test_de(fit, contrast = cond(condition = "ctrl") - cond(condition = "panobinostat"))
nei <- find_de_neighborhoods(fit, group_by = vars(patient_id, condition))
```

## A worked through example

We will demonstrate `lemur` using a dataset published by [Zhao et al. (2021)](https://doi.org/10.1186/s13073-021-00894-y). The data consist of tumor biopsies from five glioblastomas which were treated with the drug panobinostat and with a control. Accordingly, we will analyze ten samples (patient-treatment combinations) using a paired experimental design.

We start by loading some required packages.

```
library("tidyverse")
library("SingleCellExperiment")
library("lemur")
set.seed(42)
```

We use a reduced-size version of the glioblastoma data that ships with the `lemur` package.

```
data(glioblastoma_example_data)
glioblastoma_example_data
#> class: SingleCellExperiment
#> dim: 300 5000
#> metadata(0):
#> assays(2): counts logcounts
#> rownames(300): ENSG00000210082 ENSG00000118785 ... ENSG00000167468
#>   ENSG00000139289
#> rowData names(6): gene_id symbol ... strand. source
#> colnames(5000): CGCCAGAGCGCA AGCTTTACTGCG ... TGAACAGTGCGT TGACCGGAATGC
#> colData names(10): patient_id treatment_id ... sample_id id
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
```

Initially, the data separates by the known covariates `patient_id` and `condition`.

```
orig_umap <- uwot::umap(as.matrix(t(logcounts(glioblastoma_example_data))))

as_tibble(colData(glioblastoma_example_data)) %>%
  mutate(umap = orig_umap) %>%
  ggplot(aes(x = umap[,1], y = umap[,2])) +
    geom_point(aes(color = patient_id, shape = condition), size = 0.5) +
    labs(title = "UMAP of logcounts")
```

![](data:image/jpeg;base64...)

We fit the LEMUR model by calling `lemur()`. We provide the experimental design using a formula. The elements of the formula can refer to columns of the `colData` of the `SingleCellExperiment` object.

We also set the number of latent dimensions (`n_embedding`), which has a similar interpretation as the number of dimensions in PCA.

The `test_fraction` argument sets the fraction of cells which are exclusively used to test for differential expression and not for inferring the LEMUR parameters. It balances the sensitivity to detect subtle patterns in the latent space against the power to detect differentially expressed genes.

```
fit <- lemur(glioblastoma_example_data, design = ~ patient_id + condition,
             n_embedding = 15, test_fraction = 0.5)
#> Storing 50% of the data (2500 cells) as test data.
#> Regress out global effects using linear method.
#> Find base point for differential embedding
#> Fit differential embedding model
#> Initial error: 1.78e+06
#> ---Fit Grassmann linear model
#> Final error: 1.11e+06

fit
#> class: lemur_fit
#> dim: 300 5000
#> metadata(9): n_embedding design ... use_assay row_mask
#> assays(2): counts logcounts
#> rownames(300): ENSG00000210082 ENSG00000118785 ... ENSG00000167468
#>   ENSG00000139289
#> rowData names(6): gene_id symbol ... strand. source
#> colnames(5000): CGCCAGAGCGCA AGCTTTACTGCG ... TGAACAGTGCGT TGACCGGAATGC
#> colData names(10): patient_id treatment_id ... sample_id id
#> reducedDimNames(2): linearFit embedding
#> mainExpName: NULL
#> altExpNames(0):
```

The `lemur()` function returns a `lemur_fit` object which extends `SingleCellExperiment`. It supports subsetting and all the usual data accessor methods (e.g., `nrow`, `assay`, `colData`, `rowData`). In addition, `lemur` overloads the `$` operator to allow easy access to additional fields produced by the LEMUR model. For example, the low-dimensional embedding can be accessed using `fit$embedding`:

Optionally, we can further align corresponding cells using manually annotated cell types (`align_by_grouping`) or an automated alignment procedure (e.g., `align_harmony`). This ensures that corresponding cells are close to each other in the `fit$embedding`.

```
fit <- align_harmony(fit)
#> Select cells that are considered close with 'harmony'
```

I will make a UMAP of the `fit$embedding`. This is similar to working on the integrated PCA space in a traditional single-cell analysis.

```
umap <- uwot::umap(t(fit$embedding))

as_tibble(fit$colData) %>%
  mutate(umap = umap) %>%
  ggplot(aes(x = umap[,1], y = umap[,2])) +
    geom_point(aes(color = patient_id), size = 0.5) +
    facet_wrap(vars(condition)) +
    labs(title = "UMAP of latent space from LEMUR")
```

![](data:image/jpeg;base64...)

Next, we will predict the effect of the panobinostat treatment for each gene and cell. The `test_de` function takes a `lemur_fit` object and returns the object with a new assay `"DE"`. This assay contains the predicted log fold change between the conditions specified in `contrast`. Note that `lemur` implements a special notation for contrasts. Instead of providing a contrast vector or design matrix column names, you provide for each *condition* the levels, and `lemur` automatically forms the contrast vector. This makes the contrast more readable.

```
fit <- test_de(fit, contrast = cond(condition = "panobinostat") - cond(condition = "ctrl"))
```

We can pick any gene and show the differential expression pattern on the UMAP plot:

```
sel_gene <- "ENSG00000172020" # is GAP43

tibble(umap = umap) %>%
  mutate(de = assay(fit, "DE")[sel_gene,]) %>%
  ggplot(aes(x = umap[,1], y = umap[,2])) +
    geom_point(aes(color = de)) +
    scale_color_gradient2() +
    labs(title = "Differential expression on UMAP plot")
```

![](data:image/jpeg;base64...)

Alternatively, we can use the matrix of differential expression values (`assay(fit, "DE")`) to guide the selection of cell neighborhoods that show consistent differential expression. `find_de_neighborhoods` validates the results with a pseudobulked diferential expression test. For this it uses the `fit$test_data` which was put aside in the first `lemur()` call. In addition, `find_de_neighborhoods` assess if the difference between the conditions is significantly larger for the cells inside the neighborhood than the cells outside the neighborhood (see columns starting with `did`, short for difference-in-difference).

The `group_by` argument determines how the pseudobulk samples are formed. It specifies the columns in the `fit$colData` that are used to define a sample and is inspired by the `group_by` function in `dplyr`. Typically, you provide the covariates that were used for the experimental design plus the sample id (in this case `patient_id`).

```
neighborhoods <- find_de_neighborhoods(fit, group_by = vars(patient_id, condition))
#> Find optimal neighborhood using zscore.
#> Validate neighborhoods using test data
#> Form pseudobulk (summing counts)
#> Calculate size factors for each gene
#> Fit glmGamPoi model on pseudobulk data
#> Fit diff-in-diff effect

as_tibble(neighborhoods) %>%
  left_join(as_tibble(rowData(fit)[,1:2]), by = c("name" = "gene_id")) %>%
  relocate(symbol, .before = "name") %>%
  arrange(pval) %>%
  dplyr::select(symbol, neighborhood, name, n_cells, pval, adj_pval, lfc, did_lfc)
#> # A tibble: 300 × 8
#>    symbol neighborhood  name            n_cells     pval adj_pval    lfc did_lfc
#>    <chr>  <I<list>>     <chr>             <int>    <dbl>    <dbl>  <dbl>   <dbl>
#>  1 MT1X   <chr [2,410]> ENSG00000187193    2410  6.93e-6  0.00208  3.20  -0.805
#>  2 PMP2   <chr [3,880]> ENSG00000147588    3880  3.89e-5  0.00583 -1.33   0.592
#>  3 NEAT1  <chr [3,771]> ENSG00000245532    3771  2.92e-4  0.0232   1.86  -0.475
#>  4 SKP1   <chr [3,196]> ENSG00000113558    3196  3.59e-4  0.0232   0.777 -0.455
#>  5 POLR2L <chr [3,825]> ENSG00000177700    3825  3.87e-4  0.0232   1.23  -0.168
#>  6 MT1E   <chr [972]>   ENSG00000169715     972  6.74e-4  0.0285   2.40  -0.358
#>  7 CALM1  <chr [3,933]> ENSG00000198668    3933  7.22e-4  0.0285   0.805  0.142
#>  8 ATP5G3 <chr [3,733]> ENSG00000154518    3733  7.61e-4  0.0285   0.719 -0.310
#>  9 MT2A   <chr [2,430]> ENSG00000125148    2430  1.02e-3  0.0341   1.67   0.0894
#> 10 HMGB1  <chr [3,444]> ENSG00000189403    3444  1.39e-3  0.0410  -0.837  0.460
#> # ℹ 290 more rows
```

To continue, we investigate one gene for which the neighborhood shows a significant differential expression pattern: here we choose a *CXCL8* (also known as interleukin 8), an important inflammation signalling molecule. We see that it is upregulated by panobinostat in a subset of cells (blue). We chose this gene because it (1) had a significant change between panobinostat and negative control condition (`adj_pval` column) and (2) showed much larger differential expression for the cells inside the neighborhood than for the cells outside (`did_lfc` column).

```
sel_gene <- "ENSG00000169429" # is CXCL8

tibble(umap = umap) %>%
  mutate(de = assay(fit, "DE")[sel_gene,]) %>%
  ggplot(aes(x = umap[,1], y = umap[,2])) +
    geom_point(aes(color = de)) +
    scale_color_gradient2() +
    labs(title = "Differential expression on UMAP plot")
```

![](data:image/jpeg;base64...)

To plot the boundaries of the differential expression neighborhood, we create a helper dataframe and use the `geom_density2d` function from `ggplot2`. To avoid the cutting of the boundary to the extremes of the cell coordinates, add `lims` to the plot with an appropriately large limit.

```
neighborhood_coordinates <- neighborhoods %>%
  dplyr::filter(name == sel_gene) %>%
  unnest(c(neighborhood)) %>%
  dplyr::rename(cell_id = neighborhood) %>%
  left_join(tibble(cell_id = rownames(umap), umap), by = "cell_id") %>%
  dplyr::select(name, cell_id, umap)

tibble(umap = umap) %>%
  mutate(de = assay(fit, "DE")[sel_gene,]) %>%
  ggplot(aes(x = umap[,1], y = umap[,2])) +
    geom_point(aes(color = de)) +
    scale_color_gradient2() +
    geom_density2d(data = neighborhood_coordinates, breaks = 0.5,
                   contour_var = "ndensity", color = "black") +
    labs(title = "Differential expression with neighborhood boundary")
```

![](data:image/jpeg;base64...)

To summarize the results, we make a volcano plot of the differential expression results to better understand the expression differences across all genes.

```
neighborhoods %>%
  drop_na() %>%
  ggplot(aes(x = lfc, y = -log10(pval))) +
    geom_point(aes(color  = adj_pval < 0.1)) +
    labs(title = "Volcano plot of the neighborhoods")
```

![](data:image/jpeg;base64...)

```
neighborhoods %>%
  drop_na() %>%
  ggplot(aes(x = n_cells, y = -log10(pval))) +
    geom_point(aes(color  = adj_pval < 0.1)) +
    labs(title = "Neighborhood size vs neighborhood significance")
```

![](data:image/jpeg;base64...)

This analysis was conducted without using any cell type information. Often, additional cell type information is available or can be annotated manually. Here, we can for example distinguish the tumor cells from cells of the microenvironment, because the tumors had a chromosome 10 deletion and chromosome 7 duplication. We build a simple classifier to distinguish the cells accordingly. (This is just to illustrate the process; for a real analysis, we would use more sophisticated methods.)

```
tumor_label_df <- tibble(cell_id = colnames(fit),
       chr7_total_expr = colMeans(logcounts(fit)[rowData(fit)$chromosome == "7",]),
       chr10_total_expr = colMeans(logcounts(fit)[rowData(fit)$chromosome == "10",])) %>%
  mutate(is_tumor = chr7_total_expr > 0.8 & chr10_total_expr < 2.5)

ggplot(tumor_label_df, aes(x = chr10_total_expr, y = chr7_total_expr)) +
    geom_point(aes(color = is_tumor), size = 0.5) +
    geom_hline(yintercept = 0.8) +
    geom_vline(xintercept = 2.5) +
    labs(title = "Simple gating strategy to find tumor cells")
```

![](data:image/jpeg;base64...)

```
tibble(umap = umap) %>%
  mutate(is_tumor = tumor_label_df$is_tumor) %>%
  ggplot(aes(x = umap[,1], y = umap[,2])) +
    geom_point(aes(color = is_tumor), size = 0.5) +
    labs(title = "The tumor cells are enriched in parts of the big blob") +
    facet_wrap(vars(is_tumor))
```

![](data:image/jpeg;base64...)

We use the cell annotation, to focus our neighborhood finding on subpopulations of the tumor.

```
tumor_fit <- fit[, tumor_label_df$is_tumor]
tum_nei <- find_de_neighborhoods(tumor_fit, group_by = vars(patient_id, condition), verbose = FALSE)

as_tibble(tum_nei) %>%
  left_join(as_tibble(rowData(fit)[,1:2]), by = c("name" = "gene_id")) %>%
  dplyr::relocate(symbol, .before = "name") %>%
  filter(adj_pval < 0.1) %>%
  arrange(did_pval)  %>%
  dplyr::select(symbol, name, neighborhood, n_cells, adj_pval, lfc, did_pval, did_lfc) %>%
  print(n = 10)
#> # A tibble: 39 × 8
#>    symbol name            neighborhood  n_cells adj_pval    lfc did_pval did_lfc
#>    <chr>  <chr>           <I<list>>       <int>    <dbl>  <dbl>    <dbl>   <dbl>
#>  1 CCL3   ENSG00000277632 <chr [1,795]>    1795  0.0383  -2.79   0.00777   2.65
#>  2 CALM1  ENSG00000198668 <chr [2,077]>    2077  0.0160   1.02   0.00943  -0.731
#>  3 NAMPT  ENSG00000105835 <chr [1,885]>    1885  0.0383  -1.14   0.0706    1.03
#>  4 POLR2L ENSG00000177700 <chr [2,428]>    2428  0.00923  1.23   0.0787   -0.557
#>  5 A2M    ENSG00000175899 <chr [2,361]>    2361  0.0789  -1.97   0.0941    1.28
#>  6 CXCL8  ENSG00000169429 <chr [1,756]>    1756  0.0264   1.20   0.193    -0.594
#>  7 TUBA1A ENSG00000167552 <chr [2,761]>    2761  0.0782  -0.462  0.225    -0.212
#>  8 MT1X   ENSG00000187193 <chr [1,972]>    1972  0.00266  3.20   0.250    -0.674
#>  9 RPS11  ENSG00000142534 <chr [2,238]>    2238  0.0958  -0.383  0.256    -0.173
#> 10 HMGB1  ENSG00000189403 <chr [2,535]>    2535  0.0383  -0.833  0.261     0.374
#> # ℹ 29 more rows
```

Focusing on RPS11, we see that panobinostat mostly has no effect on its expression, except for a subpopulation of tumor cells where RPS11 was originally upregulated and panobinostat downregulates the expression. A small caveat: this analysis is conducted on a subset of all cells and should be interpreted carefully. Yet, this section demonstrates how `lemur` can be used to find tumor subpopulations which show differential responses to treatments.

```
sel_gene <- "ENSG00000142534" # is RPS11

as_tibble(colData(fit)) %>%
  mutate(expr = assay(fit, "logcounts")[sel_gene,]) %>%
  mutate(is_tumor = tumor_label_df$is_tumor) %>%
  mutate(in_neighborhood = id %in% filter(tum_nei, name == sel_gene)$neighborhood[[1]]) %>%
  ggplot(aes(x = condition, y = expr)) +
    geom_jitter(size = 0.3, stroke = 0) +
    geom_point(data = . %>% summarize(expr = mean(expr), .by = c(condition, patient_id, is_tumor, in_neighborhood)),
               aes(color = patient_id), size = 2) +
    stat_summary(fun.data = mean_se, geom = "crossbar", color = "red") +
    facet_wrap(vars(is_tumor, in_neighborhood), labeller = label_both)
```

![](data:image/jpeg;base64...)

# FAQ

##### I have already integrated my data using Harmony / MNN / Seurat. Can I call `lemur` directly with the aligned data?

No. You need to call `lemur` with the unaligned data so that it can learn how much the expression of each gene changes between conditions.

##### Can I call lemur with [sctransformed](https://github.com/satijalab/sctransform) instead of log-transformed data?

Yes. You can call lemur with any variance stabilized count matrix. Based on a [previous project](https://www.biorxiv.org/content/10.1101/2021.06.24.449781v4), I recommend to use log-transformation, but other methods will work just fine.

##### My data appears less integrated after calling `lemur()` than before. What is happening?!

This is a known issue and can be caused if the data has large compositional shifts (for example, if one cell type disappears). The problem is that the initial linear regression step, which centers the conditions relative to each other, overcorrects and introduces a consistent shift in the latent space. You can either use `align_by_grouping` / `align_harmony` to correct for this effect or manually fix the regression coefficient to zero:

```
fit <- lemur(sce, design = ~ patient_id + condition, n_embedding = 15, linear_coefficient_estimator = "zero")
```

##### The conditions still separate if I plot the data using UMAP / tSNE. Even after calling `align_harmony` / `align_neighbors`. What should I do?

You can try to increase `n_embedding`. If this still does not help, there is little use in inferring differential expression neighborhoods. But as I haven’t encountered such a dataset yet, I would like to try it out myself. If you can share the data publicly, please open an issue.

##### How do I make `lemur` faster?

Several parameters influence the duration to fit the LEMUR model and find differentially expressed neighborhoods:

* Make sure that your data is stored in memory (not a `DelayedArray`) either as a sparse dgCMatrix or dense matrix.
* A larger `test_fraction` means fewer cells are used to fit the model (and more cells are used for the DE test), which speeds up many steps.
* A smaller `n_embedding` reduces the latent dimensions of the fit, which makes the model less flexible, but speeds up the `lemur()` call.
* Providing a pre-calculated set of matching cells and calling `align_grouping` is faster than `align_harmony`.
* Setting `selection_procedure = "contrast"` in `find_de_neighborhoods` often produces better neighborhoods, but is a lot slower than `selection_procedure = "zscore"`.
* Setting `size_factor_method = "ratio"` in `find_de_neighborhoods` makes the DE more powerful, but is a lot slower than `size_factor_method = "normed_sum"`.

# Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] lubridate_1.9.4             forcats_1.0.1
#>  [3] stringr_1.5.2               dplyr_1.1.4
#>  [5] purrr_1.1.0                 readr_2.1.5
#>  [7] tidyr_1.3.1                 tibble_3.3.0
#>  [9] ggplot2_4.0.0               tidyverse_2.0.0
#> [11] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#> [13] Biobase_2.70.0              GenomicRanges_1.62.0
#> [15] Seqinfo_1.0.0               IRanges_2.44.0
#> [17] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [19] generics_0.1.4              MatrixGenerics_1.22.0
#> [21] matrixStats_1.5.0           lemur_1.8.0
#> [23] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1          farver_2.1.2
#>  [3] S7_0.2.0                  fastmap_1.2.0
#>  [5] digest_0.6.37             timechange_0.3.0
#>  [7] lifecycle_1.0.4           magrittr_2.0.4
#>  [9] compiler_4.5.1            rlang_1.1.6
#> [11] sass_0.4.10               tools_4.5.1
#> [13] utf8_1.2.6                yaml_2.3.10
#> [15] knitr_1.50                S4Arrays_1.10.0
#> [17] labeling_0.4.3            DelayedArray_0.36.0
#> [19] RColorBrewer_1.1-3        abind_1.4-8
#> [21] withr_3.0.2               grid_4.5.1
#> [23] beachmat_2.26.0           MASS_7.3-65
#> [25] scales_1.4.0              isoband_0.2.7
#> [27] dichromat_2.0-0.1         tinytex_0.57
#> [29] cli_3.6.5                 rmarkdown_2.30
#> [31] glmGamPoi_1.22.0          tzdb_0.5.0
#> [33] DelayedMatrixStats_1.32.0 cachem_1.1.0
#> [35] splines_4.5.1             BiocManager_1.30.26
#> [37] XVector_0.50.0            vctrs_0.6.5
#> [39] Matrix_1.7-4              jsonlite_2.0.0
#> [41] bookdown_0.45             hms_1.1.4
#> [43] irlba_2.3.5.1             magick_2.9.0
#> [45] harmony_1.2.4             jquerylib_0.1.4
#> [47] glue_1.8.0                codetools_0.2-20
#> [49] cowplot_1.2.0             uwot_0.2.3
#> [51] RcppAnnoy_0.0.22          stringi_1.8.7
#> [53] gtable_0.3.6              pillar_1.11.1
#> [55] htmltools_0.5.8.1         R6_2.6.1
#> [57] sparseMatrixStats_1.22.0  evaluate_1.0.5
#> [59] lattice_0.22-7            RhpcBLASctl_0.23-42
#> [61] bslib_0.9.0               Rcpp_1.1.0
#> [63] SparseArray_1.10.0        xfun_0.53
#> [65] pkgconfig_2.0.3
```