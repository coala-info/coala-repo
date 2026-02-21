# omXplore: a versatile series of Shiny apps to explore ‘omics’ data

Samuel Wieczorek and Thomas Burger

#### 2025-11-20

#### Abstract

The package omXplore (standing for “Omics Explore”) is a R package which provides functions to vizualize omics data experiments. It deals with common data formats in Bioconductor such as MSnSet, MultiAssayEperiments, QFeatures or even simple lists.

#### Package

omXplore 1.4.2

# 1 Introduction

The `omXplore` package offers a series of built-in plots dedicated to
the visualization and the analysis of \*omics (genomic, transcriptomics,
proteomics) data. As for several R packages available in `Bioconductor`
for exploring omics-like datasets, `omXplore` is based on Shiny to make
those plots easily available in a web application. Four popular
Bioconductor data objects are currently supported:
`SummarizedExperiment`, `MultiAssayExperiment`, `MSnset` and
`QFeatures.`It is also possible to use `data.frame` or `matrix` (or
lists of) which contains quantitative data tables (rows for features and
columns for samples).

All these formats are automatically converted into an internal S4 class
which is an enriched version of the `MultiAssayexperiment` class. This
process is invisible to the end-user.

The package `omXplore` was created to be versatile, reusable and
scalable. It differs from similar R packages in two main points:

* (versatile) The main Shiny module in `omXplore` is a hub which gives
  access to the individual plots. The plots are automatically updated
  w.r.t the selected dataset (in case of data which contains several
  ExperimentData like the classes `MultiAssayExperiment` or
  `QFeatures`).
* (scalable) with less effort, it is easy integrate external plots
  (written as Shiny modules) in the main GUI of `omXplore`.
