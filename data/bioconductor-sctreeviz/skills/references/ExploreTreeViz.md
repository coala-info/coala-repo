# Interactively explore and visualize Single Cell RNA seq data

Jayaram Kancherla, Kazi Tasnim Zinat, Héctor Corrada Bravo

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
  + [1.1 Loading required packages](#loading-required-packages)
* [2 Preparing Datasets](#preparing-datasets)
  + [2.1 From `SingleCellExperiment`](#from-singlecellexperiment)
  + [2.2 From `Seurat`](#from-seurat)
  + [2.3 Create TreeViz from count matrix and Cluster hierarchy](#create-treeviz-from-count-matrix-and-cluster-hierarchy)
  + [2.4 Start the TreeViz App (using hosted app)](#start-the-treeviz-app-using-hosted-app)
  + [2.5 Visualize gene expression across clusters](#visualize-gene-expression-across-clusters)
    - [2.5.1 Adding Gene Box Plots via UI](#adding-gene-box-plots-via-ui)
    - [2.5.2 Adding Gene Box Plots via R Session](#adding-gene-box-plots-via-r-session)
  + [2.6 Stop App](#stop-app)
  + [2.7 Session](#session)

# 1 Introduction

[`scTreeViz`](https://github.com/HCBravoLab/scTreeViz) is a package for interactive visualization and exploration of Single Cell RNA sequencing data. `scTreeViz` provides methods for exploring hierarchical features (eg. clusters in single cell at different resolutions or taxonomic hierarchy in single cell datasets), while supporting other useful data visualization charts like heatmaps for expression and scatter plots for dimensionality reductions like UMAP or TSNE.

## 1.1 Loading required packages

```
library(scTreeViz)
library(Seurat)
library(SC3)
library(scran)
library(scater)
library(clustree)
library(igraph)
library(scRNAseq)
```

# 2 Preparing Datasets

The first step in using the `scTreeViz` package is to wrap datasets into `TreeViz` objects. The `TreeViz` class extends `SummarizedExperiment` and provides various methods to interactively perform various operations on the underlying hierarchy and count or expression matrices. In this section, we show various ways to generate a `TreeViz` object either from existing Single Cell packages (SingleCellExperiment or Seurat) or from a raw count matrix and cluster hierarchy.

## 2.1 From `SingleCellExperiment`

A number of Single cell datasets are available as `SingleCellExperiment` objects through the `scRNAseq` package, for this usecase, we use `LunSpikeInData` dataset. In addition, we calculate the dimensionality reductions; UMAP, TSNE and PCA from the functions provided in `scater` package.

```
# load dataset
sce<- ZeiselBrainData()
# Normalization
sce <- logNormCounts(sce)
# calculate umap and tsne
sce <- runUMAP(sce)
sce<- runTSNE(sce)
sce<- runPCA(sce)
```

We provide `createFromSCE` function to create a `TreeViz` object from `SingleCellExperiment` object. Here, the workflow works in two ways:

1. If no cluster information is available in the `colData` of the `SingleCellExperiment` object, we create clusters at different resolutions using the `WalkTrap` algorithm by calling an internal function `generate_walktrap_hierarchy` and use this cluster information for visualization.

```
treeViz <- createFromSCE(sce, reduced_dim = c("UMAP","PCA","TSNE"))
#>  [1] "1.cluster1"   "2.cluster2"   "3.cluster3"   "4.cluster4"   "5.cluster5"
#>  [6] "6.cluster6"   "7.cluster7"   "8.cluster8"   "9.cluster9"   "10.cluster10"
#> [11] "11.cluster11" "12.cluster12" "13.cluster13" "14.cluster14" "samples"
plot(treeViz)
```

![](data:image/png;base64...)

2. If cluster information is provided in the `colData` of the object, then the user should set the flag parameter `check_coldata` to `TRUE` and provide prefix for the columns where cluster information is stored.

```
# Forming clusters
set.seed(1000)
for (i in  seq(10)) {
  clust.kmeans <- kmeans(reducedDim(sce, "TSNE"), centers = i)
  sce[[paste0("clust", i)]] <- factor(clust.kmeans$cluster)
}

treeViz<- createFromSCE(sce, check_coldata = TRUE, col_regex = "clust")
plot(treeViz)
```

Note: In both cases the user needs to provide the name of dimensionality reductions present in the object as a parameter.

## 2.2 From `Seurat`

We use the dataset `pbmc_small` available through Seurat to create a `TreeViz` object.

```
data(pbmc_small)
pbmc <- pbmc_small
```

We then preprocess the data and find clusters at different resolutions.

```
pbmc[["percent.mt"]] <- PercentageFeatureSet(pbmc, pattern = "^MT-")
pbmc <- NormalizeData(pbmc)
all.genes <- rownames(pbmc)
pbmc <- ScaleData(pbmc, vars.to.regress = "percent.mt")
pbmc <- FindVariableFeatures(object = pbmc)
pbmc <- RunPCA(pbmc, features = VariableFeatures(object = pbmc))
pbmc <- FindNeighbors(pbmc, dims = 1:10)
pbmc <- FindClusters(pbmc, resolution = c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0), print.output = 0, save.SNN = TRUE)
pbmc
```

The measurements for dimensionality reduction methods we want to visualize are also added to the object via native functions in `Seurat`. Since `PCA` is already added, we calculate `TSNE` and `UMAP`

```
# pbmc<- RunTSNE(pbmc)
pbmc<- RunUMAP(pbmc, dims=1:3)
Reductions(pbmc)
```

We use the `createFromSeurat` function to create a `TreeViz` object from `Seurat` object. In addition the object, we pass the name of dimensionality reductions present in the object as a paramter in vector format to indicate these measurements should be added to `treeviz` for visualization. If the mentioned reduced dimension is not present it would simply be ignored.

```
treeViz<- createFromSeurat(pbmc, check_metadata = TRUE, reduced_dim = c("umap","pca","tsne"))
#> [1] "6.cluster6"   "10.cluster10" "11.cluster11" "samples"
#> [1] "umap" "pca"  "tsne"
plot(treeViz)
```

![](data:image/png;base64...)

## 2.3 Create TreeViz from count matrix and Cluster hierarchy

```
n=64
# create a hierarchy
df<- data.frame(cluster0=rep(1,n))
for(i in seq(1,5)){
  df[[paste0("cluster",i)]]<- rep(seq(1:(2**i)),each=ceiling(n/(2**i)),len=n)
}

# generate a count matrix
counts <- matrix(rpois(6400, lambda = 10), ncol=n, nrow=100)
colnames(counts)<- seq(1:64)
# create a `TreeViz` object
treeViz <- createTreeViz(df, counts)
plot(treeViz)
```

![](data:image/png;base64...)

## 2.4 Start the TreeViz App (using hosted app)

Start the App from the `treeViz` object we created. This adds a `facetZoom` to navigate the cluster hierarchy, a heatmap of the top `n` most variable genes from the dataset, where ‘n’ is selected by the user and one scatter plot for each of the reduced dimensions.

```
app <- startTreeviz(treeViz, top_genes = 500)
```

![](data:image/png;base64...)

Cell 416B dataset

![](data:image/png;base64...)

pbmc dataset

Users can also use the interface to explore the same dataset using different visualizations available through Epiviz.

## 2.5 Visualize gene expression across clusters

Users can also add Gene Box plots using either the frontend application, or from R session. In the following example, we visualize the 5th, 50th and 500th most variable gene as Box plots
![visualizing expression of a gene across clusters](data:image/png;base64...)

### 2.5.1 Adding Gene Box Plots via UI

Users need to select `Add Visualization -> Gene Box PLot` option from menu and then select the desired gene using the search pane in the appeared dialogue box

![](data:image/png;base64...)

Selecting a gene to visualize

### 2.5.2 Adding Gene Box Plots via R Session

Users can also select the gene from R session by using the `plotGene` command followed by Gene name.

```
app$plotGene(gene="AIF1")
```

## 2.6 Stop App

After exploring the dataset, this command the websocket connection.

```
app$stop_app()
```

## 2.7 Session

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
#>  [1] future_1.67.0               scRNAseq_2.23.1
#>  [3] igraph_2.2.1                clustree_0.5.1
#>  [5] ggraph_2.2.2                scater_1.38.0
#>  [7] ggplot2_4.0.0               scran_1.38.0
#>  [9] scuttle_1.20.0              SingleCellExperiment_1.32.0
#> [11] SC3_1.38.0                  Seurat_5.3.1
#> [13] SeuratObject_5.2.0          sp_2.2-0
#> [15] scTreeViz_1.16.0            SummarizedExperiment_1.40.0
#> [17] Biobase_2.70.0              GenomicRanges_1.62.0
#> [19] Seqinfo_1.0.0               IRanges_2.44.0
#> [21] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [23] generics_0.1.4              MatrixGenerics_1.22.0
#> [25] matrixStats_1.5.0           epivizr_2.40.0
#> [27] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] dichromat_2.0-0.1        epivizrData_1.38.0       goftest_1.2-3
#>   [4] Biostrings_2.78.0        HDF5Array_1.38.0         vctrs_0.6.5
#>   [7] spatstat.random_3.4-2    digest_0.6.37            png_0.1-8
#>  [10] proxy_0.4-27             pcaPP_2.0-5              gypsum_1.6.0
#>  [13] ggrepel_0.9.6            deldir_2.0-4             parallelly_1.45.1
#>  [16] magick_2.9.0             alabaster.sce_1.10.0     MASS_7.3-65
#>  [19] reshape2_1.4.4           httpuv_1.6.16            foreach_1.5.2
#>  [22] withr_3.0.2              xfun_0.53                survival_3.8-3
#>  [25] doRNG_1.8.6.2            memoise_2.0.1            ggbeeswarm_0.7.2
#>  [28] zoo_1.8-14               pbapply_1.7-4            DEoptimR_1.1-4
#>  [31] sys_3.4.3                KEGGREST_1.50.0          promises_1.4.0
#>  [34] otel_0.2.0               httr_1.4.7               restfulr_0.0.16
#>  [37] globals_0.18.0           fitdistrplus_1.2-4       rhdf5filters_1.22.0
#>  [40] rhdf5_2.54.0             UCSC.utils_1.6.0         miniUI_0.1.2
#>  [43] curl_7.0.0               ScaledMatrix_1.18.0      h5mread_1.2.0
#>  [46] polyclip_1.10-7          ExperimentHub_3.0.0      SparseArray_1.10.0
#>  [49] RBGL_1.86.0              xtable_1.8-4             stringr_1.5.2
#>  [52] doParallel_1.0.17        evaluate_1.0.5           S4Arrays_1.10.0
#>  [55] BiocFileCache_3.0.0      bookdown_0.45            irlba_2.3.5.1
#>  [58] filelock_1.0.3           ROCR_1.0-11              reticulate_1.44.0
#>  [61] spatstat.data_3.1-9      magrittr_2.0.4           lmtest_0.9-40
#>  [64] later_1.4.4              viridis_0.6.5            lattice_0.22-7
#>  [67] spatstat.geom_3.6-0      future.apply_1.20.0      robustbase_0.99-6
#>  [70] scattermore_1.2          XML_3.99-0.19            cowplot_1.2.0
#>  [73] RcppAnnoy_0.0.22         class_7.3-23             pillar_1.11.1
#>  [76] nlme_3.1-168             iterators_1.0.14         compiler_4.5.1
#>  [79] beachmat_2.26.0          RSpectra_0.16-2          stringi_1.8.7
#>  [82] tensor_1.5.1             GenomicAlignments_1.46.0 plyr_1.8.9
#>  [85] crayon_1.5.3             abind_1.4-8              BiocIO_1.20.0
#>  [88] locfit_1.5-9.12          graphlayouts_1.2.2       bit_4.6.0
#>  [91] dplyr_1.1.4              codetools_0.2-20         BiocSingular_1.26.0
#>  [94] bslib_0.9.0              alabaster.ranges_1.10.0  e1071_1.7-16
#>  [97] plotly_4.11.0            mime_0.13                splines_4.5.1
#> [100] Rcpp_1.1.0               fastDummies_1.7.5        dbplyr_2.5.1
#> [103] knitr_1.50               blob_1.2.4               BiocVersion_3.22.0
#> [106] AnnotationFilter_1.34.0  WriteXLS_6.8.0           checkmate_2.3.3
#> [109] listenv_0.9.1            tibble_3.3.0             Matrix_1.7-4
#> [112] statmod_1.5.1            tweenr_2.0.3             pkgconfig_2.0.3
#> [115] pheatmap_1.0.13          tools_4.5.1              cachem_1.1.0
#> [118] cigarillo_1.0.0          RSQLite_2.4.3            viridisLite_0.4.2
#> [121] DBI_1.2.3                fastmap_1.2.0            rmarkdown_2.30
#> [124] scales_1.4.0             grid_4.5.1               ica_1.0-3
#> [127] epivizrServer_1.38.0     Rsamtools_2.26.0         AnnotationHub_4.0.0
#> [130] sass_0.4.10              FNN_1.1.4.1              patchwork_1.3.2
#> [133] BiocManager_1.30.26      dotCall64_1.2            graph_1.88.0
#> [136] RANN_2.6.2               alabaster.schemas_1.10.0 farver_2.1.2
#> [139] tidygraph_1.3.1          yaml_2.3.10              rtracklayer_1.70.0
#> [142] cli_3.6.5                purrr_1.1.0              lifecycle_1.0.4
#> [145] uwot_0.2.3               mvtnorm_1.3-3            backports_1.5.0
#> [148] bluster_1.20.0           BiocParallel_1.44.0      gtable_0.3.6
#> [151] rjson_0.2.23             ggridges_0.5.7           progressr_0.17.0
#> [154] parallel_4.5.1           limma_3.66.0             jsonlite_2.0.0
#> [157] edgeR_4.8.0              RcppHNSW_0.6.0           bitops_1.0-9
#> [160] bit64_4.6.0-1            Rtsne_0.17               alabaster.matrix_1.10.0
#> [163] spatstat.utils_3.2-0     BiocNeighbors_2.4.0      jquerylib_0.1.4
#> [166] metapod_1.18.0           alabaster.se_1.10.0      dqrng_0.4.1
#> [169] spatstat.univar_3.1-4    rrcov_1.7-7              lazyeval_0.2.2
#> [172] alabaster.base_1.10.0    shiny_1.11.1             htmltools_0.5.8.1
#> [175] sctransform_0.4.2        rappdirs_0.3.3           tinytex_0.57
#> [178] ensembldb_2.34.0         glue_1.8.0               spam_2.11-1
#> [181] httr2_1.2.1              XVector_0.50.0           RCurl_1.98-1.17
#> [184] gridExtra_2.3            R6_2.6.1                 tidyr_1.3.1
#> [187] labeling_0.4.3           GenomicFeatures_1.62.0   cluster_2.1.8.1
#> [190] rngtools_1.5.2           Rhdf5lib_1.32.0          GenomeInfoDb_1.46.0
#> [193] DelayedArray_0.36.0      tidyselect_1.2.1         vipor_0.4.7
#> [196] ProtGenerics_1.42.0      ggforce_0.5.0            AnnotationDbi_1.72.0
#> [199] rsvd_1.0.5               KernSmooth_2.23-26       S7_0.2.0
#> [202] data.table_1.17.8        htmlwidgets_1.6.4        RColorBrewer_1.1-3
#> [205] rlang_1.1.6              spatstat.sparse_3.1-0    spatstat.explore_3.5-3
#> [208] beeswarm_0.4.0           OrganismDbi_1.52.0
```