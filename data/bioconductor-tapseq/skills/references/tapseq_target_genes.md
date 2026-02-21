# Select target genes for TAP-seq

Andreas Gschwind

Department of Genetics, Stanford University

#### 2026-01-19

#### Package

TAPseq 1.22.1

# Contents

* [1 Data](#data)
* [2 Select target genes](#select-target-genes)
* [3 Assess target gene panels](#assess-target-gene-panels)
* [4 Session information](#session-information)

One application of TAP-seq is to measure the expression of genes that enable assigning cells to
different cell types. The TAPseq package offers a simple approach to identify a desired number of
cell type markers based on differentially expressed genes between cell types.

This optional functionality requires additional R-packages such as Seurat. Please install the TAPseq
package with all suggested dependencies.

# 1 Data

The TAPseq package contains a small subset of the mouse bone marrow data from Baccin et al., 2019
(<https://www.nature.com/articles/s41556-019-0439-6>). The full dataset can be downloaded
[here](https://static-content.springer.com/esm/art%3A10.1038/s41556-019-0439-6/MediaObjects/41556_2019_439_MOESM4_ESM.zip).
This dataset is stored in a Seurat object which contains both gene expression and cell type data for
every cell.

```
library(TAPseq)
library(Seurat)

# example of mouse bone marrow 10x gene expression data
data("bone_marrow_genex")

# transcript counts
GetAssayData(bone_marrow_genex, layer = "counts", assay = "RNA")[1:10, 1:10]

# number of cells per cell type
table(Idents(bone_marrow_genex))
```

# 2 Select target genes

A linear model with lasso regularization is used to select target genes that best identify cell
types. By default 10-fold cross-validation is used to select the number of target genes based on the
largest value of lambda within 1 standard error of the minimum. See `?glmnet::cv.glmnet` for more
details.

```
# automatically select a number of target genes using 10-fold cross-validation
target_genes_cv <- selectTargetGenes(bone_marrow_genex)
#> Warning in lognet(x, is.sparse, y, weights, offset, alpha, nobs, nvars, : one
#> multinomial or binomial class has fewer than 8 observations; dangerous ground
#> Warning in lognet(x, is.sparse, y, weights, offset, alpha, nobs, nvars, : one
#> multinomial or binomial class has fewer than 8 observations; dangerous ground
head(target_genes_cv)
length(target_genes_cv)
```

This example results in a reasonable target gene panel, but in cases with many different cell types
the resulting panels might be very large.

To avoid this, we can specify a desired number of targets. This selects a value for lamda in the
lasso model that results in approximately this number of non-zero coefficients, i.e. marker genes.

```
# identify approximately 100 target genes that can be used to identify cell populations
target_genes_100 <- selectTargetGenes(bone_marrow_genex, targets = 100)
length(target_genes_100)
```

# 3 Assess target gene panels

To intuitively assess how well a chosen set of target genes distinguishes cell types, we can use
UMAP plots based on the full gene expression data and on target genes only.

```
plotTargetGenes(bone_marrow_genex, target_genes = target_genes_100)
```

![](data:image/png;base64...)

We can see that the expression of the 100 selected target genes groups
cells of different populations together.

A good follow up would be to cluster the cells based on only the target genes following the same
workflow used to define the cell identities in the original object. This could then be used to
verify that the selected target genes reliably identify the correct cell types.

# 4 Session information

All of the output in this vignette was produced under the following conditions:

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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] Seurat_5.4.0                      SeuratObject_5.3.0
#>  [3] sp_2.2-0                          ggplot2_4.0.1
#>  [5] dplyr_1.1.4                       BSgenome.Hsapiens.UCSC.hg38_1.4.5
#>  [7] GenomeInfoDb_1.46.2               BSgenome_1.78.0
#>  [9] rtracklayer_1.70.1                BiocIO_1.20.0
#> [11] Biostrings_2.78.0                 XVector_0.50.0
#> [13] BiocParallel_1.44.0               GenomicRanges_1.62.1
#> [15] Seqinfo_1.0.0                     IRanges_2.44.0
#> [17] S4Vectors_0.48.0                  BiocGenerics_0.56.0
#> [19] generics_0.1.4                    TAPseq_1.22.1
#> [21] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RcppAnnoy_0.0.23            splines_4.5.2
#>   [3] later_1.4.5                 bitops_1.0-9
#>   [5] tibble_3.3.1                polyclip_1.10-7
#>   [7] XML_3.99-0.20               fastDummies_1.7.5
#>   [9] lifecycle_1.0.5             globals_0.18.0
#>  [11] lattice_0.22-7              MASS_7.3-65
#>  [13] magrittr_2.0.4              limma_3.66.0
#>  [15] plotly_4.11.0               sass_0.4.10
#>  [17] rmarkdown_2.30              jquerylib_0.1.4
#>  [19] yaml_2.3.12                 httpuv_1.6.16
#>  [21] otel_0.2.0                  sctransform_0.4.3
#>  [23] spam_2.11-3                 spatstat.sparse_3.1-0
#>  [25] reticulate_1.44.1           cowplot_1.2.0
#>  [27] pbapply_1.7-4               DBI_1.2.3
#>  [29] RColorBrewer_1.1-3          abind_1.4-8
#>  [31] Rtsne_0.17                  purrr_1.2.1
#>  [33] RCurl_1.98-1.17             ggrepel_0.9.6
#>  [35] irlba_2.3.5.1               listenv_0.10.0
#>  [37] spatstat.utils_3.2-1        goftest_1.2-3
#>  [39] RSpectra_0.16-2             spatstat.random_3.4-3
#>  [41] fitdistrplus_1.2-4          parallelly_1.46.1
#>  [43] codetools_0.2-20            DelayedArray_0.36.0
#>  [45] shape_1.4.6.1               tidyselect_1.2.1
#>  [47] UCSC.utils_1.6.1            farver_2.1.2
#>  [49] matrixStats_1.5.0           spatstat.explore_3.6-0
#>  [51] GenomicAlignments_1.46.0    jsonlite_2.0.0
#>  [53] progressr_0.18.0            iterators_1.0.14
#>  [55] ggridges_0.5.7              survival_3.8-6
#>  [57] foreach_1.5.2               tools_4.5.2
#>  [59] ica_1.0-3                   Rcpp_1.1.1
#>  [61] glue_1.8.0                  gridExtra_2.3
#>  [63] SparseArray_1.10.8          xfun_0.56
#>  [65] MatrixGenerics_1.22.0       withr_3.0.2
#>  [67] BiocManager_1.30.27         fastmap_1.2.0
#>  [69] digest_0.6.39               R6_2.6.1
#>  [71] mime_0.13                   scattermore_1.2
#>  [73] tensor_1.5.1                dichromat_2.0-0.1
#>  [75] spatstat.data_3.1-9         RSQLite_2.4.5
#>  [77] cigarillo_1.0.0             tidyr_1.3.2
#>  [79] data.table_1.18.0           httr_1.4.7
#>  [81] htmlwidgets_1.6.4           S4Arrays_1.10.1
#>  [83] uwot_0.2.4                  pkgconfig_2.0.3
#>  [85] gtable_0.3.6                blob_1.3.0
#>  [87] lmtest_0.9-40               S7_0.2.1
#>  [89] htmltools_0.5.9             dotCall64_1.2
#>  [91] bookdown_0.46               scales_1.4.0
#>  [93] Biobase_2.70.0              png_0.1-8
#>  [95] spatstat.univar_3.1-6       knitr_1.51
#>  [97] reshape2_1.4.5              rjson_0.2.23
#>  [99] nlme_3.1-168                curl_7.0.0
#> [101] cachem_1.1.0                zoo_1.8-15
#> [103] stringr_1.6.0               KernSmooth_2.23-26
#> [105] parallel_4.5.2              miniUI_0.1.2
#> [107] AnnotationDbi_1.72.0        restfulr_0.0.16
#> [109] pillar_1.11.1               grid_4.5.2
#> [111] vctrs_0.7.0                 RANN_2.6.2
#> [113] promises_1.5.0              xtable_1.8-4
#> [115] cluster_2.1.8.1             evaluate_1.0.5
#> [117] tinytex_0.58                GenomicFeatures_1.62.0
#> [119] magick_2.9.0                cli_3.6.5
#> [121] compiler_4.5.2              Rsamtools_2.26.0
#> [123] rlang_1.1.7                 crayon_1.5.3
#> [125] future.apply_1.20.1         labeling_0.4.3
#> [127] plyr_1.8.9                  stringi_1.8.7
#> [129] deldir_2.0-4                viridisLite_0.4.2
#> [131] lazyeval_0.2.2              spatstat.geom_3.6-1
#> [133] glmnet_4.1-10               Matrix_1.7-4
#> [135] RcppHNSW_0.6.0              patchwork_1.3.2
#> [137] bit64_4.6.0-1               future_1.69.0
#> [139] statmod_1.5.1               KEGGREST_1.50.0
#> [141] shiny_1.12.1                SummarizedExperiment_1.40.0
#> [143] ROCR_1.0-11                 igraph_2.2.1
#> [145] memoise_2.0.1               bslib_0.9.0
#> [147] bit_4.6.0
```