* [What is it for?](#what-is-it-for)
* [Main worfklow](#main-worfklow)
* [Acknowledgements](#acknowledgements)
* [Session Information](#session-information)

Code

```
library(BulkSignalR)
library(SingleCellSignalR)
```

SingleCellSignalR package version: 2.0.1

## What is it for?

`SingleCellSignalR` is a tool that enables the inference of L-R interactions from single-cell data.

See also `BulkSignalR` vignette for a more complete description of all functionalities.

## Main worfklow

The following code snippet give an example of the main commands to use in order to process your dataset with `SingleCellSignalR` package.

Code

```
data(example_dataset,package='SingleCellSignalR')
mat <- log1p(data.matrix(example_dataset[,-1]))/log(2)
rownames(mat) <- example_dataset[[1]]
rme <- rowMeans(mat)
mmat <- mat[rme>0.05,]
d <- dist(t(mmat))
h <- hclust(d, method="ward.D")
clusters <- paste0("pop_", cutree(h, 5))

# SCSRNoNet -> LRscore based approach

scsrnn <- SCSRNoNet(mat,normalize=FALSE,method="log-only",
    min.count=1,prop=0.001,
    log.transformed=TRUE,populations=clusters)

scsrnn <- performInferences(scsrnn,verbose=TRUE,
    min.logFC=1e-10,max.pval=1,min.LR.score=0.5)
```

```
## Computing diffential expression tables:
```

```
##  pop_1
```

```
##  pop_2
```

```
##  pop_3
```

```
##  pop_4
```

```
##  pop_5
```

```
## Computing autocrine naive (network-free) interactions
```

```
## Computing paracrine naive (network-free) interactions
```

Code

```
# SCSRNet -> DifferentialMode based approach

scsrcn <- SCSRNet(mat,normalize=FALSE,method="log-only",
    min.count=1,prop=0.001,
    log.transformed=TRUE,populations=clusters)

if(FALSE){
scsrcn <- performInferences(scsrcn,
    selected.populations = c("pop_1","pop_2","pop_3"),
    verbose=TRUE,rank.p=0.8,
    min.logFC=log2(1.01),max.pval=0.05)

print("getAutocrines")
inter1 <- getAutocrines(scsrcn, "pop_1")
head(inter1)

print("getParacrines")
inter2 <- getParacrines(scsrcn, "pop_1","pop_2")
head(inter2)

# Visualisation

cellNetBubblePlot(scsrcn)
}
```

## Acknowledgements

We thank Morgan Maillard for his help with the LRdb database and Pierre Giroux for the work with proteomics.

Thank you for reading this guide and for using `SingleCellSignalR`.

## Session Information

Code

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
## [1] SingleCellSignalR_2.0.1 BulkSignalR_1.2.1
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] shape_1.4.6.1               magrittr_2.0.4
##   [5] magick_2.9.0                farver_2.1.2
##   [7] rmarkdown_2.30              GlobalOptions_0.1.2
##   [9] fs_1.6.6                    vctrs_0.6.5
##  [11] multtest_2.66.0             matrixTests_0.2.3.1
##  [13] memoise_2.0.1               RCurl_1.98-1.17
##  [15] ggtree_4.0.1                rstatix_0.7.3
##  [17] htmltools_0.5.8.1           S4Arrays_1.10.0
##  [19] curl_7.0.0                  broom_1.0.10
##  [21] SparseArray_1.10.1          Formula_1.2-5
##  [23] gridGraphics_0.5-1          sass_0.4.10
##  [25] bslib_0.9.0                 htmlwidgets_1.6.4
##  [27] httr2_1.2.1                 plotly_4.11.0
##  [29] cachem_1.1.0                igraph_2.2.1
##  [31] lifecycle_1.0.4             iterators_1.0.14
##  [33] pkgconfig_2.0.3             Matrix_1.7-4
##  [35] R6_2.6.1                    fastmap_1.2.0
##  [37] MatrixGenerics_1.22.0       clue_0.3-66
##  [39] digest_0.6.37               aplot_0.2.9
##  [41] colorspace_2.1-2            patchwork_1.3.2
##  [43] S4Vectors_0.48.0            grr_0.9.5
##  [45] GenomicRanges_1.62.0        RSQLite_2.4.3
##  [47] ggpubr_0.6.2                filelock_1.0.3
##  [49] httr_1.4.7                  abind_1.4-8
##  [51] compiler_4.5.1              withr_3.0.2
##  [53] bit64_4.6.0-1               fontquiver_0.2.1
##  [55] doParallel_1.0.17           S7_0.2.0
##  [57] backports_1.5.0             orthogene_1.16.0
##  [59] carData_3.0-5               DBI_1.2.3
##  [61] homologene_1.4.68.19.3.27   ggsignif_0.6.4
##  [63] MASS_7.3-65                 rappdirs_0.3.3
##  [65] DelayedArray_0.36.0         rjson_0.2.23
##  [67] tools_4.5.1                 ape_5.8-1
##  [69] glue_1.8.0                  stabledist_0.7-2
##  [71] nlme_3.1-168                grid_4.5.1
##  [73] Rtsne_0.17                  cluster_2.1.8.1
##  [75] generics_0.1.4              gtable_0.3.6
##  [77] tidyr_1.3.1                 data.table_1.17.8
##  [79] car_3.1-3                   XVector_0.50.0
##  [81] BiocGenerics_0.56.0         ggrepel_0.9.6
##  [83] RANN_2.6.2                  foreach_1.5.2
##  [85] pillar_1.11.1               yulab.utils_0.2.1
##  [87] babelgene_22.9              circlize_0.4.16
##  [89] splines_4.5.1               dplyr_1.1.4
##  [91] BiocFileCache_3.0.0         treeio_1.34.0
##  [93] lattice_0.22-7              survival_3.8-3
##  [95] bit_4.6.0                   tidyselect_1.2.1
##  [97] fontLiberation_0.1.0        ComplexHeatmap_2.26.0
##  [99] SingleCellExperiment_1.32.0 knitr_1.50
## [101] fontBitstreamVera_0.1.1     gridExtra_2.3
## [103] IRanges_2.44.0              Seqinfo_1.0.0
## [105] SummarizedExperiment_1.40.0 stats4_4.5.1
## [107] xfun_0.54                   Biobase_2.70.0
## [109] matrixStats_1.5.0           lazyeval_0.2.2
## [111] ggfun_0.2.0                 yaml_2.3.10
## [113] evaluate_1.0.5              codetools_0.2-20
## [115] gdtools_0.4.4               tibble_3.3.0
## [117] ggplotify_0.1.3             cli_3.6.5
## [119] systemfonts_1.3.1           jquerylib_0.1.4
## [121] dichromat_2.0-0.1           Rcpp_1.1.0
## [123] dbplyr_2.5.1                gprofiler2_0.2.3
## [125] png_0.1-8                   parallel_4.5.1
## [127] ggplot2_4.0.0               blob_1.2.4
## [129] ggalluvial_0.12.5           bitops_1.0-9
## [131] glmnet_4.1-10               SpatialExperiment_1.20.0
## [133] viridisLite_0.4.2           tidytree_0.4.6
## [135] ggiraph_0.9.2               scales_1.4.0
## [137] purrr_1.2.0                 crayon_1.5.3
## [139] GetoptLong_1.0.5            rlang_1.1.6
```