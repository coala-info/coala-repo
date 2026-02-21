# How to use iSEE with big data

Kevin Rue-Albrecht1\*, Federico Marini2,3\*\*, Charlotte Soneson4,5\*\*\* and Aaron Lun\*\*\*\*

1MRC WIMM Centre for Computational Biology, University of Oxford, Oxford, OX3 9DS, UK
2Institute of Medical Biostatistics, Epidemiology and Informatics (IMBEI), Mainz
3Center for Thrombosis and Hemostasis (CTH), Mainz
4Institute of Molecular Life Sciences, University of Zurich
5SIB Swiss Institute of Bioinformatics

\*kevinrue67@gmail.com
\*\*marinif@uni-mainz.de
\*\*\*charlottesoneson@gmail.com
\*\*\*\*infinite.monkeys.with.keyboards@gmail.com

#### 30 October 2025

#### Package

iSEE 2.22.0

**Compiled date**: 2025-10-30

**Last edited**: 2018-03-08

**License**: MIT + file LICENSE

# 1 Overview

Some tweaks can be performed to enable *[iSEE](https://bioconductor.org/packages/3.22/iSEE)* to run efficiently on large datasets.
This includes datasets with many features (methylation, SNPs) or many columns (cytometry, single-cell RNA-seq).
To demonstrate some of this functionality, we will use a dataset from the *[TENxPBMCData](https://bioconductor.org/packages/3.22/TENxPBMCData)* dataset:

```
library(TENxPBMCData)
sce.pbmc <- TENxPBMCData("pbmc68k")
sce.pbmc$Library <- factor(sce.pbmc$Library)
sce.pbmc
#> class: SingleCellExperiment
#> dim: 32738 68579
#> metadata(0):
#> assays(1): counts
#> rownames(32738): ENSG00000243485 ENSG00000237613 ... ENSG00000215616
#>   ENSG00000215611
#> rowData names(3): ENSEMBL_ID Symbol_TENx Symbol
#> colnames: NULL
#> colData names(11): Sample Barcode ... Individual Date_published
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
```

# 2 Using out-of-memory matrices

Many `SummarizedExperiment` objects store assay matrices as in-memory matrix-like objects,
be they ordinary matrices or alternative representations such as sparse matrices from the *[Matrix](https://CRAN.R-project.org/package%3DMatrix)* package.
For example, if we looked at the Allen data, we would see that the counts are stored as an ordinary matrix.

```
library(scRNAseq)
sce.allen <- ReprocessedAllenData("tophat_counts")
class(assay(sce.allen, "tophat_counts"))
#> [1] "matrix" "array"
```

In situations involving large datasets and limited computational resources, storing the entire assay in memory may not be feasible.
Rather, we can represent the data as a file-backed matrix where contents are stored on disk and retrieved on demand.
Within the Bioconductor ecosystem, the easiest way of doing this is to create a `HDF5Matrix`, which uses a [HDF5 file](https://support.hdfgroup.org/HDF5/whatishdf5.html) to store all the assay data.
We see that this has already been done for use in the 68K PBMC dataset:

```
counts(sce.pbmc, withDimnames=FALSE)
#> <32738 x 68579> sparse HDF5Matrix object of type "integer":
#>              [,1]     [,2]     [,3]     [,4] ... [,68576] [,68577] [,68578]
#>     [1,]        0        0        0        0   .        0        0        0
#>     [2,]        0        0        0        0   .        0        0        0
#>     [3,]        0        0        0        0   .        0        0        0
#>     [4,]        0        0        0        0   .        0        0        0
#>     [5,]        0        0        0        0   .        0        0        0
#>      ...        .        .        .        .   .        .        .        .
#> [32734,]        0        0        0        0   .        0        0        0
#> [32735,]        0        0        0        0   .        0        0        0
#> [32736,]        0        0        0        0   .        0        0        0
#> [32737,]        0        0        0        0   .        0        0        0
#> [32738,]        0        0        0        0   .        0        0        0
#>          [,68579]
#>     [1,]        0
#>     [2,]        0
#>     [3,]        0
#>     [4,]        0
#>     [5,]        0
#>      ...        .
#> [32734,]        0
#> [32735,]        0
#> [32736,]        0
#> [32737,]        0
#> [32738,]        0
```

Despite the dimensions of this matrix, the `HDF5Matrix` object occupies very little space in memory.

```
object.size(counts(sce.pbmc, withDimnames=FALSE))
#> 2496 bytes
```

However, parts of the data can still be read in on demand.
For all intents and purposes, the `HDF5Matrix` appears to be an ordinary matrix to downstream applications and can be used as such.

```
first.gene <- counts(sce.pbmc)[1,]
head(first.gene)
#> [1] 0 0 0 0 0 0
```

This means that we can use the 68K PBMC `SingleCellExperiment` object in `iSEE()` without any extra work.
The app below shows the distribution of counts for everyone’s favorite gene *MALAT1* across libraries.
Here, `iSEE()` is simply retrieving data on demand from the `HDF5Matrix` without ever loading the entire assay matrix into memory.
This enables it to run efficiently on arbitrary large datasets with limited resources.

```
library(iSEE)
app <- iSEE(sce.pbmc, initial=
    list(RowDataTable(Selected="ENSG00000251562", Search="MALAT1"),
        FeatureAssayPlot(XAxis="Column data", XAxisColumnData="Library",
            YAxisFeatureSource="RowDataTable1")
    )
)
```

![](data:image/png;base64...)

Generally speaking, these HDF5 files are written once by a process with sufficient computational resources (i.e., memory and time).
We typically create `HDF5Matrix` objects using the `writeHDF5Array()` function from the *[HDF5Array](https://bioconductor.org/packages/3.22/HDF5Array)* package.
After the file is created, the objects can be read many times in more deprived environments.

```
sce.h5 <- sce.allen
library(HDF5Array)
assay(sce.h5, "tophat_counts", withDimnames=FALSE)  <-
    writeHDF5Array(assay(sce.h5, "tophat_counts"), file="assay.h5", name="counts")
class(assay(sce.h5, "tophat_counts", withDimnames=FALSE))
#> [1] "HDF5Matrix"
#> attr(,"package")
#> [1] "HDF5Array"
list.files("assay.h5")
#> character(0)
```

It is worth noting that `iSEE()` does not know or care that the data is stored in a HDF5 file.
The app is fully compatible with any matrix-like representation of the assay data that supports `dim()` and `[,`.
As such, `iSEE()` can be directly used with other memory-efficient objects like the `DeferredMatrix` and `LowRankMatrix` from the *[BiocSingular](https://bioconductor.org/packages/3.22/BiocSingular)* package, or perhaps the `ResidualMatrix` from the *[batchelor](https://bioconductor.org/packages/3.22/batchelor)* package.

# 3 Downsampling points

It is also possible to downsample points to reduce the time required to generate the plot.
This involves subsetting the dataset so that only the most recently plotted point for an overlapping set of points is shown.
In this manner, we avoid wasting time in plotting many points that would not be visible anyway.
To demonstrate, we will re-use the 68K PBMC example and perform downsampling on the feature assay plot;
we can see that its aesthetics are largely similar to the non-downsampled counterpart above.

```
library(iSEE)
app <- iSEE(sce.pbmc, initial=
    list(RowDataTable(Selected="ENSG00000251562", Search="MALAT1"),
        FeatureAssayPlot(XAxis="Column data", XAxisColumnData="Library",
            YAxisFeatureSource="RowDataTable1",
            VisualChoices="Point", Downsample=TRUE,
            VisualBoxOpen=TRUE
        )
    )
)
```

![](data:image/png;base64...)

Downsampling is possible in all `iSEE()` plotting panels that represent features or samples as points.
We can turn on downsampling for all such panels using the relevant field in `panelDefaults()`,
which spares us the hassle of setting `Downsample=` individually in each panel constructor.

```
panelDefaults(Downsample=TRUE)
```

The downsampling only affects the visualization and the speed of the plot rendering.
Any interactions with other panels occur as if all of the points were still there.
For example, if one makes a brush, all of the points therein will be selected regardless of whether they were downsampled.

![](data:image/png;base64...)

The downsampling resolution determines the degree to which points are considered to be overlapping.
Decreasing the resolution will downsample more aggressively,
improving plotting speed but potentially affecting the fidelity of the visualization.
This may compromise the aesthetics of the plot when the size of the points is small,
in which case an increase in resolution may be required at the cost of speed.

Obviously, downsampling will not preserve overlays for partially transparent points,
but any reliance on partial transparency is probably not a good idea in the first place when there are many points.

# 4 Changing the interface

One can generally improve the speed of the `iSEE()` interface by only initializing the app with the desired panels.
For example, it makes little sense to spend time rendering a `RowDataPlot` when only the `ReducedDimensionPlot` is of interest.
Specification of the initial state is straightforward with the `initial=` argument,
as described in a [previous vignette](https://bioconductor.org/packages/3.22/iSEE/vignettes/configure.html).

On occasion, there may be alternative panels with more efficient visualizations for the same data.
The prime example is the `ReducedDimensionHexPlot` class from the *[iSEEu](https://bioconductor.org/packages/3.22/iSEEu)* package;
this will create a hexplot rather than a scatter plot, thus avoiding the need to render each point in the latter.

# 5 Comments on deployment

It is straightforward to host *[iSEE](https://bioconductor.org/packages/3.22/iSEE)* applications on hosting platforms like [Shiny Server](https://rstudio.com/products/shiny/shiny-server/) or [Rstudio Connect](https://rstudio.com/products/connect/).
All one needs to do is to create an `app.R` file that calls `iSEE()` with the desired parameters,
and then follow the instructions for the target platform.
For a better user experience, we suggest setting a minimum number of processes to avoid the initial delay from R start-up.

It is also possible to deploy and host Shiny app on [shinyapps.io](https://www.shinyapps.io/), a platform as a service (PaaS) provided by RStudio.
In many cases, users will need to configure the settings of their deployed apps, in particular selecting larger instances to provide sufficient memory for the app.
The maximum amount of 1GB available to free accounts may not be sufficient to deploy large datasets;
in which case you may consider [using out-of-memory matrices](#out-of-memory), filtering your dataset (e.g., removing lowly detected features), or going for a paid account.
Detailed instructions to get started are available at <https://shiny.rstudio.com/articles/shinyapps.html>.
For example, see the [isee-shiny-contest](https://rstudio.cloud/project/230765) app, [winner of the 1st Shiny Contest](https://blog.rstudio.com/2019/04/05/first-shiny-contest-winners/).

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
# devtools::session_info()
```