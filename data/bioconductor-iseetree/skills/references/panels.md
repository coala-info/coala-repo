Code

* Show All Code
* Hide All Code

# Panel Catalogue

Giulio Benedetti1\*

1University of Turku

\*giulio.benedetti@utu.fi

#### 30 October 2025

#### Package

iSEEtree 1.4.0

# 1 Introduction

This page introduces users to the complete catalogue of panels provided by
iSEEtree. Each panel is presented individually and visualised as it appears in
the app. This catalogue is divided into four sections:

* [compositional analysis](#sec-composition): abundance plot, abundance density
  plot, prevalence plot and complex heatmap plot
* [ordination analysis](#sec-ordination): RDA plot, Scree plot, loading plot and
  reduced dimension plot
* [structural analysis](#sec-structure): row/column tree plots and row/column
  graph plots
* [other](#sec-other): row/column tile plots, mediation plot and row/column data
  plots

# 2 Compositional Analysis

| Panel name | Panel class | Information |
| --- | --- | --- |
| Abundance plot | AbundancePlot | Feature abundance by sample |
| Abundance density plot | AbundanceDensityPlot | Feature distribution across samples |
| Prevalence plot | PrevalencePlot | Feature prevalence across samples |
| Feature assay plot | FeatureAssayPlot | Feature counts by column variable |
| Complex heatmap plot | ComplexHeatmapPlot | Counts by features and samples |

## 2.1 Abundance plot

The Abundance plot illustrates the feature composition of each sample with a
barplot of the relative or absolute feature abundace. This panel is based on the
miaViz function plotAbundance.

Supported operations:

* Selecting taxonomic rank of the composition
* Choosing either absolute or relative abundance
* Ordering samples by feature or sample metadata
* Customising aesthetics

![](data:image/png;base64...)

## 2.2 Abundance density plot

The Abundance density plot provides an alternative way to visualise abundance.
In this panel, each row represents the feature distribution across the samples.
It is based on the miaViz function plotAbundanceDensity.

Supported operations:

* selecting layout (jitter, density or dot plot)
* specifying the number of top features to show
* customising aesthetics

![](data:image/png;base64...)

## 2.3 Prevalence plot

The Prevalence plot provides an way to visualise feature prevalence across
samples. In this panel, each line represents the feature abundance across the
samples and prevalence is encoded by the colour. It is based on the miaViz
function plotPrevalence.

Supported operations:

* adjusting prevalence and detection thresholds
* selecting the taxonomic rank to show

![](data:image/png;base64...)

## 2.4 Feature assay plot

The Feature assay plot is inherited from iSEE. It is based on the
scater function plotRowData and can be used to visualise the counts of a
specific feature across samples grouped by a column variable.

See its image in the iSEE panel catalogue:
[FeatureAssayPlot](https://isee.github.io/panels.html#featureassayplot)

## 2.5 Complex heatmap plot

The Reduced dimension plot is inherited from iSEE. It is based on the
ComplexHeatmap function Heatmap, which shows an entire assay as a heatmap where
rows and columns represent features and samples, respectively. Hierarchical
clustering as well as grouping by a variable can be performed across both
dimensions.

See its image in the iSEE panel catalogue:
[ComplexHeatmapPlot](https://isee.github.io/panels.html#complexheatmapplot)

# 3 Ordination Analysis

| Panel name | Panel class | Information |
| --- | --- | --- |
| RDA plot | RDAPlot | Supervised ordination |
| Scree plot | ScreePlot | Explained variance by component |
| Loading plot | LoadingPlot | Feature loadings by component |
| Reduced dimension plot | ReducedDimensionPlot | Any ordination result |

## 3.1 RDA plot

The RDA plot visualises results for a distance-based Redundance Analysis (dbRDA)
performed on a TreeSE object with the mia function runRDA. It is based on the
miaViz function plotRDA.

Supported operations:

* selecting reduced dimension
* adjusting statistical parameters
* customising aesthetics

![](data:image/png;base64...)

## 3.2 Scree plot

The Scree plot shows the proportion of variance explained by each component
of a dimensionality reduction analysis by means of a line plot or barplot. It
is based on the miaViz function plotScree.

Supported operations:

* selecting reduced dimension
* changing number of components
* showing individual or cumulative variance
* adding components labels and names

![](data:image/png;base64...)

## 3.3 Loading plot

The Loading plot visualises the contributions of each feature to the components
of a reduced dimension of choice. It is based on the miaViz function
plotLoadings.

Supported operations:

* selecting layout (barplot, heatmap or lollipop)
* changing number of components
* adding feature tree

![](data:image/png;base64...)

## 3.4 Reduced dimension plot

The Reduced dimension plot is inherited from iSEE. It is based on the
scater function plotReducedDim and can be used to visualise the results
of an ordination analysis with both supervised and unsupervised methods as dot
plot with reduced dimensions as coordinate axes.

See its image in the iSEE panel catalogue:
[ReducedDimensionPlot](https://isee.github.io/panels.html#reduceddimensionplot)

# 4 Structural Analysis

| Panel name | Panel class | Information |
| --- | --- | --- |
| Row tree plot | RowTreePlot | Hierarchical structure of features |
| Column tree plot | ColumnTreePlot | Hierarchical structure of samples |
| Row graph plot | RowGraphPlot | Network structure of features |
| Column graph plot | ColumnGraphPlot | Network structure of samples |

## 4.1 Row/Column tree plots

Row and column tree plots belong to the TreePlot family. They can be used to
visualise the hierarchical organisation of the features or samples by means
of a tree. They are based on the miaViz functions plotRowTree and plotColTree.

Supported operations:

* collapsing and expanding clades
* rotating and opening trees
* ordering trees
* labeling nodes and tips
* selecting tree layout
* customising aesthetics

![](data:image/png;base64...)

## 4.2 Row/Column graph plots

Row and column graph plots belong to the GraphPlot family. They can be used to
visualise the network organisation of the features or samples by means of a
graph. They are based on the miaViz functions plotRowGraph and plotColGraph.

Supported operations:

* selecting graph and assay type
* labelling nodes
* selecting graph layout
* selecting edge type
* customising aesthetics

![](data:image/png;base64...)

# 5 Other panels

| Panel name | Panel class | Information |
| --- | --- | --- |
| Row tile plot | RowTilePlot | Variable distribution across feature groups |
| Column tile plot | ColumnTilePlot | Variable distribution across sample groups |
| Mediation plot | MediationPlot | Results of mediation analysis |
| Row data table | RowDataTable | Table of feature metadata |
| Column data table | ColumnDataTable | Table of sample metadata |
| Row data plot | RowDataPlot | Feature variable distribution |
| Column data plot | ColumnDataPlot | Sample variable distribution |

## 5.1 Row/Column tile plots

Coming soon!

## 5.2 Mediation plot

Coming soon!

## 5.3 Row/Column data tables

The Row and column data tables are inherited from iSEE. They are rendered as
a tidy table of feeature or sample variables, respectively. From those, it is
possible to select a subset of the observations and transmit it to one or many
other panels.

See their images in the iSEE panel catalogue:
[RowDataPlot](https://isee.github.io/panels.html#rowdataplot) and
[ColumnDataPlot](https://isee.github.io/panels.html#columndataplot)

## 5.4 Row/Column data plots

The Row and column data plots are inherited from iSEE. They are based on the
scater functions plotRowData and plotColData and can be used to visualise
feature or sample metadata as scatter plots when the x variable is continuous or
boxplots when the x variable is discrete.

See their images in the iSEE panel catalogue:
[RowDataTable](https://isee.github.io/panels.html#rowdatatable) and
[ColumnDataTable](https://isee.github.io/panels.html#columndatatable)

# 6 Reproducibility

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

# 7 References