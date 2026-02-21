# The `iSEEfier` User’s Guide

Najla Abassi1\* and Federico Marini1,2\*\*

1Institute of Medical Biostatistics, Epidemiology and Informatics (IMBEI), Mainz
2Research Center for Immunotherapy (FZI), Mainz

\*najla.abassi@uni-mainz.de
\*\*marinif@uni-mainz.de

#### 30 October 2025

# 1 Introduction

This vignette describes how to use the *[iSEEfier](https://bioconductor.org/packages/3.22/iSEEfier)*
package to configure various initial states of iSEE instances, in order to
simplify the task of visualizing single-cell RNA-seq, bulk RNA-seq data, or even
your proteomics data in *[iSEE](https://bioconductor.org/packages/3.22/iSEE)*.
In the remainder of this vignette, we will illustrate the main features of `r BiocStyle::Biocpkg("iSEEfier")` on a publicly available dataset from Baron et
al. “A Single-Cell Transcriptomic Map of the Human and Mouse Pancreas Reveals
Inter- and Intra-cell Population Structure”, published in Cell Systems in 2016.
[doi:10.1016/j.cels.2016.08.011](https://doi.org/10.1016/j.cels.2016.08.011).
The data is made available via the *[scRNAseq](https://bioconductor.org/packages/3.22/scRNAseq)*
Bioconductor package. We’ll simply use the mouse dataset, consisting of islets
isolated from five C57BL/6 and ICR mice.
# Getting started {#gettingstarted}
To install *[iSEEfier](https://bioconductor.org/packages/3.22/iSEEfier)* package, we start R and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("iSEEfier")
```

Once installed, the package can be loaded and attached to the current workspace
as follows:

```
library("iSEEfier")
```

# 2 Create an initial state for gene expression visualization using `iSEEinit()`

When we have all input elements ready, we can create an `iSEE` initial state by
running:

```
iSEEinit(sce = sce_obj,
         features = feature_list,
         reddim.type = reduced_dim,
         clusters = cluster,
         groups = group,
         add_markdown_panel = FALSE)
```

To configure the initial state of our `iSEE` instance using `iSEEinit()`, we
need five parameters:

1. `sce` : A `SingleCellExperiment` object. This object stores information of
   different quantifications (counts, log-expression…), dimensionality reduction
   coordinates (t-SNE, UMAP…), as well as some metadata related to the samples
   and features.
   We’ll start by loading the `sce` object:

```
library("scRNAseq")
sce <- BaronPancreasData('mouse')
sce
#> class: SingleCellExperiment
#> dim: 14878 1886
#> metadata(0):
#> assays(1): counts
#> rownames(14878): X0610007P14Rik X0610009B22Rik ... Zzz3 l7Rn6
#> rowData names(0):
#> colnames(1886): mouse1_lib1.final_cell_0001 mouse1_lib1.final_cell_0002
#>   ... mouse2_lib3.final_cell_0394 mouse2_lib3.final_cell_0395
#> colData names(2): strain label
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
```

Let’s add the normalized counts

```
library("scuttle")
sce <- logNormCounts(sce)
```

Now we can add different dimensionality reduction coordinates

```
library("scater")
sce <- runPCA(sce)
sce <- runTSNE(sce)
sce <- runUMAP(sce)
```

Now our `sce` is ready, we can move on to the next argument.

2. `features` : which is a vector or a dataframe containing the genes/features
   of interest.
   Let’s say we would like to visualize the expression of some genes that were
   identified as marker genes for different cell population.

```
gene_list <- c("Gcg", # alpha
               "Ins1") # beta
```

3. `reddim_type` : In this example we decided to plot our data as a t-SNE plot.

```
reddim_type <- "TSNE"
```

4. `clusters` : Now we specify what clusters/cell-types/states/samples we would
   like to color/split our data with

```
# cell populations
cluster <- "label" #the name should match what's in the colData names
```

5. `groups` : Here we can add the groups/conditions/cell-types

```
# ICR vs C57BL/6
group <- "strain" #the name should match what's in the colData names
```

We can choose to include in this initial step a `MarkdownBoard` by setting the arguments
`add_markdown_panel` to `TRUE`.
At this point, all the elements are ready to be transferred into `iSEEinit()`

```
initial1 <- iSEEinit(sce = sce,
                    features = gene_list,
                    clusters = cluster,
                    groups = group,
                    add_markdown_panel = TRUE)
```

In case our `features` parameter was a data.frame, we could assign the name of the column containing the features to the `gene_id` parameter.

Now we are one step away from visualizing our list of genes of interest. All
that’s left to do is to run `iSEE` with the initial state created with
`iSEEinit()`

```
library("iSEE")
iSEE(sce, initial= initial1)
```

This instance, generated with `iSEEinit()`, returns a combination of panels,
linked to each other, with the goal of visualizing the expression of certain
marker genes in each cell population/group:

* A `ReducedDimensionPlot`, `FeatureAssayPlot` and `RowDataTable` for each single gene in `features`.
* A `ComplexHeatmapPlot` with all genes in `features`
* A `ColumnDataPlot` panel
* A `MarkdownBoard` panel

# 3 Create an initial state for feature sets exploration using `iSEEnrich()`

Sometimes it is interesting to look at some specific feature sets and the
associated genes. That’s when the utility of `iSEEnrich` becomes apparent. We
will need 4 elements to explore feature sets of interest:

* `sce`: A SingleCellExperiment object
* `collection`: A character vector specifying the gene set collections of interest (it is possible to use GO or KEGG terms)
* `gene_identifier`: A character string specifying the identifier to use to extract gene IDs for the organism package. This can be **“ENS”** for ENSEMBL ids, **“SYMBOL”** for gene names…
* `organism`: A character string of the `org.*.eg.db` package to use to extract mappings of gene sets to gene IDs.
* `reddim_type`: A string vector containing the dimensionality reduction type
* `clusters`: A character string containing the name of the clusters/cell-type/state…(as listed in the colData of the sce)
* `groups`: A character string of the groups/conditions…(as it appears in the colData of the sce)

```
GO_collection <- "GO"
Mm_organism <- "org.Mm.eg.db"
gene_id <- "SYMBOL"
cluster <- "label"
group <- "strain"
reddim_type <- "PCA"
```

Now let’s create this initial setup for `iSEE` using `iSEEnrich()`

```
results <- iSEEnrich(
  sce = sce,
  collection = GO_collection,
  gene_identifier = gene_id,
  organism = Mm_organism,
  clusters = cluster,
  reddim_type = reddim_type,
  groups = group
)
```

`iSEEnrich` will specifically return a list with the updated `sce` object and
its associated `initial` configuration. To start the `iSEE` instance we run:

```
iSEE(results$sce, initial = results$initial)
```

# 4 Create an initial state for marker gene exploration using `iSEEmarker()`

In many cases, we are interested in determining the identity of our clusters, or further subset our cells types. That’s where `iSEEmarker()` comes in handy. Similar to `iSEEinit()`, we need the following parameters:

* `sce`: a `SingleCellExperiment` object
* `clusters`: the name of the clusters/cell-type/state
* `groups`: the groups/conditions
* `selection_plot_format`: the class of the panel that we will be using to select the clusters of interest.

```
initial3 <- iSEEmarker(
  sce = sce,
  clusters = cluster,
  groups = group,
  selection_plot_format = "ColumnDataPlot")
```

This function returns a list of panels, with the goal of visualizing the expression of
marker genes selected from the `DynamicMarkerTable` in each cell cell type. Unlike `iSEEinit()`, which requires us to specify a list of genes, `iSEEmarker()` utilizes the `DynamicMarkerTable` that performs statistical testing through the `findMarkers()` function from the *[scran](https://bioconductor.org/packages/3.22/scran)* package.
To start exploring the marker genes of each cell type with `iSEE`, we run:

```
iSEE(sce, initial = initial3)
```

# 5 Visualize a preview of the initial configurations with `view_initial_tiles()`

Previously, we successfully generated three distinct initial configurations for
iSEE. However, understanding the expected content of our iSEE instances is not
always straightforward. That’s when we can use `view_initial_tiles()`.
We only need as an input the initial configuration to obtain a graphical
visualization of the expected the corresponding `iSEE` instance:

```
library(ggplot2)
view_initial_tiles(initial = initial1)
```

![](data:image/png;base64...)

```
view_initial_tiles(initial = results$initial)
```

![](data:image/png;base64...)

# 6 Visualize network connections between panels with `view_initial_network()`

As some of these panels are linked to each other, we can visualize these
networks with `view_initial_network()`. Similar to `iSEEconfigviewer()`, this
function takes the initial setup as input:
This function always returns the `igraph` object underlying the visualizations
that can be displayed as a side effect.

```
library("igraph")
library("visNetwork")
g1 <- view_initial_network(initial1, plot_format = "igraph")
```

![](data:image/png;base64...)

```
g1
#> IGRAPH 10d156c DN-- 11 3 --
#> + attr: name (v/c), color (v/c)
#> + edges from 10d156c (vertex names):
#> [1] ReducedDimensionPlot1->ColumnDataPlot1
#> [2] ReducedDimensionPlot2->ColumnDataPlot1
#> [3] ReducedDimensionPlot3->FeatureAssayPlot3
initial2 <- results$initial
g2 <- view_initial_network(initial2, plot_format = "visNetwork")
```

# 7 Merge different initial configurations with `glue_initials()`

Sometimes, it would be interesting to merge different `iSEE` initial
configurations to visualize all different panel in the same `iSEE` instance.

```
merged_config <- glue_initials(initial1,initial2)
```

We can then preview the content of this initial configuration

```
view_initial_tiles(merged_config)
```

![](data:image/png;base64...)

# 8 Related work

The idea of launching `iSEE()` with some specific configuration is not entirely
new, and it was covered in some use cases by the `mode_` functions available in
the *[iSEEu](https://bioconductor.org/packages/3.22/iSEEu)* package. There, the user has access to the
following:

* `iSEEu::modeEmpty()` - this will launch `iSEE` without any panels, and let you build up the configuration from the scratch. Easy to start, easy to build.
* `iSEEu::modeGating()` - this will open `iSEE` with multiple chain-linked FeatureExpressionPlot panels, just like when doing some in silico gating. This could be a very good fit if working with mass cytometry data.
* `iSEEu::modeReducedDim()` - `iSEE` will be ready to compare multiple ReducedDimensionPlot panels, which is a suitable option to compare the views resulting from different embeddings (and/or embeddings generated with slightly different parameter configurations).
  The `mode`s directly launch an instance of `iSEE`, whereas the functionality in
  *[iSEEfier](https://bioconductor.org/packages/3.22/iSEEfier)* is rather oriented to obtain more
  tailored-to-the-data-at-hand `initial` objects, that can subsequently be passed
  as an argument to the `iSEE()` call.
  We encourage users to submit suggestions about their “classical ways” of using
  `iSEE` on their data - be that by opening an issue or already proposing a Pull
  Request on GitHub.

# Session info

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
#>  [1] visNetwork_2.1.4            igraph_2.2.1
#>  [3] scater_1.38.0               ggplot2_4.0.0
#>  [5] scuttle_1.20.0              scRNAseq_2.23.1
#>  [7] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#>  [9] Biobase_2.70.0              GenomicRanges_1.62.0
#> [11] Seqinfo_1.0.0               IRanges_2.44.0
#> [13] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [15] generics_0.1.4              MatrixGenerics_1.22.0
#> [17] matrixStats_1.5.0           iSEEfier_1.6.0
#> [19] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] splines_4.5.1            later_1.4.4              BiocIO_1.20.0
#>   [4] bitops_1.0-9             filelock_1.0.3           tibble_3.3.0
#>   [7] XML_3.99-0.19            lifecycle_1.0.4          httr2_1.2.1
#>  [10] doParallel_1.0.17        lattice_0.22-7           ensembldb_2.34.0
#>  [13] alabaster.base_1.10.0    magrittr_2.0.4           sass_0.4.10
#>  [16] rmarkdown_2.30           jquerylib_0.1.4          yaml_2.3.10
#>  [19] httpuv_1.6.16            otel_0.2.0               DBI_1.2.3
#>  [22] RColorBrewer_1.1-3       abind_1.4-8              Rtsne_0.17
#>  [25] AnnotationFilter_1.34.0  RCurl_1.98-1.17          rappdirs_0.3.3
#>  [28] circlize_0.4.16          ggrepel_0.9.6            irlba_2.3.5.1
#>  [31] alabaster.sce_1.10.0     iSEEhex_1.12.0           codetools_0.2-20
#>  [34] DelayedArray_0.36.0      DT_0.34.0                tidyselect_1.2.1
#>  [37] shape_1.4.6.1            UCSC.utils_1.6.0         farver_2.1.2
#>  [40] viridis_0.6.5            ScaledMatrix_1.18.0      shinyWidgets_0.9.0
#>  [43] BiocFileCache_3.0.0      GenomicAlignments_1.46.0 jsonlite_2.0.0
#>  [46] BiocNeighbors_2.4.0      GetoptLong_1.0.5         iterators_1.0.14
#>  [49] foreach_1.5.2            tools_4.5.1              Rcpp_1.1.0
#>  [52] glue_1.8.0               gridExtra_2.3            SparseArray_1.10.0
#>  [55] BiocBaseUtils_1.12.0     xfun_0.53                mgcv_1.9-3
#>  [58] GenomeInfoDb_1.46.0      dplyr_1.1.4              HDF5Array_1.38.0
#>  [61] gypsum_1.6.0             shinydashboard_0.7.3     withr_3.0.2
#>  [64] BiocManager_1.30.26      fastmap_1.2.0            rhdf5filters_1.22.0
#>  [67] shinyjs_2.1.0            rsvd_1.0.5               digest_0.6.37
#>  [70] R6_2.6.1                 mime_0.13                colorspace_2.1-2
#>  [73] listviewer_4.0.0         dichromat_2.0-0.1        RSQLite_2.4.3
#>  [76] cigarillo_1.0.0          h5mread_1.2.0            hexbin_1.28.5
#>  [79] FNN_1.1.4.1              rtracklayer_1.70.0       httr_1.4.7
#>  [82] htmlwidgets_1.6.4        S4Arrays_1.10.0          org.Mm.eg.db_3.22.0
#>  [85] uwot_0.2.3               iSEE_2.22.0              pkgconfig_2.0.3
#>  [88] gtable_0.3.6             blob_1.2.4               ComplexHeatmap_2.26.0
#>  [91] S7_0.2.0                 XVector_0.50.0           htmltools_0.5.8.1
#>  [94] bookdown_0.45            ProtGenerics_1.42.0      rintrojs_0.3.4
#>  [97] clue_0.3-66              scales_1.4.0             alabaster.matrix_1.10.0
#> [100] png_0.1-8                knitr_1.50               rjson_0.2.23
#> [103] nlme_3.1-168             curl_7.0.0               shinyAce_0.4.4
#> [106] cachem_1.1.0             rhdf5_2.54.0             GlobalOptions_0.1.2
#> [109] BiocVersion_3.22.0       parallel_4.5.1           miniUI_0.1.2
#> [112] vipor_0.4.7              AnnotationDbi_1.72.0     restfulr_0.0.16
#> [115] pillar_1.11.1            grid_4.5.1               alabaster.schemas_1.10.0
#> [118] vctrs_0.6.5              promises_1.4.0           BiocSingular_1.26.0
#> [121] dbplyr_2.5.1             iSEEu_1.22.0             beachmat_2.26.0
#> [124] xtable_1.8-4             cluster_2.1.8.1          beeswarm_0.4.0
#> [127] evaluate_1.0.5           magick_2.9.0             tinytex_0.57
#> [130] GenomicFeatures_1.62.0   cli_3.6.5                compiler_4.5.1
#> [133] Rsamtools_2.26.0         rlang_1.1.6              crayon_1.5.3
#> [136] ggbeeswarm_0.7.2         viridisLite_0.4.2        alabaster.se_1.10.0
#> [139] BiocParallel_1.44.0      Biostrings_2.78.0        lazyeval_0.2.2
#> [142] colourpicker_1.3.0       Matrix_1.7-4             ExperimentHub_3.0.0
#> [145] bit64_4.6.0-1            Rhdf5lib_1.32.0          KEGGREST_1.50.0
#> [148] shiny_1.11.1             alabaster.ranges_1.10.0  AnnotationHub_4.0.0
#> [151] memoise_2.0.1            bslib_0.9.0              bit_4.6.0
```