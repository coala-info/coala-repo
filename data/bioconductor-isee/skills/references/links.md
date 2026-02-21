# Sharing information across iSEE panels

Kevin Rue-Albrecht1\*, Federico Marini2,3\*\*, Charlotte Soneson4,5\*\*\* and Aaron Lun\*\*\*\*

1MRC WIMM Centre for Computational Biology, University of Oxford, Oxford, OX3 9DS, UK
2Institute of Medical Biostatistics, Epidemiology and Informatics (IMBEI), Mainz
3Center for Thrombosis and Hemostasis (CTH), Mainz
4Friedrich Miescher Institute for Biomedical Research, Basel, Switzerland
5SIB Swiss Institute of Bioinformatics

\*kevinrue67@gmail.com
\*\*marinif@uni-mainz.de
\*\*\*charlottesoneson@gmail.com
\*\*\*\*infinite.monkeys.with.keyboards@gmail.com

#### 30 October 2025

#### Package

iSEE 2.22.0

**Compiled date**: 2025-10-30

**Last edited**: 2020-04-20

**License**: MIT + file LICENSE

# 1 Introduction

One of *[iSEE](https://bioconductor.org/packages/3.22/iSEE)*’s main features is the ability to share information between panels.
This facilitates deeper exploration of a dataset by allowing users to visualize relationships across multiple metrics.
`iSEE()` currently supports three modes of information sharing between panels - multiple selections, single selections and dynamic selections - which are demonstrated in this vignette using the Allen dataset processed in the [previous vignette](https://bioconductor.org/packages/3.22/iSEE/vignettes/basic.html).

# 2 Multiple selections

## 2.1 Basic use

As its name suggests, this involves selecting multiple features or samples in one panel and transmitting their identities to another panel to affect the visualization.
To demonstrate, we will create a small app involving a single reduced dimension plot and a column metadata plot.

```
library(iSEE)
app <- iSEE(sce, initial=list(
    ReducedDimensionPlot(),
    ColumnDataPlot()
))
```

![](data:image/png;base64...)

We indicate that we want one panel to “receive” a multiple selection from another panel.
This is done by specifying the selection source (for samples/columns in this case, given the nature of the two panels)
and indicating that the column data plot is to receive a selection from the reduced dimension plot.

![](data:image/png;base64...)

We can click-and-drag to select multiple points in the reduced dimension plot with a brush,
which highlights those same points in the column data plot.
This enables users to easily explore relationships between different visualizations in the `iSEE()` interface.

![](data:image/png;base64...)

Alternatively, a single click will lay down lasso waypoints for a non-rectangular selection.
Once closed, the points in the lasso will be transmitted to the column data plot.

![](data:image/png;base64...)

## 2.2 Selection effects

Transparency is the default aesthetic effect used to distinguish points in multiple selections in receiving plots.
Alternatively, we may use color:

![](data:image/png;base64...)

Another option is to restrict the receiving plot so that it only shows the points in the multiple selection.
This effectively “gates” the dataset on the selection in the reduced dimension plot,
analogous to identification populations of interest in flow cytometry studies.
Indeed, this gating process can be repeated as many times as desired;
a multiple selection could made on the column data plot and transmitted to another panel, and so on.
(See [this mass cytometry tour](https://github.com/iSEE/iSEE2018/blob/master/tours/cytof/app.R) for an example.)

![](data:image/png;base64...)

Of course, not all receiving panels need to be plots.
If we transmit a multiple selection to a column data table,
the effect is to subset the rows of the table corresponding to the selected points.

![](data:image/png;base64...)

As an aside, it is equally possible for a table to transmit a multiple selection to other panels.
This is achieved using the search fields to subset the dataset to the desired selection.

![](data:image/png;base64...)

## 2.3 Saving selections

In certain panels (usually plots), multiple selections can be saved to form disjoint selections.
Receiving plots will respond to the union of all active and saved selections:

![](data:image/png;base64...)

The saved selection history operates on a first-in-last-out basis.
Upon saving, a snapshot is taken of the current “active” selection, i.e., the brush or lasso that is just created.
Deletion will only operate on the last saved selection.

# 3 Single selections

Another mode of information sharing involves transmitting a selection of a single feature or sample.
This allows users to conveniently direct other panels to focus on a feature or sample of interest.
For example, we can transmit a single selection from a row data table to a reduced dimension plot,
instructing the latter to color points by the expression of the chosen feature.

![](data:image/png;base64...)

The same approach can be used to control what is plotted on a feature assay plot.
Clicking on a different row of the table will directly change the axes (in this case, the y-axis) of the plot,
allowing the user to synchronise different aspects of the `iSEE()` interface to whatever is currently of interest.

![](data:image/png;base64...)

We can also perform single selections on sample identities.
In the example below, the reduced dimension plot highlights the location of the sample chosen in the column data table.
This is useful for checking the behavior of specific samples of interest, e.g., during quality control.

![](data:image/png;base64...)

Furthermore, it is possible to transmit single selections from a plot using brushes or lassos.
If the brush/lasso contains multiple points, one of them is arbitrarily chosen for the purposes of obtaining a single selection.
Below, we select a single highly variable gene to examine its distribution of expression values across the reduced dimension plot.

![](data:image/png;base64...)

# 4 Dynamic selections

Most panels will have an option to dynamically change the choice of transmitting panel according to the last active selection in the app.
This allows users to, for example, simply brush on any plot in the app and have all participating receiving panels immediately use that selection without requiring manual resetting of the transmitter.
To illustrate, let’s set up an instance with three different plots that all represent points as samples.

![](data:image/png;base64...)

Notice how we have checked the dynamic source selection option in the selection parameter box for all panels.
This means that, upon making a selection in any one of the plots, all of the other plots will automatically respond as if they had been manually set to receive a transmission from that plot.

![](data:image/png;base64...)

The same logic applies for some parameters that respond to single selections.
This allows a panel to respond to an appropriate single selection from any other panel in the interface,
without requiring the user to manually set the relationship between panels.
In the example below, users can easily define the y-axis of the feature assay plot from a selected row in the row data table or from a selected single point in the row data plot.

![](data:image/png;base64...)

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
#>  [1] TENxPBMCData_1.27.0         HDF5Array_1.38.0
#>  [3] h5mread_1.2.0               rhdf5_2.54.0
#>  [5] DelayedArray_0.36.0         SparseArray_1.10.0
#>  [7] S4Arrays_1.10.0             abind_1.4-8
#>  [9] Matrix_1.7-4                scater_1.38.0
#> [11] ggplot2_4.0.0               scuttle_1.20.0
#> [13] scRNAseq_2.23.1             iSEE_2.22.0
#> [15] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#> [17] Biobase_2.70.0              GenomicRanges_1.62.0
#> [19] Seqinfo_1.0.0               IRanges_2.44.0
#> [21] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [23] generics_0.1.4              MatrixGenerics_1.22.0
#> [25] matrixStats_1.5.0           BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] splines_4.5.1            later_1.4.4              BiocIO_1.20.0
#>   [4] bitops_1.0-9             filelock_1.0.3           tibble_3.3.0
#>   [7] XML_3.99-0.19            lifecycle_1.0.4          httr2_1.2.1
#>  [10] doParallel_1.0.17        lattice_0.22-7           ensembldb_2.34.0
#>  [13] alabaster.base_1.10.0    magrittr_2.0.4           sass_0.4.10
#>  [16] rmarkdown_2.30           jquerylib_0.1.4          yaml_2.3.10
#>  [19] httpuv_1.6.16            otel_0.2.0               DBI_1.2.3
#>  [22] RColorBrewer_1.1-3       Rtsne_0.17               purrr_1.1.0
#>  [25] AnnotationFilter_1.34.0  RCurl_1.98-1.17          rappdirs_0.3.3
#>  [28] circlize_0.4.16          ggrepel_0.9.6            irlba_2.3.5.1
#>  [31] alabaster.sce_1.10.0     codetools_0.2-20         DT_0.34.0
#>  [34] tidyselect_1.2.1         shape_1.4.6.1            UCSC.utils_1.6.0
#>  [37] farver_2.1.2             viridis_0.6.5            ScaledMatrix_1.18.0
#>  [40] shinyWidgets_0.9.0       BiocFileCache_3.0.0      GenomicAlignments_1.46.0
#>  [43] jsonlite_2.0.0           GetoptLong_1.0.5         BiocNeighbors_2.4.0
#>  [46] iterators_1.0.14         foreach_1.5.2            tools_4.5.1
#>  [49] Rcpp_1.1.0               glue_1.8.0               gridExtra_2.3
#>  [52] xfun_0.53                mgcv_1.9-3               GenomeInfoDb_1.46.0
#>  [55] dplyr_1.1.4              gypsum_1.6.0             shinydashboard_0.7.3
#>  [58] withr_3.0.2              BiocManager_1.30.26      fastmap_1.2.0
#>  [61] rhdf5filters_1.22.0      shinyjs_2.1.0            digest_0.6.37
#>  [64] rsvd_1.0.5               R6_2.6.1                 mime_0.13
#>  [67] colorspace_2.1-2         listviewer_4.0.0         dichromat_2.0-0.1
#>  [70] RSQLite_2.4.3            cigarillo_1.0.0          rtracklayer_1.70.0
#>  [73] httr_1.4.7               htmlwidgets_1.6.4        pkgconfig_2.0.3
#>  [76] gtable_0.3.6             blob_1.2.4               ComplexHeatmap_2.26.0
#>  [79] S7_0.2.0                 XVector_0.50.0           htmltools_0.5.8.1
#>  [82] bookdown_0.45            ProtGenerics_1.42.0      rintrojs_0.3.4
#>  [85] clue_0.3-66              scales_1.4.0             alabaster.matrix_1.10.0
#>  [88] png_0.1-8                knitr_1.50               rjson_0.2.23
#>  [91] nlme_3.1-168             curl_7.0.0               shinyAce_0.4.4
#>  [94] cachem_1.1.0             GlobalOptions_0.1.2      BiocVersion_3.22.0
#>  [97] parallel_4.5.1           miniUI_0.1.2             vipor_0.4.7
#> [100] AnnotationDbi_1.72.0     restfulr_0.0.16          pillar_1.11.1
#> [103] grid_4.5.1               alabaster.schemas_1.10.0 vctrs_0.6.5
#> [106] promises_1.4.0           BiocSingular_1.26.0      dbplyr_2.5.1
#> [109] beachmat_2.26.0          xtable_1.8-4             cluster_2.1.8.1
#> [112] beeswarm_0.4.0           evaluate_1.0.5           GenomicFeatures_1.62.0
#> [115] cli_3.6.5                compiler_4.5.1           Rsamtools_2.26.0
#> [118] rlang_1.1.6              crayon_1.5.3             ggbeeswarm_0.7.2
#> [121] viridisLite_0.4.2        alabaster.se_1.10.0      BiocParallel_1.44.0
#> [124] Biostrings_2.78.0        lazyeval_0.2.2           colourpicker_1.3.0
#> [127] ExperimentHub_3.0.0      bit64_4.6.0-1            Rhdf5lib_1.32.0
#> [130] KEGGREST_1.50.0          shiny_1.11.1             alabaster.ranges_1.10.0
#> [133] AnnotationHub_4.0.0      fontawesome_0.5.3        igraph_2.2.1
#> [136] memoise_2.0.1            bslib_0.9.0              bit_4.6.0
```