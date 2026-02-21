# Tranferable Omics Pediction

Harry Robertson1,2,3, Nicholas Robertson1,2 and Ellis Patrick1,2,3

1Centre for Precision Data Science, University of Sydney, Australia
2School of Mathematics and Statistics, University of Sydney, Australia
3Westmead Institute for Medical Research, University of Sydney, Australia

#### 30 October 2025

# Contents

* [1 Installation](#installation)
* [2 Overview](#overview)
* [3 Loading example data](#loading-example-data)
* [4 Building a survival model.](#building-a-survival-model.)
* [5 Common genes between datasets](#common-genes-between-datasets)
* [6 Survival samples](#survival-samples)
* [7 Preparing data for modelling.](#preparing-data-for-modelling.)
* [8 Visualising performance.](#visualising-performance.)
* [9 sessionInfo](#sessioninfo)

```
suppressPackageStartupMessages({
  library(tidyverse)
  library(survival)
  library(dplyr)
  library(survminer)
  library(Biobase)
  library(ggsci)
  library(ggbeeswarm)
  library(TOP)
  library(curatedOvarianData)
})

theme_set(theme_bw())
```

# 1 Installation

```
# Install the package from Bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
BiocManager::install("TOP")
```

# 2 Overview

The TOP R package provides a transfer learning approach for building predictive models across multiple omics datasets. With the increasing availability of omics data, there is a growing need for methods that can effectively integrate and analyze data from multiple sources. However, merging datasets can be challenging due to batch effects and other sources of variation.

TOP uses transfer learning strategies to build predictive models that can be applied across multiple datasets without the need for extensive batch correction methods. Specifically, TOP employs a lasso regression model to identify important features and construct a transferable predictive model. By leveraging information from multiple datasets, TOP can improve predictive accuracy and identify common biomarkers across different omics datasets.

The package provides several functions for building and evaluating transfer learning models, including options for visualizing results. Additionally, the package includes sample datasets and detailed documentation to help users get started with the package and understand the underlying methods.

Overall, TOP offers a flexible and powerful approach for integrating and analyzing omics data from multiple sources, making it a valuable tool for researchers in a variety of fields.

# 3 Loading example data

The example data used in this vignette is the curatedOvarianData. Described in the paper from [Benjamin Frederick Ganzfried et al (2013)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3625954/)

```
data("GSE12418_eset", package = "curatedOvarianData")
data("GSE30009_eset", package = "curatedOvarianData")
```

# 4 Building a survival model.

The transferable omics prediction framework is also able to build survival models. In this section, we will demonstrate how to use TOP to build a survival model using example ovarian cancer datasets. First we utilise nine datasets that were preparred by Ganzfield et al.

```
data("GSE32062.GPL6480_eset")
japan_a <- GSE32062.GPL6480_eset

data("GSE9891_eset")
tothill <- GSE9891_eset

data("GSE32063_eset")
japan_b <- GSE32063_eset

data("TCGA.RNASeqV2_eset")
selection <- TCGA.RNASeqV2_eset$tumorstage %in% c(3, 4) & TCGA.RNASeqV2_eset$site_of_tumor_first_recurrence == "metastasis"
selection[is.na(selection)] <- FALSE
tcgarnaseq <- TCGA.RNASeqV2_eset[, selection]

data("E.MTAB.386_eset")
bentink <- E.MTAB.386_eset

data("GSE13876_eset")
crijns <- GSE13876_eset
crijns <- crijns[, crijns$grade %in% c(3, 4)]

data("GSE18520_eset")
mok <- GSE18520_eset

data("GSE17260_eset")
yoshihara2010 <- GSE17260_eset

data("GSE26712_eset")
bonome <- GSE26712_eset

list_ovarian_eset <- lst(
  japan_a, tothill, japan_b,
  tcgarnaseq, bonome, mok, yoshihara2010,
  bentink, crijns
)

list_ovarian_eset %>%
  sapply(dim)
#>          japan_a tothill japan_b tcgarnaseq bonome   mok yoshihara2010 bentink
#> Features   20106   19816   20106      20502  13104 19816         20106   10357
#> Samples      260     285      40         51    195    63           110     129
#>          crijns
#> Features  20577
#> Samples      85
```

# 5 Common genes between datasets

In order to apply the TOP framework, it is important that the input matrices have identical feature names, such as gene names, across all datasets. In this example, we will identify the common genes present in all the datasets, as these will be the features used for transfer learning.

```
raw_gene_list <- purrr::map(list_ovarian_eset, rownames)
common_genes <- Reduce(f = intersect, x = raw_gene_list)
length(common_genes)
#> [1] 7517
```

# 6 Survival samples

Next, we will prepare the survival data from each of the ovarian cancer datasets. The survival data includes the survival time and the event status (i.e., whether the event of interest, such as death, has occurred)

```
ov_pdata <- purrr::map(list_ovarian_eset, pData)
list_pdata <- list_ovarian_eset %>%
  purrr::map(pData) %>%
  purrr::map(tibble::rownames_to_column, var = "sample_id")

ov_surv_raw <- purrr::map(
  .x = list_pdata,
  .f = ~ data.frame(
    sample_id = .x$sample_id,
    time = .x$days_to_death %>% as.integer(),
    dead = ifelse(.x$vital_status == "deceased", 1, 0)
  ) %>%
    na.omit() %>%
    dplyr::filter(
      time > 0,
      !is.nan(time),
      !is.nan(dead)
    )
)
ov_surv_raw %>% sapply(nrow)
#>       japan_a       tothill       japan_b    tcgarnaseq        bonome
#>           260           276            40            51           185
#>           mok yoshihara2010       bentink        crijns
#>            53           110           129            85
ov_surv_y <- ov_surv_raw %>%
  purrr::map(~ .x %>%
    dplyr::select(-sample_id)) %>%
  purrr::map(~ Surv(time = .x$time, event = .x$dead))
```

# 7 Preparing data for modelling.

In this section, we will prepare the gene expression data and survival data for visualization. We will subset the gene expression data to include only the common genes and samples with survival information. Then, we will create a combined survival data table, with a data\_source column to identify the origin of each sample. Finally we plot the distribution of survival times across datasets.

```
ov_surv_exprs <- purrr::map2(
  .x = list_ovarian_eset,
  .y = ov_surv_raw,
  .f = ~ exprs(.x[common_genes, .y$sample_id])
)

ov_surv_tbl <- ov_surv_raw %>%
  bind_rows(.id = "data_source")
ov_surv_tbl %>%
  ggplot(aes(
    x = time,
    y = ..density..,
    fill = data_source
  )) +
  geom_density(alpha = 0.25) +
  scale_fill_d3()
#> Warning: The dot-dot notation (`..density..`) was deprecated in ggplot2 3.4.0.
#> ℹ Please use `after_stat(density)` instead.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)
# Building a TOP survival model.
In this section, we will build the survival model using the TOP framework. To do this, we will first organize the survival data and gene expression data into appropriate data structures. Then, we will apply the `TOP_survival` function to build the model, specifying the number of features to be selected by the lasso regression.

```
surv_list <- ov_surv_tbl %>%
  split(ov_surv_tbl$data_source)
surv_list <- lapply(surv_list, function(x) x[, 3:4])

surv_counts <- ov_surv_exprs %>% lapply(t)
surv_list <- surv_list[names(surv_counts)]
surv_model <- TOP_survival(
  x_list = surv_counts, y_list = surv_list, nFeatures = 10
)
```

# 8 Visualising performance.

Once we have built the survival model using the TOP framework, it is important to evaluate its performance. In this section, we will visualize the performance of the model by calculating the concordance index (C-index) for each dataset. The C-index measures the agreement between the predicted and observed survival times, with values ranging from 0 to 1,

```
conf_results <- unlist(lapply(seq_along(surv_counts), function(x) {
  Surv_TOP_CI(
    surv_model,
    newx = surv_counts[[x]], newy = surv_list[[x]]
  )$concordance
}))

conf_results %>%
  tibble::enframe() %>%
  mutate(Metric = "C-index") %>%
  ggplot(aes(y = value, x = Metric)) +
  geom_boxplot(width = 0.5) +
  ylab("C-index") +
  geom_jitter(alpha = 0.7, width = 0.1) +
  theme(axis.text.x = element_blank()) +
  xlab("Survival Model")
```

![](data:image/png;base64...)

# 9 sessionInfo

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#>  [1] curatedOvarianData_1.47.2 TOP_1.10.0
#>  [3] ggbeeswarm_0.7.2          ggsci_4.1.0
#>  [5] Biobase_2.70.0            BiocGenerics_0.56.0
#>  [7] generics_0.1.4            survminer_0.5.1
#>  [9] ggpubr_0.6.2              survival_3.8-3
#> [11] lubridate_1.9.4           forcats_1.0.1
#> [13] stringr_1.5.2             dplyr_1.1.4
#> [15] purrr_1.1.0               readr_2.1.5
#> [17] tidyr_1.3.1               tibble_3.3.0
#> [19] ggplot2_4.0.0             tidyverse_2.0.0
#> [21] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] splines_4.5.1               latex2exp_0.9.6
#>   [3] polyclip_1.10-7             hardhat_1.4.2
#>   [5] pROC_1.19.0.1               rpart_4.1.24
#>   [7] lifecycle_1.0.4             rstatix_0.7.3
#>   [9] doParallel_1.0.17           globals_0.18.0
#>  [11] lattice_0.22-7              MASS_7.3-65
#>  [13] MultiAssayExperiment_1.36.0 backports_1.5.0
#>  [15] magrittr_2.0.4              plotly_4.11.0
#>  [17] limma_3.66.0                Hmisc_5.2-4
#>  [19] sass_0.4.10                 rmarkdown_2.30
#>  [21] jquerylib_0.1.4             yaml_2.3.10
#>  [23] doRNG_1.8.6.2               ClassifyR_3.14.0
#>  [25] dcanr_1.26.0                RColorBrewer_1.1-3
#>  [27] abind_1.4-8                 GenomicRanges_1.62.0
#>  [29] ggraph_2.2.2                nnet_7.3-20
#>  [31] tweenr_2.0.3                ipred_0.9-15
#>  [33] lava_1.8.1                  IRanges_2.44.0
#>  [35] KMsurv_0.1-6                S4Vectors_0.48.0
#>  [37] ggrepel_0.9.6               listenv_0.9.1
#>  [39] parallelly_1.45.1           codetools_0.2-20
#>  [41] DelayedArray_0.36.0         ggforce_0.5.0
#>  [43] shape_1.4.6.1               tidyselect_1.2.1
#>  [45] farver_2.1.2                viridis_0.6.5
#>  [47] matrixStats_1.5.0           stats4_4.5.1
#>  [49] base64enc_0.1-3             Seqinfo_1.0.0
#>  [51] jsonlite_2.0.0              caret_7.0-1
#>  [53] tidygraph_1.3.1             Formula_1.2-5
#>  [55] iterators_1.0.14            foreach_1.5.2
#>  [57] tools_4.5.1                 ggnewscale_0.5.2
#>  [59] Rcpp_1.1.0                  glue_1.8.0
#>  [61] prodlim_2025.04.28          gridExtra_2.3
#>  [63] SparseArray_1.10.0          BiocBaseUtils_1.12.0
#>  [65] xfun_0.53                   MatrixGenerics_1.22.0
#>  [67] ggthemes_5.1.0              withr_3.0.2
#>  [69] BiocManager_1.30.26         fastmap_1.2.0
#>  [71] digest_0.6.37               timechange_0.3.0
#>  [73] R6_2.6.1                    colorspace_2.1-2
#>  [75] dichromat_2.0-0.1           directPA_1.5.1
#>  [77] calibrate_1.7.7             data.table_1.17.8
#>  [79] recipes_1.3.1               class_7.3-23
#>  [81] httr_1.4.7                  graphlayouts_1.2.2
#>  [83] htmlwidgets_1.6.4           S4Arrays_1.10.0
#>  [85] ModelMetrics_1.2.2.2        pkgconfig_2.0.3
#>  [87] gtable_0.3.6                timeDate_4051.111
#>  [89] S7_0.2.0                    XVector_0.50.0
#>  [91] survMisc_0.5.6              htmltools_0.5.8.1
#>  [93] carData_3.0-5               bookdown_0.45
#>  [95] scales_1.4.0                ggupset_0.4.1
#>  [97] gower_1.0.2                 knitr_1.50
#>  [99] km.ci_0.5-6                 rstudioapi_0.17.1
#> [101] tzdb_0.5.0                  reshape2_1.4.4
#> [103] checkmate_2.3.3             nlme_3.1-168
#> [105] cachem_1.1.0                zoo_1.8-14
#> [107] parallel_4.5.1              vipor_0.4.7
#> [109] foreign_0.8-90              pillar_1.11.1
#> [111] grid_4.5.1                  vctrs_0.6.5
#> [113] car_3.1-3                   xtable_1.8-4
#> [115] cluster_2.1.8.1             beeswarm_0.4.0
#> [117] htmlTable_2.4.3             evaluate_1.0.5
#> [119] magick_2.9.0                tinytex_0.57
#> [121] cli_3.6.5                   compiler_4.5.1
#> [123] crayon_1.5.3                rlang_1.1.6
#> [125] rngtools_1.5.2              future.apply_1.20.0
#> [127] ggsignif_0.6.4              labeling_0.4.3
#> [129] plyr_1.8.9                  stringi_1.8.7
#> [131] viridisLite_0.4.2           BiocParallel_1.44.0
#> [133] assertthat_0.2.1            lazyeval_0.2.2
#> [135] glmnet_4.1-10               Matrix_1.7-4
#> [137] hms_1.1.4                   future_1.67.0
#> [139] statmod_1.5.1               SummarizedExperiment_1.40.0
#> [141] igraph_2.2.1                broom_1.0.10
#> [143] memoise_2.0.1               bslib_0.9.0
```