# A detailed explanation of scFeatures’ features

#### 12 February 2026

# Contents

* [1 Introduction](#introduction)
* [2 Running scFeatures](#running-scfeatures)
  + [2.1 Classification of conditions using the generated features](#classification-of-conditions-using-the-generated-features)
  + [2.2 Survival analysis using the generated features](#survival-analysis-using-the-generated-features)
* [3 Association study of the features with the conditions](#association-study-of-the-features-with-the-conditions)
* [4 sessionInfo()](#sessioninfo)

# 1 Introduction

scFeatures is a tool for generating multi-view representations of samples in a single-cell dataset. This vignette provides an overview of scFeatures. It uses the main function to generate features and then illustrates case studies of using the generated features for classification, survival analysis and association study.

```
library(scFeatures)
```

# 2 Running scFeatures

scFeatures can be run using one line of code `scfeatures_result <- scFeatures(data)`, which generates a list of dataframes containing all feature types in the form of samples x features.

```
data("example_scrnaseq" , package = "scFeatures")
data <- example_scrnaseq

scfeatures_result <- scFeatures(data = data@assays$RNA@data, sample = data$sample, celltype = data$celltype,
                                feature_types = "gene_mean_celltype"  ,
                                type = "scrna",
                                ncores = 1,
                                species = "Homo sapiens")
```

By default, the above function generates all feature types. To reduce the computational time for the demonstrate, here we generate only the selected feature type “gene mean celltype”. More information on the function customisation can be obtained by typing `?scFeatures()`

## 2.1 Classification of conditions using the generated features

To build disease prediction model from the generated features we utilise [`ClassifyR`](https://www.bioconductor.org/packages/release/bioc/html/ClassifyR.html).

The output from scFeatures is a matrix of sample x feature, ie, the row corresponds to each sample, the column corresponds to the feature, and can be directly used as the `X`. The order of the rows is in the order of unique(data$sample).

Here we use the feature type gene mean celltype as an example to build classification model on the disease condition.

```
feature_gene_mean_celltype <- scfeatures_result$gene_mean_celltype

# inspect the first 5 rows and first 5 columns
feature_gene_mean_celltype[1:5, 1:5]
#>         Naive T Cells--SNRPD2 Naive T Cells--NOSIP Naive T Cells--IL2RG
#> Pre_P8              1.6774074             1.856023             1.834704
#> Pre_P6              3.4815573             3.217231             3.583760
#> Pre_P27             0.0000000             1.486346             1.742069
#> Pre_P7              1.1761242             1.282083             2.050024
#> Pre_P20             0.6999054             1.315393             2.781787
#>         Naive T Cells--ALDOA Naive T Cells--LUC7L3
#> Pre_P8              1.598921             1.8056758
#> Pre_P6              3.493135             0.0000000
#> Pre_P27             3.518687             1.5080699
#> Pre_P7              2.575957             0.9163035
#> Pre_P20             1.626403             1.2659969

# inspect the dimension of the matrix
dim(feature_gene_mean_celltype)
#> [1]   19 2217
```

We recommend using `ClassifyR::crossValidate` to do cross-validated classification with the extracted feaures.

```
library(ClassifyR)

# X is the feature type generated
# y is the condition for classification
X <- feature_gene_mean_celltype
y <- data@meta.data[!duplicated(data$sample), ]
y <- y[match(rownames(X), y$sample), ]$condition

# run the classification model using random forest
result <- ClassifyR::crossValidate(
    X, y,
    classifier = "randomForest", nCores = 2,
    nFolds = 3, nRepeats = 5
)

ClassifyR::performancePlot(results = result)
```

![](data:image/png;base64...)

It is expected that the classification accuracy is low. This is because we are using a small subset of data containing only 3523 genes and 519 cells. The dataset is unlikely to contain enough information to distinguish responders and non-responders.

## 2.2 Survival analysis using the generated features

Suppose we want to use the features to perform survival analysis. In here, since the patient outcomes are responder and non-responder, and do not contain survival information, we randomly “generate” the survival outcome for the purpose of demonstration.

We use a standard hierarchical clustering to split the patients into 2 groups based on the generated features.

```
library(survival)
library(survminer)

X <- feature_gene_mean_celltype
X <- t(X)

# run hierarchical clustering
hclust_res <- hclust(
    as.dist(1 - cor(X, method = "pearson")),
    method = "ward.D2"
)

set.seed(1)
# generate some survival outcome, including the survival days and the censoring outcome
survival_day <- sample(1:100, ncol(X))
censoring <- sample(0:1, ncol(X), replace = TRUE)

cluster_res <- cutree(hclust_res, k = 2)
metadata <- data.frame( cluster = factor(cluster_res),
                        survival_day = survival_day,
                        censoring = censoring)

# plot survival curve
fit <- survfit(
    Surv(survival_day, censoring) ~ cluster,
    data = metadata
)
ggsurv <- ggsurvplot(fit,
    conf.int = FALSE, risk.table = TRUE,
    risk.table.col = "strata", pval = TRUE
)
ggsurv
```

![](data:image/png;base64...)

The p-value is very high, indicating there is not enough evidence to claim there is a survival difference between the two groups.
This is as expected, because we randomly assigned survival status to each of the patient.

# 3 Association study of the features with the conditions

scFeatures provides a function that automatically run association study of the features with the conditions and produce an HTML file with the visualisation of the features and the association result.

For this, we would first need to generate the features using scFeatures and then store the result in a named list format.

For demonstration purpose, we provide an example of this features list. The code below show the steps of generating the HTML output from the features list.

```
# here we use the demo data from the package
data("scfeatures_result" , package = "scFeatures")

# here we use the current working directory to save the html output
# modify this to save the html file to other directory
output_folder <-  tempdir()

run_association_study_report(scfeatures_result, output_folder )
#> /usr/bin/pandoc +RTS -K512m -RTS output_report.knit.md --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash --output /tmp/RtmpM45b4q/output_report.html --lua-filter /home/biocbuild/bbs-3.22-bioc/R/site-library/rmarkdown/rmarkdown/lua/pagebreak.lua --lua-filter /home/biocbuild/bbs-3.22-bioc/R/site-library/rmarkdown/rmarkdown/lua/latex-div.lua --self-contained --variable bs3=TRUE --section-divs --table-of-contents --toc-depth 3 --variable toc_float=1 --variable toc_selectors=h1,h2,h3 --variable toc_collapsed=1 --variable toc_print=1 --template /home/biocbuild/bbs-3.22-bioc/R/site-library/rmarkdown/rmd/h/default.html --no-highlight --variable highlightjs=1 --number-sections --variable theme=bootstrap --mathjax --variable 'mathjax-url=https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML' --include-in-header /tmp/RtmpM45b4q/rmarkdown-str1eaf8d4007e15e.html --variable code_folding=hide --variable code_menu=1
```

Inside the directory defined in the `output_folder`, you will see the html report output with the name `output_report.html`.

# 4 sessionInfo()

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
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
#> [1] grid      stats4    stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] data.table_1.18.2.1         enrichplot_1.30.4
#>  [3] DOSE_4.4.0                  clusterProfiler_4.18.4
#>  [5] msigdbr_25.1.1              EnsDb.Hsapiens.v79_2.99.0
#>  [7] ensembldb_2.34.0            AnnotationFilter_1.34.0
#>  [9] GenomicFeatures_1.62.0      org.Hs.eg.db_3.22.0
#> [11] AnnotationDbi_1.72.0        plotly_4.12.0
#> [13] igraph_2.2.2                tidyr_1.3.2
#> [15] DT_0.34.0                   limma_3.66.0
#> [17] pheatmap_1.0.13             dplyr_1.2.0
#> [19] reshape2_1.4.5              survminer_0.5.1
#> [21] ggpubr_0.6.2                ggplot2_4.0.2
#> [23] ClassifyR_3.14.0            survival_3.8-6
#> [25] BiocParallel_1.44.0         MultiAssayExperiment_1.36.1
#> [27] SummarizedExperiment_1.40.0 Biobase_2.70.0
#> [29] GenomicRanges_1.62.1        Seqinfo_1.0.0
#> [31] IRanges_2.44.0              MatrixGenerics_1.22.0
#> [33] matrixStats_1.5.0           scFeatures_1.10.9
#> [35] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [37] generics_0.1.4              BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] SpatialExperiment_1.20.0    R.methodsS3_1.8.2
#>   [3] dichromat_2.0-0.1           GSEABase_1.72.0
#>   [5] dcanr_1.26.0                EnsDb.Mmusculus.v79_2.99.0
#>   [7] goftest_1.2-3               Biostrings_2.78.0
#>   [9] HDF5Array_1.38.0            vctrs_0.7.1
#>  [11] ggtangle_0.1.1              spatstat.random_3.4-4
#>  [13] digest_0.6.39               png_0.1-8
#>  [15] BiocBaseUtils_1.12.0        ggrepel_0.9.6
#>  [17] deldir_2.0-4                parallelly_1.46.1
#>  [19] magick_2.9.0                MASS_7.3-65
#>  [21] fontLiberation_0.1.0        foreach_1.5.2
#>  [23] qvalue_2.42.0               withr_3.0.2
#>  [25] xfun_0.56                   ggfun_0.2.0
#>  [27] doRNG_1.8.6.3               memoise_2.0.1
#>  [29] proxyC_0.5.2                commonmark_2.0.0
#>  [31] gson_0.1.0                  systemfonts_1.3.1
#>  [33] tidytree_0.4.7              zoo_1.8-15
#>  [35] gtools_3.9.5                R.oo_1.27.1
#>  [37] Formula_1.2-5               KEGGREST_1.50.0
#>  [39] otel_0.2.0                  httr_1.4.7
#>  [41] rstatix_0.7.3               restfulr_0.0.16
#>  [43] globals_0.19.0              rhdf5filters_1.22.0
#>  [45] rhdf5_2.54.1                UCSC.utils_1.6.1
#>  [47] babelgene_22.9              curl_7.0.0
#>  [49] ScaledMatrix_1.18.0         h5mread_1.2.1
#>  [51] polyclip_1.10-7             SparseArray_1.10.8
#>  [53] xtable_1.8-4                stringr_1.6.0
#>  [55] evaluate_1.0.5              S4Arrays_1.10.1
#>  [57] bookdown_0.46               irlba_2.3.7
#>  [59] spatstat.data_3.1-9         magrittr_2.0.4
#>  [61] ggtree_4.0.4                lattice_0.22-9
#>  [63] spatstat.geom_3.7-0         future.apply_1.20.1
#>  [65] genefilter_1.92.0           XML_3.99-0.22
#>  [67] cowplot_1.2.0               ggupset_0.4.1
#>  [69] pillar_1.11.1               nlme_3.1-168
#>  [71] iterators_1.0.14            compiler_4.5.2
#>  [73] beachmat_2.26.0             stringi_1.8.7
#>  [75] tensor_1.5.1                GenomicAlignments_1.46.0
#>  [77] plyr_1.8.9                  crayon_1.5.3
#>  [79] abind_1.4-8                 BiocIO_1.20.0
#>  [81] gridGraphics_0.5-1          ggtext_0.1.2
#>  [83] sp_2.2-0                    bit_4.6.0
#>  [85] fastmatch_1.1-8             codetools_0.2-20
#>  [87] BiocSingular_1.26.1         crosstalk_1.2.2
#>  [89] bslib_0.10.0                splines_4.5.2
#>  [91] markdown_2.0                Rcpp_1.1.1
#>  [93] tidydr_0.0.6                sparseMatrixStats_1.22.0
#>  [95] gridtext_0.1.5              knitr_1.51
#>  [97] blob_1.3.0                  fs_1.6.6
#>  [99] listenv_0.10.0              DelayedMatrixStats_1.32.0
#> [101] GSVA_2.4.4                  ggsignif_0.6.4
#> [103] ggplotify_0.1.3             tibble_3.3.1
#> [105] Matrix_1.7-4                statmod_1.5.1
#> [107] tweenr_2.0.3                pkgconfig_2.0.3
#> [109] tools_4.5.2                 cachem_1.1.0
#> [111] cigarillo_1.0.0             RSQLite_2.4.6
#> [113] viridisLite_0.4.3           DBI_1.2.3
#> [115] fastmap_1.2.0               rmarkdown_2.30
#> [117] scales_1.4.0                Rsamtools_2.26.0
#> [119] broom_1.0.12                sass_0.4.10
#> [121] patchwork_1.3.2             BiocManager_1.30.27
#> [123] dotCall64_1.2               graph_1.88.1
#> [125] carData_3.0-6               farver_2.1.2
#> [127] scatterpie_0.2.6            yaml_2.3.12
#> [129] rtracklayer_1.70.1          cli_3.6.5
#> [131] purrr_1.2.1                 lifecycle_1.0.5
#> [133] backports_1.5.0             annotate_1.88.0
#> [135] gtable_0.3.6                rjson_0.2.23
#> [137] progressr_0.18.0            parallel_4.5.2
#> [139] ape_5.8-1                   jsonlite_2.0.0
#> [141] bitops_1.0-9                bit64_4.6.0-1
#> [143] assertthat_0.2.1            yulab.utils_0.2.4
#> [145] spatstat.utils_3.2-1        litedown_0.9
#> [147] SeuratObject_5.3.0          ranger_0.18.0
#> [149] jquerylib_0.1.4             GOSemSim_2.36.0
#> [151] survMisc_0.5.6              spatstat.univar_3.1-6
#> [153] R.utils_2.13.0              lazyeval_0.2.2
#> [155] htmltools_0.5.9             KMsurv_0.1-6
#> [157] GO.db_3.22.0                rappdirs_0.3.4
#> [159] tinytex_0.58                glue_1.8.0
#> [161] spam_2.11-3                 XVector_0.50.0
#> [163] gdtools_0.5.0               RCurl_1.98-1.17
#> [165] treeio_1.34.0               gridExtra_2.3
#> [167] AUCell_1.32.0               R6_2.6.1
#> [169] SingleCellExperiment_1.32.0 ggiraph_0.9.4
#> [171] km.ci_0.5-6                 labeling_0.4.3
#> [173] cluster_2.1.8.2             rngtools_1.5.2
#> [175] Rhdf5lib_1.32.0             memuse_4.2-3
#> [177] aplot_0.2.9                 GenomeInfoDb_1.46.2
#> [179] DelayedArray_0.36.0         tidyselect_1.2.1
#> [181] ProtGenerics_1.42.0         ggforce_0.5.0
#> [183] xml2_1.5.2                  fontBitstreamVera_0.1.1
#> [185] car_3.1-5                   future_1.69.0
#> [187] rsvd_1.0.5                  S7_0.2.1
#> [189] fontquiver_0.2.1            htmlwidgets_1.6.4
#> [191] fgsea_1.36.2                RColorBrewer_1.1-3
#> [193] rlang_1.1.7                 spatstat.sparse_3.1-0
#> [195] spatstat.explore_3.7-0      ggnewscale_0.5.2
```