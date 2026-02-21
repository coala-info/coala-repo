# How to perform CCI simulation by `cellCellSimulate` function

Koki Tsuyuzaki1, Manabu Ishii1 and Itoshi Nikaido1\*

1Laboratory for Bioinformatics Research, RIKEN Center for Biosystems Dynamics Research

\*k.t.the-answer@hotmail.co.jp

#### 30 October 2025

#### Package

scTensor 2.20.0

# Contents

* [1 Introduction](#introduction)
* [Session information](#session-information)

# 1 Introduction

Here, we explain the way to generate CCI simulation data.
*[scTensor](https://bioconductor.org/packages/3.22/scTensor)* has a function `cellCellSimulate`
to generate the simulation data.

The simplest way to generate such data is `cellCellSimulate` with default parameters.

```
suppressPackageStartupMessages(library("scTensor"))
sim <- cellCellSimulate()
```

```
## Getting the values of params...
```

```
## Setting random seed...
```

```
## Generating simulation data...
```

```
## Done!
```

This function internally generate the parameter sets by `newCCSParams`,
and the values of the parameter can be changed, and specified as the input of `cellCellSimulate` by users as follows.

```
# Default parameters
params <- newCCSParams()
str(params)
```

```
## Formal class 'CCSParams' [package "scTensor"] with 5 slots
##   ..@ nGene  : num 1000
##   ..@ nCell  : num [1:3] 50 50 50
##   ..@ cciInfo:List of 4
##   .. ..$ nPair: num 500
##   .. ..$ CCI1 :List of 4
##   .. .. ..$ LPattern: num [1:3] 1 0 0
##   .. .. ..$ RPattern: num [1:3] 0 1 0
##   .. .. ..$ nGene   : num 50
##   .. .. ..$ fc      : chr "E10"
##   .. ..$ CCI2 :List of 4
##   .. .. ..$ LPattern: num [1:3] 0 1 0
##   .. .. ..$ RPattern: num [1:3] 0 0 1
##   .. .. ..$ nGene   : num 50
##   .. .. ..$ fc      : chr "E10"
##   .. ..$ CCI3 :List of 4
##   .. .. ..$ LPattern: num [1:3] 0 0 1
##   .. .. ..$ RPattern: num [1:3] 1 0 0
##   .. .. ..$ nGene   : num 50
##   .. .. ..$ fc      : chr "E10"
##   ..@ lambda : num 1
##   ..@ seed   : num 1234
```

```
# Setting different parameters
# No. of genes : 1000
setParam(params, "nGene") <- 1000
# 3 cell types, 20 cells in each cell type
setParam(params, "nCell") <- c(20, 20, 20)
# Setting for Ligand-Receptor pair list
setParam(params, "cciInfo") <- list(
    nPair=500, # Total number of L-R pairs
    # 1st CCI
    CCI1=list(
        LPattern=c(1,0,0), # Only 1st cell type has this pattern
        RPattern=c(0,1,0), # Only 2nd cell type has this pattern
        nGene=50, # 50 pairs are generated as CCI1
        fc="E10"), # Degree of differential expression (Fold Change)
    # 2nd CCI
    CCI2=list(
        LPattern=c(0,1,0),
        RPattern=c(0,0,1),
        nGene=30,
        fc="E100")
    )
# Degree of Dropout
setParam(params, "lambda") <- 10
# Random number seed
setParam(params, "seed") <- 123

# Simulation data
sim <- cellCellSimulate(params)
```

```
## Getting the values of params...
```

```
## Setting random seed...
```

```
## Generating simulation data...
```

```
## Done!
```

The output object **sim** has some attributes as follows.

Firstly, **sim$input** contains a synthetic gene expression matrix.
The size can be changed by **nGene** and **nCell** parameters described above.

```
dim(sim$input)
```

```
## [1] 1000   60
```

```
sim$input[1:2,1:3]
```

```
##       Cell1 Cell2 Cell3
## Gene1  9105     2     0
## Gene2     4    37   850
```

Next, **sim$LR** contains a ligand-receptor (L-R) pair list.
The size can be changed by **nPair** parameter of **cciInfo**,
and the differentially expressed (DE) L-R pairs
are saved in the upper side of this matrix.
Here, two DE L-R patterns are specified as **cciInfo**,
and each number of pairs is 50 and 30, respectively.

```
dim(sim$LR)
```

```
## [1] 500   2
```

```
sim$LR[1:10,]
```

```
##    GENEID_L GENEID_R
## 1     Gene1   Gene81
## 2     Gene2   Gene82
## 3     Gene3   Gene83
## 4     Gene4   Gene84
## 5     Gene5   Gene85
## 6     Gene6   Gene86
## 7     Gene7   Gene87
## 8     Gene8   Gene88
## 9     Gene9   Gene89
## 10   Gene10   Gene90
```

```
sim$LR[46:55,]
```

```
##    GENEID_L GENEID_R
## 46   Gene46  Gene126
## 47   Gene47  Gene127
## 48   Gene48  Gene128
## 49   Gene49  Gene129
## 50   Gene50  Gene130
## 51   Gene51  Gene131
## 52   Gene52  Gene132
## 53   Gene53  Gene133
## 54   Gene54  Gene134
## 55   Gene55  Gene135
```

```
sim$LR[491:500,]
```

```
##     GENEID_L GENEID_R
## 491  Gene571  Gene991
## 492  Gene572  Gene992
## 493  Gene573  Gene993
## 494  Gene574  Gene994
## 495  Gene575  Gene995
## 496  Gene576  Gene996
## 497  Gene577  Gene997
## 498  Gene578  Gene998
## 499  Gene579  Gene999
## 500  Gene580 Gene1000
```

Finally, **sim$celltypes** contains a cell type vector.
Since **nCell** is specified as “c(20, 20, 20)” described above,
three cell types are generated.

```
length(sim$celltypes)
```

```
## [1] 60
```

```
head(sim$celltypes)
```

```
## Celltype1 Celltype1 Celltype1 Celltype1 Celltype1 Celltype1
##   "Cell1"   "Cell2"   "Cell3"   "Cell4"   "Cell5"   "Cell6"
```

```
table(names(sim$celltypes))
```

```
##
## Celltype1 Celltype2 Celltype3
##        20        20        20
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