* (reusable) Each plot (a Shiny module) can be run alone or integrated
  as a complementary tool in third party Shiny apps. As an example, it
  is well suited for the package
  [Prostar](https://www.bioconductor.org/packages/release/bioc/html/Prostar.html)
  in which it is used.

# 2 Features

`omXplore` provides a graphical user interface using the `Shiny` and the
`highcharter` packages for the following visualizations:

* Connected Components of graph-type data (e.g. in proteomics
  datasets, graphs of peptide-protein relationship),
* Principal Component Analysis (PCA),
* Histograms to analyze the quantitative data based on cell metadata
  (eg missing values, imputed values, …),
* Intensity plots (boxplot and violinplot) of quantitative data. There
  is also a tool to select and view (by superimposition) the evolution
  of intensity over samples for a given set of entities,
* Density plot
* Variance distribution plot
* Heatmap
* Correlation plot

For developers or users who wants to enhance their application,
additional features include:

* As each plot is a Shiny module, it can be launched in a standalone
  mode (from a R console) or it can be easily integrated into any
  third party Shiny app
* Internal convert function from a large variety of `Bioconductor`
  objects,
* A easy way to add user-defined plots (written as Shiny modules) in
  the main GUI of `omXplore`

# 3 Installation

To install this package, start R (version “4.3”) and enter:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("omXplore")
```

This will also install dependencies.

It is also possible to install `omXplore` from Github:

```
library(devtools)
install_github('edyp-lab/omXplore')
```

Then, load the package into R environment:

```
library("omXplore")
```

# 4 Enriching native MultiAssayExperiment

The internal data struture used in `omXplore` is based on the class
[MultiAssayExperiments](https://www.bioconductor.org/packages/release/bioc/html/MultiAssayExperiment.html)
which is enriched with specific slots needed to create built-in plots.
The plots display statistical information about data contained in the
SummarizedExperiment slots of a dataset.

Some items are added to the metadata of the instance of
MultiAssayExperiment and to each of the instances of
SummarizedExperiment.

**Additional info in MultiAssayExperiment**

Currently, there is no custom slot in the metadata of the mae contains
the following additional items (in the slot names `other`):

```
data(vdata)
MultiAssayExperiment::metadata(vdata)
```

```
## $other
## list()
```

**Additional info in SummarizedExperiment**

The metadata of each SummarizedExperiment dataset contains the following
items:

* **proteinID**: the name of the column which contains xxx
* **colID**: the name of the column which serves as unique index
* **cc**: the list of Connected Components, based on the adjacency
  matrix (if exists)
* **type**: the type of data contained in the current Experiment (e.g.
  peptide, protein, …)
* **pkg\_version**: the name and version number which has been used to
  create the current Experiment.

```
data(vdata)
MultiAssayExperiment::metadata(vdata[[1]])
```

```
## $pkg_version
## NULL
##
## $type
## [1] "protein"
##
## $colID
## [1] "protID"
##
## $proteinID
## [1] "protID"
##
## $cc
## $cc[[1]]
## 1 x 1 sparse Matrix of class "dgCMatrix"
##        proteinID_1
## prot_1           1
##
## $cc[[2]]
## 1 x 1 sparse Matrix of class "dgCMatrix"
##        proteinID_2
## prot_2           1
##
## $cc[[3]]
## 1 x 1 sparse Matrix of class "dgCMatrix"
##        proteinID_3
## prot_3           1
##
## $cc[[4]]
## 1 x 1 sparse Matrix of class "dgCMatrix"
##        proteinID_4
## prot_4           1
##
## $cc[[5]]
## 1 x 1 sparse Matrix of class "dgCMatrix"
##        proteinID_5
## prot_5           1
```

The **adjacencyMatrix** (when exists) is stored as a DataFrame in the
rowData() of a SummarizedExperiment itemµ.

All modules are self-contained in the sense that it is not necessary to
manipulate datasets to view the plots. The information described above
are given only to discover the slots used if the user wants to enrich
its dataset before using omXplore.

# 5 Using omXplore

The package `omXplore` offers a collection of standard plots written as
Shiny modules. The main app is a Shiny module itself which displays the
plots of each module.

This section describes how to view built-in plots and the main app of
`omXplore`.

## 5.1 Individual built-in plots

The list of plots available in the current R session via omXplore can be
obtained with:

```
listPlotModules()
```

```
## [1] "omXplore_cc"          "omXplore_corrmatrix"  "omXplore_density"
## [4] "omXplore_heatmap"     "omXplore_intensity"   "omXplore_pca"
## [7] "omXplore_tabExplorer" "omXplore_variance"
```

By default, this function lists the built-in modules and the external
modules compliant with omXplore.

Each of these functions is a Shiny app implemented as a module and can
be launched in a standalone mode or embedded in another shiny app (as it
is the case with the main UI of `omXplore` or inserted in a third party
Shiny app).

Most of these functions analyse the data contained in an Experiment of
the dataset (an instance of the class `SummarizedExperiment`). For a
sake of simplicity, they all have the same two parameters: (1) the
dataset in any (compatible) format (See the help page of the plot
functions for details) and (2) the indice of the assay to analyse (See
[MultiAssayExperiment](https://www.bioconductor.org/packages/release/bioc/html/MultiAssayExperiment.html)).

Internally, each function builds the enriched instance of MAE used
inside omXplore then show the plot for the assay which has been
specified in parameters.

```
data(sub_R25)
app <- omXplore_density(sub_R25, 1)
shiny::runApp(app)
```

Note: this code to run a shiny app follows the recommendations of
Bioconductor on [Running Shiny
apps](https://contributions.bioconductor.org/shiny.html#running-app).

![Plot generated by the module omXplore_density()](data:image/png;base64...)

(#fig:omXplore\_density\_png)Plot generated by the module omXplore\_density()

## 5.2 Main UI

As it is 9described in the previous section, omXplore have several
built-in plots. And it may be fastidious to launch each plot function
one after one to completely analyze a dataset.

For that purpose, `omXplore` has another shiny app, called
`view_dataset()` which acts as a hub for plots to facilitate the analyse
of the different assays in a dataset. It is launched as follows:

```
data(sub_R25)
app <- view_dataset(sub_R25)
shiny::runApp(app)
```

The resulting UI is the following:

![`omXplore` interactive interface with modal.](data:image/png;base64...)

(#fig:example\_view\_dataset\_nomodal\_png)`omXplore` interactive interface with modal.

The interface is divided in three parts.

**(A) Choosing the assay**

A widget let the user select one of the experiments contained in the
dataset.

**(B) Select which plot to display**

A series of clickable vignettes which represent the different plots
available. When the user clicks on a vignette, the corresponding plot is
displayed (See are C).

**(C) Viewing the plots**

The plots are displayed in the same window as the UI (below the
vignettes) or in a modal window, depending of the option used to launch
the Shinyp app (See `?view_dataset`).

![`omXplore` interactive interface with modal.](data:image/png;base64...)

(#fig:view\_dataset\_nomodal\_png)`omXplore` interactive interface with modal.

When a plot is displayed, it shows the data corresponding to the dataset
selected in the widget (of the left side). If this dataset is changed,
the plot is automatically updated with the data of the new dataset.

# 6 Session information

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