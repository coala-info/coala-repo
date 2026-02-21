# How to reanalyze the results of scTensor

Koki Tsuyuzaki1, Manabu Ishii1 and Itoshi Nikaido1\*

1Laboratory for Bioinformatics Research, RIKEN Center for Biosystems Dynamics Research

\*k.t.the-answer@hotmail.co.jp

#### 30 October 2025

#### Package

scTensor 2.20.0

# Contents

* [1 Summary of the output objects of scTensor](#summary-of-the-output-objects-of-sctensor)
* [2 Execution of scTensor with the different options](#execution-of-sctensor-with-the-different-options)
* [Session information](#session-information)

# 1 Summary of the output objects of scTensor

Here, we introduced the objects saved in reanalysis.RData.

```
library("scTensor")
load("reanalysis.RData")
```

After performing `cellCellReport`, some R objects are saved in the reanalysis.RData as follows;

* **sce** : SingleCellExperiment object
  + **metadata(sce)$lrbase** : The file pass to the database file of LRBase
  + **metadata(sce)$color** : The color vector specified by `cellCellSetting`
  + **metadata(sce)$label** : The label vector specified by `cellCellSetting`
  + **metadata(sce)$algorithm** : The algorithm for performing *[scTensor](https://bioconductor.org/packages/3.22/scTensor)*
  + **metadata(sce)$sctensor** : The results of *[scTensor](https://bioconductor.org/packages/3.22/scTensor)*
    - **metadata(sce)$sctensor$ligand** : The factor matrix (Ligand)
    - **metadata(sce)$sctensor$receptor** : The factor matrix (Receptor)
    - **metadata(sce)$sctensor$lrpair** : The core tensor
  + **metadata(sce)$datasize** : The data size of CCI tensor
  + **metadata(sce)$ranks** : The number of lower dimension in each direction of CCI tensor
  + **metadata(sce)$recerror** : Reconstruction Error of NTD
  + **metadata(sce)$relchange** : Relative Change of NTD
* **input** : The gene expression matrix <# Genes \* # Cells>
* **twoD** : The result of 2D dimensional reduction (e.g. t-SNE)
* **LR** : The Ligand-Receptor corresponding table extracted from LRBase.XXX.eg.db
* **celltypes** : The celltype label and color scheme
* **index** : The core tensor values
* **corevalue** : The core tensor values (normalized)
* **selected** : The selected corevalue position with thr threshold “thr”
* **ClusterL** : The result of analysis in each L vector
* **ClusterR** : The result of analysis in each R vector
* **out.vecLR** : The result of analysis in LR pairs
* **g** : The igraph object to visualize ligand-receptor gene network

# 2 Execution of scTensor with the different options

Using the `reanalysis.RData`, some users may want to perform *[scTensor](https://bioconductor.org/packages/3.22/scTensor)* with different parameters.

For example, some users want to perform `cellCellDecomp` with different ranks, perform `cellCellReport` with omitting some enrichment analysis, provide the results to their collaborators.

To do such tasks, just type like belows.

```
library("AnnotationHub")
library("LRBaseDbi")

# Create LRBase object
ah <- AnnotationHub()
dbfile <- query(ah, c("LRBaseDb", "Homo sapiens"))[[1]]
LRBase.Hsa.eg.db <- LRBaseDbi::LRBaseDb(dbfile)

# Register the file pass of user's LRBase
metadata(sce)$lrbase <- dbfile(LRBase.Hsa.eg.db)

# CCI Tensor Decomposition
cellCellDecomp(sce, ranks=c(6,5), assayNames="normcounts")

# HTML Report
cellCellReport(sce, reducedDimNames="TSNE", assayNames="normcounts",
    title="Cell-cell interaction within Germline_Male, GSE86146",
    author="Koki Tsuyuzaki", html.open=TRUE,
    goenrich=TRUE, meshenrich=FALSE, reactomeenrich=FALSE,
    doenrich=FALSE, ncgenrich=FALSE, dgnenrich=FALSE)
```

# Session information

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
##  [1] scTGIF_1.24.0
##  [2] Homo.sapiens_1.3.1
##  [3] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
##  [4] org.Hs.eg.db_3.22.0
##  [5] GO.db_3.22.0
##  [6] OrganismDbi_1.52.0
##  [7] GenomicFeatures_1.62.0
##  [8] AnnotationDbi_1.72.0
##  [9] SingleCellExperiment_1.32.0
## [10] SummarizedExperiment_1.40.0
## [11] Biobase_2.70.0
## [12] GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0
## [14] IRanges_2.44.0
## [15] S4Vectors_0.48.0
## [16] MatrixGenerics_1.22.0
## [17] matrixStats_1.5.0
## [18] scTensor_2.20.0
## [19] RSQLite_2.4.3
## [20] LRBaseDbi_2.20.0
## [21] AnnotationHub_4.0.0
## [22] BiocFileCache_3.0.0
## [23] dbplyr_2.5.1
## [24] BiocGenerics_0.56.0
## [25] generics_0.1.4
## [26] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] fs_1.6.6                 bitops_1.0-9             enrichplot_1.30.0
##   [4] httr_1.4.7               webshot_0.5.5            RColorBrewer_1.1-3
##   [7] Rgraphviz_2.54.0         tools_4.5.1              backports_1.5.0
##  [10] R6_2.6.1                 lazyeval_0.2.2           withr_3.0.2
##  [13] graphite_1.56.0          gridExtra_2.3            schex_1.24.0
##  [16] fdrtool_1.2.18           cli_3.6.5                TSP_1.2-5
##  [19] entropy_1.3.2            sass_0.4.10              S7_0.2.0
##  [22] genefilter_1.92.0        meshr_2.16.0             Rsamtools_2.26.0
##  [25] systemfonts_1.3.1        yulab.utils_0.2.1        gson_0.1.0
##  [28] DOSE_4.4.0               R.utils_2.13.0           MeSHDbi_1.46.0
##  [31] AnnotationForge_1.52.0   dichromat_2.0-0.1        nnTensor_1.3.0
##  [34] plotrix_3.8-4            maps_3.4.3               visNetwork_2.1.4
##  [37] gridGraphics_0.5-1       GOstats_2.76.0           BiocIO_1.20.0
##  [40] dplyr_1.1.4              dendextend_1.19.1        Matrix_1.7-4
##  [43] abind_1.4-8              R.methodsS3_1.8.2        lifecycle_1.0.4
##  [46] yaml_2.3.10              qvalue_2.42.0            SparseArray_1.10.0
##  [49] grid_4.5.1               blob_1.2.4               misc3d_0.9-1
##  [52] crayon_1.5.3             ggtangle_0.0.7           lattice_0.22-7
##  [55] msigdbr_25.1.1           cowplot_1.2.0            cigarillo_1.0.0
##  [58] annotate_1.88.0          KEGGREST_1.50.0          magick_2.9.0
##  [61] pillar_1.11.1            knitr_1.50               fgsea_1.36.0
##  [64] tcltk_4.5.1              rjson_0.2.23             codetools_0.2-20
##  [67] fastmatch_1.1-6          glue_1.8.0               ggiraph_0.9.2
##  [70] outliers_0.15            ggfun_0.2.0              fontLiberation_0.1.0
##  [73] data.table_1.17.8        vctrs_0.6.5              png_0.1-8
##  [76] treeio_1.34.0            spam_2.11-1              rTensor_1.4.9
##  [79] gtable_0.3.6             assertthat_0.2.1         cachem_1.1.0
##  [82] xfun_0.53                S4Arrays_1.10.0          tidygraph_1.3.1
##  [85] survival_3.8-3           seriation_1.5.8          iterators_1.0.14
##  [88] tinytex_0.57             fields_17.1              nlme_3.1-168
##  [91] Category_2.76.0          ggtree_4.0.0             bit64_4.6.0-1
##  [94] fontquiver_0.2.1         filelock_1.0.3           bslib_0.9.0
##  [97] DBI_1.2.3                tidyselect_1.2.1         bit_4.6.0
## [100] compiler_4.5.1           curl_7.0.0               httr2_1.2.1
## [103] graph_1.88.0             fontBitstreamVera_0.1.1  DelayedArray_0.36.0
## [106] plotly_4.11.0            bookdown_0.45            rtracklayer_1.70.0
## [109] checkmate_2.3.3          scales_1.4.0             hexbin_1.28.5
## [112] RBGL_1.86.0              plot3D_1.4.2             rappdirs_0.3.3
## [115] stringr_1.5.2            digest_0.6.37            rmarkdown_2.30
## [118] ca_0.71.1                XVector_0.50.0           htmltools_0.5.8.1
## [121] pkgconfig_2.0.3          fastmap_1.2.0            rlang_1.1.6
## [124] htmlwidgets_1.6.4        farver_2.1.2             jquerylib_0.1.4
## [127] jsonlite_2.0.0           BiocParallel_1.44.0      GOSemSim_2.36.0
## [130] R.oo_1.27.1              RCurl_1.98-1.17          magrittr_2.0.4
## [133] ggplotify_0.1.3          dotCall64_1.2            patchwork_1.3.2
## [136] Rcpp_1.1.0               babelgene_22.9           ape_5.8-1
## [139] viridis_0.6.5            gdtools_0.4.4            stringi_1.8.7
## [142] tagcloud_0.7.0           ggraph_2.2.2             MASS_7.3-65
## [145] plyr_1.8.9               parallel_4.5.1           ggrepel_0.9.6
## [148] Biostrings_2.78.0        graphlayouts_1.2.2       splines_4.5.1
## [151] igraph_2.2.1             reshape2_1.4.4           BiocVersion_3.22.0
## [154] XML_3.99-0.19            evaluate_1.0.5           BiocManager_1.30.26
## [157] foreach_1.5.2            tweenr_2.0.3             tidyr_1.3.1
## [160] purrr_1.1.0              polyclip_1.10-7          heatmaply_1.6.0
## [163] ggplot2_4.0.0            ReactomePA_1.54.0        ggforce_0.5.0
## [166] xtable_1.8-4             restfulr_0.0.16          reactome.db_1.94.0
## [169] tidytree_0.4.6           viridisLite_0.4.2        tibble_3.3.0
## [172] aplot_0.2.9              ccTensor_1.0.3           GenomicAlignments_1.46.0
## [175] memoise_2.0.1            registry_0.5-1           cluster_2.1.8.1
## [178] concaveman_1.2.0         GSEABase_1.72.0
```