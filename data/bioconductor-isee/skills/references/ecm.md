# Describing the ExperimentColorMap class

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

**Last edited**: 2018-03-08

**License**: MIT + file LICENSE

# 1 Background

*[iSEE](https://bioconductor.org/packages/3.22/iSEE)* coordinates the coloration in every plot via the `ExperimentColorMap` class (Rue-Albrecht et al. [2018](#ref-kra2018iSEE)).
Colors for samples or features are defined from column or row metadata or assay values using “colormaps”.
Each colormap is a function that takes a single integer argument and returns that number of distinct colors.
The `ExperimentColorMap` is a container that stores these functions for use within the `iSEE()` function.
Users can define their own colormaps to customize coloration for specific assays or covariates.

# 2 Defining colormaps

## 2.1 Colormaps for continuous variables

For continuous variables, the function will be asked to generate a number of colors (21, by default).
Interpolation will then be performed internally to generate a color gradient.
Users can use existing color scales like `viridis::viridis` or `heat.colors`:

```
# Coloring for log-counts:
logcounts_color_fun <- viridis::viridis
```

It is also possible to use a function that completely ignores any arguments, and simply returns a fixed number of interpolation points:

```
# Coloring for FPKMs:
fpkm_color_fun <- function(n){
    c("black","brown","red","orange","yellow")
}
```

## 2.2 Colormaps for categorical variables

For categorical variables, the function should accept the number of levels and return a color per level.
Colors are automatically assigned to factor levels in the specified order of the levels.

```
# Coloring for the 'driver' metadata variable.
driver_color_fun <- function(n){
    RColorBrewer::brewer.pal(n, "Set2")
}
```

Alternatively, the function can ignore its arguments and simply return a named vector of colors if users want to specify the color for each level explicitly
It is the user’s responsibility to ensure that all levels are accounted for111 Needless to say, these functions should not be used as shared or global colormaps..
For instance, the following colormap function will only be compatible with factors of two levels, namely `"Y"` and `"N"`:

```
# Coloring for the QC metadata variable:
qc_color_fun <- function(n){
    qc_colors <- c("forestgreen", "firebrick1")
    names(qc_colors) <- c("Y", "N")
    qc_colors
}
```

# 3 The colormap hierarchy

## 3.1 Specific and shared colormaps

Colormaps can be defined by users at three different levels:

* Each individual assay, column data field, and row data field can be assigned its own distinct colormap.
  Those colormaps are stored as named lists of functions in the `assays`, `colData`, and `rowData` slots, respectively, of the `ExperimentColorMap`.
  This can be useful to easily remember which assay is currently shown;
  to apply different color scale limits to assays that vary on different ranges of values;
  or display boolean information in an intuitive way, among many other scenarios.
* *Shared* colormaps can be defined for all assays, all column data, and all row data.
  These colormaps are stored in the `all_discrete` and `all_continuous` slots of the `ExperimentColorMap`, as lists of functions named `assays`, `colData`, and `rowData`.
* *Global* colormaps can be defined for all categorical or continuous data.
  Those two colormaps are stored in the `global_discrete` and `global_continuous` slots of the `ExperimentColorMap`.

## 3.2 Searching for colors

When queried for a specific colormap of any type (assay, column data, or row data), the following process takes place:

* A specific *individual* colormap is looked up in the appropriate slot of the `ExperimentColorMap`.
* If it is not found, the *shared* colormap of the appropriate slot is looked up, according to whether the data are categorical or continuous.
* If it is not found, the *global* colormap is looked up, according to whether the data are categorical or continuous.
* If none of the above colormaps were defined, the `ExperimentColorMap` will revert to the default colormaps.

By default, `viridis` is used as the default continuous colormap, and `hcl` is used as the default categorical colormap.

# 4 Creating the `ExperimentColorMap`

We store the set of colormap functions in an instance of the `ExperimentColorMap` class.
Named functions passed as `assays`, `colData`, or `rowData` arguments will be used for coloring data in those slots, respectively.

```
library(iSEE)
ecm <- ExperimentColorMap(
    assays = list(
        counts = heat.colors,
        logcounts = logcounts_color_fun,
        cufflinks_fpkm = fpkm_color_fun
    ),
    colData = list(
        passes_qc_checks_s = qc_color_fun,
        driver_1_s = driver_color_fun
    ),
    all_continuous = list(
        assays = viridis::plasma
    )
)
ecm
#> Class: ExperimentColorMap
#> assays(3): counts logcounts cufflinks_fpkm
#> colData(2): passes_qc_checks_s driver_1_s
#> rowData(0):
#> all_discrete(0):
#> all_continuous(1): assays
```

Users can change the defaults for all assays or column data by modifying the *shared* colormaps.
Similarly, users can modify the defaults for all continuous or categorical data by modifying the global colormaps.
This is demonstrated below for the continuous variables:

```
ExperimentColorMap(
    all_continuous=list( # shared
        assays=viridis::plasma,
        colData=viridis::inferno
    ),
    global_continuous=viridis::magma # global
)
#> Class: ExperimentColorMap
#> assays(0):
#> colData(0):
#> rowData(0):
#> all_discrete(0):
#> all_continuous(2): assays colData
#> global_continuous(1)
```

# 5 Benefits

The `ExperimentColorMap` class offers the following major features:

* A single place to define flexible and lightweight sets of colormaps, that may be saved and reused across sessions and projects outside the app, to apply consistent coloring schemes across entire projects
* A simple interface through accessors `colDataColorMap(colormap, "coldata_name")` and setters `assayColorMap(colormap, "assay_name") <- colormap_function`
* An elegant fallback mechanism to consistently return a colormap, even for undefined covariates, including a default categorical and continuous colormap, respectively.
* Three levels of colormaps override: individual, shared within slot (i.e., `assays`, `colData`, `rowData`), or shared globally between all categorical or continuous data scales.

Detailed examples on the use of `ExperimentColorMap` objects are available in the documentation `?ExperimentColorMap`, as well as below.

# 6 Demonstration

Here, we use the `allen` single-cell RNA-seq data set to demonstrate the use of the `ExperimentColorMap` class.
Using the `sce` object that we created [previously](https://bioconductor.org/packages/3.22/iSEE/vignettes/basic.html), we create an `iSEE` app with the `SingleCellExperiment` object and the colormap generated above.

```
app <- iSEE(sce, colormap = ecm)
```

We run this using `runApp` to open the app on our browser.

```
shiny::runApp(app)
```

![](data:image/png;base64...)

Now, choose to color cells by `Column data` and select `passes_qc_checks_s`.
We will see that all cells that passed QC (`Y`) are colored “forestgreen”, while the ones that didn’t pass are colored firebrick.

If we color any plot by gene expression, we see that use of counts follows the `heat.colors` coloring scheme;
use of log-counts follows the `viridis` coloring scheme;
and use of FPKMs follows the black-to-yellow scheme we defined in `fpkm_color_fun`.

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

# References

Rue-Albrecht, K., F. Marini, C. Soneson, and A. T. L. Lun. 2018. “ISEE: Interactive Summarizedexperiment Explorer.” *F1000Research* 7 (June): 741.