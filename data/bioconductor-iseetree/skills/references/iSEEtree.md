Code

* Show All Code
* Hide All Code

# iSEEtree: interactive explorer for hierarchical data

Giulio Benedetti1\*

1University of Turku

\*giulio.benedetti@utu.fi

#### 30 October 2025

#### Package

iSEEtree 1.4.0

# 1 Introduction

## 1.1 Motivation

iSEEtree is a Bioconductor package for the interactive visualisation of
hierarchical data stored in a TreeSummarizedExperiment (TreeSE) container. On
the one side, it leverages and extends the graphics of the iSEE package, which
is designed for the generic SummarizedExperiment class. On the other side, it
employs the statistical and visual tools for microbiome data science provided by
the mia family of packages. Thus, iSEE and mia represent the two building blocks
of iSEEtree. Detailed introductory material on these two frameworks is available
in the [iSEE-verse website](https://isee.github.io/) and the
[OMA Bioconductor book](https://microbiome.github.io/OMA/docs/devel/),
respectively.

iSEEtree is meant for new and experienced users alike, who desire to create and
interact with several graphics for hierarchical data, without the need for an
in-depth knowledge of the underlying mia functionality. Current panels include
compositional plots, ordination graphs and structural tree or networks, which
are further discussed in the current article and in the
[online package documentation](https://microbiome.github.io/iSEEtree/).
Other more generic panels are also inherited from the parent package iSEE and
its many extensions.

## 1.2 Panels

iSEEtree derives its microbiome-related visualisation methods from the
[miaViz](https://microbiome.github.io/miaViz/) package, which is code-based and
requires basic knowledge of R programming and microbiome data structures. The
panels provided represent an easy-to-use interactive version of most miaViz
plotting functions. They allow to visualise several aspects of hierarchical data
by three general approaches: compositional, ordination and structural analysis.

### 1.2.1 Compositional Analysis

These panels can be used to explore sample composition and feature prevalence
or abundance across samples. This topic is further discussed in the OMA chapter
on [Community Composition](https://microbiome.github.io/OMA/docs/devel/pages/composition.html).

* [AbundancePlot](https://microbiome.github.io/iSEEtree/reference/AbundancePlot.html):
  a compositional barplot of the samples, where every bar is a sample composed
  by different features in different colours.
* [AbundanceDensityPlot](https://microbiome.github.io/iSEEtree/reference/AbundanceDensityPlot.html):
  a density plot of the top features, where every line is a feature and the x
  axis shows its abundance for different samples.
* PrevalencePlot: coming soon!

### 1.2.2 Ordination Analysis

These panels show the results of ordination analyses or dimensionality reduction
methods applied to the assay data, both in terms of reduced components as well
as explained variance and feature importance. This topic is further discussed in
the OMA chapter on
[Community Similarity](https://microbiome.github.io/OMA/docs/devel/pages/20_beta_diversity.html).

* [RDAPlot](https://microbiome.github.io/iSEEtree/reference/RDAPlot.html): an
  supervised ordination plot of the samples, where every dot is a sample on a
  reduced dimensional space and every arrow reflects the contribution of a
  sample variable.
* [LoadingPlot](https://microbiome.github.io/iSEEtree/reference/LoadingPlot.html):
  a heatmap or barplot of the loadings or contributions of each feature to the
  reduced dimensions of PCA, PCoA or another ordination method.
* [ScreePlot](https://microbiome.github.io/iSEEtree/reference/LoadingPlot.html):
  a barplot of the contributions of each reduced dimension component to the
  explained variance.

### 1.2.3 Structural Analysis

The structure or organisation of hierarchical data can be explored with the
tree and network visualisations that provide a holistic picture of the
structured relationships across features or samples. This topic is further
discussed in the OMA chapters on
[Exploration](https://microbiome.github.io/OMA/docs/devel/pages/quality_control.html) and
[Networks](https://microbiome.github.io/OMA/docs/devel/pages/network_learning.html).

* [RowTreePlot](https://microbiome.github.io/iSEEtree/reference/RowTreePlot.html):
  a phylogenetic tree of the features, where every tip is a feature and two
  neighbouring tips are more closely related than two far apart from each other.
* [ColumnTreePlot](https://microbiome.github.io/iSEEtree/reference/ColumnTreePlot.html):
  the hierarchical organisation of the samples, where every tip is a sample and
  the closer the more related they are.
* [RowGraphPlot](https://microbiome.github.io/iSEEtree/reference/RowGraphPlot.html):
  the network organisation of the features, where every node is a feature and
  edges reflect the degree of connection between features.
* [ColumnGraphPlot](https://microbiome.github.io/iSEEtree/reference/ColumnGraphPlot.html):
  the network organisation of the samples, where every node is a sample and
  edges reflect the degree of connection between samples.

### 1.2.4 Other Panels

By default, the iSEEtree layout also includes the following panels inherited by
iSEE:

* [RowDataTable](https://isee.github.io/iSEE/articles/basic.html#row-data-tables)
* [ColumnDataTable](https://isee.github.io/iSEE/articles/basic.html#column-data-tables)
* [ReducedDimensionPlot](https://isee.github.io/iSEE/articles/basic.html#reduced-dimension-plots)
* [ComplexHeatmapPlot](https://isee.github.io/iSEE/articles/basic.html#heat-maps)

The [ColumnDataPlot](https://isee.github.io/iSEE/articles/basic.html#coldataplot)
could also prove useful for the visualisation of column variables such as
alpha diversity indices. Its interpretation is explained in the OMA chapter on
[Community Diversity](https://microbiome.github.io/OMA/docs/devel/pages/14_alpha_diversity.html).

For more information on the available panels, users are directed to the
[iSEEtree panel catalogue](https://microbiome.github.io/iSEEtree/articles/panels.html)
in the main package documentation.

# 2 Tutorial

## 2.1 Installation

R is an open-source statistical environment which can be easily modified to
enhance its functionality via packages. iSEEtree is an R package available on
[Bioconductor](https://bioconductor.org/). R can be installed on any operating
system from [CRAN](https://cran.r-project.org/) after which you can install
iSEEtree by using the following commands in your R session:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("iSEEtree")
```

## 2.2 Example

The panels described above can be generated for a model TreeSE object in the
following example:

```
library(iSEEtree)
library(mia)
library(scater)

# Import TreeSE
data("Tengeler2020", package = "mia")
tse <- Tengeler2020

# Add relabundance assay
tse <- transformAssay(tse, method = "relabundance")

# Add reduced dimensions
tse <- runMDS(tse, assay.type = "relabundance")

# Launch iSEE
if (interactive()) {
  iSEE(tse)
}
```

![](data:image/png;base64...)

# 3 Resources

## 3.1 Open datasets

TreeSE objects can be constructed from raw data and standardised file formats.
However, several packages provide access to demonstration datasets used to
familiarise with the use of TreeSE objects. A complete list of resources is
available in the OMA chapter on
[Data Import](https://microbiome.github.io/OMA/docs/devel/pages/import.html#sec-example-data).

In addition, we provide the Microbiome Analysis Dashboard (miaDash), a web app
based on iSEEtree that offers a complete interface to import, analyse and
visualise microbiome data, or to easily access mia datasets for experimentation
purposes. The app is hosted online at
[this address](https://miadash-microbiome.2.rahtiapp.fi/) by the Finnish IT
Center for Science (CSC).

## 3.2 Other tutorials

Users interested in general topics about the iSEE interface are redirected to
the [documentation](https://isee.github.io/iSEE) of the iSEE parent package,
which provides ideas and solutions on how to:

* use iSEE with big data
* configure iSEE apps
* deploy custom panels
* share information across panels
* control the interface with speech

## 3.3 Citation

We hope that iSEEtree will be useful for your research. Please use the following
information to cite the package and the overall approach. Thank you!

```
citation("iSEEtree")
#> To cite iSEEtree in publications use:
#>
#>   Benedetti, G., Seraidarian, E., Pralas, T., Jeba, A. Borman, T., &
#>   Lahti, L. (2025). iSEEtree: interactive explorer for hierarchical
#>   data. Bioinformatics Advances.  doi:
#>   https://doi.org/10.1093/bioadv/vbaf107
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Article{,
#>     title = {iSEEtree: interactive explorer for hierarchical data},
#>     author = {Giulio Benedetti and Ely Seraidarian and Theotime Pralas and Akewak Jeba and Tuomas Borman and Leo Lahti},
#>     journal = {Bioinformatics Advances},
#>     year = {2025},
#>     doi = {https://doi.org/10.1093/bioadv/vbaf107},
#>   }
```

## 3.4 Acknowledgements

iSEEtree originates from the joint effort of the R/Bioconductor community. It is
mainly based on the following software:

* [R](https://www.r-project.org/), statistical programming language (R Core Team [2024](#ref-core2024r))
* [mia](https://bioconductor.org/packages/release/bioc/html/mia.html), framework for microbiome data analysis (Borman et al. [2024](#ref-borman2024mia))
* [iSEE](https://bioconductor.org/packages/release/bioc/html/iSEE.html), SummarizedExperiment interactive explorer (Rue-Albrecht et al. [2018](#ref-rue2018isee))
* [TreeSummarizedExperiment](https://bioconductor.org/packages/release/bioc/html/TreeSummarizedExperiment.htmlm), S4 container for hierarchical data (Huang et al. [2021](#ref-huang2021treesummarizedexperiment))
* [shiny](https://cran.r-project.org/web/packages/shiny/index.html), web app development in R (Chang et al. [2024](#ref-chang2024shiny))

If you are asking yourself the question “Where do I start using Bioconductor?”
you might be interested in
[this blog post](https://lcolladotor.github.io/2014/10/16/startbioc/#.VkOKbq6rRuU).

## 3.5 Help

As package developers, we try to explain clearly how to use our packages and in
which order to use the functions. But R and Bioconductor have a steep learning
curve so it is critical to learn where to ask for help. The blog post quoted
above mentions some but we would like to highlight the
[Bioconductor support site](https://support.bioconductor.org/) as the main
resource for getting help: remember to use the iSEEtree tag and check the
[older posts](https://support.bioconductor.org/t/iSEEtree/). Other alternatives
are available such as creating GitHub issues and tweeting. However, please note
that if you want to receive help you should adhere to the
[posting guidelines](https://www.bioconductor.org/help/support/posting-guide/).
It is particularly critical that you provide a small reproducible example and
your session information so package developers can track down the source of the
error.

# 4 Reproducibility

R session information:

```
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8    LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#>  [1] scater_1.38.0                   ggplot2_4.0.0                   scuttle_1.20.0
#>  [4] mia_1.18.0                      TreeSummarizedExperiment_2.18.0 Biostrings_2.78.0
#>  [7] XVector_0.50.0                  MultiAssayExperiment_1.36.0     iSEEtree_1.4.0
#> [10] iSEE_2.22.0                     SingleCellExperiment_1.32.0     SummarizedExperiment_1.40.0
#> [13] Biobase_2.70.0                  GenomicRanges_1.62.0            Seqinfo_1.0.0
#> [16] IRanges_2.44.0                  S4Vectors_0.48.0                BiocGenerics_0.56.0
#> [19] generics_0.1.4                  MatrixGenerics_1.22.0           matrixStats_1.5.0
#> [22] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] splines_4.5.1               later_1.4.4                 ggplotify_0.1.3             cellranger_1.1.0
#>   [5] tibble_3.3.0                polyclip_1.10-7             DirichletMultinomial_1.52.0 lifecycle_1.0.4
#>   [9] doParallel_1.0.17           miaViz_1.18.0               lattice_0.22-7              MASS_7.3-65
#>  [13] SnowballC_0.7.1             magrittr_2.0.4              sass_0.4.10                 rmarkdown_2.30
#>  [17] jquerylib_0.1.4             yaml_2.3.10                 httpuv_1.6.16               otel_0.2.0
#>  [21] DBI_1.2.3                   RColorBrewer_1.1-3          multcomp_1.4-29             abind_1.4-8
#>  [25] purrr_1.1.0                 fillpattern_1.0.2           ggraph_2.2.2                yulab.utils_0.2.1
#>  [29] TH.data_1.1-4               tweenr_2.0.3                rappdirs_0.3.3              sandwich_3.1-1
#>  [33] gdtools_0.4.4               circlize_0.4.16             ggrepel_0.9.6               tokenizers_0.3.0
#>  [37] irlba_2.3.5.1               tidytree_0.4.6              vegan_2.7-2                 rbiom_2.2.1
#>  [41] parallelly_1.45.1           permute_0.9-8               DelayedMatrixStats_1.32.0   codetools_0.2-20
#>  [45] DelayedArray_0.36.0         ggforce_0.5.0               xml2_1.4.1                  ggtext_0.1.2
#>  [49] DT_0.34.0                   tidyselect_1.2.1            shape_1.4.6.1               aplot_0.2.9
#>  [53] farver_2.1.2                ScaledMatrix_1.18.0         viridis_0.6.5               shinyWidgets_0.9.0
#>  [57] jsonlite_2.0.0              GetoptLong_1.0.5            BiocNeighbors_2.4.0         tidygraph_1.3.1
#>  [61] decontam_1.30.0             survival_3.8-3              iterators_1.0.14            emmeans_2.0.0
#>  [65] systemfonts_1.3.1           foreach_1.5.2               tools_4.5.1                 ggnewscale_0.5.2
#>  [69] ragg_1.5.0                  treeio_1.34.0               Rcpp_1.1.0                  glue_1.8.0
#>  [73] gridExtra_2.3               SparseArray_1.10.0          BiocBaseUtils_1.12.0        xfun_0.54
#>  [77] mgcv_1.9-3                  dplyr_1.1.4                 withr_3.0.2                 shinydashboard_0.7.3
#>  [81] BiocManager_1.30.26         fastmap_1.2.0               bluster_1.20.0              shinyjs_2.1.0
#>  [85] digest_0.6.37               rsvd_1.0.5                  R6_2.6.1                    mime_0.13
#>  [89] gridGraphics_0.5-1          estimability_1.5.1          textshaping_1.0.4           colorspace_2.1-2
#>  [93] listviewer_4.0.0            dichromat_2.0-0.1           tidyr_1.3.1                 fontLiberation_0.1.0
#>  [97] DECIPHER_3.6.0              graphlayouts_1.2.2          htmlwidgets_1.6.4           S4Arrays_1.10.0
#> [101] pkgconfig_2.0.3             gtable_0.3.6                ComplexHeatmap_2.26.0       S7_0.2.0
#> [105] janeaustenr_1.0.0           htmltools_0.5.8.1           fontBitstreamVera_0.1.1     bookdown_0.45
#> [109] rintrojs_0.3.4              clue_0.3-66                 scales_1.4.0                png_0.1-8
#> [113] ggfun_0.2.0                 knitr_1.50                  tzdb_0.5.0                  reshape2_1.4.4
#> [117] rjson_0.2.23                coda_0.19-4.1               nlme_3.1-168                shinyAce_0.4.4
#> [121] cachem_1.1.0                zoo_1.8-14                  GlobalOptions_0.1.2         stringr_1.5.2
#> [125] parallel_4.5.1              miniUI_0.1.2                vipor_0.4.7                 pillar_1.11.1
#> [129] grid_4.5.1                  vctrs_0.6.5                 slam_0.1-55                 promises_1.4.0
#> [133] BiocSingular_1.26.0         beachmat_2.26.0             xtable_1.8-4                cluster_2.1.8.1
#> [137] beeswarm_0.4.0              evaluate_1.0.5              readr_2.1.5                 mvtnorm_1.3-3
#> [141] cli_3.6.5                   compiler_4.5.1              rlang_1.1.6                 crayon_1.5.3
#> [145] tidytext_0.4.3              plyr_1.8.9                  fs_1.6.6                    ggbeeswarm_0.7.2
#> [149] ggiraph_0.9.2               stringi_1.8.7               viridisLite_0.4.2           BiocParallel_1.44.0
#> [153] lazyeval_0.2.2              colourpicker_1.3.0          fontquiver_0.2.1            Matrix_1.7-4
#> [157] hms_1.1.4                   patchwork_1.3.2             sparseMatrixStats_1.22.0    shiny_1.11.1
#> [161] gridtext_0.1.5              memoise_2.0.1               igraph_2.2.1                bslib_0.9.0
#> [165] ggtree_4.0.1                readxl_1.4.5                ape_5.8-1
```

# References

Borman, Tuomas, Felix G. M. Ernst, Sudarshan A. Shetty, and Leo Lahti. 2024. *Mia: Microbiome Analysis*. <https://doi.org/10.18129/B9.bioc.mia>.

Chang, Winston, Joe Cheng, JJ Allaire, Carson Sievert, Barret Schloerke, Yihui Xie, Jeff Allen, Jonathan McPherson, Alan Dipert, and Barbara Borges. 2024. *Shiny: Web Application Framework for R*. [https://CRAN.R-project.org/package=shiny](https://CRAN.R-project.org/package%3Dshiny).

Huang, Ruizhu, Charlotte Soneson, Felix GM Ernst, Kevin C Rue-Albrecht, Guangchuang Yu, Stephanie C Hicks, and Mark D Robinson. 2021. “TreeSummarizedExperiment: a S4 class for data with hierarchical structure.” *F1000Research* 9. <https://doi.org/10.12688/f1000research.26669.2>.

R Core Team. 2024. *R: A Language and Environment for Statistical Computing*. Vienna, Austria: R Foundation for Statistical Computing. <https://www.R-project.org/>.

Rue-Albrecht, Kevin, Federico Marini, Charlotte Soneson, and Aaron TL Lun. 2018. “iSEE: interactive SummarizedExperiment explorer.” *F1000Research* 7. <https://doi.org/10.12688/f1000research.14966.1>.