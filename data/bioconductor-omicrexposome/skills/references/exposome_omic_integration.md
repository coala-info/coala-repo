# Exposome Data Integration with Omic Data

Carles Hernandez-Ferer and Juan R. Gonzalez

#### 30 October 2025

#### Abstract

This is an introductory guide to integration analysis between exposome and omics data with R package omicRexposome. The document illustrates two types of analysis: 1) Association analysis, that are performed between exposome and a single omic data-set; and 2) Integration analysis where multiple data-sets, including exposome data, are analysed at the same time.

#### Package

omicRexposome 1.32.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Installation](#installation)
  + [1.2 Pipeline](#pipeline)
  + [1.3 Exposome and Omic Data](#exposome-and-omic-data)
* [2 Analysis](#analysis)
  + [2.1 Association Studies](#association-studies)
    - [2.1.1 Exposome - Transcriptome Data Association](#exposome---transcriptome-data-association)
    - [2.1.2 Exposome - Proteome Data Association](#exposome---proteome-data-association)
  + [2.2 Integration Analysis](#integration-analysis)
* [Session info](#session-info)

# 1 Introduction

`omicRexposome` is an R package designed to work join with `rexposome`. The aim of `omicRexposome` is to perform analysis joining exposome and omic data with the goal to find the relationship between a single or set of exposures (external exposome) and the behavior of a gene, a group of CpGs, the level of a protein, etc. Also to provide a series of tools to analyse exposome and omic data using standard methods from Biocondcutor.

## 1.1 Installation

`omicRexposome` is currently in development and not available from CRAN nor Bioconductor. Anyway, the package can be installed by using devtools R package and taking the source from **Bioinformatic Research Group in Epidemiology**’s GitHub repository.

This can be done by opening an R session and typing the following code:

```
devtools::install_github("isglobal-brge/omicRexposome")
```

User must take into account that this sentence do not install the packages’ dependencies.

## 1.2 Pipeline

Two different types of analyses can be done with `omicRexposome`:

| Analysis | `omicRexposome` function |
| --- | --- |
| Association Study | `association` |
| Integration Study | `crossomics` |

Both association and integration studies are based in objects of class `MultiDataSet`. A `MultiDataSet` object is a contained for multiple layers of sample information. Once the exposome data and the omics data are encapsulated in a `MultiDataSet` the object can be used for both association and integration studies.

The method `association` requires a `MultiDataSet` object having to types of information: the exposome data from an `ExposomeSet` object and omic information from objects of class `ExpressionSet`, `MethylationSet`, `SummarizedExperiment` or others. `ExposomeSet` objects are created with functions `read_exposome` and `load_exposome` from `rexposome` R package (see next section *Loading Exposome Data*) and encapsulates exposome data. The method `crossomics` expects a `MultiDataSet` with any number of different data-sets (at last two). Compared with `association` method, `crossomics` do not requires an `ExposomeSet`.

## 1.3 Exposome and Omic Data

In order to illustrate the capabilities of `omicRexposome` and the exposome-omic analysis pipeline, we will use the data from `BRGdata` package. This package includes different omic-sets including methylation, transcriptome and proteome data-sets and an exposome-data set.

# 2 Analysis

`omicRexposome` and `MultiDataSet` R packages are loaded using the standard library command:

```
library(omicRexposome)
library(MultiDataSet)
```

## 2.1 Association Studies

The association studies are performed using the method `association`. This method requires, at last four, augments:

1. Argument `object` should be filled with a `MultiDataSet` object.
2. Argument `formula` should be filled with an expression containing the covariates used to adjust the model.
3. Argument `expset` should be filled with the name that the exposome-set receives in the `MultiDataSet` object.
4. Argument `omicset` should be filled with the name that the omic-set receives in the `MultiDataSet` object.

The argument `formula` should follow the pattern: `~sex+age`. The method `association` will fill the formula placing the exposures in the `ExposomeSet`m between `~` and the covariates `sex+age`.

`association` implements the `limma` pipeline using `lmFit` and `eBayes` in the extraction methods from `MultiDataSet`. The method takes care of the missing data in exposures, outcomes and omics data and locating and is subsets both data-sets, exposome data and omic data, by common samples. The argument `method` allows to select the fitting method used in `lmFit`. By default it takes the value `"ls"` for *least squares* but it can also takes `"robust"` for *robust regression*.

The following subsections illustrates the usage of `association` with different types of omics data: *methylome*, *transcriptome* and *proteome*.

### 2.1.1 Exposome - Transcriptome Data Association

First we get the exposome data from `BRGdata` package that we will use in the whole section.

```
data("brge_expo", package = "brgedata")
class(brge_expo)
```

```
## [1] "ExposomeSet"
## attr(,"package")
## [1] "rexposome"
```

The aim of this analysis is to perform an association test between the gene expression levels and the exposures. So the first point is to obtain the transcriptome data from the `brgedata` package.

```
data("brge_gexp", package = "brgedata")
```

The association studies between exposures and transcriptome are done in the same way that the ones with methylome. The method used is `association`, that takes as input an object of `MultiDataSet` class with both exposome and expression data.

```
mds <- createMultiDataSet()
mds <- add_genexp(mds, brge_gexp)
mds <- add_exp(mds, brge_expo)

gexp <- association(mds, formula=~Sex+Age,
    expset = "exposures", omicset = "expression")
```

We can have a look to the number of hits and the lambda score of each analysis with the methods `tableHits` and `tableLambda`, seen in the previous section.

```
hit <- tableHits(gexp, th=0.001)
lab <- tableLambda(gexp)
merge(hit, lab, by="exposure")
```

```
##    exposure hits    lambda
## 1     BPA_p   19 0.9072377
## 2    BPA_t1   27 0.8807316
## 3    BPA_t3   56 0.9391129
## 4     Ben_p   19 0.8013466
## 5    Ben_t1   12 0.8234104
## 6    Ben_t2    9 0.8393350
## 7    Ben_t3   21 0.8301203
## 8     NO2_p   32 1.0281960
## 9    NO2_t1   16 0.7942881
## 10   NO2_t2   35 1.1482314
## 11   NO2_t3   31 0.8770931
## 12   PCB118   59 0.9308472
## 13   PCB138   38 1.0726221
## 14   PCB153   51 1.1743989
## 15   PCB180   17 0.9790750
```

Since most of all models have a lambda under one, we should consider use *Surrogate Variable Analysis*. This can be done using the same `association` method but by setting the argument `sva` to `"fast"` so the pipeline of `isva` and `SmartSVA` R packages is applied. If `sva` is set to `"slow"` the applied. pipeline is the one from `sva` R package.

```
gexp <- association(mds, formula=~Sex+Age,
    expset = "exposures", omicset = "expression", sva = "fast")
```

We can re-check the results creating the same table than before:

```
hit <- tableHits(gexp, th=0.001)
lab <- tableLambda(gexp)
merge(hit, lab, by="exposure")
```

```
##    exposure hits    lambda
## 1     BPA_p   50 0.9874143
## 2    BPA_t1   51 0.9433845
## 3    BPA_t3   61 0.9842234
## 4     Ben_p   76 1.0117743
## 5    Ben_t1   64 1.0115556
## 6    Ben_t2   71 1.0089886
## 7    Ben_t3   59 0.9968889
## 8     NO2_p   78 1.0116970
## 9    NO2_t1   67 1.0056894
## 10   NO2_t2   69 1.0209991
## 11   NO2_t3   49 0.9802463
## 12   PCB118  129 1.0518532
## 13   PCB138   67 1.0094398
## 14   PCB153   58 0.9925023
## 15   PCB180   67 0.9974135
```

The objects of class `ResultSet` have a method called `plotAssociation` that allows to create QQ Plots (that are another useful way to see if there are some inflation/deflation in the P-Values).

```
gridExtra::grid.arrange(
    plotAssociation(gexp, rid="Ben_p", type="qq") +
        ggplot2::ggtitle("Transcriptome - Pb Association"),
    plotAssociation(gexp, rid="BPA_p", type="qq") +
        ggplot2::ggtitle("Transcriptome - THM Association"),
    ncol=2
)
```

```
## Warning in ggplot2::geom_text(ggplot2::aes(x = -Inf, y = Inf, hjust = 0, : All aesthetics have length 1, but the data has 67528 rows.
## ℹ Please consider using `annotate()` or provide this layer with data containing
##   a single row.
## All aesthetics have length 1, but the data has 67528 rows.
## ℹ Please consider using `annotate()` or provide this layer with data containing
##   a single row.
```

![](data:image/png;base64...)

Following this line, the same method `plotAssociation` can be used to create volcano plots.

```
gridExtra::grid.arrange(
    plotAssociation(gexp, rid="Ben_p", type="volcano", tPV=-log10(1e-04)) +
        ggplot2::ggtitle("Transcriptome - Pb Association"),
    plotAssociation(gexp, rid="BPA_p", type="volcano", tPV=-log10(1e-04)) +
        ggplot2::ggtitle("Transcriptome - THM Association"),
    ncol=2
)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the MultiDataSet package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the MultiDataSet package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

### 2.1.2 Exposome - Proteome Data Association

The proteome data-set included in `brgedata` has 47 proteins for 90 samples.

```
data("brge_prot", package="brgedata")
brge_prot
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 47 features, 90 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: x0001 x0002 ... x0090 (90 total)
##   varLabels: age sex
##   varMetadata: labelDescription
## featureData
##   featureNames: Adiponectin_ok Alpha1AntitrypsinAAT_ok ...
##     VitaminDBindingProte_ok (47 total)
##   fvarLabels: chr start end
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
```

The association analysis between exposures and proteome is also done using `association`.

```
mds <- createMultiDataSet()
mds <- add_eset(mds, brge_prot, dataset.type  ="proteome")
mds <- add_exp(mds, brge_expo)

prot <- association(mds, formula=~Sex+Age,
    expset = "exposures", omicset = "proteome")
```

The `tableHits` indicates that no association was found between the 47 proteins and the exposures.

```
tableHits(prot, th=0.001)
```

```
##        exposure hits
## Ben_p     Ben_p    0
## Ben_t1   Ben_t1    0
## Ben_t2   Ben_t2    0
## Ben_t3   Ben_t3    0
## BPA_p     BPA_p    0
## BPA_t1   BPA_t1    0
## BPA_t3   BPA_t3    0
## NO2_p     NO2_p    0
## NO2_t1   NO2_t1    1
## NO2_t2   NO2_t2    0
## NO2_t3   NO2_t3    0
## PCB118   PCB118    0
## PCB138   PCB138    0
## PCB153   PCB153    0
## PCB180   PCB180    0
```

This is also seen in the Manhattan plot for proteins that can be obtained from `plotAssociation`.

```
gridExtra::grid.arrange(
    plotAssociation(prot, rid="Ben_p", type="protein") +
        ggplot2::ggtitle("Proteome - Cd Association") +
        ggplot2::geom_hline(yintercept = 1, color = "LightPink"),
    plotAssociation(prot, rid="NO2_p", type="protein") +
        ggplot2::ggtitle("Proteome - Cotinine Association") +
        ggplot2::geom_hline(yintercept = 1, color = "LightPink"),
    ncol=2
)
```

![](data:image/png;base64...)

**NOTE**: A real Manhattan plot can be draw with `plot` method for `ResultSet` objects by setting the argument `type` to `"manhattan"`.

```
##            used  (Mb) gc trigger   (Mb)  max used   (Mb)
## Ncells  9217723 492.3   13980382  746.7  13980382  746.7
## Vcells 24067135 183.7  351766002 2683.8 439706681 3354.7
```

## 2.2 Integration Analysis

`omicRexposome` allows to study the relation between exposures and omic-features from another perspective, different from the association analyses. The integration analysis can be done, in `omicRexposome` using *multi canonical correlation analysis* or using *multiple co-inertia analysis*. The first methods is implemented in R package `PMA` (CRAN) and the second in `omicade4` R package (Bioconductor). The two methods are encapsulated in the `crossomics` method.

The differences between `association` and `crossomics` are that the first method test association between two complete data-sets, by removing the samples having missing values in any of the involved data-sets, and the second try to find latent relationships between two or more sets.

Hence, we need to explore the missing data in the exposome data-set. This can be done using the methods `plotMissings` and `tableMissings` from `rexposome` R package.

```
library(rexposome)
plotMissings(brge_expo, set = "exposures")
```

![](data:image/png;base64...)

From the plot we can see that more of the exposures have up to 25% of missing values. Hence the first step in the integration analysis is to avoid missing values. so, we perform a fast imputation on the exposures side:

```
brge_expo <- imputation(brge_expo)
```

`crossomics` function expects to obtain the different data-sets in a single labelled-list, in the argument called `list`. The argument `method` from `crossomics` function can be set to `mcia` (for *multiple co-inertia analysis*) or to `mcca` (for *multi canonical correlation analysis*).

The following code shows how to perform the integration of the exposome and the proteome. The method `crossomics` request a `MultiDataSet` object as input, containing the data-set to be integrated.

```
mds <- createMultiDataSet()
mds <- add_genexp(mds, brge_gexp)
mds <- add_eset(mds, brge_prot, dataset.type = "proteome")
mds <- add_exp(mds, brge_expo)

cr_mcia <- crossomics(mds, method = "mcia", verbose = TRUE)
cr_mcia
```

```
## Object of class 'ResultSet'
##  . created with: crossomics
##  . sva:
##     . method: mcia  ( omicade4 )
##  . #results: 1 ( error: 0 )
##  . featureData:  3
##     . expression: 67528x11
##     . proteome: 47x3
##     . exposures: 15x12
```

As can be seen, `crossomics` returns an object of class `ResultSet`. In the integration process, the different data-sets are subset by common samples. This is done taking advantage of `MultiDataSet` capabilities.

The same is done when method is set to `mcca`.

```
cr_mcca <- crossomics(mds, method = "mcca", permute=c(4, 2))
cr_mcca
```

We used an extra argument (`permute`) into the previous call to `crossomics` using *multi canonical correlation analysis*. This argument allows to set the internal argument corresponding to `permutations` and `iterations`, that are used to tune-up internal parameters.

When a `ResultSet` is generated using `crossomics` the methods `plotHits`, `plotLambda` and `plotAssociation` can **NOT** be used. But the `plotIntegration` will help us to understand what was done. This method allows to provide the colors to be used on the plots:

```
colors <- c("green", "blue", "red")
names(colors) <- names(mds)
```

The graphical representation of the results from a *multiple co-inertia analysis* is a composition of four different plots.

```
plotIntegration(cr_mcia, colors=colors)
```

![](data:image/png;base64...)

The first plot (first row, first column) is the samples space. It illustrates how the different data-sets are related in terms of intra-sample variability (each data-set has a different color). The second plot (first row, second column) shows the feature space. The features of each set are drawn on the same components so the relation between each data-set can be seen (the features are colored depending of the set were they belong).

The third plot (second row, first column) shows the inertia of each component. The two first plots are drawn on the first and second component. Finally, the fourth plot shows the behavior of the data-sets.

A radar plots is obtained when `plotIntegration` is used on a `ResultSet` created though *multi canonical correlation analysis*.

```
plotIntegration(cr_mcca, colors=colors)
```

```
## Warning: `position_stack()` requires non-overlapping x intervals.
```

![](data:image/png;base64...)

This plot shows the features of the three data-sets in the same 2D space.The relation between the features can be understood by proximity. This means that the features that clusters, or that are in the same quadrant are related and goes in a different direction than the features in the other quadrants.

```
rm(cr_mcia, cr_mcca)
```

# Session info

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] rexposome_1.32.0     MultiDataSet_1.38.0  omicRexposome_1.32.0
## [4] Biobase_2.70.0       BiocGenerics_0.56.0  generics_0.1.4
## [7] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1               norm_1.0-11.1
##   [3] bitops_1.0-9                tibble_3.3.0
##   [5] omicade4_1.50.0             XML_3.99-0.19
##   [7] rpart_4.1.24                lifecycle_1.0.4
##   [9] Rdpack_2.6.4                edgeR_4.8.0
##  [11] lattice_0.22-7              MASS_7.3-65
##  [13] flashClust_1.01-2           backports_1.5.0
##  [15] magrittr_2.0.4              limma_3.66.0
##  [17] Hmisc_5.2-4                 sass_0.4.10
##  [19] rmarkdown_2.30              jquerylib_0.1.4
##  [21] yaml_2.3.10                 minqa_1.2.8
##  [23] DBI_1.2.3                   RColorBrewer_1.1-3
##  [25] ade4_1.7-23                 multcomp_1.4-29
##  [27] abind_1.4-8                 GenomicRanges_1.62.0
##  [29] JADE_2.0-4                  nnet_7.3-20
##  [31] TH.data_1.1-4               sandwich_3.1-1
##  [33] sva_3.58.0                  circlize_0.4.16
##  [35] IRanges_2.44.0              S4Vectors_0.48.0
##  [37] ggrepel_0.9.6               genefilter_1.92.0
##  [39] made4_1.84.0                SmartSVA_0.1.3
##  [41] RSpectra_0.16-2             annotate_1.88.0
##  [43] PMA_1.2-4                   codetools_0.2-20
##  [45] DelayedArray_0.36.0         DT_0.34.0
##  [47] tidyselect_1.2.1            gmm_1.9-1
##  [49] shape_1.4.6.1               farver_2.1.2
##  [51] lme4_1.1-37                 matrixStats_1.5.0
##  [53] stats4_4.5.1                base64enc_0.1-3
##  [55] Seqinfo_1.0.0               jsonlite_2.0.0
##  [57] Formula_1.2-5               survival_3.8-3
##  [59] iterators_1.0.14            emmeans_2.0.0
##  [61] foreach_1.5.2               tools_4.5.1
##  [63] pryr_0.1.6                  Rcpp_1.1.0
##  [65] glue_1.8.0                  gridExtra_2.3
##  [67] SparseArray_1.10.0          xfun_0.53
##  [69] mgcv_1.9-3                  qvalue_2.42.0
##  [71] MatrixGenerics_1.22.0       dplyr_1.1.4
##  [73] withr_3.0.2                 BiocManager_1.30.26
##  [75] fastmap_1.2.0               boot_1.3-32
##  [77] caTools_1.18.3              digest_0.6.37
##  [79] R6_2.6.1                    estimability_1.5.1
##  [81] imputeLCMD_2.1              colorspace_2.1-2
##  [83] isva_1.9                    gtools_3.9.5
##  [85] dichromat_2.0-0.1           RSQLite_2.4.3
##  [87] calibrate_1.7.7             data.table_1.17.8
##  [89] httr_1.4.7                  htmlwidgets_1.6.4
##  [91] S4Arrays_1.10.0             scatterplot3d_0.3-44
##  [93] pkgconfig_2.0.3             gtable_0.3.6
##  [95] blob_1.2.4                  S7_0.2.0
##  [97] impute_1.84.0               XVector_0.50.0
##  [99] htmltools_0.5.8.1           bookdown_0.45
## [101] multcompView_0.1-10         clue_0.3-66
## [103] scales_1.4.0                tmvtnorm_1.7
## [105] leaps_3.2                   png_0.1-8
## [107] reformulas_0.4.2            corrplot_0.95
## [109] knitr_1.50                  rstudioapi_0.17.1
## [111] reshape2_1.4.4              nloptr_2.2.1
## [113] coda_0.19-4.1               checkmate_2.3.3
## [115] nlme_3.1-168                cachem_1.1.0
## [117] zoo_1.8-14                  GlobalOptions_0.1.2
## [119] stringr_1.5.2               KernSmooth_2.23-26
## [121] parallel_4.5.1              foreign_0.8-90
## [123] AnnotationDbi_1.72.0        pillar_1.11.1
## [125] grid_4.5.1                  fastICA_1.2-7
## [127] vctrs_0.6.5                 gplots_3.2.0
## [129] pcaMethods_2.2.0            xtable_1.8-4
## [131] cluster_2.1.8.1             htmlTable_2.4.3
## [133] evaluate_1.0.5              qqman_0.1.9
## [135] mvtnorm_1.3-3               cli_3.6.5
## [137] locfit_1.5-9.12             compiler_4.5.1
## [139] rlang_1.1.6                 crayon_1.5.3
## [141] labeling_0.4.3              plyr_1.8.9
## [143] stringi_1.8.7               lsr_0.5.2
## [145] BiocParallel_1.44.0         Biostrings_2.78.0
## [147] glmnet_4.1-10               Matrix_1.7-4
## [149] bit64_4.6.0-1               ggplot2_4.0.0
## [151] KEGGREST_1.50.0             statmod_1.5.1
## [153] FactoMineR_2.12             SummarizedExperiment_1.40.0
## [155] rbibutils_2.3               memoise_2.0.1
## [157] bslib_0.9.0                 bit_4.6.0
```