# Adding third party plots

Samuel Wieczorek and Thomas Burger

#### 2025-11-20

#### Abstract

The package `omXplore` is able to embed third party plots. This vignette aims to explain how to add an external plot to the main UI of `omXplore`.

#### Package

omXplore 1.4.2

# 1 Introduction

An interesting feature about `omXplore` is the capacity to insert custom
plots into the collection of vignettes of the Shiny app
`view_dataset()`. This is useful to complete the panel of built-in plots
of `omXplore` and the main UI (See ?view\_dataset).

This vignette aims to describe how to (i) develop a plot function
compliant with `omXplore` and (ii) add a new plot in the main app of the
package `omXplore`.

# 2 Develop a plot module for `omXplore`

Any plot function, to be compatible with `omXplore`, must be written as
a [shiny module](https://shiny.posit.co/r/articles/improve/modules/) to
allow for better code organisation and re-usability. Let suppose one
wants to write a plot called “myFirstPlot”. As usual, the code of this
shiny app is divided into two parts:

* User interface (UI): function “myFirstPlot\_ui()”
* Server: function “myFirstPlot\_server()”

Moreover, the parameters of these two functions must have the same name
and class as the built-in plot functions in `omXplore` . For more
details, see ?extFoo1 which is a simple example of what a generic plot
function should looks like.

Following Bioconductor’s recommendations about [Running shiny
apps](https://contributions.bioconductor.org/shiny.html#running-app),
the source code for this plot function should look as follows:

```
myFirstPlot <- function(obj, i) {
    ui <- myFirstPlot_ui(id)
    server <- myFirstPlot_server(id, obj, i)
    app <- shinyApp(ui = ui, server = server)
}
```

These three functions (myFirstPlot\_ui(), myFirstPlot\_server() and
myFirstPlot()) can be written in the same source file (e.g.
myFirstPlot.R)

# 3 Adding an existing module

## 3.1 From a R package

When one wants to add an external plot from a R package, it is by means
of the parameter ‘addons’ of the function `view_dataset()`. This
parameter is a list structured as follows:

* the name of each slot is the name of a R package in which a plot
  module is implemented,
* the content of the slot is a vector of modules names.

It is necessary that the functions \*\_ui() and \*\_server are defined outside the global app function myFirstPlot(). This is because the function “view\_dataset” cannot use the function myFirstPlot() and it must use the two functions myFirstPlot\_ui(), myFirstPlot\_server().

Thus, the following code **will not work**:

```
myFirstPlot <- function(obj, i) {
    ui <- function(id) {
        ...
    }
    server <- function(id, obj, i) {
        moduleServer(
            id,
            function(input, output, session) {
                ...
            }
        )
    }

    app <- shinyApp(ui = ui, server = server)
}
```

A functional code is as follows:

```
myFirstPlot_ui <- function(id) {
    ...
}

myFirstPlot_server <- function(id, obj, i) {
    moduleServer(
        id,
        function(input, output, session) {
            ...
        }
    )
}

myFirstPlot <- function(obj, i) {
    ui <- myFirstPlot_ui(id)
    server <- myFirstPlot_server(id, obj, i)
    app <- shinyApp(ui = ui, server = server)
}
```

As an example, the code below will add three external plots:

* package `myPkgA`: the plot functions “extFoo1” and “extFoo2”,
* package `myPkgB`: the plot function “extFoo1”.

The corresponding R code is the following:

```
addons <- list(
    myPkgA = c("extFoo1", "extFoo2"),
    myPkgB = c("extFoo1")
)
view_dataset(myData, addons)
```

Functions can have same names if they are part of different packages.

With this procedure, it is not necessary to load the entire package in
order to user the plot module. `omXplore` loads only the necessary code for the plot fucntions.

**Icon for clickable vignette**

If the plot function is part of a R package, it is possible to store a
\*.png image that serves as icon for the clickable vignette displayed in
the (B) area of the main app of `omXplore`. For that purpose,
the file should be stored in the ‘images’ directory of the corresponding
package and its name should be the same as the function it refers to.

The global file structure for the plot function of the example is the
following:

```
MyPackage/
|-- R/
|   |-- myFirstPlot.R
|-- inst/
|   |-- images/
|       |-- myFirstPlot.png
```

## 3.2 From R console

If the plot function is written in a R script nor console, the same rules are used to write the three functions described in the previous section.

However, there are two important modifications:

* the name of the three functions must be prefixed by "omXplore\_’
* so as to let `omXplore` find the plot function, it must already be loaded in the global R environment before running the app `view_dataset()`. Please note that in this case, there is to need to set the parameter “addons”.

```
omXplore_mySecondPlot <- function(obj, i) {
    ui <- omXplore_mySecondPlot_ui(id)
    server <- omXplore_mySecondPlot_server(id, obj, i)
    app <- shinyApp(ui = ui, server = server)
}
```

## 3.3 Session information

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
## [1] omXplore_1.4.2   BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] MultiAssayExperiment_1.36.1 magrittr_2.0.4
##   [5] TH.data_1.1-5               estimability_1.5.1
##   [7] shinyjqui_0.4.1             MALDIquant_1.22.3
##   [9] farver_2.1.2                rmarkdown_2.30
##  [11] fs_1.6.6                    vctrs_0.6.5
##  [13] BiocBaseUtils_1.12.0        htmltools_0.5.8.1
##  [15] S4Arrays_1.10.0             curl_7.0.0
##  [17] broom_1.0.10                SparseArray_1.10.2
##  [19] mzID_1.48.0                 TTR_0.24.4
##  [21] sass_0.4.10                 KernSmooth_2.23-26
##  [23] bslib_0.9.0                 htmlwidgets_1.6.4
##  [25] plyr_1.8.9                  sandwich_3.1-1
##  [27] impute_1.84.0               emmeans_2.0.0
##  [29] zoo_1.8-14                  lubridate_1.9.4
##  [31] cachem_1.1.0                igraph_2.2.1
##  [33] iterators_1.0.14            mime_0.13
##  [35] lifecycle_1.0.4             pkgconfig_2.0.3
##  [37] Matrix_1.7-4                R6_2.6.1
##  [39] fastmap_1.2.0               MatrixGenerics_1.22.0
##  [41] shiny_1.11.1                clue_0.3-66
##  [43] digest_0.6.39               pcaMethods_2.2.0
##  [45] S4Vectors_0.48.0            GenomicRanges_1.62.0
##  [47] Spectra_1.20.0              timechange_0.3.0
##  [49] abind_1.4-8                 compiler_4.5.2
##  [51] doParallel_1.0.17           S7_0.2.1
##  [53] backports_1.5.0             BiocParallel_1.44.0
##  [55] viridis_0.6.5               dendextend_1.19.1
##  [57] gplots_3.2.0                MASS_7.3-65
##  [59] DelayedArray_0.36.0         scatterplot3d_0.3-44
##  [61] gtools_3.9.5                caTools_1.18.3
##  [63] mzR_2.44.0                  flashClust_1.01-2
##  [65] tools_4.5.2                 PSMatch_1.14.0
##  [67] otel_0.2.0                  quantmod_0.4.28
##  [69] httpuv_1.6.16               FactoMineR_2.12
##  [71] glue_1.8.0                  QFeatures_1.20.0
##  [73] promises_1.5.0              grid_4.5.2
##  [75] reshape2_1.4.5              cluster_2.1.8.1
##  [77] generics_0.1.4              gtable_0.3.6
##  [79] shinyBS_0.61.1              preprocessCore_1.72.0
##  [81] sm_2.2-6.0                  tidyr_1.3.1
##  [83] MetaboCoreUtils_1.18.1      data.table_1.17.8
##  [85] XVector_0.50.0              BiocGenerics_0.56.0
##  [87] foreach_1.5.2               ggrepel_0.9.6
##  [89] pillar_1.11.1               stringr_1.6.0
##  [91] limma_3.66.0                later_1.4.4
##  [93] splines_4.5.2               dplyr_1.1.4
##  [95] lattice_0.22-7              survival_3.8-3
##  [97] tidyselect_1.2.1            vioplot_0.5.1
##  [99] knitr_1.50                  gridExtra_2.3
## [101] bookdown_0.45               IRanges_2.44.0
## [103] Seqinfo_1.0.0               ProtGenerics_1.42.0
## [105] SummarizedExperiment_1.40.0 stats4_4.5.2
## [107] xfun_0.54                   Biobase_2.70.0
## [109] statmod_1.5.1               factoextra_1.0.7
## [111] MSnbase_2.36.0              matrixStats_1.5.0
## [113] DT_0.34.0                   visNetwork_2.1.4
## [115] stringi_1.8.7               lazyeval_0.2.2
## [117] yaml_2.3.10                 evaluate_1.0.5
## [119] codetools_0.2-20            nipals_1.0
## [121] MsCoreUtils_1.22.0          tibble_3.3.0
## [123] BiocManager_1.30.27         affyio_1.80.0
## [125] multcompView_0.1-10         cli_3.6.5
## [127] xtable_1.8-4                jquerylib_0.1.4
## [129] dichromat_2.0-0.1           Rcpp_1.1.0
## [131] coda_0.19-4.1               XML_3.99-0.20
## [133] parallel_4.5.2              leaps_3.2
## [135] ggplot2_4.0.1               assertthat_0.2.1
## [137] AnnotationFilter_1.34.0     bitops_1.0-9
## [139] viridisLite_0.4.2           mvtnorm_1.3-3
## [141] rlist_0.4.6.2               affy_1.88.0
## [143] scales_1.4.0                xts_0.14.1
## [145] ncdf4_1.24                  purrr_1.2.0
## [147] highcharter_0.9.4           rlang_1.1.6
## [149] vsn_3.78.0                  multcomp_1.4-29
## [151] shinyjs_2.1.0
```