# Controlling the iSEE interface using speech recognition

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

**Last edited**: 2018-11-29

**License**: MIT + file LICENSE

# 1 Feature

Using JavaScript, `iSEE` applications can leverage lightweight speech recognition libraries that react to specific vocal commands (think “OK Google”, “Hey Siri”) and trigger updates of the UI equivalent to one or more mouse or keyboard interaction with the UI components (Rue-Albrecht et al. [2018](#ref-kra2018iSEE)).

**Note**: As we value privacy, this feature is disabled by default: `iSEE(..., voice=FALSE)`.

To keep the spoken commands reasonably short, only one panel may be under voice command at any one time.
All spoken commands will affect the currently active panel, until a new panel is selected for voice command.
See section [Vocal commands available](#availableVocalCommands).

# 2 Implementation

We use the [*annyang*](https://github.com/TalAter/annyang) lightweight JavaScript library to handle speech recognition and update *Shiny* reactive values in the same way as mouse and keyboard UI elements trigger panel updates.

Note that *annyang* requires an active internet connection, as it relies on the browser’s own speech recognition engine (see the *annyang* [FAQ](https://github.com/TalAter/annyang/blob/master/docs/FAQ.md#can-annyang-work-offline)).
For instance, in *Google Chrome*, this engine performs the recognition in the cloud.

# 3 Supported web browsers

Note that the speech recognition library that we use does not work with every web browser.
We currently only validated this feature in *Google Chrome*.
Please refer to the *annyang* [FAQ](https://github.com/TalAter/annyang/blob/master/docs/FAQ.md#which-browsers-are-supported) for details.

# 4 Usage

Using the `sce` object that we generated [earlier](https://bioconductor.org/packages/3.22/iSEE/vignettes/basic.html), enabling speech recognition is as simple as setting `voice=TRUE` below:

```
library(iSEE)
app <- iSEE(sce, voice=TRUE)
```

With `voice=TRUE`, the lightweight JavaScript speech recognition library *annyang* is loaded and activated in any web browser tab that runs `app`.

If your default browser is not compatible with the feature, or if you work in *RStudio*, you can prevent the application from opening in the default browser by setting `launch.browser=FALSE` as follows:

```
if (interactive()) {
    shiny::runApp(app, port=1234, launch.browser=FALSE)
}
```

At that point, your R console should be displaying the address and port where `app` is running.
In the example above, that would be:

```
Listening on http://127.0.0.1:1234
```

Using a compatible browser, navigate to the indicated address and port.
Note that when the web page opens, you may be prompted to allow the web browser to use your microphone, which you must accept to enable the functionality.

# 5 Vocal commands available

As a proof of concept, only a subset of spoken commands are currently implemented, compared to the full range of interactions possible using the mouse and keyboard.

Note that in the commands below, words in brackets are optional.

* “**Show active panel**”: shows a persistent notification displaying the name of the panel currently under vocal control.
* “**Create** ”: Adds a new panel of the requested type to the GUI and immediately takes vocal control of it.
* “**Remove <Reduced dimension plot 1>**”: Removes the requested panel from the GUI. If the panel was under vocal control, clears vocal control.
* “**Control <Reduced dimension plot 1>**”: Takes vocal control of the requested panel.
* “**Colour using <Column data | Feature name | …>**”: Changes the colouring mode of the panel under vocal control.
* “**Colour by <…>**”: Changes the colouring covariate (e.g. gene name, `colData` column name) of the panel under vocal control.
* “**Receive selection from <Reduced dimension plot 1>**”: Makes the panel under vocal control receive the point selection from the requested panel.
* “**Send selection to <Reduced dimension plot 1>**”: Makes the requested panel receive the point selection from the panel under vocal control.
* “**Good <boy | girl>!**”: If the app is behaving well, throw it a bone!

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