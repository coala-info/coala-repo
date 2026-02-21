# The iSEEhex package

Kevin Rue-Albrecht1\*, Federico Marini2,3\*\*, Charlotte Soneson4,5\*\*\* and Aaron Lun\*\*\*\*

1MRC Weatherall Institute of Molecular Medicine, University of Oxford, Headington, Oxford OX3 9DS, UK.
2Institute of Medical Biostatistics, Epidemiology and Informatics (IMBEI), Mainz
3Center for Thrombosis and Hemostasis (CTH), Mainz
4Friedrich Miescher Institute for Biomedical Research, Basel
5SIB Swiss Institute of Bioinformatics

\*kevin.rue-albrecht@imm.ox.ac.uk
\*\*marinif@uni-mainz.de
\*\*\*charlottesoneson@gmail.com
\*\*\*\*infinite.monkeys.with.keyboards@gmail.com

#### 30 October 2025

#### Package

iSEEhex 1.12.0

# Contents

* [1 Overview](#overview)
  + [1.1 Example](#example)
  + [1.2 Further reading](#further-reading)
* [Session information](#session-information)
* [References](#references)

# 1 Overview

The *[iSEE](https://bioconductor.org/packages/3.22/iSEE)* package (Rue-Albrecht et al. [2018](#ref-iSEE-2018)) provides a general and flexible framework for interactively exploring `SummarizedExperiment` objects.
However, in many cases, more specialized panels are required for effective visualization of specific data types.
The *[iSEEhex](https://bioconductor.org/packages/3.22/iSEEhex)* package implements panels summarising data points in hexagonal bins, that work directly in the `iSEE` application and can smoothly interact with other panels.

We first load in the package:

```
library(iSEEhex)
```

All the panels described in this document can be deployed by simply passing them into the `iSEE()` function via the `initial=` argument, as shown in the following examples.

## 1.1 Example

Let us prepare an example *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* object.

```
library(scRNAseq)

# Example data ----
sce <- ReprocessedAllenData(assays="tophat_counts")
class(sce)
```

```
## [1] "SingleCellExperiment"
## attr(,"package")
## [1] "SingleCellExperiment"
```

```
library(scater)
sce <- logNormCounts(sce, exprs_values="tophat_counts")

sce <- runPCA(sce, ncomponents=4)
sce <- runTSNE(sce)
rowData(sce)$ave_count <- rowMeans(assay(sce, "tophat_counts"))
rowData(sce)$n_cells <- rowSums(assay(sce, "tophat_counts") > 0)
sce
```

```
## class: SingleCellExperiment
## dim: 20816 379
## metadata(2): SuppInfo which_qc
## assays(2): tophat_counts logcounts
## rownames(20816): 0610007P14Rik 0610009B22Rik ... Zzef1 Zzz3
## rowData names(2): ave_count n_cells
## colnames(379): SRR2140028 SRR2140022 ... SRR2139341 SRR2139336
## colData names(23): NREADS NALIGNED ... passes_qc_checks_s sizeFactor
## reducedDimNames(2): PCA TSNE
## mainExpName: endogenous
## altExpNames(1): ERCC
```

Then, we create an *[iSEE](https://bioconductor.org/packages/3.22/iSEE)* app that compares the
`ReducedDimensionHexPlot` panel – defined in this package – to the
standard `ReducedDimensionPlot` defined in the *[iSEE](https://bioconductor.org/packages/3.22/iSEE)*
package.

```
initialPanels <- list(
    ReducedDimensionPlot(
        ColorBy = "Feature name", ColorByFeatureName = "Cux2", PanelWidth = 6L),
    ReducedDimensionHexPlot(
        ColorBy = "Feature name", ColorByFeatureName = "Cux2", PanelWidth = 6L,
        BinResolution = 30)
)
app <- iSEE(se = sce, initial = initialPanels)
```

![](data:image/png;base64...)

## 1.2 Further reading

#### Where can I find a comprehensive introduction to *[iSEE](https://bioconductor.org/packages/3.22/iSEE)*?

The *[iSEE](https://bioconductor.org/packages/3.22/iSEE)* package contains several vignettes detailing the main functionality.
You can also take a look at this [workshop](https://iSEE.github.io/iSEEWorkshop2019/index.html).
A compiled version from the Bioc2019 conference (based on Bioconductor release 3.10) is available [here](http://biocworkshops2019.bioconductor.org.s3-website-us-east-1.amazonaws.com/page/iSEEWorkshop2019__iSEE-lab/).

# Session information

```
sessionInfo()
```

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] scater_1.38.0               ggplot2_4.0.0
##  [3] scuttle_1.20.0              scRNAseq_2.23.1
##  [5] iSEEhex_1.12.0              iSEE_2.22.0
##  [7] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0              GenomicRanges_1.62.0
## [11] Seqinfo_1.0.0               IRanges_2.44.0
## [13] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [15] generics_0.1.4              MatrixGenerics_1.22.0
## [17] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1            later_1.4.4              BiocIO_1.20.0
##   [4] bitops_1.0-9             filelock_1.0.3           tibble_3.3.0
##   [7] XML_3.99-0.19            lifecycle_1.0.4          httr2_1.2.1
##  [10] doParallel_1.0.17        lattice_0.22-7           ensembldb_2.34.0
##  [13] alabaster.base_1.10.0    magrittr_2.0.4           sass_0.4.10
##  [16] rmarkdown_2.30           jquerylib_0.1.4          yaml_2.3.10
##  [19] httpuv_1.6.16            otel_0.2.0               DBI_1.2.3
##  [22] RColorBrewer_1.1-3       abind_1.4-8              Rtsne_0.17
##  [25] AnnotationFilter_1.34.0  RCurl_1.98-1.17          rappdirs_0.3.3
##  [28] circlize_0.4.16          ggrepel_0.9.6            irlba_2.3.5.1
##  [31] alabaster.sce_1.10.0     codetools_0.2-20         DelayedArray_0.36.0
##  [34] DT_0.34.0                tidyselect_1.2.1         shape_1.4.6.1
##  [37] UCSC.utils_1.6.0         farver_2.1.2             viridis_0.6.5
##  [40] ScaledMatrix_1.18.0      shinyWidgets_0.9.0       BiocFileCache_3.0.0
##  [43] GenomicAlignments_1.46.0 jsonlite_2.0.0           GetoptLong_1.0.5
##  [46] BiocNeighbors_2.4.0      iterators_1.0.14         foreach_1.5.2
##  [49] tools_4.5.1              Rcpp_1.1.0               glue_1.8.0
##  [52] gridExtra_2.3            SparseArray_1.10.0       xfun_0.53
##  [55] mgcv_1.9-3               GenomeInfoDb_1.46.0      dplyr_1.1.4
##  [58] HDF5Array_1.38.0         gypsum_1.6.0             shinydashboard_0.7.3
##  [61] withr_3.0.2              BiocManager_1.30.26      fastmap_1.2.0
##  [64] rhdf5filters_1.22.0      shinyjs_2.1.0            digest_0.6.37
##  [67] rsvd_1.0.5               R6_2.6.1                 mime_0.13
##  [70] colorspace_2.1-2         listviewer_4.0.0         dichromat_2.0-0.1
##  [73] RSQLite_2.4.3            cigarillo_1.0.0          h5mread_1.2.0
##  [76] hexbin_1.28.5            rtracklayer_1.70.0       httr_1.4.7
##  [79] htmlwidgets_1.6.4        S4Arrays_1.10.0          pkgconfig_2.0.3
##  [82] gtable_0.3.6             blob_1.2.4               ComplexHeatmap_2.26.0
##  [85] S7_0.2.0                 XVector_0.50.0           htmltools_0.5.8.1
##  [88] bookdown_0.45            ProtGenerics_1.42.0      rintrojs_0.3.4
##  [91] clue_0.3-66              scales_1.4.0             alabaster.matrix_1.10.0
##  [94] png_0.1-8                knitr_1.50               rjson_0.2.23
##  [97] nlme_3.1-168             curl_7.0.0               shinyAce_0.4.4
## [100] cachem_1.1.0             rhdf5_2.54.0             GlobalOptions_0.1.2
## [103] BiocVersion_3.22.0       parallel_4.5.1           miniUI_0.1.2
## [106] vipor_0.4.7              AnnotationDbi_1.72.0     restfulr_0.0.16
## [109] pillar_1.11.1            grid_4.5.1               alabaster.schemas_1.10.0
## [112] vctrs_0.6.5              promises_1.4.0           BiocSingular_1.26.0
## [115] dbplyr_2.5.1             beachmat_2.26.0          xtable_1.8-4
## [118] cluster_2.1.8.1          beeswarm_0.4.0           evaluate_1.0.5
## [121] GenomicFeatures_1.62.0   cli_3.6.5                compiler_4.5.1
## [124] Rsamtools_2.26.0         rlang_1.1.6              crayon_1.5.3
## [127] ggbeeswarm_0.7.2         viridisLite_0.4.2        alabaster.se_1.10.0
## [130] BiocParallel_1.44.0      Biostrings_2.78.0        lazyeval_0.2.2
## [133] colourpicker_1.3.0       Matrix_1.7-4             ExperimentHub_3.0.0
## [136] bit64_4.6.0-1            Rhdf5lib_1.32.0          KEGGREST_1.50.0
## [139] shiny_1.11.1             alabaster.ranges_1.10.0  AnnotationHub_4.0.0
## [142] fontawesome_0.5.3        igraph_2.2.1             memoise_2.0.1
## [145] bslib_0.9.0              bit_4.6.0
```

# References

Rue-Albrecht, Kevin, Federico Marini, Charlotte Soneson, and Aaron T. L. Lun. 2018. “ISEE: Interactive Summarizedexperiment Explorer.” *F1000Research* 7 (June): 741. <https://doi.org/10.12688/f1000research.14966.1>.