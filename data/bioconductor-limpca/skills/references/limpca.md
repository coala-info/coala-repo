# Get started with limpca.

Benaiche Nadia, Sébastien Franceschini, Martin Manon, Thiel Michel, Govaerts Bernadette

#### October 30, 2025

#### Package

limpca 1.6.0

[![R-CMD-check](data:image/svg+xml; charset=utf-8;base64...)](https://github.com/ManonMartin/limpca/actions/workflows/check-standard.yaml)

# 1 Introduction

## 1.1 About the package

This package was created to analyse models with high-dimensional data and a multi-factor design of experiment. `limpca` stands for **li**near **m**odeling of high-dimensional designed data based on the ASCA (ANOVA-Simultaneous Component Analysis) and A**PCA** (ANOVA-Principal Component Analysis) family of methods. These methods combine ANOVA with a General Linear Model (GLM) decomposition and PCA. They provide powerful visualization tools for multivariate structures in the space of each effect of the statistical model linked to the experimental design. Details on the methods used and the package implementation can be found in the articles of Thiel, Féraud, and Govaerts ([2017](#ref-Thiel2017)), Guisset, Martin, and Govaerts ([2019](#ref-Guisset2019)) and Thiel et al. ([2023](#ref-Thiel2023)).

Therefore, ASCA/APCA are highly informative modeling and visualisation tools to analyse -omics data tables in a multivariate framework and act as a complement to differential expression analyses methods such as `limma` (Ritchie et al. ([2015](#ref-limma2015))).

## 1.2 Vignettes description

* `Get started with limpca` (this vignette): This vignette is a short application of `limpca` on the `UCH` dataset with data visualisation, exploration (PCA), GLM decomposition and ASCA modelling. The ASCA model used in this example is a three-way ANOVA with fixed effects.
* [Analysis of the UCH dataset with limpca](UCH.html): This vignette is an extensive application of `limpca` on the `UCH` dataset with data visualisation, exploration (PCA), GLM decomposition and ASCA/APCA/ASCA-E modelling. The applied model is a three-way ANOVA with fixed effects. This document presents all the usual steps of the analysis, from importing the data to visualising the results.
* [Analysis of the Trout dataset with limpca](Trout.html): This vignette is an extensive application of `limpca` on the `Trout` dataset with data visualisation, exploration (PCA), GLM decomposition and ASCA/APCA/ASCA-E modelling. The applied model involves three main effects and their two-way interaction terms. It also compares the results of ASCA to a univariate ANOVA modeling.

# 2 Installation and loading of the `limpca` package

`limpca` can be installed from Bioconductor:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("limpca")
```

And then loaded into your R session:

```
library("limpca")
```

For any enquiry, you can send an email to the package authors: bernadette.govaerts@uclouvain.be ; michel.thiel@uclouvain.be or manon.martin@uclouvain.be

# 3 Short application on the `UCH` dataset

## 3.1 Data object

In order to use the limpca core functions, the data need to be formatted as a list (informally called an lmpDataList) with the following elements: `outcomes` (multivariate matrix), `design` (data.frame) and `formula` (character string).
The `UCH` data set is already formatted appropriately and can be loaded from `limpca` with the `data` function.

```
data("UCH")
str(UCH)
#> List of 3
#>  $ design  :'data.frame':    34 obs. of  5 variables:
#>   ..$ Hippurate: Factor w/ 3 levels "0","1","2": 1 1 1 1 1 1 2 2 2 2 ...
#>   ..$ Citrate  : Factor w/ 3 levels "0","2","4": 1 1 2 2 3 3 1 1 2 2 ...
#>   ..$ Dilution : Factor w/ 1 level "diluted": 1 1 1 1 1 1 1 1 1 1 ...
#>   ..$ Day      : Factor w/ 2 levels "2","3": 1 1 1 1 1 1 1 1 1 1 ...
#>   ..$ Time     : Factor w/ 2 levels "1","2": 1 2 1 2 1 2 1 2 1 2 ...
#>  $ outcomes: num [1:34, 1:600] 0.0312 0.0581 0.027 0.0341 0.0406 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$   : chr [1:34] "M2C00D2R1" "M2C00D2R2" "M2C02D2R1" "M2C02D2R2" ...
#>   .. ..$ X1: chr [1:600] "9.9917004" "9.9753204" "9.9590624" "9.9427436" ...
#>  $ formula : chr "outcomes ~ Hippurate + Citrate + Time + Hippurate:Citrate + Time:Hippurate + Time:Citrate + Hippurate:Citrate:Time"
```

Alternatively, the lmpDataList can be created with the function `data2LmpDataList` :

* from scratch:

```
UCH2 <- data2LmpDataList(
   outcomes = UCH$outcomes,
   design = UCH$design,
   formula = UCH$formula
 )
#> | dim outcomes: 34x600
#> | formula: ~ Hippurate + Citrate + Time + Hippurate:Citrate + Time:Hippurate + Time:Citrate + Hippurate:Citrate:Time
#> | design variables (5):
#> * Hippurate (factor)
#> * Citrate (factor)
#> * Dilution (factor)
#> * Day (factor)
#> * Time (factor)
```

* or from a `SummarizedExperiment`:

```
se <- SummarizedExperiment(
   assays = list(
     counts = t(UCH$outcomes)), colData = UCH$design,
   metadata = list(formula = UCH$formula)
 )

UCH3 <- data2LmpDataList(se, assay_name = "counts")
#> | dim outcomes: 34x600
#> | formula: ~ Hippurate + Citrate + Time + Hippurate:Citrate + Time:Hippurate + Time:Citrate + Hippurate:Citrate:Time
#> | design variables (5):
#> * Hippurate (factor)
#> * Citrate (factor)
#> * Dilution (factor)
#> * Day (factor)
#> * Time (factor)
```

`SummarizedExperiment` is a generic data container that stores rectangular matrices of experimental results. See Morgan et al. ([2023](#ref-SummarizedExperiment23)) for more information.

## 3.2 Data visualisation

The design can be visualised with `plotDesign()`.

```
# design
plotDesign(
    design = UCH$design, x = "Hippurate",
    y = "Citrate", rows = "Time",
    title = "Design of the UCH dataset"
)
```

![](data:image/png;base64...)

```
# row 3 of outcomes
plotLine(
    Y = UCH$outcomes,
    title = "H-NMR spectrum",
    rows = c(3),
    xlab = "ppm",
    ylab = "Intensity"
)
```

![](data:image/png;base64...)

## 3.3 PCA

```
ResPCA <- pcaBySvd(UCH$outcomes)
pcaScreePlot(ResPCA, nPC = 6)
```

![](data:image/png;base64...)

```
pcaScorePlot(
    resPcaBySvd = ResPCA, axes = c(1, 2),
    title = "PCA scores plot: PC1 and PC2",
    design = UCH$design,
    color = "Hippurate", shape = "Citrate",
    points_labs_rn = FALSE
)
```

![](data:image/png;base64...)

## 3.4 Model estimation and effect matrix decomposition

```
# Model matrix generation
resMM <- lmpModelMatrix(UCH)

# Model estimation and effect matrices decomposition
resEM <- lmpEffectMatrices(resMM)
```

## 3.5 Effect matrix test of significance and importance measure

```
# Effects importance
resEM$varPercentagesPlot
```

![](data:image/png;base64...)

```
# Bootstrap tests
resBT <- lmpBootstrapTests(resLmpEffectMatrices = resEM, nboot = 100)
resBT$resultsTable
#>                        % of variance (T III) Bootstrap p-values
#> Hippurate                              39.31             < 0.01
#> Citrate                                29.91             < 0.01
#> Time                                   16.24             < 0.01
#> Hippurate:Citrate                       1.54               0.11
#> Hippurate:Time                          6.23             < 0.01
#> Citrate:Time                            0.54               0.46
#> Hippurate:Citrate:Time                  1.68               0.14
#> Residuals                               4.30                  -
```

## 3.6 ASCA decomposition

```
# ASCA decomposition
resASCA <- lmpPcaEffects(resLmpEffectMatrices = resEM, method = "ASCA")

# Scores Plot for the hippurate
lmpScorePlot(resASCA,
    effectNames = "Hippurate",
    color = "Hippurate", shape = "Hippurate"
)
```

![](data:image/png;base64...)

```
# Loadings Plot for the hippurate
lmpLoading1dPlot(resASCA,
    effectNames = c("Hippurate"),
    axes = 1, xlab = "ppm"
)
```

![](data:image/png;base64...)

```
# Scores ScatterPlot matrix
lmpScoreScatterPlotM(resASCA,
    PCdim = c(1, 1, 1, 1, 1, 1, 1, 2),
    modelAbbrev = TRUE,
    varname.colorup = "Citrate",
    varname.colordown = "Time",
    varname.pchup = "Hippurate",
    varname.pchdown = "Time",
    title = "ASCA scores scatterplot matrix"
)
```

![](data:image/png;base64...)

# 4 sessionInfo

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
#>  [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [5] IRanges_2.44.0              S4Vectors_0.48.0
#>  [7] BiocGenerics_0.56.0         generics_0.1.4
#>  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [11] car_3.1-3                   carData_3.0-5
#> [13] pander_0.6.6                gridExtra_2.3
#> [15] limpca_1.6.0                ggplot2_4.0.0
#> [17] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
#>  [4] ggrepel_0.9.6       lattice_0.22-7      vctrs_0.6.5
#>  [7] tools_4.5.1         parallel_4.5.1      tibble_3.3.0
#> [10] pkgconfig_2.0.3     Matrix_1.7-4        tidyverse_2.0.0
#> [13] RColorBrewer_1.1-3  S7_0.2.0            lifecycle_1.0.4
#> [16] compiler_4.5.1      farver_2.1.2        stringr_1.5.2
#> [19] tinytex_0.57        ggsci_4.1.0         codetools_0.2-20
#> [22] htmltools_0.5.8.1   sass_0.4.10         yaml_2.3.10
#> [25] Formula_1.2-5       crayon_1.5.3        pillar_1.11.1
#> [28] jquerylib_0.1.4     tidyr_1.3.1         DelayedArray_0.36.0
#> [31] cachem_1.1.0        magick_2.9.0        iterators_1.0.14
#> [34] abind_1.4-8         foreach_1.5.2       tidyselect_1.2.1
#> [37] digest_0.6.37       stringi_1.8.7       dplyr_1.1.4
#> [40] reshape2_1.4.4      purrr_1.1.0         bookdown_0.45
#> [43] labeling_0.4.3      fastmap_1.2.0       grid_4.5.1
#> [46] cli_3.6.5           SparseArray_1.10.0  magrittr_2.0.4
#> [49] S4Arrays_1.10.0     dichromat_2.0-0.1   withr_3.0.2
#> [52] scales_1.4.0        rmarkdown_2.30      XVector_0.50.0
#> [55] evaluate_1.0.5      knitr_1.50          doParallel_1.0.17
#> [58] rlang_1.1.6         Rcpp_1.1.0          glue_1.8.0
#> [61] formatR_1.14        BiocManager_1.30.26 jsonlite_2.0.0
#> [64] R6_2.6.1            plyr_1.8.9
```

Guisset, Séverine, Manon Martin, and Bernadette Govaerts. 2019. “Comparison of Parafasca, Acomdim, and Amopls Approaches in the Multivariate Glm Modelling of Multi-Factorial Designs.” *Chemometrics and Intelligent Laboratory Systems* 184: 44–63. [https://doi.org/https://doi.org/10.1016/j.chemolab.2018.11.006](https://doi.org/https%3A//doi.org/10.1016/j.chemolab.2018.11.006).

Morgan, Martin, Valerie Obenchain, Jim Hester, and Hervé Pagès. 2023. *SummarizedExperiment: SummarizedExperiment Container*. <https://doi.org/10.18129/B9.bioc.SummarizedExperiment>.

Ritchie, Matthew E, Belinda Phipson, Di Wu, Yifang Hu, Charity W Law, Wei Shi, and Gordon K Smyth. 2015. “limma Powers Differential Expression Analyses for RNA-Sequencing and Microarray Studies.” *Nucleic Acids Research* 43 (7): e47. <https://doi.org/10.1093/nar/gkv007>.

Thiel, Michel, Nadia Benaiche, Manon Martin, Sébastien Franceschini, Robin Van Oirbeek, and Bernadette Govaerts. 2023. “Limpca: An R Package for the Linear Modeling of High-Dimensional Designed Data Based on Asca/Apca Family of Methods.” *Journal of Chemometrics* 37 (7): e3482. [https://doi.org/https://doi.org/10.1002/cem.3482](https://doi.org/https%3A//doi.org/10.1002/cem.3482).

Thiel, Michel, Baptiste Féraud, and Bernadette Govaerts. 2017. “ASCA+ and Apca+: Extensions of Asca and Apca in the Analysis of Unbalanced Multifactorial Designs.” *Journal of Chemometrics* 31 (6): e2895. [https://doi.org/https://doi.org/10.1002/cem.2895](https://doi.org/https%3A//doi.org/10.1002/cem.2895).