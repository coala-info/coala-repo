# The auxiliary commands which can help to the users

#### Selcen Ari

#### 2025-10-29

* [1. Introduction](#introduction)
* [2. Installation](#installation)
* [3. Selection of perturbing element from dataset](#selection-of-perturbing-element-from-dataset)
  + [3.1. Selection of HIST1H3H gene at vignette How does the system behave in mirtarbase dataset without interaction factors?](#selection-of-hist1h3h-gene-at-vignette-how-does-the-system-behave-in-mirtarbase-dataset-without-interaction-factors)
  + [3.2. Selection of ACTB gene at vignette How does the system behave in mirtarbase dataset without interaction factors?](#selection-of-actb-gene-at-vignette-how-does-the-system-behave-in-mirtarbase-dataset-without-interaction-factors)
  + [4. Determination of ACTB gene perturbation efficiency with different expression level changes](#determination-of-actb-gene-perturbation-efficiency-with-different-expression-level-changes)
* [5. Session Info](#session-info)

```
library(ceRNAnetsim)
```

# 1. Introduction

In the other package vignettes, usage of ceRNAnetsim is explained in details. But in this vignette, some of commands which facitate to use of other vignettes.

# 2. Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ceRNAnetsim")
```

# 3. Selection of perturbing element from dataset

```
data("TCGA_E9_A1N5_tumor")
data("TCGA_E9_A1N5_normal")
data("mirtarbasegene")
data("TCGA_E9_A1N5_mirnanormal")
```

## 3.1. Selection of HIST1H3H gene at vignette [How does the system behave in mirtarbase dataset without interaction factors?](https://selcenari.github.io/ceRNAnetsim/articles/mirtarbase_example.html)

```
TCGA_E9_A1N5_mirnanormal %>%
  inner_join(mirtarbasegene, by= "miRNA") %>%
  inner_join(TCGA_E9_A1N5_normal,
             by = c("Target"= "external_gene_name")) %>%
  select(Target, miRNA, total_read, gene_expression) %>%
  distinct() -> TCGA_E9_A1N5_mirnagene
#> Warning in inner_join(., TCGA_E9_A1N5_normal, by = c(Target = "external_gene_name")): Detected an unexpected many-to-many relationship between `x` and `y`.
#> ℹ Row 3405 of `x` matches multiple rows in `y`.
#> ℹ Row 842 of `y` matches multiple rows in `x`.
#> ℹ If a many-to-many relationship is expected, set `relationship =
#>   "many-to-many"` to silence this warning.
```

```
TCGA_E9_A1N5_tumor%>%
  inner_join(TCGA_E9_A1N5_normal, by= "external_gene_name")%>%
  select(patient = patient.x,
         external_gene_name,
         tumor_exp = gene_expression.x,
         normal_exp = gene_expression.y)%>%
  distinct()%>%
  inner_join(TCGA_E9_A1N5_mirnagene, by = c("external_gene_name"= "Target"))%>%
  filter(tumor_exp != 0, normal_exp != 0)%>%
  mutate(FC= tumor_exp/normal_exp)%>%
  filter(external_gene_name== "HIST1H3H")
#> Warning in inner_join(., TCGA_E9_A1N5_normal, by = "external_gene_name"): Detected an unexpected many-to-many relationship between `x` and `y`.
#> ℹ Row 361 of `x` matches multiple rows in `y`.
#> ℹ Row 17044 of `y` matches multiple rows in `x`.
#> ℹ If a many-to-many relationship is expected, set `relationship =
#>   "many-to-many"` to silence this warning.
#> Warning in inner_join(., TCGA_E9_A1N5_mirnagene, by = c(external_gene_name = "Target")): Detected an unexpected many-to-many relationship between `x` and `y`.
#> ℹ Row 1 of `x` matches multiple rows in `y`.
#> ℹ Row 3362 of `y` matches multiple rows in `x`.
#> ℹ If a many-to-many relationship is expected, set `relationship =
#>   "many-to-many"` to silence this warning.
#> # A tibble: 13 × 8
#>    patient      external_gene_name tumor_exp normal_exp miRNA         total_read
#>    <chr>        <chr>                  <dbl>      <dbl> <chr>              <int>
#>  1 TCGA-E9-A1N5 HIST1H3H                 825         27 hsa-miR-193b…        193
#>  2 TCGA-E9-A1N5 HIST1H3H                 825         27 hsa-miR-299-…          7
#>  3 TCGA-E9-A1N5 HIST1H3H                 825         27 hsa-miR-34a-…          3
#>  4 TCGA-E9-A1N5 HIST1H3H                 825         27 hsa-miR-34a-…        450
#>  5 TCGA-E9-A1N5 HIST1H3H                 825         27 hsa-miR-378a…       1345
#>  6 TCGA-E9-A1N5 HIST1H3H                 825         27 hsa-miR-379-…         14
#>  7 TCGA-E9-A1N5 HIST1H3H                 825         27 hsa-miR-380-…          3
#>  8 TCGA-E9-A1N5 HIST1H3H                 825         27 hsa-miR-411-…         35
#>  9 TCGA-E9-A1N5 HIST1H3H                 825         27 hsa-miR-484          205
#> 10 TCGA-E9-A1N5 HIST1H3H                 825         27 hsa-miR-497-…        270
#> 11 TCGA-E9-A1N5 HIST1H3H                 825         27 hsa-miR-503-…         38
#> 12 TCGA-E9-A1N5 HIST1H3H                 825         27 hsa-miR-6793…          1
#> 13 TCGA-E9-A1N5 HIST1H3H                 825         27 hsa-miR-760            4
#> # ℹ 2 more variables: gene_expression <dbl>, FC <dbl>

#HIST1H3H: interacts with various miRNA in dataset, so we can say that HIST1H3H is non-isolated competing element and increases to 30-fold.
```

## 3.2. Selection of ACTB gene at vignette [How does the system behave in mirtarbase dataset without interaction factors?](https://selcenari.github.io/ceRNAnetsim/articles/mirtarbase_example.html)

```
TCGA_E9_A1N5_tumor%>%
  inner_join(TCGA_E9_A1N5_normal, by= "external_gene_name") %>%
  select(patient = patient.x,
         external_gene_name,
         tumor_exp = gene_expression.x,
         normal_exp = gene_expression.y) %>%
  distinct() %>%
  inner_join(TCGA_E9_A1N5_mirnagene,
             by = c("external_gene_name"= "Target")) %>%
  filter(tumor_exp != 0, normal_exp != 0) %>%
  mutate(FC= tumor_exp/normal_exp) %>%
  filter(external_gene_name == "ACTB")
#> Warning in inner_join(., TCGA_E9_A1N5_normal, by = "external_gene_name"): Detected an unexpected many-to-many relationship between `x` and `y`.
#> ℹ Row 361 of `x` matches multiple rows in `y`.
#> ℹ Row 17044 of `y` matches multiple rows in `x`.
#> ℹ If a many-to-many relationship is expected, set `relationship =
#>   "many-to-many"` to silence this warning.
#> Warning in inner_join(., TCGA_E9_A1N5_mirnagene, by = c(external_gene_name = "Target")): Detected an unexpected many-to-many relationship between `x` and `y`.
#> ℹ Row 1 of `x` matches multiple rows in `y`.
#> ℹ Row 3362 of `y` matches multiple rows in `x`.
#> ℹ If a many-to-many relationship is expected, set `relationship =
#>   "many-to-many"` to silence this warning.
#> # A tibble: 46 × 8
#>    patient      external_gene_name tumor_exp normal_exp miRNA         total_read
#>    <chr>        <chr>                  <dbl>      <dbl> <chr>              <int>
#>  1 TCGA-E9-A1N5 ACTB                  191469     101917 hsa-let-7a-5p      67599
#>  2 TCGA-E9-A1N5 ACTB                  191469     101917 hsa-let-7b-5p      47266
#>  3 TCGA-E9-A1N5 ACTB                  191469     101917 hsa-let-7c-5p      14554
#>  4 TCGA-E9-A1N5 ACTB                  191469     101917 hsa-let-7i-3p        191
#>  5 TCGA-E9-A1N5 ACTB                  191469     101917 hsa-miR-1-3p           5
#>  6 TCGA-E9-A1N5 ACTB                  191469     101917 hsa-miR-100-…      12625
#>  7 TCGA-E9-A1N5 ACTB                  191469     101917 hsa-miR-127-…       5297
#>  8 TCGA-E9-A1N5 ACTB                  191469     101917 hsa-miR-1307…       2379
#>  9 TCGA-E9-A1N5 ACTB                  191469     101917 hsa-miR-145-…       8041
#> 10 TCGA-E9-A1N5 ACTB                  191469     101917 hsa-miR-16-5p       1522
#> # ℹ 36 more rows
#> # ℹ 2 more variables: gene_expression <dbl>, FC <dbl>

#ACTB: interacts with various miRNA in dataset, so ACTB is not isolated node in network and increases to 1.87-fold.
```

## 4. Determination of ACTB gene perturbation efficiency with different expression level changes

Firstly, clean dataset as individual gene has one expression value. And then filter genes which have expression values greater than 10.

```
TCGA_E9_A1N5_mirnagene %>%
  group_by(Target) %>%
  mutate(gene_expression= max(gene_expression)) %>%
  distinct() %>%
  ungroup() -> TCGA_E9_A1N5_mirnagene

TCGA_E9_A1N5_mirnagene%>%
  filter(gene_expression > 10)->TCGA_E9_A1N5_mirnagene
```

We can determine perturbation efficiency of an element on entire network as following:

```
TCGA_E9_A1N5_mirnagene %>%
  priming_graph(competing_count = gene_expression,
                miRNA_count = total_read)%>%
  calc_perturbation(node_name= "ACTB", cycle=10, how= 1.87,limit = 0.1)
```

On the other hand, the perturbation eficiency of ATCB gene is higher, when this gene is regulated with 30-fold upregulation like in HIST1H3H.

```
TCGA_E9_A1N5_mirnagene %>%
  priming_graph(competing_count = gene_expression,
                miRNA_count = total_read)%>%
  calc_perturbation(node_name= "ACTB", cycle=10, how= 30,limit = 0.1)
```

# 5. Session Info

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
#> [1] ceRNAnetsim_1.22.0 tidygraph_1.3.1    dplyr_1.1.4
#>
#> loaded via a namespace (and not attached):
#>  [1] viridis_0.6.5      utf8_1.2.6         sass_0.4.10        future_1.67.0
#>  [5] generics_0.1.4     tidyr_1.3.1        listenv_0.9.1      digest_0.6.37
#>  [9] magrittr_2.0.4     evaluate_1.0.5     grid_4.5.1         RColorBrewer_1.1-3
#> [13] fastmap_1.2.0      jsonlite_2.0.0     ggrepel_0.9.6      gridExtra_2.3
#> [17] purrr_1.1.0        viridisLite_0.4.2  scales_1.4.0       tweenr_2.0.3
#> [21] codetools_0.2-20   jquerylib_0.1.4    cli_3.6.5          graphlayouts_1.2.2
#> [25] rlang_1.1.6        polyclip_1.10-7    parallelly_1.45.1  withr_3.0.2
#> [29] cachem_1.1.0       yaml_2.3.10        tools_4.5.1        parallel_4.5.1
#> [33] memoise_2.0.1      ggplot2_4.0.0      globals_0.18.0     vctrs_0.6.5
#> [37] R6_2.6.1           lifecycle_1.0.4    MASS_7.3-65        furrr_0.3.1
#> [41] ggraph_2.2.2       pkgconfig_2.0.3    pillar_1.11.1      bslib_0.9.0
#> [45] gtable_0.3.6       Rcpp_1.1.0         glue_1.8.0         ggforce_0.5.0
#> [49] xfun_0.53          tibble_3.3.0       tidyselect_1.2.1   knitr_1.50
#> [53] dichromat_2.0-0.1  farver_2.1.2       htmltools_0.5.8.1  igraph_2.2.1
#> [57] rmarkdown_2.30     compiler_4.5.1     S7_0.2.0
```