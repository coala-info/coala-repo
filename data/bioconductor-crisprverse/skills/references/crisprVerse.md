# crisprVerse: ecosystem of R packages for CRISPR gRNA design

Jean-Philippe Fortin1\* and Luke Hoberecht1\*\*

1Data Science and Statistical Computing, gRED, Genentech

\*fortin946@gmail.com
\*\*lukehob3@gmail.com

#### 2025-10-29

# 1 Installation and getting started

The [crisprVerse](https://github.com/crisprVerse) is a collection of packages for CRISPR guide RNA (gRNA) design that can easily be installed
with the `crisprVerse` package. This provides
a convenient way of downloading and installing all crisprVerse packages
with a single R command.

The package can be installed from the Bioconductor devel branch using
the following commands in an R session:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install(version="devel")
BiocManager::install("crisprVerse")
```

The core crisprVerse includes the packages that are commonly used for
gRNA design, and are attached when you attach the `crisprVerse` package:

```
library(crisprVerse)
```

You can check that all crisprVerse packages are up-to-date
with the function `crisprVerse_update()`.

# 2 Components

The following packages are installed and loaded with the `crisprVerse` package:

* *[crisprBase](https://bioconductor.org/packages/3.22/crisprBase)* to specify and manipulate CRISPR nucleases.
* *[crisprBowtie](https://bioconductor.org/packages/3.22/crisprBowtie)* to perform gRNA spacer sequence
  alignment with Bowtie.
* *[crisprScore](https://bioconductor.org/packages/3.22/crisprScore)* to annotate gRNAs with on-target
  and off-target scores.
* *[crisprScoreData](https://bioconductor.org/packages/3.22/crisprScoreData)* pre-trained data for crisprScore
* *[crisprDesign](https://bioconductor.org/packages/3.22/crisprDesign)* to design and manipulate gRNAs
  with `GuideSet` objects.
* *[crisprViz](https://bioconductor.org/packages/3.22/crisprViz)* to visualize gRNAs.

# 3 Reproducibility

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] crisprViz_1.12.0       crisprDesign_1.12.0    crisprScore_1.14.0
##  [4] crisprScoreData_1.13.0 ExperimentHub_3.0.0    AnnotationHub_4.0.0
##  [7] BiocFileCache_3.0.0    dbplyr_2.5.1           BiocGenerics_0.56.0
## [10] generics_0.1.4         crisprBowtie_1.14.0    crisprBase_1.14.0
## [13] crisprVerse_1.12.0     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
##   [3] jsonlite_2.0.0              magrittr_2.0.4
##   [5] GenomicFeatures_1.62.0      farver_2.1.2
##   [7] rmarkdown_2.30              BiocIO_1.20.0
##   [9] vctrs_0.6.5                 memoise_2.0.1
##  [11] Rsamtools_2.26.0            RCurl_1.98-1.17
##  [13] base64enc_0.1-3             htmltools_0.5.8.1
##  [15] S4Arrays_1.10.0             progress_1.2.3
##  [17] curl_7.0.0                  SparseArray_1.10.0
##  [19] Formula_1.2-5               sass_0.4.10
##  [21] bslib_0.9.0                 htmlwidgets_1.6.4
##  [23] basilisk_1.22.0             Gviz_1.54.0
##  [25] httr2_1.2.1                 cachem_1.1.0
##  [27] GenomicAlignments_1.46.0    lifecycle_1.0.4
##  [29] pkgconfig_2.0.3             Matrix_1.7-4
##  [31] R6_2.6.1                    fastmap_1.2.0
##  [33] MatrixGenerics_1.22.0       digest_0.6.37
##  [35] colorspace_2.1-2            AnnotationDbi_1.72.0
##  [37] S4Vectors_0.48.0            Hmisc_5.2-4
##  [39] GenomicRanges_1.62.0        RSQLite_2.4.3
##  [41] filelock_1.0.3              randomForest_4.7-1.2
##  [43] httr_1.4.7                  abind_1.4-8
##  [45] compiler_4.5.1              Rbowtie_1.50.0
##  [47] bit64_4.6.0-1               backports_1.5.0
##  [49] htmlTable_2.4.3             S7_0.2.0
##  [51] BiocParallel_1.44.0         DBI_1.2.3
##  [53] biomaRt_2.66.0              rappdirs_0.3.3
##  [55] DelayedArray_0.36.0         rjson_0.2.23
##  [57] tools_4.5.1                 foreign_0.8-90
##  [59] nnet_7.3-20                 glue_1.8.0
##  [61] restfulr_0.0.16             grid_4.5.1
##  [63] checkmate_2.3.3             cluster_2.1.8.1
##  [65] gtable_0.3.6                BSgenome_1.78.0
##  [67] tzdb_0.5.0                  ensembldb_2.34.0
##  [69] data.table_1.17.8           hms_1.1.4
##  [71] XVector_0.50.0              BiocVersion_3.22.0
##  [73] pillar_1.11.1               stringr_1.5.2
##  [75] dplyr_1.1.4                 lattice_0.22-7
##  [77] deldir_2.0-4                rtracklayer_1.70.0
##  [79] bit_4.6.0                   biovizBase_1.58.0
##  [81] tidyselect_1.2.1            Biostrings_2.78.0
##  [83] knitr_1.50                  gridExtra_2.3
##  [85] bookdown_0.45               ProtGenerics_1.42.0
##  [87] IRanges_2.44.0              Seqinfo_1.0.0
##  [89] SummarizedExperiment_1.40.0 stats4_4.5.1
##  [91] xfun_0.53                   Biobase_2.70.0
##  [93] matrixStats_1.5.0           stringi_1.8.7
##  [95] UCSC.utils_1.6.0            lazyeval_0.2.2
##  [97] yaml_2.3.10                 evaluate_1.0.5
##  [99] codetools_0.2-20            cigarillo_1.0.0
## [101] interp_1.1-6                tibble_3.3.0
## [103] BiocManager_1.30.26         cli_3.6.5
## [105] rpart_4.1.24                reticulate_1.44.0
## [107] jquerylib_0.1.4             dichromat_2.0-0.1
## [109] Rcpp_1.1.0                  GenomeInfoDb_1.46.0
## [111] dir.expiry_1.18.0           png_0.1-8
## [113] XML_3.99-0.19               parallel_4.5.1
## [115] ggplot2_4.0.0               readr_2.1.5
## [117] blob_1.2.4                  prettyunits_1.2.0
## [119] jpeg_0.1-11                 latticeExtra_0.6-31
## [121] AnnotationFilter_1.34.0     bitops_1.0-9
## [123] txdbmaker_1.6.0             VariantAnnotation_1.56.0
## [125] scales_1.4.0                crayon_1.5.3
## [127] rlang_1.1.6                 KEGGREST_1.50.0
```