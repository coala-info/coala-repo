# Gene Detection Analysis for scRNA-seq

#### Ruoxin Li, Gerald Quon

#### 2025-10-30

# Introduction

This tutorial provides an example analysis for modelling gene detection pattern as outlined in [R.Li et al, 2018](https://www.biorxiv.org/content/10.1101/454629v1). The goal of this tutorial is to provide an overview of the cell type classification and visualization tasks by learning a low dimensional embedding through a class of gene detection models: that is BFA and Binary PCA.

## Summary of workflow

The following workflow summarizes a typical dimensionality reduction procedure performed by BFA or Binary PCA.

1. Data processing
2. Dimensionality reduction
3. Visualization

## Installation

Let’s start with the installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("scBFA")
```

next we can load dependent packages

```
library(zinbwave)
library(SingleCellExperiment)
library(ggplot2)
library(scBFA)
```

## Information of example dataset

The example dataset is generated from our scRNA-seq pre-DC/cDC dataset sourced from <https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE89232> After performing all quality control procedure of genes and cells (as outlined in the paper), we then select 500 most variable genes for illustration purpose. The example dataset consists of 950 cells and 500 genes

```
# raw counts matrix with rows are genes and columns are cells
data("exprdata")

# a vector specify the ground truth of cell types provided by conquer database
data("celltype")
```

## Working with SingleCellExperiment class

The design of BFA and Binary PCA allows three kinds of input object(scData):

For illustration, here we construct a singleCellExperiment class to be the input of BFA and Binary PCA.

```
sce <- SingleCellExperiment(assay = list(counts = exprdata))
```

## Gene Detection Model analysis

### Binary Factor Analysis

Let \(N\) stands for number of cells, \(G\) stands for the number of genes, and \(K\) stands for the number of latent dimensions.

A bfa model object computes the following parameters after fitting the gene detection matrix.

1. \(Z\) is \(N\) by \(K\) embedding matrix and is named as “ZZ” in the model object
2. \(A\) is \(G\) by \(K\) loading matrix and is named as “AA” in the model object
3. \(\beta\) if there is cell-level covariates (e.g batch effect), \(\beta\) is corresponding coefficient matrix and is named as “beta” in the model object
4. \(\gamma\) if there is gene-level covariates (e.g QC measures), \(\gamma\) is corresponding coefficient matrix and is named as “gamma” in the model object

We choose 3 as number of latent dimensions and project the gene detection matrix on the embedding space.

```
bfa_model = scBFA(scData = sce, numFactors = 2)
```

We then visualize the low dimensional embedding of BFA in tSNE space. Points are colored by their corresponding cell types.

```
set.seed(5)
df = as.data.frame(bfa_model$ZZ)
df$celltype = celltype

p1 <- ggplot(df,aes(x = V1,y = V2,colour = celltype))
p1 <- p1 + geom_jitter(size=2.5,alpha = 0.8)
colorvalue <- c("#43d5f9","#24b71f","#E41A1C", "#ffc935","#3d014c","#39ddb2",
                "slateblue2","maroon","#f7df27","palevioletred1","olivedrab3",
                "#377EB8","#5043c1","blue","aquamarine2","chartreuse4",
                "burlywood2","indianred1","mediumorchid1")
p1 <- p1 + xlab("tsne axis 1") + ylab("tsne axis 2")
p1 <- p1 + scale_color_manual(values = colorvalue)
p1 <- p1 + theme(panel.background = element_blank(),
                  legend.position = "right",
                  axis.text=element_blank(),
                  axis.line.x = element_line(color="black"),
                  axis.line.y = element_line(color="black"),
                  plot.title = element_blank()
                   )
p1
```

![](data:image/png;base64...)

### Binary PCA

```
bpca = BinaryPCA(scData = sce)
```

We then visualize the low dimensional embedding of Binary PCA in tSNE space. Points are colored by their corresponding cell types.

```
df = as.data.frame(bpca$x[,c(1:2)])
colnames(df) = c("V1","V2")
df$celltype = celltype

p1 <- ggplot(df,aes(x = V1,y = V2,colour = celltype))
p1 <- p1 + geom_jitter(size=2.5,alpha = 0.8)
colorvalue <- c("#43d5f9","#24b71f","#E41A1C", "#ffc935","#3d014c","#39ddb2",
                "slateblue2","maroon","#f7df27","palevioletred1","olivedrab3",
                "#377EB8","#5043c1","blue","aquamarine2","chartreuse4",
                "burlywood2","indianred1","mediumorchid1")
p1 <- p1 + xlab("tsne axis 1") + ylab("tsne axis 2")
p1 <- p1 + scale_color_manual(values = colorvalue)
p1 <- p1 + theme(panel.background = element_blank(),
                legend.position = "right",
                axis.text=element_blank(),
                axis.line.x = element_line(color="black"),
                axis.line.y = element_line(color="black"),
                plot.title = element_blank()
                )
p1
```

![](data:image/png;base64...)

## Session Info

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
#>  [1] scBFA_1.24.0                ggplot2_4.0.0
#>  [3] zinbwave_1.32.0             SingleCellExperiment_1.32.0
#>  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [9] IRanges_2.44.0              S4Vectors_0.48.0
#> [11] BiocGenerics_0.56.0         generics_0.1.4
#> [13] MatrixGenerics_1.22.0       matrixStats_1.5.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RcppAnnoy_0.0.22       splines_4.5.1          later_1.4.4
#>   [4] tibble_3.3.0           polyclip_1.10-7        XML_3.99-0.19
#>   [7] fastDummies_1.7.5      lifecycle_1.0.4        edgeR_4.8.0
#>  [10] globals_0.18.0         lattice_0.22-7         MASS_7.3-65
#>  [13] magrittr_2.0.4         limma_3.66.0           plotly_4.11.0
#>  [16] sass_0.4.10            rmarkdown_2.30         jquerylib_0.1.4
#>  [19] yaml_2.3.10            httpuv_1.6.16          otel_0.2.0
#>  [22] Seurat_5.3.1           sctransform_0.4.2      spam_2.11-1
#>  [25] sp_2.2-0               spatstat.sparse_3.1-0  reticulate_1.44.0
#>  [28] cowplot_1.2.0          pbapply_1.7-4          DBI_1.2.3
#>  [31] RColorBrewer_1.1-3     ADGofTest_0.3          abind_1.4-8
#>  [34] Rtsne_0.17             purrr_1.1.0            pspline_1.0-21
#>  [37] ggrepel_0.9.6          irlba_2.3.5.1          listenv_0.9.1
#>  [40] spatstat.utils_3.2-0   genefilter_1.92.0      goftest_1.2-3
#>  [43] RSpectra_0.16-2        spatstat.random_3.4-2  annotate_1.88.0
#>  [46] fitdistrplus_1.2-4     parallelly_1.45.1      codetools_0.2-20
#>  [49] DelayedArray_0.36.0    tidyselect_1.2.1       farver_2.1.2
#>  [52] spatstat.explore_3.5-3 jsonlite_2.0.0         progressr_0.17.0
#>  [55] ggridges_0.5.7         survival_3.8-3         tools_4.5.1
#>  [58] ica_1.0-3              Rcpp_1.1.0             glue_1.8.0
#>  [61] gridExtra_2.3          SparseArray_1.10.0     xfun_0.53
#>  [64] DESeq2_1.50.0          dplyr_1.1.4            withr_3.0.2
#>  [67] numDeriv_2016.8-1.1    fastmap_1.2.0          digest_0.6.37
#>  [70] R6_2.6.1               mime_0.13              scattermore_1.2
#>  [73] tensor_1.5.1           dichromat_2.0-0.1      spatstat.data_3.1-9
#>  [76] RSQLite_2.4.3          copula_1.1-6           tidyr_1.3.1
#>  [79] data.table_1.17.8      httr_1.4.7             htmlwidgets_1.6.4
#>  [82] S4Arrays_1.10.0        uwot_0.2.3             pkgconfig_2.0.3
#>  [85] gtable_0.3.6           blob_1.2.4             lmtest_0.9-40
#>  [88] S7_0.2.0               XVector_0.50.0         pcaPP_2.0-5
#>  [91] htmltools_0.5.8.1      dotCall64_1.2          SeuratObject_5.2.0
#>  [94] scales_1.4.0           png_0.1-8              spatstat.univar_3.1-4
#>  [97] knitr_1.50             reshape2_1.4.4         nlme_3.1-168
#> [100] cachem_1.1.0           zoo_1.8-14             stringr_1.5.2
#> [103] KernSmooth_2.23-26     parallel_4.5.1         miniUI_0.1.2
#> [106] softImpute_1.4-3       AnnotationDbi_1.72.0   pillar_1.11.1
#> [109] grid_4.5.1             vctrs_0.6.5            RANN_2.6.2
#> [112] promises_1.4.0         xtable_1.8-4           cluster_2.1.8.1
#> [115] evaluate_1.0.5         mvtnorm_1.3-3          cli_3.6.5
#> [118] locfit_1.5-9.12        compiler_4.5.1         rlang_1.1.6
#> [121] crayon_1.5.3           future.apply_1.20.0    labeling_0.4.3
#> [124] plyr_1.8.9             stringi_1.8.7          viridisLite_0.4.2
#> [127] deldir_2.0-4           BiocParallel_1.44.0    Biostrings_2.78.0
#> [130] gsl_2.1-8              lazyeval_0.2.2         spatstat.geom_3.6-0
#> [133] Matrix_1.7-4           RcppHNSW_0.6.0         stabledist_0.7-2
#> [136] patchwork_1.3.2        bit64_4.6.0-1          future_1.67.0
#> [139] KEGGREST_1.50.0        statmod_1.5.1          shiny_1.11.1
#> [142] ROCR_1.0-11            igraph_2.2.1           memoise_2.0.1
#> [145] bslib_0.9.0            bit_4.6.0
```