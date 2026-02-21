# distinct: a method for differential analyses via hierarchical permutation tests

Simone Tiberi1,2\*

1Institute for Molecular Life Sciences, University of Zurich, Switzerland
2SIB Swiss Institute of Bioinformatics, University of Zurich, Switzerland

\*simone.tiberi@uzh.ch

#### 10/29/2025

#### Package

distinct 1.22.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Bioconductor installation](#bioconductor-installation)
* [2 Differential State analysis](#differential-state-analysis)
  + [2.1 Input data](#input-data)
  + [2.2 Differential analyses within sub-populations of cells](#differential-analyses-within-sub-populations-of-cells)
    - [2.2.1 Handling covariates and batch effects](#handling-covariates-and-batch-effects)
  + [2.3 Visualizing results](#visualizing-results)
  + [2.4 Plotting significant results](#plotting-significant-results)

---

# 1 Introduction

*distinct* is a statistical method to perform differential testing between two or more groups of distributions; differential testing is performed via hierarchical non-parametric permutation tests on the cumulative distribution functions (cdfs) of each sample.
While most methods for differential expression target differences in the mean abundance between conditions, *distinct*, by comparing full cdfs, identifies, both, differential patterns involving changes in the mean, as well as more subtle variations that do not involve the mean (e.g., unimodal vs. bi-modal distributions with the same mean).
*distinct* is a general and flexible tool: due to its fully non-parametric nature, which makes no assumptions on how the data was generated, it can be applied to a variety of datasets.
It is particularly suitable to perform differential state analyses on single cell data (e.g., differential analyses within sub-populations of cells), such as single cell RNA sequencing (scRNA-seq) and high-dimensional flow or mass cytometry (HDCyto) data.

At present, covariates are not allowed, and only 2-group comparisons are implemented.
In future releases, we will allow for covariates and for differential testing between more than 2 groups.

A pre-print will follow in the coming months.

To access the R code used in the vignettes, type:

```
browseVignettes("distinct")
```

Questions relative to *distinct* should be reported as a new issue at *[BugReports](https://github.com/SimoneTiberi/distinct/issues)*.

To cite *distinct*, type:

```
citation("distinct")
```

## 1.1 Bioconductor installation

*distinct* is available on [Bioconductor](https://bioconductor.org/packages/distinct) and can be installed with the command:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
  install.packages("BiocManager")
BiocManager::install("distinct")
```

# 2 Differential State analysis

Differential state analyses aim at investigating differential patterns between conditions in sub-populations of cells.
To use *distinct* one needs data from two or more groups of samples (i.e., experimental conditions), with at least 2 samples (i.e., biological replicates) per group.
Given a single-cell RNA-sequencing (scRNA-seq) or a high dimensional flow or mass cytometry (HDCyto) dataset, cells need first to be clustered in groups via some form of clustering algorithms; *distinct* is then applied to identify differential patterns between groups, within each cluster of cells.

## 2.1 Input data

Load the example dataset, consisting of a subset of 6 samples (3 individuals observed across 2 conditions) and 100 genes selected from the `Kang18_8vs8()` object of the *muscData* package.

```
library(SingleCellExperiment)
data("Kang_subset", package = "distinct")
Kang_subset
```

```
## class: SingleCellExperiment
## dim: 100 9517
## metadata(1): experiment_info
## assays(2): logcounts cpm
## rownames(100): ISG15 SYF2 ... MX2 PDXK
## rowData names(0):
## colnames: NULL
## colData names(3): stim cell sample_id
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

Columns `ind` and `stim` of the `colData` indicate the indivual id and the experimental condition (control or stimulated) of each cell, while column `sample_id` shows the sample id, needed for the differential anlyses.
Column `cell` represents the cell type, which defines the clustering structure of cells: differential testing between conditions is performed separately for each cluster of cells.
Note that, if cell clustering label was unknown, we would need to cluster cells into groups via some clustering algorithm.

```
colData(Kang_subset)
```

```
## DataFrame with 9517 rows and 3 columns
##          stim            cell sample_id
##      <factor>        <factor>  <factor>
## 1        ctrl CD4 T cells     ctrl_107
## 2        ctrl CD14+ Monocytes ctrl_1015
## 3        ctrl NK cells        ctrl_1015
## 4        ctrl CD4 T cells     ctrl_107
## 5        ctrl CD14+ Monocytes ctrl_1015
## ...       ...             ...       ...
## 9513     stim CD14+ Monocytes stim_1015
## 9514     stim CD4 T cells     stim_101
## 9515     stim CD14+ Monocytes stim_101
## 9516     stim CD14+ Monocytes stim_107
## 9517     stim CD4 T cells     stim_107
```

The experimental design compares two groups (stim vs ctrl) with 3 biological replicates each.

```
Kang_subset@metadata$experiment_info
```

```
##   sample_id stim
## 1  ctrl_107 ctrl
## 2 ctrl_1015 ctrl
## 3  ctrl_101 ctrl
## 4  stim_101 stim
## 5 stim_1015 stim
## 6  stim_107 stim
```

## 2.2 Differential analyses within sub-populations of cells

Load *distinct*.

```
library(distinct)
```

Create the design of the study:

```
samples = Kang_subset@metadata$experiment_info$sample_id
group = Kang_subset@metadata$experiment_info$stim
design = model.matrix(~group)
# rownames of the design must indicate sample ids:
rownames(design) = samples
design
```

```
##           (Intercept) groupstim
## ctrl_107            1         0
## ctrl_1015           1         0
## ctrl_101            1         0
## stim_101            1         1
## stim_1015           1         1
## stim_107            1         1
## attr(,"assign")
## [1] 0 1
## attr(,"contrasts")
## attr(,"contrasts")$group
## [1] "contr.treatment"
```

Perform differential state testing between conditions.
Parameter `name_assays_expression` specifies the input data (logcounts) in `assays(x)`, while `name_cluster` and `name_sample` define the column names of `colData(x)` containing the clustering of cells (cell) and the id of individual samples (sample\_id).
The group we would like to test for is in the second column of the design, therefore we will specify: column\_to\_test = 2.

Note that the sample names in `colData(x)$name_sample` have to be the same ones as those in `rownames(design)` (although not necessarily in the same order).

```
rownames(design)
```

```
## [1] "ctrl_107"  "ctrl_1015" "ctrl_101"  "stim_101"  "stim_1015" "stim_107"
```

```
unique(colData(Kang_subset)$sample_id)
```

```
## [1] ctrl_107  ctrl_1015 ctrl_101  stim_101  stim_1015 stim_107
## Levels: ctrl_101 ctrl_1015 ctrl_107 stim_101 stim_1015 stim_107
```

In order to obtain a finer ranking for the most significant genes, if computational resources are available, we encourage users to increase `P_4` (i.e., the number of permutations when a raw p-value is < 0.001) and set `P_4 = 20,000` (by default `P_4 = 10,000`).

We strongly encourage using normalized data, such as counts per million (CPM) or log2-CPM (e.g., `logcounts` as created via `scater::logNormCounts`).

```
set.seed(61217)

res = distinct_test(x = Kang_subset,
                    name_assays_expression = "logcounts",
                    name_cluster = "cell",
                    name_sample = "sample_id",
                    design = design,
                    column_to_test = 2,
                    min_non_zero_cells = 20,
                    n_cores = 2)
```

```
## 2 groups of samples provided
```

```
## Data loaded, starting differential testing
```

```
## Differential testing completed, returning results
```

### 2.2.1 Handling covariates and batch effects

Covariates (such as batch effects), if present, can be added to the design matrix.
In each cluster of cells, we fit a linear model, with covariates as predictors, and regress them out by performing differential analyeses on the residuals.
By separately fitting a linear model on each cluster, we allow the effect of covariates to vary from cluster to cluster.

When specifying covariates, we highly recommend using log-normalized data, such as log2-CPMs (e.g., `logcounts` as created via `scater::logNormCounts`), because it is generally assumed that covariates (and particularly batch effects) have an approximately linear effect on the log or log2 scale of counts.

Assume samples are associated to three different batches; we modify the design to also include batches.

```
batch = factor(c("A", "B", "C", "A", "B", "C"))

design = model.matrix(~group + batch)
# rownames of the design must indicate sample ids:
rownames(design) = samples
design
```

```
##           (Intercept) groupstim batchB batchC
## ctrl_107            1         0      0      0
## ctrl_1015           1         0      1      0
## ctrl_101            1         0      0      1
## stim_101            1         1      0      0
## stim_1015           1         1      1      0
## stim_107            1         1      0      1
## attr(,"assign")
## [1] 0 1 2 2
## attr(,"contrasts")
## attr(,"contrasts")$group
## [1] "contr.treatment"
##
## attr(,"contrasts")$batch
## [1] "contr.treatment"
```

We proceed as before to perform differential testing.
Again, we specify the column of the design to be tested via `column_to_test = 2`.

```
set.seed(61217)

res_batches = distinct_test(x = Kang_subset,
                            name_assays_expression = "logcounts",
                            name_cluster = "cell",
                            name_sample = "sample_id",
                            design = design,
                            column_to_test = 2,
                            min_non_zero_cells = 20,
                            n_cores = 2)
```

```
## 2 groups of samples provided
```

```
## Covariates detected
```

```
## Data loaded, starting differential testing
```

```
## Differential testing completed, returning results
```

## 2.3 Visualizing results

Results are reported as a `data.frame`, where columns `gene` and `cluster_id` contain the gene and cell-cluster name, while `p_val`, `p_adj.loc` and `p_adj.glb` report the raw p-values, locally and globally adjusted p-values, via Benjamini and Hochberg (BH) correction.
In locally adjusted p-values (`p_adj.loc`) BH correction is applied in each cluster separately, while in globally adjusted p-values (`p_adj.glb`) BH correction is performed to the results from all clusters.

We can further compute the fold change (FC) and log2-FC between groups.
To compute FCs, use normalized data, such as CPMs; do not use logarithm transformed data (e.g., logcounts).

```
res = log2_FC(res = res,
              x = Kang_subset,
              name_assays_expression = "cpm",
              name_group = "stim",
              name_cluster = "cell")
```

```
## FC and log2_FC computed, returning results
```

`log2_FC` computes the log-FC between the first and the second level of the group id, in this case beween controls (numerator) and stimulated samples (denominator).

```
levels(colData(Kang_subset)$stim)
```

```
## [1] "ctrl" "stim"
```

```
head(res[,9:10], 3)
```

```
##   FC_ctrl/stim log2FC_ctrl/stim
## 1   0.02309151       -5.4364934
## 2   1.16891993        0.2251761
## 3   1.26131602        0.3349298
```

To use a different level (i.e., stim/ctrl), we can reorder the levels before running `log2_FC2`.

```
# set "stim" as 1st level:
colData(Kang_subset)$stim = relevel(colData(Kang_subset)$stim, "stim")
levels(colData(Kang_subset)$stim)
```

```
## [1] "stim" "ctrl"
```

```
res_2 = log2_FC(res = res,
              x = Kang_subset,
              name_assays_expression = "cpm",
              name_group = "stim",
              name_cluster = "cell")
```

```
## 'res' already contains columns 'FC' and/or 'log2FC': they will be overwritten
```

```
## FC and log2_FC computed, returning results
```

```
head(res_2[,9:10], 3)
```

```
##   FC_stim/ctrl log2FC_stim/ctrl
## 1   43.3059524        5.4364934
## 2    0.8554906       -0.2251761
## 3    0.7928227       -0.3349298
```

We can visualize significant results via `top_results` function.

```
head(top_results(res))
```

```
##     gene cluster_id     p_val   p_adj.loc   p_adj.glb filtered mean_ctrl
## 1  ISG15    B cells 9.999e-05 0.001224878 0.000731038    FALSE  198.0569
## 41 POLD2    B cells 9.999e-05 0.001224878 0.000731038    FALSE  129.3231
## 49  RPL7    B cells 9.999e-05 0.001224878 0.000731038    FALSE 6330.3843
## 57  SPI1    B cells 9.999e-05 0.001224878 0.000731038    FALSE  159.7687
## 61 PRDX5    B cells 9.999e-05 0.001224878 0.000731038    FALSE  382.3718
## 72 PSME2    B cells 9.999e-05 0.001224878 0.000731038    FALSE  668.6966
##     mean_stim FC_ctrl/stim log2FC_ctrl/stim
## 1  8577.04339   0.02309151       -5.4364934
## 41   51.37722   2.51712882        1.3317791
## 49 4537.11929   1.39524308        0.4805165
## 57   21.60257   7.39582088        2.8867103
## 61  136.40614   2.80318652        1.4870677
## 72 1574.42658   0.42472389       -1.2354028
```

We can also visualize significant results for a specific cluster of cells.

```
top_results(res, cluster = "Dendritic cells")
```

```
##       gene      cluster_id      p_val   p_adj.loc   p_adj.glb filtered
## 401  ISG15 Dendritic cells 0.00009999 0.001549845 0.000731038    FALSE
## 449   RPL7 Dendritic cells 0.00009999 0.001549845 0.000731038    FALSE
## 472  PSME2 Dendritic cells 0.00009999 0.001549845 0.000731038    FALSE
## 499    MX2 Dendritic cells 0.00009999 0.001549845 0.000731038    FALSE
## 417 ARID5A Dendritic cells 0.00069993 0.008679132 0.004264388    FALSE
##      mean_ctrl  mean_stim FC_ctrl/stim log2FC_ctrl/stim
## 401  262.99661 21085.0630   0.01247312       -6.3250333
## 449 3568.75526  2156.7050   1.65472570        0.7265921
## 472  785.99389  2291.2623   0.34303968       -1.5435526
## 499   41.46270   502.7550   0.08247097       -3.5999698
## 417   37.40927   181.3747   0.20625400       -2.2775060
```

By default, results from ‘top\_results’ are sorted by (globally) adjusted p-value; they can also be sorted by log2-FC.

```
top_results(res, cluster = "Dendritic cells", sort_by = "log2FC")
```

```
##       gene      cluster_id      p_val   p_adj.loc   p_adj.glb filtered
## 401  ISG15 Dendritic cells 0.00009999 0.001549845 0.000731038    FALSE
## 499    MX2 Dendritic cells 0.00009999 0.001549845 0.000731038    FALSE
## 417 ARID5A Dendritic cells 0.00069993 0.008679132 0.004264388    FALSE
## 472  PSME2 Dendritic cells 0.00009999 0.001549845 0.000731038    FALSE
## 449   RPL7 Dendritic cells 0.00009999 0.001549845 0.000731038    FALSE
##      mean_ctrl  mean_stim FC_ctrl/stim log2FC_ctrl/stim
## 401  262.99661 21085.0630   0.01247312       -6.3250333
## 499   41.46270   502.7550   0.08247097       -3.5999698
## 417   37.40927   181.3747   0.20625400       -2.2775060
## 472  785.99389  2291.2623   0.34303968       -1.5435526
## 449 3568.75526  2156.7050   1.65472570        0.7265921
```

We can further filter results to visualize significant up- or down-regulated results only.
Here we visualize the down-regulated gene-cluster results; i.e., results with lower expression in ‘ctlr’ group compared to ‘stim’.

```
top_results(res, up_down = "down",
            cluster = "Dendritic cells")
```

```
##       gene      cluster_id      p_val   p_adj.loc   p_adj.glb filtered
## 401  ISG15 Dendritic cells 0.00009999 0.001549845 0.000731038    FALSE
## 472  PSME2 Dendritic cells 0.00009999 0.001549845 0.000731038    FALSE
## 499    MX2 Dendritic cells 0.00009999 0.001549845 0.000731038    FALSE
## 417 ARID5A Dendritic cells 0.00069993 0.008679132 0.004264388    FALSE
##     mean_ctrl  mean_stim FC_ctrl/stim log2FC_ctrl/stim
## 401 262.99661 21085.0630   0.01247312        -6.325033
## 472 785.99389  2291.2623   0.34303968        -1.543553
## 499  41.46270   502.7550   0.08247097        -3.599970
## 417  37.40927   181.3747   0.20625400        -2.277506
```

## 2.4 Plotting significant results

Density plot of one significant gene (ISG15) in `Dendritic cells` cluster.

```
plot_densities(x = Kang_subset,
               gene = "ISG15",
               cluster = "Dendritic cells",
               name_assays_expression = "logcounts",
               name_cluster = "cell",
               name_sample = "sample_id",
               name_group = "stim")
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the distinct package.
##   Please report the issue at <https://github.com/SimoneTiberi/distinct/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

Instead of one curve per sample, we can also plot aggregated group-level curves by setting `group_level = TRUE`.

```
plot_densities(x = Kang_subset,
               gene = "ISG15",
               cluster = "Dendritic cells",
               name_assays_expression = "logcounts",
               name_cluster = "cell",
               name_sample = "sample_id",
               name_group = "stim",
               group_level = TRUE)
```

![](data:image/png;base64...)

CDF plot of one significant gene (ISG15) in `Dendritic cells` cluster.

```
plot_cdfs(x = Kang_subset,
          gene = "ISG15",
          cluster = "Dendritic cells",
          name_assays_expression = "logcounts",
          name_cluster = "cell",
          name_sample = "sample_id",
          name_group = "stim")
```

![](data:image/png;base64...)

Violin plots of significant genes in `Dendritic cells` cluster.

```
# select cluster of cells:
cluster = "Dendritic cells"
sel_cluster = res$cluster_id == cluster
sel_column = Kang_subset$cell == cluster

# select significant genes:
sel_genes = res$p_adj.glb < 0.01
genes = as.character(res$gene[sel_cluster & sel_genes])

# make violin plots:
library(scater)
```

```
## Loading required package: scuttle
```

```
## Loading required package: ggplot2
```

```
plotExpression(Kang_subset[,sel_column],
               features = genes, exprs_values = "logcounts",
               log2_values = FALSE,
               x = "sample_id", colour_by = "stim", ncol = 3) +
  guides(fill = guide_legend(override.aes = list(size = 5, alpha = 1))) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
```

![](data:image/png;base64...)

Visualize the concordance of differential results between cell clusters.
We select as significant genes with globally adjusted p-value below 0.01.

```
library(UpSetR)
res_by_cluster = split( ifelse(res$p_adj.glb < 0.01, 1, 0), res$cluster_id)
upset(data.frame(do.call(cbind, res_by_cluster)), nsets = 10, nintersects = 20)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the UpSetR package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
## ℹ Please use the `linewidth` argument instead.
## ℹ The deprecated feature was likely used in the UpSetR package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)
# Session info

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] UpSetR_1.4.0                scater_1.38.0
##  [3] ggplot2_4.0.0               scuttle_1.20.0
##  [5] distinct_1.22.0             SingleCellExperiment_1.32.0
##  [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [9] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [11] IRanges_2.44.0              S4Vectors_0.48.0
## [13] BiocGenerics_0.56.0         generics_0.1.4
## [15] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [17] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1    viridisLite_0.4.2   dplyr_1.1.4
##  [4] vipor_0.4.7         farver_2.1.2        viridis_0.6.5
##  [7] S7_0.2.0            fastmap_1.2.0       digest_0.6.37
## [10] rsvd_1.0.5          lifecycle_1.0.4     statmod_1.5.1
## [13] magrittr_2.0.4      compiler_4.5.1      rlang_1.1.6
## [16] sass_0.4.10         rngtools_1.5.2      tools_4.5.1
## [19] yaml_2.3.10         knitr_1.50          S4Arrays_1.10.0
## [22] labeling_0.4.3      doRNG_1.8.6.2       DelayedArray_0.36.0
## [25] plyr_1.8.9          RColorBrewer_1.1-3  abind_1.4-8
## [28] BiocParallel_1.44.0 withr_3.0.2         grid_4.5.1
## [31] beachmat_2.26.0     scales_1.4.0        iterators_1.0.14
## [34] dichromat_2.0-0.1   tinytex_0.57        cli_3.6.5
## [37] rmarkdown_2.30      crayon_1.5.3        ggbeeswarm_0.7.2
## [40] cachem_1.1.0        parallel_4.5.1      BiocManager_1.30.26
## [43] XVector_0.50.0      vctrs_0.6.5         Matrix_1.7-4
## [46] jsonlite_2.0.0      bookdown_0.45       BiocSingular_1.26.0
## [49] BiocNeighbors_2.4.0 ggrepel_0.9.6       irlba_2.3.5.1
## [52] beeswarm_0.4.0      magick_2.9.0        foreach_1.5.2
## [55] limma_3.66.0        jquerylib_0.1.4     glue_1.8.0
## [58] codetools_0.2-20    cowplot_1.2.0       gtable_0.3.6
## [61] ScaledMatrix_1.18.0 tibble_3.3.0        pillar_1.11.1
## [64] htmltools_0.5.8.1   R6_2.6.1            doParallel_1.0.17
## [67] evaluate_1.0.5      lattice_0.22-7      bslib_0.9.0
## [70] Rcpp_1.1.0          gridExtra_2.3       SparseArray_1.10.0
## [73] xfun_0.53           pkgconfig_2.0.3
```